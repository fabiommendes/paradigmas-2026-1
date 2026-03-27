from bytecode import Bytecode, Instr, Label
from types import FunctionType
import timeit

def fib_py(n):
    x = 1
    y = 1
    for _ in range(n):
        aux = y
        y = x + y
        x = aux

    return x

BEGIN_OF_LOOP = Label()
END_OF_LOOP = Label()

code = Bytecode(
    [
        # > 1, 1
        Instr("LOAD_CONST", 1),
        Instr("LOAD_CONST", 1),
        # > 1, 1, iter(range(n))
        Instr("LOAD_GLOBAL", "range"),
        Instr("LOAD_FAST", "n"),
        Instr("CALL_FUNCTION", 1),
        Instr("GET_ITER"),
        # > 1, 1
        Instr("STORE_FAST", "_iter"),
        BEGIN_OF_LOOP,
        Instr("LOAD_FAST", "_iter"),
        Instr("FOR_ITER", END_OF_LOOP),  # > x, y, _iter, _counter
        # > x, y
        Instr("POP_TOP"),
        Instr("POP_TOP"),
        # Loop principal do cálculo do Fibonacci,
        # > x, y, y
        Instr("DUP_TOP"),
        # > y, x, y
        Instr("ROT_THREE"),
        # > y, x + y
        Instr("BINARY_ADD"),
        Instr("JUMP_ABSOLUTE", BEGIN_OF_LOOP),
        END_OF_LOOP,
        # x
        Instr("POP_TOP"),
        Instr("RETURN_VALUE"),
    ]
)
code.argcount = 1
code.argnames = ["n"]

fib = FunctionType(code.to_code(), {"range": range}, "fib")

N = 100_000

dt_py = timeit.timeit("f(200)", number=N, globals={"f": fib_py})
dt_stack = timeit.timeit("f(200)", number=N, globals={"f": fib})

print(f"Implementação manual: {dt_stack}")
print(f"Implementação python: {dt_py}")


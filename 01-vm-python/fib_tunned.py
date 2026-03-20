import dis
import timeit
from types import FunctionType

from bytecode import Bytecode, Compare, Instr, Label

N_TIMES = 3_000_000
N = 20


def fib(n):
    a = 1
    b = 1
    for _ in range(n - 1):
        aux = b
        b = a + b
        a = aux
    return b


def fib_while(n):
    a = 1
    b = 1
    while n > 1:
        aux = b
        b = a + b
        a = aux
        n -= 1
    return b


print("Bytecodes de fib:")
dis.dis(fib_while)


# Recriamos fib-for manualmente
LOOP_START = Label()
LOOP_END = Label()

code = Bytecode(
    [
        # 1, 1
        Instr("LOAD_CONST", 1),
        Instr("LOAD_CONST", 1),
        # 1, 1, iter(range(n - 1))
        Instr("LOAD_GLOBAL", "range"),
        Instr("LOAD_FAST", "n"),
        Instr("LOAD_CONST", 1),
        Instr("BINARY_SUBTRACT"),
        Instr("CALL_FUNCTION", 1),
        Instr("GET_ITER"),
        # a, b, <iter>
        LOOP_START,
        Instr("FOR_ITER", LOOP_END),
        Instr("POP_TOP"),
        # a, b
        Instr("STORE_FAST", "iter"),
        # a, b, b
        Instr("DUP_TOP"),
        # b, a, b
        Instr("ROT_THREE"),
        # b, a + b
        Instr("BINARY_ADD"),
        Instr("LOAD_FAST", "iter"),
        # b, a + b, <iter>
        Instr("JUMP_ABSOLUTE", LOOP_START),
        LOOP_END,
        Instr("RETURN_VALUE"),
    ]
)
code.argnames = ["n"]
code.argcount = 1
fib_manual = FunctionType(code.to_code(), {"range": range}, "fib_manual")


# Recriamos fib-while manualmente
code = Bytecode(
    [
        # 1, 1, n
        Instr("LOAD_CONST", 1),
        Instr("LOAD_CONST", 1),
        Instr("LOAD_FAST", "n"),
        LOOP_START,
        # a, b
        Instr("STORE_FAST", "n"),
        # a, b, b
        Instr("DUP_TOP"),
        # b, a, b
        Instr("ROT_THREE"),
        # b, a + b
        Instr("BINARY_ADD"),
        # b, a + b, n - 1
        Instr("LOAD_FAST", "n"),
        Instr("LOAD_CONST", 1),
        Instr("INPLACE_SUBTRACT"),
        # b, a + b, n - 1, n - 1 <= 1
        Instr("DUP_TOP"),
        Instr("LOAD_CONST", 1),
        Instr("COMPARE_OP", Compare.LE),
        Instr("POP_JUMP_IF_FALSE", LOOP_START),
        LOOP_END,
        Instr("POP_TOP"),
        Instr("RETURN_VALUE"),
    ]
)
code.argnames = ["n"]
code.argcount = 1
fib_while_manual = FunctionType(code.to_code(), {"range": range}, "fib_while_manual")

# Valores
print(f"{fib(N)=}\n{fib_while(N)=}\n{fib_manual(N)=}\n{fib_while_manual(N)=}\n")

# Tempos de execução
print(
    "t_fib =",
    timeit.timeit(f"fib({N})", globals=globals(), number=N_TIMES),
)
print(
    "t_fib_while =",
    timeit.timeit(f"fib_while({N})", globals=globals(), number=N_TIMES),
)
print(
    "t_fib_manual=",
    timeit.timeit(f"fib_manual({N})", globals=globals(), number=N_TIMES),
)
print(
    "t_fib_while_manual=",
    timeit.timeit(f"fib_while_manual({N})", globals=globals(), number=N_TIMES),
)

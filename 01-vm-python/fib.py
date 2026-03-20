import dis
import timeit
from types import FunctionType

from bytecode import Bytecode, Compare, Instr, Label

N_TIMES = 3_000_000


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
        # a = 1
        Instr("LOAD_CONST", 1),
        Instr("STORE_FAST", "a"),
        # b = a
        Instr("LOAD_CONST", 1),
        Instr("STORE_FAST", "b"),
        # range(n - 1)
        Instr("LOAD_GLOBAL", "range"),
        Instr("LOAD_FAST", "n"),
        Instr("LOAD_CONST", 1),
        Instr("BINARY_SUBTRACT"),
        Instr("CALL_FUNCTION", 1),
        Instr("GET_ITER"),
        # for _ in TOS:
        LOOP_START,
        Instr("FOR_ITER", LOOP_END),
        Instr("STORE_FAST", "_"),
        # aux = b
        Instr("LOAD_FAST", "b"),
        Instr("STORE_FAST", "aux"),
        # b = a + b
        Instr("LOAD_FAST", "a"),
        Instr("LOAD_FAST", "b"),
        Instr("BINARY_ADD"),
        Instr("STORE_FAST", "b"),
        # a = aux
        Instr("LOAD_FAST", "aux"),
        Instr("STORE_FAST", "a"),
        # fim do loop
        Instr("JUMP_ABSOLUTE", LOOP_START),
        LOOP_END,
        # return b
        Instr("LOAD_FAST", "b"),
        Instr("RETURN_VALUE"),
    ]
)
code.argnames = ["n"]
code.argcount = 1
fib_manual = FunctionType(code.to_code(), {"range": range}, "fib_manual")


# Recriamos fib-while manualmente
code = Bytecode(
    [
        # a = 1
        Instr("LOAD_CONST", 1),
        Instr("STORE_FAST", "a"),
        # b = a
        Instr("LOAD_CONST", 1),
        Instr("STORE_FAST", "b"),
        # while n > 1:
        LOOP_START,
        Instr("LOAD_FAST", "n"),
        Instr("LOAD_CONST", 1),
        Instr("COMPARE_OP", Compare.GT),
        Instr("POP_JUMP_IF_FALSE", LOOP_END),
        # aux = b
        Instr("LOAD_FAST", "b"),
        Instr("STORE_FAST", "aux"),
        # b = a + b
        Instr("LOAD_FAST", "a"),
        Instr("LOAD_FAST", "b"),
        Instr("BINARY_ADD"),
        Instr("STORE_FAST", "b"),
        # a = aux
        Instr("LOAD_FAST", "aux"),
        Instr("STORE_FAST", "a"),
        # n -= 1
        Instr("LOAD_FAST", "n"),
        Instr("LOAD_CONST", 1),
        Instr("INPLACE_SUBTRACT"),
        Instr("STORE_FAST", "n"),
        # fim do loop
        Instr("JUMP_ABSOLUTE", LOOP_START),
        LOOP_END,
        # return b
        Instr("LOAD_FAST", "b"),
        Instr("RETURN_VALUE"),
    ]
)
code.argnames = ["n"]
code.argcount = 1
fib_while_manual = FunctionType(code.to_code(), {"range": range}, "fib_while_manual")

# Valores
print(f"{fib(10)=}\n{fib_while(10)=}\n{fib_manual(10)=}\n{fib_while_manual(10)=}\n")

# Tempos de execução
print(
    "t_fib =",
    timeit.timeit("fib(10)", globals=globals(), number=N_TIMES),
)
print(
    "t_fib_while =",
    timeit.timeit("fib_while(10)", globals=globals(), number=N_TIMES),
)
print(
    "t_fib_manual=",
    timeit.timeit("fib_manual(10)", globals=globals(), number=N_TIMES),
)
print(
    "t_fib_while_manual=",
    timeit.timeit("fib_while_manual(10)", globals=globals(), number=N_TIMES),
)

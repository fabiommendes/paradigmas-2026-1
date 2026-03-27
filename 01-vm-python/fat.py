from bytecode import Bytecode, Instr, Label, Compare
from types import FunctionType
import timeit


def fat_py(n):
    acc = 1
    while n > 0:
        acc = n * acc
        n = n - 1
    return acc


BEGIN_OF_LOOP = Label()
END_OF_LOOP = Label()

code = Bytecode(
    [
        # > acc, n
        Instr("LOAD_CONST", 1),
        Instr("LOAD_FAST", "n"),
        BEGIN_OF_LOOP,
        # Condicao do loop
        # > acc, n, n, 0
        Instr("DUP_TOP"),
        Instr("LOAD_CONST", 0),
        # > acc, n, n > 0
        Instr("COMPARE_OP", Compare.GT),
        # > acc, n
        Instr("POP_JUMP_IF_FALSE", END_OF_LOOP),
        # Bloco de código do loop
        # > acc, n, acc, n
        Instr("DUP_TOP_TWO"),
        # > acc, n, acc * n
        Instr("BINARY_MULTIPLY"),
        # > acc * n, acc, n
        Instr("ROT_THREE"),
        # > acc * n, n
        Instr("ROT_TWO"),
        Instr("POP_TOP"),
        # > acc * n, n, 1
        Instr("LOAD_CONST", 1),
        # > acc * n, n - 1
        Instr("BINARY_SUBTRACT"),
        Instr("JUMP_ABSOLUTE", BEGIN_OF_LOOP),
        END_OF_LOOP,
        # > acc, n
        # > acc
        Instr("POP_TOP"),
        Instr("RETURN_VALUE"),
    ]
)
code.argcount = 1
code.argnames = ["n"]

fat = FunctionType(code.to_code(), {}, "fat")

N = 100_000

dt_py = timeit.timeit("f(10)", number=N, globals={"f": fat_py})
dt_stack = timeit.timeit("f(10)", number=N, globals={"f": fat})

print(f"Implementação manual: {dt_stack}")
print(f"Implementação python: {dt_py}")

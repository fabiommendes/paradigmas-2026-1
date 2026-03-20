import dis
import timeit
from types import FunctionType

from bytecode import Bytecode, Instr, Label

N_TIMES = 3_000_000


def fat(n):
    acc = 1
    for n in range(2, n + 1):
        acc *= n
    return acc


dis.dis(fat)

# Recriamos fat manualmente
LOOP_START = Label()
LOOP_END = Label()

# code = Bytecode(
#     [
#         # acc, n
#         Instr("LOAD_CONST", 1),
#         Instr("LOAD_FAST", "n"),
#         LOOP_START,
#         # acc, n, n
#         Instr("DUP_TOP"),
#         # n, acc, n
#         Instr("ROT_THREE"),
#         # n, acc
#         Instr("BINARY_MULTIPLY"),
#         # acc, n - 1
#         Instr("ROT_TWO"),
#         Instr("LOAD_CONST", 1),
#         Instr("INPLACE_SUBTRACT"),
#         # acc, n', n'
#         Instr("DUP_TOP"),
#         # acc, n', n' > 0
#         Instr("LOAD_CONST", 0),
#         Instr("COMPARE_OP", Compare.GT),
#         Instr("POP_JUMP_IF_TRUE", LOOP_START),
#         # acc
#         Instr("POP_TOP"),
#         Instr("RETURN_VALUE"),
#     ]
# )
code = Bytecode(
    [
        Instr("LOAD_CONST", 1),
        # > acc (= 1)
        Instr("LOAD_GLOBAL", "range"),
        Instr("LOAD_CONST", 2),
        Instr("LOAD_FAST", "n"),
        Instr("LOAD_CONST", 1),
        Instr("BINARY_ADD"),
        # > acc, range, 2, n + 1
        Instr("CALL_FUNCTION", 2),
        Instr("GET_ITER"),
        # > acc, iter(range(2, n + 1))
        Instr("DUP_TOP"),
        # > acc, <iter>, <iter>
        Instr("STORE_FAST", "iter"),
        # > acc, <iter>
        LOOP_START,
        Instr("FOR_ITER", LOOP_END),
        # > acc, <iter>, n
        Instr("ROT_TWO"),
        Instr("POP_TOP"),
        # > acc', n
        Instr("BINARY_MULTIPLY"),
        Instr("LOAD_FAST", "iter"),
        # > acc', <iter>
        Instr("JUMP_ABSOLUTE", LOOP_START),
        LOOP_END,
        # > acc'
        Instr("RETURN_VALUE"),
    ]
)
code.argnames = ["n"]
code.argcount = 1
code.name = "fat_manual"
fat_manual = FunctionType(code.to_code(), globals(), "fat_manual")

# Valores
print(f"{fat(10)=}\n{fat_manual(10)=}\n")

# Tempos de execução
print(
    "t_fat =",
    timeit.timeit("fat(10)", globals=globals(), number=N_TIMES),
)
print(
    "t_fat_manual=",
    timeit.timeit("fat_manual(10)", globals=globals(), number=N_TIMES),
)

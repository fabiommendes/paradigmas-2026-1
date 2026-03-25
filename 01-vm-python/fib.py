import dis
from bytecode import Bytecode, Instr, Label
from types import FunctionType

def fibr(n):
    return 1 if n < 2 else fibr(n - 1) + fibr(n - 2)


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
        # x = 1
        Instr("LOAD_CONST", 1),
        Instr("STORE_FAST", "x"),
        # y = 1
        Instr("LOAD_CONST", 1),
        Instr("STORE_FAST", "y"),
        # iter(range(n))
        Instr("LOAD_GLOBAL", "range"),
        Instr("LOAD_FAST", "n"),
        Instr("CALL_FUNCTION", 1),
        Instr("GET_ITER"),
        # for _ in TOS:
        BEGIN_OF_LOOP,
        Instr("FOR_ITER", END_OF_LOOP),
        Instr("STORE_FAST", "_"),
        # aux = y
        Instr("LOAD_FAST", "y"),
        Instr("STORE_FAST", "aux"),
        # y = x + y
        Instr("LOAD_FAST", "x"),
        Instr("LOAD_FAST", "y"),
        Instr("BINARY_ADD"),
        Instr("STORE_FAST", "y"),
        # x = aux
        Instr("LOAD_FAST", "aux"),
        Instr("STORE_FAST", "x"),
        Instr("JUMP_ABSOLUTE", BEGIN_OF_LOOP),
        END_OF_LOOP,
        # return x
        Instr("LOAD_FAST", "x"),
        Instr("RETURN_VALUE"),
    ]
)
code.argcount = 1
code.argnames = ["n"]

fib = FunctionType(code.to_code(), {"range": range}, "fib")


for i in range(10):
    print(fib(i))

# dis.dis(fib_py)

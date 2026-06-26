import shutil
import rich
from time import sleep

width, height = shutil.get_terminal_size()
for i in range(height):
    prefix = "" if i == 0 else "\n"
    rich.print(prefix + f'[on white]{width * " "}[/]', end="")

try:
    while True:
        sleep(1.0)
except BaseException:
    pass
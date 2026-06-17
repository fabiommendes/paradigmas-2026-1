#!/usr/bin/env python3
# Digite ./make_db.py <n> para gerar um arquivo tinder_db.pl com n fatos do tipo gosta(X, Y).

import sys
import random

names = ["joao", "maria", "jose", "cris", "eli", "gabi", "gil"]

try:
    n = int(sys.argv.pop())
except (IndexError, ValueError):
    n = 15

lines = []
while len(lines) < n:
    a = random.choice(names)
    b = random.choice(names)
    if a != b and (line := f"gosta({a}, {b}).") not in lines:
        lines.append(line)


with open("tinder_db.pl", "w") as f:
    f.write("% Arquivo gerado por make_tinder_db.py\n\n")
    f.write("% gosta(X, Y) => X gosta de Y\n")
    f.write("\n".join(lines))

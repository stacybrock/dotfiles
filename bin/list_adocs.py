from pathlib import Path

for p in Path('.').rglob('*.adoc'):
    print(p)

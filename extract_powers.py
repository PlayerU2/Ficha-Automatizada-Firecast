import re

with open('c:/Users/USER/ferramental-petrichor/livro/por-documento/2.4.md', 'r', encoding='utf-8', errors='ignore') as f:
    lines = f.readlines()

powers = []
current_power = None

for line in lines:
    if line.startswith('Lista de poderes'):
        continue
    if line.startswith('## Aba: pericias'):
        break
    
    if line.startswith(' ') and 'Tipo: ' in lines[lines.index(line) + 1] if lines.index(line) + 1 < len(lines) else False:
        current_power = line.strip()
        powers.append(current_power)
    
print("Found", len(powers), "powers:")
print(powers)

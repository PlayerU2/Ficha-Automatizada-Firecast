import re

with open('c:/Users/USER/ferramental-petrichor/livro/por-documento/2.4.md', 'r', encoding='utf-8', errors='ignore') as f:
    lines = f.readlines()

powers_md = []
for line in lines:
    if line.startswith('Lista de poderes'):
        continue
    if line.startswith('## Aba: pericias'):
        break
    
    if line.startswith(' ') and 'Tipo: ' in lines[lines.index(line) + 1] if lines.index(line) + 1 < len(lines) else False:
        powers_md.append(line.strip())

with open('catalogoPoderes.lua', 'r', encoding='utf-8', errors='ignore') as f:
    lua_content = f.read()

powers_lua = re.findall(r'nome = "(.*?)",', lua_content)

print("In MD:", len(powers_md))
print("In Lua:", len(powers_lua))

missing_in_lua = [p for p in powers_md if p not in powers_lua]
missing_in_md = [p for p in powers_lua if p not in powers_md]

print("Missing in Lua:", missing_in_lua)
print("Missing in MD:", missing_in_md)

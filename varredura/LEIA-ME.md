# Varredura do catálogo

**Esta pasta não pode ir para dentro do pacote do plugin.**

O Firecast carrega todo arquivo `.lua` do pacote como parte do plugin, e estes
scripts usam `dofile`, que só existe no Lua de linha de comando. Empacotados
junto, a ficha não abre.

Ela vive na raiz do repositório porque o `.rpk` é montado a partir dos arquivos
do plugin, não do repositório inteiro — mas confira antes de distribuir.

## O que faz

Percorre todas as 29 raças, 48 poderes, 36 subclasses e as qualidades e
defeitos do catálogo, aplicando cada um numa ficha limpa e conferindo se a
ficha entrega o que o catálogo promete:

- bônus de atributo prometido por característica racial foi aplicado
- teto de atributo elevado (9 ou 10) valendo no nível certo
- poder de atributo chegando a +6 no nível 5
- poder que promete uma qualidade realmente a concede
- poder que promete bônus em defesa realmente soma
- o `tier` de toda qualidade concedida existe no catálogo
- qualidades com efeito numérico somando o valor certo
- efeitos permanentes de subclasse

## Como rodar

Precisa do interpretador Lua 5.3.

```bash
cd varredura
lua5.3 varre_tudo.lua
```

Sai um resumo com as contagens e, se houver, a lista de **FALHAS**.
"SEM FALHAS" significa que catálogo e ficha estão coerentes.

## Quando rodar

Sempre que um catálogo for regerado a partir do livro, ou depois de mexer nas
automações de concessão, bônus e cálculos.

## Atualizando após editar a ficha

`bloco_tudo.lua` é uma cópia do bloco Lua do `ficha.lfm`. Depois de editar a
ficha, extraia de novo:

```bash
python3 - <<'PY'
import io
c=io.open('../ficha.lfm',encoding='utf-8').read()
i=c.index('        -- =================================================================\n        -- PODERES\n')
j=c.index('        function inicializarFicha()')
io.open('bloco_tudo.lua','w',encoding='utf-8').write(c[i:j])
PY
```

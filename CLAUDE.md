# Ficha de Petrichor — o plugin

Esta pasta é compilada **inteira** pelo `rdk`. Nada que não seja do plugin pode
morar aqui — a checagem 36 cobra isso, e ela abre o `.rpk` para conferir em vez
de adivinhar. (O `.git` é exceção medida: o rdk o pula.)

**O ferramental está no outro repositório**, ao lado: `firecast-mcp/`, com as
três redes de verificação, o servidor MCP e o corpus do livro. O contexto do
projeto — decisões de mesa, regras confirmadas, o que já custou caro — está em
`docs/CONTEXTO-PETRICHOR.md`, **lá**, e manda sobre o livro onde os dois
divergirem.

## Antes de entregar

```
verificar   →  44 checagens de empacotamento
testes      →  243 asserções em Lua puro
mutacao     →  173 mutações (~10 min)
rdk l       →  lint do SDK
rdk i       →  instala; depois FECHE o Firecast por completo
```

E **confira o zip depois de gerado** — conferir o que você editou não prova
nada sobre o que o usuário instala.

Ao mexer num kit divino, rode `verif/gera_catalogo_poderes.py`: a lista do
catálogo de poderes é gerada, e a checagem 44 acusa até você regerar.

## Aqui o erro é silencioso

Widget que não existe devolve `nil`, o `if ~= nil` engole, e a tela **mantém o
estado anterior** — que costuma parecer certo. Daí as regras que parecem
paranoia e não são:

- **carimbe a versão na tela** e confira o selo contra o `module.xml`. Metade
  das conversas de "continua igual" é versão antiga instalada;
- **toda recusa diz o que a ficha está vendo** (`[a ficha vê na sua lista: …]`).
  Essa terceira parte resolve sozinha uma conversa de três mensagens;
- **todo valor calculado tem ajuste manual ao lado.** A mesa sempre tem um caso
  que o livro não previu.

## Armadilhas do SDK que custaram caro

- **`<layout>` não recebe `onClick`.** O clique não dispara *e* o Lua não acha
  os filhos. São 1.751 `<rectangle>` clicáveis e zero `<layout>`: o código
  instalado já dizia qual é o padrão.
- **Irmãos são posicionados na ordem em que aparecem.** Um `align="client"`
  declarado antes come a linha, e o painel seguinte nasce com largura zero para
  sempre.
- **`local` só existe a partir da linha em que é declarado.** Uma função escrita
  acima enxerga um global de mesmo nome, que é `nil` — e compila sem reclamar.
- **`visible=` em `align="top"` REORDENA o layout.** Use largura ou altura zero.
- **`field=` grava direto no NDB**, sem passar por Lua. A única trava possível é
  `setEnabled(false)`.
- **A arte de pacote não escala** (`style="originalSize"`, decisão de mesa): dois
  tamanhos são dois arquivos.
- **`#texto` conta bytes, não caracteres.**

## Quando a bateria estiver verde

Não é o mesmo que certo na tela. Peça o print — os dois piores achados desta
história apareceram usando a ficha, não rodando a bateria.

# Ficha de Petrichor — as instruções estão no CLAUDE.md

As instruções deste repositório vivem em `CLAUDE.md`, na raiz. Elas valem para
qualquer assistente, não só para o Claude: **leia o arquivo inteiro antes de
mexer em qualquer coisa.**

O que não pode ser esquecido nem por um instante:

- **Antes de apagar, sobrescrever ou renomear um arquivo, mostre o que vai
  mudar e espere confirmação.**
- **Nunca invente uma regra.** Cite o texto do livro
  (`..\firecast-mcp\livro\por-documento\`) num comentário antes de programar.
  Não achou o texto? Pergunte.
- O contexto do sistema está em `..\firecast-mcp\docs\CONTEXTO-PETRICHOR.md`
  e **manda sobre o livro** onde os dois divergirem.
- **Verificação mede a saída, não a intenção.** Rode as redes antes de mexer,
  para ter linha de base, e de novo antes de entregar.
- **Nunca confie em contagem escrita à mão** — nem nas do CLAUDE.md. O número
  atual sai de rodar a bateria. Medido em 06/09/2026: 50 checagens e 295
  asserções, enquanto o CLAUDE.md ainda dizia 46 e 289.

Esta pasta é compilada **inteira** pelo `rdk`: nada que não seja do plugin pode
morar aqui. O ferramental fica no repositório ao lado, `firecast-mcp`.
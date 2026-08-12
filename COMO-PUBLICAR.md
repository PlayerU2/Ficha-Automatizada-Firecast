# Como publicar no GitHub

O repositório já está pronto e com o primeiro commit feito. Faltam dois passos.

## 1. Criar o repositório vazio no GitHub

Em <https://github.com/new>:

- **Nome:** `petrichor-ficha` (ou o que preferir)
- **Descrição:** `Ficha de personagem automatizada para Firecast VTT — sistema Crônicas de Petrichor`
- Público ou privado, como quiser
- **NÃO** marque "Add a README", "Add .gitignore" nem "Choose a license" —
  eles já existem aqui e criariam conflito

## 2. Enviar

Na pasta do projeto, troque `SEU-USUARIO` pelo seu nome de usuário:

```bash
git remote add origin https://github.com/SEU-USUARIO/petrichor-ficha.git
git branch -M main
git push -u origin main
```

Se usar SSH em vez de HTTPS:

```bash
git remote add origin git@github.com:SEU-USUARIO/petrichor-ficha.git
git branch -M main
git push -u origin main
```

Pronto. Dali em diante, o ciclo normal:

```bash
git add -A
git commit -m "o que mudou"
git push
```

## Depois de publicar

Edite o `README.md` e troque `SEU-USUARIO` no comando de clone pela URL real
do seu repositório.

## Sobre as fontes

As quatro famílias em `fonts/` (Cinzel, Cinzel Decorative, Marcellus SC e
EB Garamond) são da Google Fonts, sob licença SIL Open Font License, que
permite redistribuição. Se o repositório for público, vale adicionar os
arquivos de licença delas numa pasta `fonts/licencas/`.

## Sobre o conteúdo de regras

Os catálogos reproduzem dados do livro de Petrichor. Se o repositório for
público e o sistema não for material aberto, considere deixá-lo privado, ou
combinar com quem escreveu o sistema antes de publicar.

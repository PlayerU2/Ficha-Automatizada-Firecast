# Servidores MCP do projeto

Este repositório declara servidores MCP (Model Context Protocol) em
[`.mcp.json`](./.mcp.json). Quando você abre o projeto no Claude Code, ele
detecta esse arquivo e oferece a conexão com os servidores listados (com sua
aprovação).

## nano-banana

Gerador de imagens que usa a API do Google Gemini.

- **Comando:** `npx nano-banana-mcp`
- **Chave necessária:** `GEMINI_API_KEY`

### Como habilitar

A chave **não** fica no repositório — o `.mcp.json` a lê da variável de
ambiente `GEMINI_API_KEY`. Defina-a antes de iniciar o Claude Code:

```bash
# Linux / macOS
export GEMINI_API_KEY="sua-chave-do-gemini"

# Windows (PowerShell)
$env:GEMINI_API_KEY = "sua-chave-do-gemini"
```

Pegue sua chave em <https://aistudio.google.com/apikey>.

### Alternativa: adicionar via CLI

Sem usar o arquivo do projeto, você também pode registrar o servidor
diretamente no Claude Code:

```bash
claude mcp add nano-banana --env GEMINI_API_KEY=sua-chave -- npx nano-banana-mcp
```

> Observação: o nano-banana é um servidor MCP **local** (roda na sua máquina
> via `npx`). Ele não aparece na lista de "conectores" de claude.ai, que é
> reservada a integrações remotas gerenciadas na sua conta.

# Crônicas de Petrichor — Ficha de Personagem

Ficha automatizada para o **Firecast VTT**, feita sob medida para o sistema
Petrichor: um d20 de semideuses, bênçãos divinas e linhagens.

A ficha calcula sozinha o que o livro manda calcular, aplica os efeitos de
raça, poderes, classes e itens equipados, e mostra **a conta atrás de cada
número** — para o jogador conferir sem abrir o livro e o mestre auditar de
relance.

<p align="center">
  <img alt="versão" src="https://img.shields.io/badge/versão-0.30.1-C9A24B">
  <img alt="Firecast SDK" src="https://img.shields.io/badge/Firecast%20SDK-3.7b-8A63C9">
  <img alt="Lua" src="https://img.shields.io/badge/Lua-5.3-000080">
</p>

---

## O que ela faz

**Nove seções**, cada uma alimentando a seguinte:

| # | Seção | O que resolve |
|---|-------|---------------|
| 1 | Perfil | Identidade, aspecto divino, traços de personalidade, XP com subida automática de nível |
| 2 | Atributos & Perícias | Economia de pontos, limites por nível, rolagem pronta de cada perícia |
| 3 | Qualidades & Defeitos | Economia de PQ/PD, tiers, efeitos numéricos automáticos |
| 4 | Raça & Classe | 29 raças, mestiçagem, 12 classes e 36 subclasses |
| 5 | Poderes & Habilidades | Kits das 18 divindades, economia de pontos, construtor de habilidades |
| 6 | Cálculos & Combate | Vida, Aura, Mana, Prana, Vitae, quatro defesas, movimento e ações |
| 7 | Inventário | 214 itens, 64 encantamentos, oito slots de equipado, bolsa de moedas |
| 8 | Favores Divinos | Favores por divindade, trocas, bênçãos e proclamação |
| 9 | Background | Campo livre com formatação e imagens |

### Automações que valem o preço

- **Concessões automáticas** — a característica racial dos Drow concede a
  perícia Animais; Constituição sobrenatural nível 1 dá a qualidade Vigor
  expandido. São 28 concessões mapeadas, todas reversíveis: tirou a fonte,
  o efeito sai junto.
- **Cada valor mostra sua origem** — `15 + 10 + (Con 5÷2 × 7)` embaixo dos
  Pontos de Vida, `9 + Força 5 + prof 3` embaixo da Defesa.
- **Equipar aplica tudo** — escudo soma em Aparar, armadura dá absorção e tira
  deslocamento, acessório bonifica a perícia que nomeia. Guardar na mochila
  zera o bônus na hora.
- **Limites que se aplicam sozinhos** — o teto do nível vale para todos os
  atributos; o teto racial de 9 ou 10 só entra a partir do nível 17.
- **Válvula de escape em tudo** — todo cálculo automático tem campo de ajuste
  manual ao lado. Automação que prende o usuário é automação ruim.

---

## Instalação

Precisa do [Firecast SDK 3](https://firecast.com.br) instalado.

```bash
git clone https://github.com/SEU-USUARIO/petrichor-ficha.git
cd petrichor-ficha
rdk i
```

> **Importante:** apague a pasta `output/` antes de compilar, se ela existir
> dentro do projeto — ela causa erro de "form declarado duas vezes".
>
> Depois de `rdk i`, **feche e reabra o Firecast por inteiro**. Recarregar só
> a ficha não limpa o cache, e você vai depurar um bug que já foi corrigido.

Para gerar o `.rpk` distribuível:

```bash
rdk c
```

---

## Estrutura

```
ficha.lfm                     a ficha inteira: XML das 9 abas + 8.200 linhas de Lua
module.xml                    manifesto do plugin
calculos.lua                  fórmulas do livro, isoladas e testáveis
dadosSistema.lua              tabela de evolução: nível, rank, proficiência, XP
catalogoItens.lua             214 itens com preço, dano, requisito e efeitos
catalogoEncantamentos.lua     64 encantamentos em três classes
catalogoPoderes.lua           48 poderes com progressão de 5 níveis
catalogoRacas.lua             29 raças com características e bônus
catalogoQualidadesDefeitos.lua 49 qualidades e defeitos
catalogoDeuses.lua            30 divindades e seus kits
catalogoClasses.lua           12 classes, 36 subclasses
catalogoPericias.lua          64 perícias por atributo
catalogoHabilidades.lua       balanceamento de rank, tags e conflitos
catalogoTracos.lua            36 traços de personalidade com seus opostos
itens/                        templates das linhas de lista (perícia, item, qualidade…)
fonts/                        Cinzel, Cinzel Decorative, Marcellus SC, EB Garamond
```

Os catálogos são **gerados a partir do livro de regras**, não digitados à mão.
Quando o sistema muda, regera-se o catálogo e a varredura confere se a ficha
continua coerente.

---

## Verificação

O projeto tem duas redes de segurança, e as duas nasceram de bugs reais.

### Varredura do catálogo

Percorre **29 raças, 48 poderes, 36 subclasses e todas as qualidades**,
aplicando cada uma numa ficha limpa e conferindo se a ficha entrega o que o
catálogo promete:

```bash
cd varredura
lua5.3 varre_tudo.lua
```

> A pasta `varredura/` **não pode ir para dentro do projeto do plugin**: o
> Firecast carrega todo `.lua` do pacote, e esses scripts usam `dofile`, que
> não existe naquele ambiente. Deixe-a ao lado.

### Checagens de empacotamento

Antes de cada entrega, o projeto verifica:

- XML bem-formado em todos os `.lfm`
- **cada bloco `CDATA` compilado como Lua** — são 1.524, e um `onClick`
  malformado passa por todas as outras checagens
- **o bloco `<script>` inteiro compilado**, não um recorte
- **`local` usada antes de ser declarada** — em Lua isso compila e vira `nil`
  em execução; já derrubou a ficha quatro vezes
- nomes de tag duplicados (o Firecast exige nome único)
- widgets referenciados no Lua mas ausentes do XML
- `dofile`, `io.open` e afins dentro do pacote
- valores inválidos em `align`, `horzTextAlign` e `vertTextAlign`

---

## Armadilhas do Firecast

Anotadas aqui porque custaram caro:

- **`local` só existe a partir da linha em que aparece.** Uma função declarada
  no meio do arquivo é `nil` para tudo que vem antes — e o Lua compila sem
  reclamar.
- **Só um filho pode ter `align="client"` por layout.** Os demais somem sem
  aviso.
- **`setVisible(false→true)` em `align="top"` reordena o elemento** para o topo
  da pilha. Use altura zero.
- **Larguras não existem no primeiro desenho.** Meça o `scrollBox` ou o painel,
  e ignore valores absurdamente pequenos.
- **`field=` dentro de `<popup>` resolve contra a ficha raiz**, não contra o
  item da lista. Carregue e salve manualmente.
- **Funções nomeadas dentro de templates de `recordList` viram globais** — a
  última linha criada sobrescreve todas as anteriores.
- **Nunca apague o nó NDB container de uma `recordList`.** O widget perde o
  vínculo e só se recupera reabrindo a ficha.
- **`#texto` conta bytes, não caracteres.** Em português isso são uns 10% de
  diferença.

---

## Créditos

Sistema **Crônicas de Petrichor** e todo o conteúdo de regras: da mesa.

Ficha desenvolvida para uso na campanha. Os catálogos reproduzem dados do
livro de regras e existem para automatizar a ficha — não substituem o material
original.

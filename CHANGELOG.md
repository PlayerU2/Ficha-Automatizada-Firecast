# Changelog — Ficha Petrichor

## v0.30.1 — correção: a ficha não abria

### Corrigido — `partirTexto` era usada antes de existir
`lerTracos` ficou na linha 524 e chamava `partirTexto`, que só era declarada na
linha 3053. Como é uma `local`, em Lua ela não existe antes dessa linha — o
arquivo compila normalmente e o erro só aparece quando o jogador abre a ficha.

A função foi para o topo do arquivo, junto dos outros utilitários, com um
comentário explicando por que precisa ficar ali.

### Duas verificações novas no build
Esta é a **quarta vez** que essa armadilha aparece no projeto — antes com
`dataHoraTexto`, `ATRIBUTOS_DA_FICHA` e `SLOTS_EQUIPADOS`. Agora o
empacotamento acusa:

1. **`local` usada antes da declaração** — varre o bloco de script comparando a
   linha de uso com a de declaração.
2. **O bloco `<script>` inteiro é compilado**, e não um recorte a partir de
   "PODERES" como eu vinha fazendo. Um `end` sobrando ou faltando fora do
   trecho recortado passava batido — foi exatamente o que aconteceu ao mover a
   função, e a checagem nova pegou na hora.

## v0.30.0 — múltiplos traços de personalidade

### Adicionado — o personagem pode acumular traços
A narrativa pode conceder um traço novo ou tirar um existente, e a ficha
guardava só um valor. Agora guarda uma **lista**.

No popup, clicar num traço concede; clicar de novo remove. O campo no Perfil
passa a mostrar todos, separados por ponto.

**Só o mestre altera**, já que é ganho de narrativa oficial — e toda concessão
ou remoção é publicada no chat.

### Opostos: aviso, não bloqueio
Em regra não se tem Lascivo e Casto ao mesmo tempo, mas quem maneja isso é o
mestre. A ficha aceita os dois e avisa — "em regra não se tem os dois, confira"
— marcando o par com **(!)** no campo do Perfil.

### Compatibilidade
O campo é o mesmo de antes (`tracoPersonalidade`), agora com os nomes separados
por `;`. Fichas com um traço só continuam valendo: viram uma lista de um item,
sem nenhuma migração.

## v0.29.1 — ajuste fino das travas

### Corrigido — o popup de habilidade não abria com a ficha finalizada
Era o erro mais atrapalhado: o popup guarda o dado, o alcance, a duração e o
efeito da habilidade, que o jogador precisa consultar em jogo — e a trava
impedia até de abrir.

Agora ele **abre sempre**; quem trava é o botão de salvar, com um aviso dentro
do próprio popup dizendo que dá para consultar mas não alterar.

### Travado — o que faltava
- **Perícias**: adicionar, remover (o "x" da linha) e limpar a lista.
- **Atributos**: o valor **base** de cada um dos sete fica somente leitura,
  em cinza. Os campos de **bônus** seguem livres, assim como o **ajuste
  manual** das perícias — os dois mudam em jogo, com item equipado, feitiço ou
  bênção temporária.
- **Classe e subclasse**: definir, mudar de nível e remover.

### Auditoria
Varri de novo todas as funções que gravam dados de criação — classe, raça,
perícia, poder, item, favor e qualidade. As únicas sem trava são as quatro
ações de jogo, de propósito: equipar, desequipar, mover na mochila e gastar
munição.

### Background maior
Cabeçalho e linha do link ficaram mais enxutos, e as margens da aba diminuíram.
Toda a altura que sobrou foi para a área de escrita.

## v0.29.0 — texto formatado no Background e revisão das travas

### Adicionado — formatação e imagens no Background
O campo passou de `textEditor` para **`richEdit`**, que traz a barra de
formatação do próprio Firecast: negrito, itálico, tamanho, cor, alinhamento,
listas e imagens coladas. O `textEditor` só guardava texto puro.

O contador de caracteres saiu junto — o `richEdit` guarda texto formatado e não
dispara o evento que alimentava a contagem. No lugar, uma linha discreta
lembra que a formatação aparece ao selecionar o texto.

### Corrigido — a trava de "ficha finalizada" não alcançava as abas novas
Auditei as 18 funções que gravam dados. Nove não checavam a trava — todas nas
abas construídas depois que ela foi criada.

A revisão também separou **o que é criação do que é jogo**:

**Travado** (só o mestre libera): adicionar e remover item, editar os atributos
de um item, aplicar encantamento, escolher atributo ou perícia do item,
escolher a defesa do escudo psíquico, o atributo favorecido pela raça e a
defesa mental do Drow.

**Livre mesmo com a ficha finalizada**: equipar e desequipar, mover para
mochila ou baú, e gastar ou repor munição. Travar isso obrigaria a chamar o
mestre a cada troca de arma no meio do combate.

### Limpeza
Removidas três referências a widgets que não existem mais desde que a aba de
Combate foi refeita. Estavam protegidas por `~= nil` e não quebravam nada, mas
eram código morto.

## v0.28.1 — Background como campo livre

### Alterado — sem roteiro de perguntas nem validação de tamanho
As histórias da mesa já estão escritas, então a ficha não tem o que cobrar. Os
sete campos, o contador de perguntas respondidas e a barra de progresso saíram.

A aba virou **um campo único ocupando toda a altura**, para história e
anotações de sessão no mesmo lugar. Um contador discreto de caracteres fica no
canto superior, apenas informativo.

Aparência e Personalidade voltaram a existir só na aba de Perfil, onde já
estavam — não fazia sentido duplicar.

### Preservado
O **campo de link** continua, com o botão que o publica no chat para o mestre
abrir. Espaços em volta do endereço são descartados.

O texto de quem já usava o campo `background` segue intacto: é o mesmo campo.

## v0.28.0 — aba Background e reordenação das abas

**A ficha está com as nove abas construídas.**

### Alterado — Inventário passou para a posição 7
Inventário e Favores trocaram de lugar, e o Inventário vem logo depois de
Cálculos & Combate. Só a tabela de abas mudou: os painéis já eram
desacoplados da ordem, então nada mais precisou ser mexido.

### Background — as sete perguntas como estrutura
O livro é categórico: a história vai de 5.000 a 20.000 caracteres e precisa
responder sete perguntas, e "não serão toleradas histórias que não respondam
essas questões".

Por isso a aba não é uma caixa de texto solta. Cada pergunta tem seu campo,
com o enunciado do livro acima e a contagem de caracteres ao lado. Uma barra
lateral fica verde quando a resposta passa de 80 caracteres — abaixo disso não
conta como respondida.

No topo: o total de caracteres, quantas das sete estão respondidas e uma barra
de progresso rumo ao mínimo. A cor muda conforme o estado, e uma linha diz
exatamente o que falta: quais perguntas estão em branco, quantos caracteres
faltam para o mínimo, ou quantos passaram do máximo.

Há também **campo de link**, já que o livro permite entregar por Google Docs,
e um botão que publica no chat um resumo com tamanho e perguntas respondidas —
útil na hora da revisão do mestre.

**Aparência** e **Personalidade** ganharam espaço próprio aqui, usando os
mesmos campos da aba de Perfil: escrever num lugar reflete no outro.

### Preservado
Quem já tinha texto no campo `background` da aba antiga não perde nada — ele
virou a seção "Outros trechos" e continua contando no total.

### Detalhe técnico
A contagem desconta os bytes de continuação UTF-8: `#texto` conta bytes, e uma
história em português tem centenas de acentos. Sem isso o contador acusaria uns
10% a mais de caracteres do que o jogador realmente escreveu.

## v0.27.6 — preços das granadas e textos capitalizados

### Corrigido — a Granada tinha o preço dentro da qualidade
Ela é o único consumível que usa o formato `[Comum - 5 Lunaris]`, e o extrator
de consumíveis tratava tudo entre colchetes como qualidade. Por isso aparecia
"Comum - 5 Lunaris" na coluna da direita e o preço saía vazio.

Ao separar os dois, apareceu um problema maior: **73 itens estavam sem preço**.
Os 72 pergaminhos têm tabela própria no livro (Rank D = 25 Lunaris,
Rank C = 1 Aureu), e o Elixir da Ira usa "Mediano" onde as outras poções usam
"Mediana". Todos os 214 itens estão precificados agora, e o build acusa se
algum ficar sem.

### Corrigido — textos começando em minúscula
O livro escreve os efeitos em minúscula ("ao ser consumido restaura...").
Foram capitalizados 143 textos no catálogo, e a ficha passou a capitalizar
também o que monta em tempo de execução — descrições de item, resumos e as
linhas do detalhe.

A função trata acentuadas corretamente ("água" vira "Água"), já que em UTF-8
elas ocupam dois bytes e `upper()` sozinho não as alcança.

## v0.27.5 — texto dos efeitos aparece por inteiro

### Corrigido — efeitos longos eram cortados com reticências
O campo de efeito era uma linha de 26px com `wordWrap="false"`, e **todos os
150 consumíveis** têm texto que passa disso — 113 passam de 100 caracteres e o
maior, a Granada de Artífice, tem 1118.

O efeito virou um **bloco**: rótulo em cima, texto ocupando a largura inteira
com quebra de linha, e altura calculada pelo tamanho do conteúdo. O mesmo para
a receita de forja e para a linha de defesas, que também podia passar de uma
linha.

O painel de detalhe passou a ter altura variável — a soma das linhas visíveis —
em vez de 420px fixos. Assim o scroll funciona de verdade e nenhum texto fica
escondido.

### Detalhe técnico
A altura é acumulada **enquanto** os campos são preenchidos, e não relendo
`.height` depois: logo após gravar, o layout ainda não redesenhou e a
propriedade devolve o valor antigo.

### Teste
Percorre os 214 itens do catálogo e confere que a altura reservada cobre o
texto de cada um. Nenhum é cortado: o maior ocupa 16 linhas, e o teto é 24.

## v0.27.4 — correção: nome de tag duplicado impedia a compilação

### Corrigido — "Tratar doença" aparecia duas vezes
No livro, o item seguinte tem a seta `→` sozinha numa linha e o nome
("Tratar ferimentos") só na linha de baixo. O extrator não reconhecia esse
formato, mantinha o nome anterior e gerava **dois "Tratar doença"** com as
mesmas qualidades.

Como o nome do widget vem de nome + qualidade, saíam duas tags
`itmL_TratardoencaRankD` — e o Firecast exige nome único no arquivo.

A correção recuperou também o **"Tratar ferimentos"**, que estava sendo
perdido: são 65 consumíveis distintos, não 64.

### Verificação nova no build
Duas checagens que teriam pego isso antes do `rdk`:

- o gerador do catálogo agora falha se dois itens tiverem o mesmo par
  nome + qualidade;
- o empacotamento acusa **qualquer tag com nome repetido** no `ficha.lfm`,
  ignorando os atributos `name` dos `<event>`, que nomeiam o evento e não a
  tag.

## v0.27.3 — consumíveis completos e interpretações corrigidas

### Corrigido — só 4 dos 150 consumíveis estavam no catálogo
A seção de Consumíveis usa um formato **diferente** do resto do livro: nome,
depois qualidade e efeito em linhas separadas, com o preço numa tabela à parte.
O extrator só entendia `[Qualidade - Preço]`, então os únicos que passavam eram
os Tônicos, por coincidência de formato.

Com um extrator próprio entraram **64 consumíveis distintos, em 150 variantes**:
alimentação, poções de Cura/Aura/Mana, ungentos, antídotos, elixires, tônicos,
as dez bombas elementais, granadas e os pergaminhos (imbuir elementos,
metamorfose, falar com animais…). Cada um com o efeito descrito, e as poções de
cura com o dado e a fórmula separados.

O catálogo passou de 68 para **214 itens**.

### Corrigido — REGRA: alcance da arma ≠ alcance extra da munição
Os Virotes davam "+2m de alcance", e o extrator lia como se fossem uma arma de
2 metros. São **metros somados ao alcance de quem atira**. Os dois valores
agora são campos distintos, e o detalhe do catálogo escreve
"+4 metros ao alcance da arma".

### Corrigido — REGRA: nem toda armadura deixa escolher as defesas
**Cinto do Gladiador** e **Colar do Resiliente** nomeiam quais duas defesas
recebem o bônus — as duas físicas e as duas mentais, respectivamente. A ficha
dizia "à sua escolha" para os dois.

Agora o catálogo distingue: quando as defesas são nomeadas, o texto diz
"distribuído entre Defesa Telepática e Defesa Empática — apenas essas duas";
quando é livre (as armaduras), continua dizendo à sua escolha.

### Melhorado — o detalhe do catálogo mostra tudo
Entraram as linhas de espaços de mochila, visão no escuro, capacidade, dano em
área, efeito e receita de forja. Antes vários acessórios apareciam sem nenhum
efeito visível no catálogo, embora funcionassem depois de adicionados.

## v0.27.2 — efeitos recuperados, seletores e editor redesenhado

### Corrigido — a extração descartava vários efeitos
Escrevi uma verificação que lista os trechos do livro que o extrator **não
reconhece**, e ela apontou dezoito padrões sendo jogados fora. Recuperados:

- **espaços de mochila** — Mochila do Peregrino dá +2 (Comum) e +4 (Ótima);
- **deslocamento positivo** — Botas de Corrida, +2 e +4 metros (o extrator só
  entendia o valor negativo das armaduras);
- **visão no escuro** — Óculos do Espião, +12m e +14m;
- **capacidade de munição** — Aljava, Cinto do Atirador e afins;
- **dano em área** dos tônicos;
- **bônus entre defesas ou perícias nomeadas** — Cinto do Gladiador, Colar do
  Resiliente, Caneta do Acadêmico, Jóia do Socialite;
- **receitas de forja** ("1x Aço e 1x Pólvora; Criação meta 16").

O que a ficha aplica sozinha entrou como campo. O que depende de escolha vira
texto na descrição do item, orientando: *"Distribua +2 entre Defesa Física -
Aparar e Defesa Física - Esquiva nos campos de defesa acima."*

### Adicionado — atributo e perícia agora são escolhidos, não digitados
Os dois campos abriam margem para erro de grafia, e nome errado significa
automação silenciosamente quebrada. Viraram seletores: o de atributo lista os
sete, o de perícia lista as 64 do catálogo agrupadas por atributo. Ambos têm a
opção de deixar vazio.

### Editor redesenhado
As alturas eram calculadas no olho e o grupo de encantamentos ficava espremido.
Agora cada linha de campos tem altura fixa e a altura do grupo é derivada dela,
com rótulo de 14px e caixa de 28px em todos.

Campos novos: **espaços de mochila**, **visão no escuro** e **munições** —
todos editáveis também em item livre.

### Alterado — criar item do zero
O campo de texto ao lado do botão saiu. O botão **CRIAR ITEM DO ZERO** cria um
item em branco e já abre o editor, onde o nome é definido junto com o resto.

## v0.27.1 — campos do editor e botões da linha

### Corrigido — campos do editor espremidos
Os grupos tinham 56px de altura, e ali precisam caber o título da seção (16),
o rótulo do campo (15) e a caixa de texto — sobrava quase nada, e o campo
virava uma linha fina. Só o grupo de Defesas, que já tinha 84, aparecia
corretamente.

Todos os grupos foram para 80px (Defesas 88, Encantamentos 128), e as alturas
usadas pelo código ao mostrar e ocultar passaram a bater com as do XML.

O grupo de Identidade também não estava na lista de grupos visíveis, e
aparecia por acidente — agora é sempre mostrado, de propósito.

### Corrigido — botões da linha do item espremidos e fora de ordem
Estavam em duas linhas, com o "x" na frente. Agora vão todos numa linha só,
dentro de um container com filhos `align="left"` — o mesmo padrão que resolveu
isso nas perícias e qualidades — na ordem:

    −  +  EDITAR  EQUIPAR  MOCHILA  BAÚ  x

com o **"x" por último, à direita de tudo**, como no resto da ficha.

### Melhorado — slots de encantamento
O campo já era editável, mas o rótulo dizia apenas "SLOTS". Passou a
"SLOTS MÁXIMOS", com a dica explicando que o número normalmente vem da
qualidade e do material, mas um item especial pode portar mais — e que dá para
aumentar à vontade.

## v0.27.0 — itens editáveis e encantamentos

### Mudança de modelo: cada item guarda os próprios valores
Antes o item era só uma referência ao catálogo, e a ficha lia os efeitos de
lá. Agora os valores são **copiados uma vez** ao adicionar, e dali em diante o
item vive por conta própria.

É o que permite uma armadura forjada, encantada ou danificada divergir do
modelo do livro — e é o que faz a edição valer imediatamente: os cálculos leem
o que está gravado no item, não o catálogo.

A serialização passou a ser por chave e valor, porque a lista de campos cresce
(material, durabilidade atual, encantamentos) e o formato por posição quebraria
a cada campo novo.

### Editor completo de item
Clicar no nome do item, no botão EDITAR ou num slot equipado abre um popup com
tudo que um item pode ter, agrupado por função:

**Identidade** (nome, qualidade, material) · **Durabilidade** (atual e máxima) ·
**Requisito** (atributo e valor mínimo) · **Dano e alcance** ·
**Bônus de defesa** (os quatro, separados) · **Proteção e carga** (absorção,
deslocamento, espaços extras) · **Bônus de perícia** · **Quantidade** ·
**Encantamentos** · **Descrição**.

Os grupos aparecem conforme a categoria: consumível não mostra campo de defesa,
armadura não mostra alcance. Item livre mostra todos.

Isso substituiu o seletor de "duas defesas" que existia antes — agora o jogador
escreve o valor direto na defesa que a armadura protege, o que também cobre
itens forjados fora do padrão.

### Encantamentos — 64 do livro
Catálogo próprio, separado por classe (I, II e III) com o preço fixo de loja.
Cinco deles têm efeito numérico que a ficha aplica sozinha: Incorporação
(+5% absorção), Incorporação melhorada (+10%), Incorporação Total (+15%),
Mente fortalecida (+2 telepática) e Contrabando (+3 espaços de mochila). Os
demais são narrativos e ficam registrados como texto no item.

O livro é claro que **só dá para encantar item que tenha slot**, e que ter slot
depende da qualidade e do material da forja — então o número de slots é um
campo editável, e a ficha recusa aplicar além dele.

### Catálogo em master-detail
Lista à esquerda, detalhe à direita com todos os campos do item: preço,
categoria, qualidade, material, durabilidade, dano, alcance, requisito,
defesas, absorção, deslocamento, bônus de perícia, munições e slots de
encantamento.

### Corrigido durante os testes
`SLOTS_EQUIPADOS` estava declarada depois das funções que a percorrem, e em Lua
uma local só existe a partir da linha em que aparece — nenhum item contava como
equipado. Movida para o topo do bloco.

## v0.26.1 — correção: o plugin não compilava

### Corrigido — um item do livro se chama literalmente "Mecânica", com aspas
O nome vinha do texto com as aspas incluídas, e ao gerar o `onClick` isso
fechava a string Lua no meio: `adicionarItemCatalogo(""Mecânica"","Ótima")`.
O `rdk i` acusava `')' expected near 'Mec'`.

Na verdade eram dois problemas somados:

1. **A extração pegou o nome errado.** Aquela linha era parte da descrição de
   outro item — um acessório cujo efeito é "+N distribuídos entre as perícias
   Ofícios, Forja, Alfaiataria ou Mecânica". O parser passou a exigir que o
   nome seja uma linha limpa: sem aspas, sem ponto-e-vírgula, sem conectivos.
   Com isso apareceu também um efeito que estava escapando: **bônus
   distribuível entre perícias**, das Jóias do Socialite e das Luvas do
   Operário.

2. **O gerador não escapava aspas.** Agora escapa em todas as strings, tanto no
   Lua quanto no XML, então um nome com aspas deixa de ser capaz de quebrar o
   arquivo.

### Verificação nova no build
O empacotamento agora **compila cada bloco CDATA como Lua**, um por um — são
1197 na ficha. Um `onClick` malformado passava por todas as checagens
anteriores (o XML era válido, o Lua do corpo principal era válido) e só
aparecia no `rdk`. Agora não passa mais.

## v0.26.0 — aba Inventário

A estrutura veio da própria ficha do livro: bolsa de moedas, oito slots de
equipado, mochila com capacidade e baú.

### Catálogo com 68 itens
Extraídos da seção "Equipamentos": armaduras, armas, escudos, projéteis,
acessórios e consumíveis, cada um em qualidade Comum e Ótima, com preço,
durabilidade, dado de dano, alcance, requisito de atributo, absorção,
penalidade de deslocamento e bônus de perícia.

Ao lado dele, o campo de **item livre** para o que não está no livro — entra na
ficha sem efeito automático, e por isso também sem travas.

### Equipar aplica tudo sozinho
- **Escudos** somam em Defesa - Aparar; **acessórios** somam na perícia que
  nomeiam; **armaduras** dão absorção e tiram deslocamento.
- **Armaduras que dizem "+N em duas defesas à escolha"** abrem um seletor: o
  jogador marca duas, e só essas recebem. A escolha fica gravada no item.
- **Requisito de atributo trava o equipar** — Armadura pesada com Força 2
  recusa e diz "Requer 4 de Força e você tem 2".
- Cada slot só aceita a categoria certa: armadura não vai na mão.
- **Só o que está equipado bonifica.** Guardar o escudo na mochila zera o
  bônus na hora.

### Mochila com a regra dos lotes
A capacidade é a que a aba de Combate já calculava, e a contagem segue o livro:
**cada lote de 2 consumíveis iguais ocupa 1 espaço**. Quatro lotes de flechas
ocupam 2, e um escudo ocupa 1 inteiro.

### Bolsa de moedas
Drams, Florins, Lunaris e Aureus em campos separados, sem conversão automática
— as taxas ficam no hint de cada campo.

### Baú
Cada item pode ser mandado para o baú, que não tem limite mas fica fora de
alcance durante a campanha.

## v0.25.1 — Proclamação, hierarquia divina e patamares legíveis

### Adicionado — PROCLAMAÇÃO
O livro chama de proclamação o evento em que o Aspecto Divino anuncia
publicamente o semideus como seu campeão ou profeta. Com 3 favores da **própria
divindade**, o mestre pode gastá-los nisso — e só dela: com outras divindades o
equivalente é a bênção, então o botão de bênção some no card do próprio
aspecto.

É definitivo e acontece uma vez. O feito ganha destaque próprio:

- **na aba de Favores**, uma faixa dourada com "PROCLAMADO POR [DIVINDADE]",
  a data e a nota de que poucos semideuses recebem o título em toda a vida;
- **no Perfil**, um selo "✦ PROCLAMADO" ao lado da divindade, que passa a ser
  escrita em ouro.

### Corrigido — REGRA: a troca de favores sobe UM degrau na hierarquia
A ficha oferecia primordiais para qualquer divindade. O correto é:

    Menor  ›  Grande  ›  Primordial  ›  a Mãe

O rótulo do botão muda conforme a divindade ("3 → 1 FAVOR DE UM GRANDE",
"3 → 1 FAVOR PRIMORDIAL", "3 → 1 FAVOR COM A MÃE"), e o seletor passa a mostrar
apenas as divindades do degrau certo.

**A Mãe Celestial** entrou como destino próprio: ela está acima dos primordiais
e não consta no catálogo de deuses. Como o destino é único, a troca é
imediata, sem seletor. Ela também é o topo — não há degrau acima dela.

### Corrigido — "Como funciona" ilegível
Estava espremido numa coluna lateral em corpo 10. Virou três cards em largura
cheia, um por patamar, com o bônus passivo em destaque e as trocas
disponíveis em corpo 11. No lugar dele, na faixa superior, entrou um card curto
mostrando a hierarquia divina — que agora importa para entender as trocas.

Os cards de patamar dividem a largura pelo mesmo mecanismo da aba de Combate,
já que percentual não existe no SDK.

## v0.25.0 — aba Favores Divinos

A aba merecia existir sozinha: além de contar favores por divindade, ela é a
origem das bênçãos que liberam kits de poder e uma fonte de pontos de poder.

### Contagem por divindade, com meios-pontos
Meio favor é o padrão; humanos (passiva "Favorecimento divino"), filhos e
legados recebem 1 inteiro. Os pips mostram seis metades até o teto, e os
valores aparecem como "1½" em vez de "1.5".

O teto de **3 é por divindade** — dá para ter 3 com Ditrys e 3 com Kaern ao
mesmo tempo.

### Só o mestre registra
"Somente é possível ganhar favores através de narrativas oficiais", então os
botões de conceder, retirar e trocar aparecem apenas para o mestre. O jogador
consulta. Toda concessão e retirada é publicada no chat.

Retirar também está previsto: o livro diz que a divindade pode tomar de volta
o que deu.

### As quatro trocas que mexem na ficha
- 2 favores → 1 ponto de poder
- 3 favores → 3 pontos de poder
- 3 favores → **bênção**, que libera o kit de poderes da divindade (conecta
  direto com a aba de Poderes)
- 3 favores → 1 favor com um deus primordial, escolhido num seletor próprio

As demais trocas do livro (milagre, auxílio narrativo, conversa com a
divindade, ressurreição) são resolvidas na mesa e aparecem como referência no
topo da aba, junto dos bônus sociais de cada patamar (+1, +3 e +5).

### Mácula divina
O defeito marca uma divindade que **nunca** concede favores. A ficha recusa a
concessão e sinaliza na linha da divindade.

### Testes
Meio e inteiro, teto por divindade sem afetar as outras, bloqueio do jogador,
os três patamares de bônus social, as quatro trocas com desconto correto,
recusa por saldo insuficiente, mácula bloqueando, retirada sem passar de zero
e round-trip da serialização.

## v0.24.2 — cards sempre expandidos

### Corrigido — a aba abria com os cards espremidos
O layout expandido era o certo; o comprimido era o bug.

Na primeira montagem as linhas ainda não têm largura — retornam 0 ou um valor
minúsculo — e a grade dividia esse número entre os cards, espremendo todos.
Só ao mexer numa qualidade ou raça o recálculo rodava de novo, agora com o
layout já desenhado, e os cards se abriam. Reiniciar o Firecast voltava ao
estado espremido.

A medição passou a tentar, em ordem, a linha, o **scrollBox** e o **painel da
aba**, ignorando qualquer valor abaixo de 320px por não ser confiável. Como
scrollBox e painel já existem na primeira passada, a largura correta aparece
desde a abertura.

A grade também passou a ser recalculada ao **abrir a aba** — que é quando o
layout ganha tamanho real — e ao final da inicialização da ficha.

### Testes
Cobrem os quatro caminhos de medição: linha disponível, queda para o
scrollBox, queda para o painel, e o fallback quando nada é mensurável. Mais o
caso que causava o defeito: linha reportando 12px enquanto o scrollBox reporta
1400 — o valor pequeno é ignorado.

## v0.24.1 — respiro no rótulo de ajuste e grade que aguenta tela pequena

### Corrigido — "AJUSTE" colado na borda do card
Os 15 rodapés de ajuste ganharam margem lateral, igual à do resto do card. Os
cards sem ajuste receberam a mesma margem no espaçador, para as alturas
continuarem batendo.

### Corrigido — em tela pequena a linha estourava
A grade tinha um mínimo de 150px por card. Com cinco cards isso exige 750px de
linha, e abaixo disso o último era empurrado para fora da área visível.

O mínimo caiu para 96px e a divisão passou a ser pura: os cards sempre somam
exatamente a largura disponível. Verificado de 1600px até 640px — em todas, a
linha de 5 cards e a de 4 barras cabem inteiras.

### Adicionado — corpo do número acompanha a largura
Em card estreito, um valor de três dígitos em corpo 27 não caberia. A fonte
passa a 24, 21 ou 18 conforme o card encolhe. É uma chamada protegida: se a
versão do SDK não expuser o ajuste de fonte, o layout segue funcionando com o
corpo padrão.

## v0.24.0 — redesenho da aba Cálculos & Combate

### Um único formato de card, repetido em toda a aba
Antes cada bloco tinha estrutura própria: larguras diferentes, alturas
diferentes, o campo de ajuste em posições distintas e o Prana mais alto que os
vizinhos. Agora os 18 cards da aba seguem exatamente o mesmo desenho:

    faixa de cor (3px) · rótulo · valor · a conta · campo de ajuste

O ajuste ocupa a mesma posição em todos, então os campos ficam alinhados na
horizontal ao longo da linha inteira. Cards sem ajuste (Corrida, Proficiência,
Carga) mantêm o espaço reservado, para não desalinhar a fileira.

A faixa colorida no topo dá a leitura imediata do que é cada coisa: vinho para
Vida, dourado para Aura e defesas físicas, azul-chuva para Mana, violeta para
Prana e Inspiração, musgo para as defesas mentais.

### Os cards agora preenchem a linha
Era a origem do vão à direita: as larguras eram fixas em 168px, então sobrava
espaço em tela larga e apertava em tela estreita. Agora cada linha divide o
espaço disponível entre os cards **visíveis**, com mínimo de 150px.

Isso resolve junto o caso das barras condicionais: personagem comum vê duas
barras ocupando metade da linha cada; o mago vê três de um terço; a bruxa,
quatro; o vampiro, duas. Sempre preenchendo.

O recálculo da grade roda no `onResize` do scrollBox, seguindo o mesmo padrão
que a aba de Qualidades já usava.

### Outros ajustes
- Seções com título menor e linha divisória mais discreta, para o olho ir aos
  números e não aos cabeçalhos.
- Bloco de composição reorganizado em quatro campos de largura igual.
- Seletor do Escudo psíquico com respiro maior.

## v0.23.2 — percentuais de volta à barra que nomeiam

### Revertido — a mudança da v0.22.3
Cada qualidade age na barra que ela nomeia, e não na barra derivada:

- **Aura expandida/reprimida** → incide na **Aura**, sempre, inclusive em
  bruxas;
- **Vigor expandido/reprimido** → incide na **Vida**, sempre, inclusive em
  vampiros.

O **Prana** continua sendo a soma pura de Mana + Aura — e como a Aura já vem
com o percentual aplicado, o efeito chega nele por consequência, sem ser
aplicado duas vezes. O **Vitae** não recebe percentual.

Com Aura expandida em 2 pontos, o Prana volta a dar **190** (era 209 na versão
anterior).

Além de corresponder ao texto do livro, isso simplifica o código: sumiram os
quatro caminhos condicionais que a versão anterior tinha introduzido.

### Testes
Reescritos para a regra correta: percentual agindo na barra nomeada, Prana
herdando o efeito através da Aura, Vitae ficando de fora, e os reprimidos
reduzindo apenas a barra que nomeiam.

## v0.23.1 — correção: a ficha não abria

### Corrigido — os scripts de teste quebravam o plugin
A v0.23.0 empacotou a varredura dentro da pasta do projeto, em `testes/`. O
Firecast carrega **todo `.lua` do pacote** como parte do plugin, e esses
scripts usam `dofile`, que não existe no ambiente do Firecast — resultado:
erro na abertura e a ficha não subia.

A pasta saiu do pacote. A varredura continua existindo, mas é entregue **em
arquivo separado**, para rodar fora do Firecast.

### Verificação nova no build
O empacotamento agora recusa qualquer `dofile`, `loadfile`, `io.open`,
`os.exit` ou `arg[` dentro do pacote, e acusa arquivos `.lua` na raiz que
nenhum `require` carrega. Era exatamente o que faltava para pegar esse erro
antes de você.

## v0.23.0 — varredura automática do catálogo

Ferramenta nova em `testes/`, que percorre **29 raças, 48 poderes, 36
subclasses (273 níveis) e todas as qualidades e defeitos**, aplicando cada um
numa ficha limpa e conferindo se a ficha entrega o que o catálogo promete.
Roda em segundos com `lua5.3 varre_tudo.lua`.

Ela confere: bônus racial de atributo aplicado, teto elevado valendo no nível
certo, poder de atributo chegando a +6 no nível 5, qualidade prometida por
poder sendo concedida, bônus de defesa somando, tier de toda concessão
existindo no catálogo, efeitos numéricos com o valor certo, e os efeitos
permanentes de subclasse.

### Corrigido — três tiers de qualidade concedidos errados
A varredura pegou concessões com tier fora do que o catálogo aceita:

| qualidade | custo real | concedia | agora |
|---|---|---|---|
| Beleza sobrenatural | 3 pontos | 1 | 3 |
| Genialidade | 3 pontos | 1 | 3 |
| Vontade de ferro | 2 pontos | 1 | 2 |

O tier não é decorativo: é ele que seleciona a faixa de efeito e o que aparece
no selo de pontos do item. A verificação de tier virou parte da varredura.

### Adicionado — os dois efeitos permanentes de subclasse
Das 36 subclasses, apenas dois efeitos são permanentes, numéricos e incidem
sobre campos calculados:

- **Espadachim/Samurai nível 4** — +3 nas defesas telepática e empática;
- **Duelista/Passos de vento nível 2** — deslocamento e corrida dobram (a
  conta na tela passa a exibir "dobrado").

Os outros 12 candidatos são bônus em testes específicos (forjar, atuar,
seduzir) ou condicionais, e continuam com o mestre.

### Verificado, sem alteração
- Os bônus de atributo das 18 raças que os concedem estão todos corretos.
- Os 7 poderes de atributo chegam a +6 no nível 5.
- As 4 qualidades com efeito percentual somam o valor certo em cada tier.
- As 7 raças sem deslocamento e dado de vida são todas **Primordiais**, que
  não têm características no livro — esperado, não é falha.
- Os 5 avisos de "%" em qualidades são percentuais de **preço de compra e
  venda** (Boa Reputação, Endividado…), não de cálculo. Corretamente fora.

## v0.22.3 — ordem dos percentuais em Prana e Vitae

### Corrigido — REGRA: o percentual entra no fim do cálculo
E a ordem muda o resultado, não é detalhe de escrita:

- **Bruxas** — Aura expandida/reprimida incide sobre o **Prana já somado**, e
  não sobre a Aura. Com +30%, um Prana que dava 190 passa a dar **209**: a
  diferença é de 19 pontos, porque o percentual passa a multiplicar também a
  Mana.
- **Vampiros** — Vigor expandido/reprimido incide sobre o **Vitae**, e não
  sobre a Vida. A Vida do vampiro fica com o valor cru.

Para quem não é bruxa nem vampiro, nada muda: o percentual continua entrando
na Aura e na Vida como antes.

### As contas na tela mostram a ordem
O Prana exibe "mana 65 + aura 96 = 161, +30%" e o Vitae mostra o percentual
aplicado ao lado da fórmula. Sem isso o número pareceria não fechar com as
parcelas.

### Testes
Cobrem os dois casos novos, os dois casos antigos (para garantir que não
mudaram) e o percentual negativo — Aura reprimida também passa a incidir sobre
o Prana somado.

## v0.22.2 — barras aparecem sozinhas, sem caixas de marcar

### Alterado — as três caixas de marcar saíram
Mana, Prana e Vitae passaram a ser detectados a partir do que já está na
ficha, sem ninguém precisar marcar nada:

- **Mana** — qualidade "Coração de mana" (ou Linhagem de Unaris, já que toda
  bruxa é maga);
- **Prana** — qualidade "Linhagem de Unaris";
- **Vitae** — raça Vampiros, ou a característica "Sede de sangue" herdada por
  um mestiço.

Os campos internos continuam existindo porque os cálculos leem deles; agora são
escritos pela detecção.

### Alterado — cada barra só aparece para quem a tem
Personagem comum vê apenas Vida e Aura. O mago ganha a Mana, a bruxa ganha o
Prana, e o vampiro ganha o Vitae — que **oculta Aura e Mana**, já que toma o
lugar das duas.

### Alterado — cores trocadas
Aura em dourado, Prana em violeta.

### Corrigido — uma chamada essencial havia se perdido
`recalcularTudo` não estava mais chamando `aplicarConcessoes`: a linha
adicionada na v0.20.3 sumiu em algum patch posterior, o que faria os bônus de
raça voltarem a só aparecer ao reabrir a ficha. Recuperada.

Para não acontecer de novo, o build agora confere se `recalcularTudo` chama as
seis rotinas de que depende (marcadores de energia, concessões, limites de
atributo, contadores de perícia, painel de qualidades e aba de combate).

## v0.22.1 — Prana como barra própria, e a Aura não zera mais

### Corrigido — REGRA: eu tinha confundido Coração de Mana com Linhagem de Unaris
São coisas distintas, e a ficha tratava as duas como se fossem a mesma:

- **Coração de Mana** — todo mago tem. Libera **Mana**. A Aura dele continua
  existindo e sendo calculada normalmente.
- **Linhagem de Unaris** — a bruxa. Ganha **Prana**, uma terceira barra que é
  a soma de Mana e Aura, e é dela que gasta.

A versão anterior somava Aura dentro do Mp e zerava a Aura, o que estava
errado nos dois casos: dava fusão a quem não é bruxa e apagava uma energia que
continua existindo.

### Adicionado — quinta barra: PONTOS DE PRANA
Aparece só para bruxas, mostrando a conta ("mana 65 + aura 64"). Mana e Aura
seguem calculadas e visíveis em separado.

Junto veio o marcador **"É Bruxa (libera Prana)"**, ao lado dos de Coração de
Mana e Vampiro. A ficha já detecta a qualidade sozinha; o marcador serve para
o mestre corrigir casos de borda.

### Corrigido — a Aura não zera mais para ninguém
Nem para bruxas, nem para vampiros. Todo ser vivo tem Aura; o que muda é de
qual barra a energia é gasta. As notas de rodapé passaram a dizer exatamente
isso em vez de sugerir que a barra some.

### Conferido — a fórmula da Mana estava certa
15 + base por idade + (Nível × 2). Para idade 18 e nível 7: 15 + 36 + 14 = 65.
O 68 que aparecia vinha da fusão indevida, não do cálculo. A conta na tela
agora mostra a idade usada, para conferência rápida.

## v0.22.0 — aba Cálculos & Combate reconstruída

A aba foi refeita do zero no padrão visual das outras. Nenhum número é
digitado ali: tudo vem das demais seções.

### Princípio do desenho — cada valor mostra a conta
Abaixo de cada número aparece de onde ele saiu: "15 + 10 + (Con 5÷2 × 7)",
"9 + Força 5 + prof 3", "2 + For 5 + rank 2". Era a parte que mais podia
assustar, e é a mesma solução que funcionou nas perícias — o jogador confere
sem precisar abrir o livro.

### Quatro seções
**Recursos** — Vida, Aura, Mana e Vitae em cards grandes, cada um com seu
campo de ajuste. Abaixo, uma faixa com os valores que os compõem (dado de
vida, vida e aura acumuladas por nível, bônus de itens equipados).

**Defesas** — os quatro cards, cada um abrindo a conta e mostrando os bônus
que vêm de poderes, raça e escudo psíquico. Uma linha embaixo resume esses
extras.

**Movimento & Iniciativa** — deslocamento, corrida, iniciativa e proficiência.

**Ações, Inspiração & Carga** — as três ações separadas, os pontos de
inspiração e a capacidade da mochila. Uma nota diz o que ainda falta
destravar: "+1 ação bônus no 10 · +1 reação no 15 · +1 ação padrão no 19".

### Corrigido — campos calculados eram editáveis
Ações padrão, bônus e reação eram campos digitáveis. Como agora são
calculados, o recálculo sobrescreveria o que o jogador escrevesse. Viraram
valores calculados com campo de ajuste próprio, como o resto da ficha.

### Adicionado — Pontos de inspiração
Não existiam na ficha. Começam em 3, com teto de 3 e piso 0, ambos aplicados.

### Adicionado — seletor de defesa do Escudo psíquico
Aparece só quando o poder chega ao nível 3, e o título acompanha o valor
(+1 no nível 3, +2 no nível 5). Completa o conjunto de escolhas do mesmo tipo
já existentes na ficha.

### Preservado
Os marcadores de **Coração de Mana** e **Vampiro** viviam nesta aba e são a
única forma de destravar Mana e Vitae. Foram reintegrados junto aos recursos —
a validação do build acusou a ausência antes do empacotamento.

## v0.21.1 — Mente fechada: escolha entre as duas defesas mentais

### Corrigido — REGRA: a mesa tem DUAS defesas mentais
Eu tinha aplicado o +2 dos Drow ("Mente fechada") direto na Defesa telepática.
Telepática e Empática são ambas defesas mentais, e o jogador escolhe em qual o
bônus recai.

O seletor ficou no popup da raça, ao lado do de atributo favorecido, e só
aparece na raça que tem a característica. Enquanto nada é escolhido, o bônus
não entra — e trocar a escolha move o +2 de uma defesa para a outra.

### Nota
O mesmo padrão vale para o **Escudo psíquico** (+1 no nível 3, +2 no nível 5,
numa defesa à escolha). A lógica já está pronta e lendo o campo
`escudoPsiquicoDefesa`; falta apenas o seletor, que entra na aba de Combate.

## v0.21.0 — auditoria completa da documentação

Varredura do `.bib` inteiro (841 mil caracteres) cruzada com o que a ficha já
automatizava, procurando valores perdidos. Resultado abaixo, separado entre o
que foi corrigido agora e o que ficou pendente de decisão.

### Confirmado — as fórmulas existentes estão corretas
Hp, Mp, Ap, Pv, Deslocamento, Iniciativa, as quatro Defesas e Capacidade da
mochila foram conferidas uma a uma contra o texto do livro. Todas batem.
As quatro qualidades percentuais (Vigor/Aura expandido e reprimido) também já
estavam ligadas.

### Corrigido — bônus de perícia: eram 8 fontes, a ficha tinha 1
Só a dos Drow estava mapeada. Entraram: Elfos (Natureza e Sobrevivência),
Fadas (Natureza e Animais), Centauros (Arcos, Bestas e Natureza), Ursaris
(Intimidação e Subjugar), Goblins (Prestidigitação e Furtividade) e a
qualidade Vontade de ferro (+2 em Vontade, com vantagem a partir do nível 10).

**Armadilha encontrada:** "Conexão com a natureza" existe em Fadas e Centauros
com valores diferentes (+1/+2 contra +2/+4). As entradas ganharam filtro por
raça — sem isso, um Centauro receberia o bônus mais fraco.

### Adicionado — bônus de defesa que ninguém aplicava
- Os quatro poderes de atributo dão **+1 na defesa correspondente ao chegar
  ao nível 2** (Força→Aparar, Destreza→Esquiva, Carisma→Empática,
  Sabedoria→Telepática).
- **Escudo psíquico** dá +1 no nível 3 e +2 no nível 5, numa defesa à escolha.
- **Drow (Mente fechada)**: +2 na Defesa Mental, aplicada na Telepática.

### Adicionado — REGRA: Linhagem de Unaris funde Mana e Aura
O livro é explícito: *"os Pontos de mana e Pontos de aura serão fundidos em uma
coisa só dentro do MP, enquanto a Aura permanecerá sem valor"*. A Aura entra no
Mp e o campo de Aura zera.

### Adicionado — REGRA: vampiros usam Vitae no lugar de Aura/Mana
"Sede de sangue" faz habilidades e feitiços rolarem com Vitae. As duas barras
passam a zerar, para não sobrar energia que o personagem não usa.

### Adicionado — Corrida
O dobro do deslocamento, e o **triplo para Sátiros** ("Maratonista").

### Corrigido — ações eram um contador só, e são três progressões
O livro dá +1 ação **bônus** no nível 10, +1 **reação** no nível 15 e +1 ação
**padrão** no nível 19 — níveis diferentes para cada tipo. A ficha tinha um
campo único que não representava isso.

### Encontrado, ainda não implementado
- **Pontos de inspiração** — todo personagem começa com 3, máximo 3. Não existe
  na ficha; entra na aba de Combate.
- **Alcance de arremesso** — Destreza ×3 para arma apropriada, Destreza ÷2 para
  não-apropriada. Entra com o Inventário.
- **Escudos** dão +3 a +6 em Defesa - Aparar, e só valem equipados. Entra com o
  Inventário.
- **Passos de vento** (Duelista nível 2) dobra o deslocamento passivamente;
  fica para quando as subclasses tiverem efeitos permanentes ligados.
- Efeitos situacionais de subclasses e traços (32 e 21 ocorrências) ficam com o
  mestre: quase todos são condicionais ("sempre que", "quando estiver").

## v0.20.5 — blindagem e revisão antes da próxima aba

Sem mudanças de regra: passada de revisão rodando toda a bateria de testes
contra o código atual.

### Corrigido — duas funções podiam falhar em silêncio
`temCaracRacial` chamava `CatalogoRacas` sem verificar se o catálogo estava
carregado. Como o motor de concessões roda dentro de `pcall`, um erro ali era
engolido e **todas** as concessões falhavam sem aviso. Agora a função cai na
recordList se o catálogo não responder.

`escolherAtributoRacial` também passou a proteger as chamadas de recálculo e
de redesenho, pelo mesmo motivo.

### Testes revisados
A suíte tinha três arquivos testando modelos já substituídos (créditos antes
dos slots concedidos, e o ponto racial antes de ir para o bônus). Foram
atualizados ao comportamento atual — não eram regressões.

Um deles revelou um caso que vale registrar: com Sabedoria sobrenatural nível 3
mais o bônus racial, o campo de bônus acumula 4 (3 do poder + 1 da raça). As
duas fontes somam no mesmo campo sem se sobrescrever, e ao trocar de raça só o
+1 racial sai.

## v0.20.4 — os botões de atributo de fato, e bônus racial em tempo real

### Corrigido — os sete botões continuavam com `align="client"`
A correção da v0.20.3 não chegou ao arquivo: a substituição do bloco não pegou
e a minha própria verificação foi enganosa — contei os nomes dos botões, não o
alinhamento deles, e o resultado pareceu correto. Agora a troca foi feita
diretamente sobre cada botão e conferida contando `align="left"`: 7 de 7, e
nenhum `align="client"` restante.

### Corrigido — bônus racial só entrava depois de reabrir a ficha
`temCaracRacial` lia apenas a recordList de características, que é
reconstruída quando a aba de Raça desenha — e não no instante em que a raça
muda. Por isso o efeito só aparecia na reabertura.

A detecção passou a consultar primeiro o **catálogo da raça gravada em
`sheet.raca`**, que responde na hora. A recordList continua sendo consultada
depois, porque é ela que guarda as características **escolhidas** de um
mestiço, que não saem do catálogo de uma raça só. O caso do humano puro que
perde a característica exclusiva ao virar mestiço segue tratado.

Testado no cenário real: trocar de raça sem repopular a lista já move os
bônus na hora.

### Verificação nova no build
O empacotamento agora acusa layouts com mais de um filho direto
`align="client"` — a armadilha que sumiu com cinco dos sete botões, já que só
um elemento pode preencher o espaço restante.

## v0.20.3 — trocar de raça atualiza os bônus, e os sete botões voltam

### Corrigido — trocar de raça não trocava os bônus
`confirmarDefinirRaca` chamava o recálculo, mas nunca reavaliava as
concessões: os bônus da raça antiga ficavam na ficha e os da nova não
entravam. Trocar de Humano para Anão mantinha o +1 escolhido e não dava o
+2 de Constituição.

A reavaliação passou a rodar dentro do próprio `recalcularTudo`, antes dos
cálculos — assim qualquer caminho que mexa na ficha (trocar raça, subir de
nível, comprar poder) mantém os bônus em dia.

Testado trocando de raça seis vezes seguidas: nenhum resíduo fica para trás.

### Corrigido — cinco dos sete botões de atributo sumiam
Eu tinha usado `align="client"` nos botões da mesma linha para eles se
adaptarem à largura. Só um elemento pode preencher o espaço restante, então os
outros eram engolidos — sobravam Inteligência e Manipulação, um por linha.

Voltaram a ter **largura fixa** (104px), em duas linhas de 4 e 3, o que cabe
mesmo com o popup reduzido a 94% de uma tela pequena. A armadilha ficou
anotada no XML.

## v0.20.2 — seletor de atributo só onde faz sentido

### Corrigido — o seletor aparecia em TODAS as raças
A checagem olhava se o personagem tinha a característica, e não qual raça
estava aberta no popup — então o bloco de escolha surgia até em Anões, que já
têm o atributo favorecido definido (+2 Constituição).

Agora ele só aparece na raça que de fato deixa **escolher** o atributo (hoje,
apenas os Humanos, via Versatilidade humana). Todas as outras já dizem qual
atributo recebe o bônus, e esse é o favorecido delas — não há o que escolher.

### Corrigido — o bônus não entrava ao escolher o atributo
Em fichas vindas de versões anteriores a concessão já constava como aplicada,
embora nada tivesse sido lançado; o motor via a chave marcada e pulava.
A chave passou a ser limpa **sempre** antes de reaplicar, e não só quando havia
escolha anterior.

### Corrigido — seletor cortado em telas menores
Sete botões de largura fixa não cabiam. Foram para duas linhas com largura
elástica, que se adapta ao espaço disponível.

### Melhorado — uma concessão com erro não derruba as demais
O motor tinha um único `pcall` em volta do laço inteiro, então uma falha no
meio abortava tudo o que viesse depois. Agora cada concessão é isolada.

## v0.20.1 — regra correta do limite de atributo e bônus raciais completos

### Corrigido — REGRA: o limite do nível vale para TODOS
A v0.20.0 somava 2 ao teto do atributo favorecido em qualquer nível, o que
estava errado. A regra é: **o limite do nível vale para todos os atributos,
sem exceção** — no nível 7 nenhum passa de 5, tenha bônus racial ou não.

A progressão chega a 8 exatamente no **nível 17** (confirmado na tabela do
livro), e só a partir daí o teto racial — 9 ou 10, conforme a raça — passa a
valer no atributo favorecido. O campo de bônus continua sem teto algum.

### Adicionado — todas as raças que bonificam atributo
Havia 17 características raciais que dão bônus de atributo e elevam o teto, e
só a dos Humanos estava automatizada. Todas foram extraídas do catálogo:

Vigorosos (+2 Constituição, teto 10) · Super força (+1 Força, 10) · Agilidade
élfica (+1 Destreza, 10) · Agilidade aprimorada (+1 Destreza, 10) ·
Graciosidade (+1 Destreza e Carisma, **teto 9**) · Fisiologia de guerra
(+1 Força e Destreza, **teto 9**) · Manipuladores e Manipuladoras
(+1 Manipulação, 10) · Carismáticos (+1 Carisma, 10).

O bônus vai para o campo "+", nunca para o valor base.

### Corrigido durante os testes — bônus aplicado várias vezes
"Super força" aparece em seis raças e "Vigorosos" em três, sempre com o mesmo
efeito. Como a ficha guarda a característica e não a raça, uma entrada por raça
fazia a Constituição ganhar +6 em vez de +2. A tabela foi deduplicada por
característica: 16 entradas viraram 9, e a validação do build passou a acusar
chaves de concessão repetidas.

### Corrigido — teto ficava preso ao trocar o atributo escolhido
Ao mudar a escolha da Versatilidade humana, o bônus saía do atributo antigo mas
o teto 10 continuava lá. Agora o teto volta a 8 junto com o bônus.

## v0.20.0 — atributo favorecido pela raça e limites aplicados

### Corrigido — o ponto racial ia para o bolso errado
A v0.19.4 somava o ponto da Versatilidade humana aos pontos de evolução, o que
fazia o total sair de 18. Agora ele vai direto para o campo de **bônus** do
atributo escolhido, e o bolso de evolução continua 18 no nível 7.

### Adicionado — seletor de atributo no popup da raça
Sete botões dentro do detalhe da raça, visíveis apenas quando ela concede
"+1 ponto de atributo à escolha". O atributo escolhido recebe o +1 de bônus e
passa a ter limite 10.

Trocar a escolha move o bônus de um atributo para o outro, e o valor que o
jogador já tinha digitado no campo é preservado: 3 vira 4 ao escolher, e volta
a 3 ao trocar.

### Adicionado — limites de atributo aplicados de verdade
O limite por nível existia na ficha, mas era apenas exibido. Agora o **valor
base** é cortado no teto:

- teto do nível — 4 no nível 1, subindo até 8 no 19;
- teto absoluto de 8, que vira **10 no atributo favorecido pela raça**.

O campo de **bônus não tem teto** — é justamente por ali que raças, poderes e
itens ultrapassam o limite, como definido pela mesa. Quando um valor é cortado,
o painel avisa quais atributos foram ajustados.

### Nota sobre o teto 10
O livro diz "limite de 10 ao invés de 8", mas o limite normal varia com o
nível. A ficha soma 2 ao teto do nível, com máximo de 10 — assim o favorecido
chega a 10 no nível 19 e mantém a proporção nos níveis anteriores (no nível 7,
7 em vez de 5). Se a mesa preferir outra leitura, é uma linha em
`limiteBaseDoAtributo`.

## v0.19.4 — resumo atualizando na hora e concessões dos Humanos

### Corrigido — o painel de resumo só mudava ao reabrir a ficha
A chamada de atualização tinha ido parar em `ativarAba` em vez do recálculo,
então o painel só se refazia ao trocar de aba. Agora ela vive dentro de
`atualizarContadoresPericias`, que é chamada pelo recálculo geral, pela troca
de aba e por cada perícia adicionada ou removida — mexer num atributo ou numa
perícia reflete na hora.

### Corrigido — duas características dos Humanos não eram contadas
- **[Multitarefas]** — 1 perícia adicional livre. Como não pertence a um
  atributo específico, abre vaga no total geral, e não no limite de um
  atributo.
- **[Versatilidade humana]** — 1 ponto adicional de atributo. Entra no
  **bolso de pontos**, não como bônus no valor de um atributo: são coisas
  diferentes, e tratá-lo como bônus daria o ponto sem cobrar a distribuição.

No cenário relatado (humano, nível 7, Sabedoria sobrenatural nível 3) o total
passa de 11 para 12 perícias — 10 por evolução, +1 de Multitarefas e +1 do
poder — e o saldo sai de −1 para 0. Os pontos de atributo vão de 18 para 19.

### Nota de regra ainda não automatizada
A Versatilidade humana também diz que **o atributo escolhido passa a ter
limite 10 em vez de 8**. Como o livro não define qual atributo (é escolha do
jogador), isso ficou fora da automação — o limite continua sendo o do nível.
Se a mesa quiser, dá para adicionar um seletor como o da escola de magia.

## v0.19.3 — tabela de atributos corrigida e coluna direita alinhada

### Corrigido — REGRA: faltava o ponto de atributo do nível 4
A tabela de ganhos por nível estava sem o nível 4, então no nível 7 a ficha
mostrava 17 pontos em vez de 18. Reextraí as quatro progressões do livro,
nível a nível, e conferi contra os valores que o mestre publicou para o
nível 7:

| item | ficha | esperado |
|------|-------|----------|
| pontos de atributo | 18 | 18 |
| pontos de poder | 17 | 17 |
| perícias | 10 | 10 |
| pontos de classe | 3 | 3 |
| proficiência | +3 | +3 |
| rank | D | D |

Atributos passam a totalizar 24 no nível 20 (era 23). As outras três tabelas
já estavam certas.

### Corrigido — campos desalinhados na coluna direita
Total, manual e "x" tinham alturas e margens diferentes, então as caixas não
fechavam na mesma linha. Os três blocos passaram a ter a mesma estrutura —
rótulo de 12px em cima, caixa embaixo, margens iguais — e o total ganhou o
rótulo "TOTAL" para nascer na mesma altura do "MANUAL". O "x" tem um rótulo
vazio pelo mesmo motivo.

Mesmo tratamento aplicado às linhas de habilidade (origem, custo, x) e de
qualidade/defeito (pontos, x).

## v0.19.2 — padronização da coluna direita e popup que vazava a tela

### Corrigido — popup de descrição de qualidade estourava em telas menores
Era o único popup da ficha aberto com `:show()` direto, sem passar pelo
`abrirPopupAjustado`, que limita a 760x600 ou 94% da tela — o que for menor.
Agora segue o mesmo caminho dos demais.

### Corrigido — botão "x" agora fica sempre por último, à direita de tudo
Passa a valer como padrão em perícias, qualidades, defeitos, habilidades e
poderes.

A ordem dos elementos alinhados à direita não era confiável: o primeiro
declarado acabava aparecendo mais à esquerda, e blocos de tipos diferentes
(`layout` e `rectangle`) se intercalavam de formas distintas. Em vez de
depender desse comportamento, cada linha agora tem **um único container à
direita com filhos `align="left"`** — assim a ordem na tela é exatamente a
ordem de declaração.

Ordem final por linha:
- **Perícia** — total, manual, x
- **Qualidade/Defeito** — pontos, x
- **Habilidade** — origem, custo, x
- **Poder** — pips, contador, +, − (o botão que remove por último)

### Corrigido — campos de perícia com tamanhos diferentes
O total (62px) e o manual (66px) ficaram ambos com **70px**, alinhados.

### Verificação nova no build
O empacotamento agora acusa qualquer popup aberto com `:show()` direto, no
`ficha.lfm` e nos templates — era o que teria evitado esse vazamento.

## v0.19.1 — Linhagem de Unaris: [Magia inata] e escola com vantagem

Ao reler o efeito da qualidade, ficou claro que ali há **duas coisas
distintas** que estavam sendo tratadas como uma só:

- **[Magia inata]** — +1 em testes de magia até o nível 10, +2 do 11 em
  diante. Vale em **todas** as cinco perícias mágicas, sem escolha nenhuma:
  Encantamentos (Carisma), Transmutação (Destreza), Evocação (Inteligência),
  Invocação (Manipulação) e Clarividência (Sabedoria).
- **Vantagem** — a qualidade também deixa escolher **uma** escola de magia
  para rolar os dados com vantagem.

### Adicionado — bônus automático nas cinco perícias mágicas
Quem tem a qualidade recebe o bônus assim que a perícia entra na ficha, sem
precisar configurar nada. A conta na linha mostra a origem ("Magia inata +2").
Perícias não mágicas não são afetadas.

### Adicionado — seletor de escola com vantagem no popup da qualidade
Dentro do detalhe da Linhagem de Unaris, cinco botões escolhem onde a
personagem rola com vantagem. A perícia escolhida ganha a marca **VANTAGEM** e
borda violeta na aba de Perícias. Vantagem não é número, então não entra na
soma — fica como marcação.

Enquanto a escolha não é feita, o painel da aba de Atributos & Perícias avisa,
deixando claro que o bônus numérico já está valendo e o que falta é só definir
a escola da vantagem.

### Testes
Bônus valendo nas cinco escolas sem depender de escolha, perícia não mágica
sem bônus, escala de +1 para +2 no nível 11, vantagem apenas na escolhida,
troca de escolha movendo a vantagem sem mexer no bônus, coexistência com o
bônus racial dos Drow, e conferência de que as cinco perícias existem no
catálogo com os atributos certos.

## v0.19.0 — painel de pontos e cálculo de rolagem das perícias

### Adicionado — painel no topo da aba de Atributos & Perícias
Mesmo formato dos painéis de Qualidades e Poderes, com as duas economias lado
a lado: TOTAL / GASTOS / SALDO / EXTRAS para atributos, e
TOTAL / ESCOLHIDAS / SALDO / EXTRAS para perícias.

Números extraídos do livro: **15 pontos de atributo** no nível 1, mais um nos
níveis 2, 6, 8, 11, 13, 15, 17 e 18 (23 no nível 20). **6 perícias iniciais**,
mais as dos níveis 3, 5 (+2), 7, 9, 12, 14, 16 e 18 (+2) — 16 no nível 20.

Dois detalhes que evitam cobrança indevida: GASTOS soma apenas os campos
**base** dos atributos, nunca os bônus de raça e poder (que aparecem em
EXTRAS); e perícias concedidas não ocupam vaga, aparecendo em EXTRAS junto com
as vagas abertas por poderes.

### Adicionado — total de rolagem em cada perícia
Cada linha mostra o valor grande à direita e a conta aberta embaixo:
**atributo + proficiência + extras + manual**.

A proficiência vem da tabela de níveis (+2 no início, +7 no nível 20). Os
extras são bônus que outras partes do sistema dão àquela perícia específica —
hoje a característica dos Drow em "Animais", que escala de +1 para +2 a partir
do nível 11, e a linha diz de onde veio.

### Adicionado — campo de ajuste manual por perícia
Um campo editável por linha, para o que não cabe em regra fixa: um feitiço que
aumenta Percepção por alguns turnos, um item, uma situação. Aceita valores
negativos. É a válvula de escape do cálculo automático.

### Ajustado
Linha de perícia passou de 64 para 76px para acomodar o total, a conta e o
campo manual. Perícias concedidas ganharam borda dourada (antes só as
aprovadas pelo mestre tinham destaque, em vinho).

### Testes
Pontos por nível nas duas economias, gastos ignorando bônus, perícia concedida
fora da contagem, vagas extras somando ao total, cálculo da rolagem, bônus
racial escalando no nível 11 e aplicando-se só à perícia citada, ajuste manual
positivo e negativo, e proficiência acompanhando o nível.

## v0.18.0 — slots concedidos com desconto embutido

Reescrita da economia de habilidades no modelo definido pela mesa: quando o
personagem ganha algo de graça, a ficha **cria o slot** já com o desconto
dentro. Quem cria pelo botão normal paga o preço cheio, sem regra especial.

### Corrigido — o desconto não acompanhava a evolução do rank
Um feitiço Rank D concedido vale **2 pontos**, não 1. Subir esse slot para
rank C (custo 3) agora sai por 1, e para rank B (custo 5) por 3. Antes o
desconto era fixo em 1 ponto e valia só na criação.

O crédito fica preso ao slot: `custoPago = custo do rank − crédito do slot`.

### Corrigido — créditos de poder e de subclasse se embaralhavam
Antes o desconto era procurado na hora de criar, então a primeira habilidade
criada pegava o crédito "errado" — a Rank E do poder e a Rank D da subclasse
disputavam entre si. Com um slot por concessão, cada crédito é independente e
não há mais disputa.

### Como funciona agora
A ficha materializa um slot para cada concessão:
- um Rank E por poder ativo (o poder Magia gera um slot de FEITIÇO, os demais
  geram habilidade);
- os feitiços da Especialista arcano (D/C/B/A/EX nos níveis 1, 5, 6, 7 e 8 da
  subclasse);
- as duas habilidades Rank EX dos níveis 15 e 20.

O slot nasce sem nome, com os valores da tabela já preenchidos e marcado em
ouro com "clique para dar um nome". Perder a fonte remove o slot se ele ainda
estiver vazio; se já foi preenchido, o conteúdo é preservado e apenas o
desconto acaba.

### Corrigido durante os testes — reconstrução perdia campos novos
A rotina que recria a lista (usada ao editar) copiava uma lista fixa de campos,
e `creditoEmbutido` não estava nela: o desconto sumia depois da primeira
edição. Os campos novos entraram na lista, e ficou um aviso no código para
quem adicionar outro campo no futuro. A validação do build agora compara os
campos usados no template com os copiados na reconstrução.

### Ajustado
O rodapé do construtor mostra a conta aberta ("5 − 2 = 3 pontos") e a linha da
habilidade exibe o desconto ao lado do custo ("3 pt (−2)").

## v0.17.0 — concessões automáticas entre abas

Antes desta versão, o jogador pagava do próprio bolso por coisas que o sistema
deveria dar de graça. Agora raças, poderes e qualidades aplicam sozinhos o que
concedem nas outras abas.

### Adicionado — motor declarativo de concessões
Cada regra é uma linha que descreve a FONTE (o que precisa estar na ficha) e o
EFEITO (o que ela entrega). A ficha compara as fontes ativas com o que já foi
aplicado e ajusta a diferença, então rodar duas vezes não duplica nada e
**perder a fonte desfaz o efeito**.

Doze concessões mapeadas:

**De raça** — Drow recebem a perícia Animais; Vampiros "Sedutores" recebem a
qualidade Beleza sobrenatural; Vampiros "Cabeça a prêmio" recebem o defeito
Segredo obscuro; Harpias recebem Intolerância.

**De poder** — Carisma sobrenatural dá Beleza sobrenatural; Constituição dá
Vigor expandido no tier 2; Inteligência dá Genialidade; Sabedoria dá Vontade
de ferro. Força, Manipulação, Inteligência (níveis 3 e 5) e Sabedoria (nível 3)
abrem vagas de perícia à escolha.

**De qualidade** — Beleza sobrenatural concede a perícia Sedução. Isso encadeia:
comprar Carisma sobrenatural traz a qualidade, que por sua vez traz a perícia.

### Adicionado — bônus de atributo dos poderes sobrenaturais
Os sete poderes de atributo lançam o bônus direto no segundo campo do atributo
(+1 por nível até o quarto, +2 no quinto, totalizando +6). A ficha guarda
quanto já lançou e soma apenas a diferença, então **o valor que o jogador já
tinha no campo nunca é sobrescrito**: 5 escrito à mão vira 6, e volta a 5 se o
poder for devolvido.

### REGRA — defeito concedido não rende PD
Confirmado com o mestre: defeito ganho de graça não dá pontos de defeito. Como
o ganho de PD já era a soma de `pontosPagos`, gravar 0 resolve — o defeito
entra na ficha e vale para efeitos (o tier é preservado), mas não engorda o
saldo de qualidades.

### Adicionado — marcação de origem
Qualidades, defeitos e perícias concedidos exibem "◆ GRÁTIS por [FONTE]" em
ouro, com borda dourada. Os itens cresceram para caber a linha (qualidade
46→58px, perícia 52→64px).

### Adicionado — vagas de perícia concedidas contam no limite
Perícias concedidas entram fora do limite do atributo, e as vagas "à escolha"
aumentam o teto. O contador passa a mostrar "3 / 5 (+1)" para deixar claro de
onde veio a folga.

### Testes
Aplicação, idempotência (rodar três vezes não duplica), bônus subindo com o
nível do poder, preservação do valor manual do jogador, perícia entrando fora
do limite, defeito sem PD com tier preservado, encadeamento
poder→qualidade→perícia, e reversão completa ao remover a raça ou devolver o
poder.

## v0.16.0 — economia de pontos correta e concessões de subclasse

### Corrigido — o saldo ignorava as habilidades
`saldoPontosPoder()` descontava apenas os poderes, então criar ou evoluir uma
habilidade não mexia no total. Poderes e habilidades saem do MESMO bolso e
agora os dois entram na conta. O campo GASTOS ganhou uma linha discreta
mostrando a divisão ("3 poderes · 5 habilidades").

### Corrigido — REGRA: o Rank E grátis é um DESCONTO, não só o rank E
A tabela de custo é cumulativa (rank D = 1 do rank E + 1 da evolução), então o
primeiro nível gratuito vale como **1 ponto de desconto em qualquer rank**, e
não apenas quando a habilidade é rank E:

| rank | cheio | com o crédito do poder |
|------|-------|------------------------|
| E    | 1     | 0                      |
| D    | 2     | 1                      |
| C    | 3     | 2                      |
| B    | 5     | 4                      |
| A    | 6     | 5                      |
| EX   | 7     | 6                      |

O crédito continua sendo um por poder ativo e some depois de usado.

### Adicionado — habilidades e feitiços concedidos por subclasse
Varri as árvores de todas as subclasses do catálogo atrás de concessões
gratuitas. A **Especialista arcano** (Arcanista) é a que entrega itens que
saem do bolso de pontos: feitiço rank D no nível 1 da subclasse, e ranks C, B,
A e EX nos níveis 5, 6, 7 e 8.

O gatilho é o nível da SUBCLASSE, não o do personagem. Ao criar um feitiço do
rank concedido, ele sai por 0 e a origem fica registrada no item, para o
crédito não ser usado duas vezes. O painel de habilidades avisa quais ranks
ainda estão disponíveis de graça.

As outras concessões do catálogo (ataque extra do Mestre das Lâminas, favor e
artefato do Sacerdote, Ascensão Divina) não gastam pontos e por isso ficaram
de fora. Para incluir uma subclasse nova no futuro basta acrescentar uma linha
na tabela `CONCESSOES_SUBCLASSE`.

### Adicionado — campo EXTRAS na carteira
Mostra quantos pontos o **sistema** concedeu sozinho: concessões de subclasse,
EX dos níveis 15 e 20, o desconto do Rank E de cada poder e o ponto de skill do
nível 19. É calculado e não editável — diferente de CONCEDIDOS, que o mestre
preenche à mão por narrativa.

## v0.15.3 — edição atualiza na hora, e tags empilháveis

### Corrigido — editar habilidade só aparecia depois de reabrir a ficha
O `onNodeReady` do template roda apenas quando o item é CRIADO. Ao editar, os
campos calculados por script (rank, resumo, tags, custo, selo de origem) não
eram reprocessados — só o nome mudava, porque usa `field=` e tem binding
próprio.

Correção: ao salvar uma edição, a lista é reconstruída — os dados são lidos,
os nós apagados e recriados NA MESMA ORDEM, o que força o `onNodeReady` de cada
item. Usa apenas `append` e `deleteNode`, as APIs já comprovadas no projeto, e
nunca toca no nó-container.

### Adicionado — a mesma tag pode ser empilhada
Clicar numa tag agora ACUMULA em vez de alternar: Ofensivo, Ofensivo (2x),
Ofensivo (3x)… Cada repetição consome uma vaga do limite do rank, então um
rank E (2 tags) pode ter no máximo Ofensivo (2x).

Para tirar, cada tag escolhida vira um chip clicável abaixo do formulário, e
cada clique remove uma instância. O card da tag no catálogo mostra a contagem.

O livro não define quanto cada repetição acrescenta em dano ou cura, então a
ficha **não calcula nada** — apenas registra a pilha e deixa os números com o
mestre, como combinado.

Armazenamento: agrupado no nó ("Ofensivo (3x), Fogo"), que é como aparece na
ficha; o construtor expande de volta ao editar. Tags simples continuam
gravadas como antes, sem sufixo.

Tags opostas seguem bloqueadas mesmo com pilha: Ofensivo (2x) + Defensivo
continua recusado fora do rank EX.

### Corrigido durante os testes — duplicação na reconstrução
A primeira versão da reconstrução iterava a lista de nós enquanto apagava dela,
o que pula elementos: três habilidades viravam quatro, fora de ordem. Os nós
passaram a ser copiados para uma tabela própria antes da remoção. O teste que
compara a lista antes e depois pegou isso.

## v0.15.2 — regras de Magia, Linhagem de Unaris e acerto visual das linhas

### Corrigido — REGRA: o crédito grátis é POR PODER, não um bolso comum
O primeiro feitiço vinha cobrado. Causa: o crédito de Rank E gratuito era um
contador único, então o crédito gerado pelo poder Magia acabava consumido por
uma habilidade comum. Agora cada poder ativo carrega o próprio crédito — o da
Magia libera o feitiço Rank E, os demais liberam habilidades. Ter dois poderes
significa dois créditos independentes, que não se roubam.

### Corrigido — REGRA: Magia não gera habilidade comum
Era possível criar habilidade "de poder" a partir da Magia. Magia é o poder dos
feitiços e só produz feitiços. Foi retirada da lista de poderes de origem do
construtor, e o salvamento recusa a combinação. Quem só tem Magia recebe um
aviso explicando que deve usar o botão FEITIÇO.

### Adicionado — Linhagem de Unaris (bruxas)
A ficha agora detecta a qualidade **Linhagem de Unaris** e aplica a escala de
bruxa aos feitiços: dados maiores (feitiço rank C passa de 3d4 para 3d6) e uma
tag extra nos ranks C e A. O construtor mostra a condição numa caixa própria,
visível só em feitiços, que o mestre pode ligar ou desligar à mão — o override
manual vence a detecção automática.

Observação: a qualidade se chama "Linhagem de Unaris" no livro, não "Sangue de
Unaris".

### Corrigido — layout das linhas de habilidade
O texto vazava para fora do cartão e a linha de tags ficava cortada. A altura
do item passou de 52 para 64px, e a coluna da direita foi reorganizada em três
blocos alinhados verticalmente: origem, custo e remover. O selo de origem
ganhou moldura e a cor do tipo (violeta para poder, musgo para classe,
azul-chuva para feitiço).

### Corrigido — duração aparecia com ponto duplo
A tabela traz "instantâneo (1 turno)." com ponto final, o que produzia
"1 turno).." na tela. O ponto é removido ao preencher.

## v0.15.1 — correção do erro de compilação no rdk

### Corrigido — `horzTextAlign="right"` derrubava o `rdk i`
O rótulo de origem em `itemHabilidade.lfm` usava `horzTextAlign="right"`. Essa
propriedade aceita apenas `center`, `leading` e `trailing` — `left` e `right`
pertencem ao `align=`, que é outra coisa. Trocado por `trailing`.

Era a única ocorrência do projeto: os outros 50 usos já estavam corretos.
A armadilha ficou anotada no cabeçalho do template.

### Verificado — o resto do código novo
O `rdk` para no primeiro erro, então a seção de Habilidades e o popup
construtor ainda não tinham passado pelo compilador. Varredura feita antes de
reempacotar: valores inválidos em `horzTextAlign`, `vertTextAlign`, `align`,
`style`, `layout` e `type` (nenhum), `fontStyle` com "+" em vez de espaço
(nenhum), e comparação de todas as propriedades e elementos usados nas partes
novas contra as que o rdk já havia aceitado (nenhuma inédita).

## v0.15.0 — Habilidades e Feitiços

Nova seção na aba V, com título próprio. Habilidades são CRIADAS pelo jogador,
então aqui a ficha usa recordList de verdade (`itemHabilidade.lfm`) e não campo
serializado: são muitos campos e o jogador digita texto livre, onde qualquer
separador corromperia o registro.

### Adicionado — construtor de habilidades
Popup com tags à esquerda e formulário à direita. Escolher o rank preenche
sozinho aura, dado-base, modificador, alcance e duração pela tabela do livro —
e todos os campos continuam editáveis, porque várias regras mexem nesses
números.

### Três tipos, com regras distintas
- **De poder** — vinculada a um poder ativo. O rank é limitado pelo NÍVEL DO
  PODER (1→E/D, 2→C, 3→B, 4→A, 5→EX). Confirmado na mesa: o rank do
  personagem NÃO limita — um personagem rank C pode ter habilidade EX se subiu
  o poder o bastante.
- **De classe** — não exige poder e chega a EX, com efeitos mais fracos. Como
  a regra ainda não está fechada, esta categoria é a mais livre: a ficha não
  trava rank nem tags, só informa a tabela e avisa para combinar com o mestre.
- **Feitiço** — exige o poder Magia. Gasta MANA e tem tabela própria: dados
  mais fracos que habilidades (1d4 contra 1d6 no rank E) e menos tags, com
  valores melhores para "Bruxas". O botão só aparece com o poder Magia.

### Adicionado — gratuidades automáticas
- 1 habilidade Rank E grátis sempre que um poder ATIVO novo chega ao nível 1,
  em qualquer nível do personagem;
- primeira habilidade EX grátis no nível 15, segunda no nível 20;
- +1 ponto de skill do nível 19, abatido do custo de habilidades (não de
  poderes).

O painel mostra quantos créditos ainda estão livres, e cada linha gratuita
aparece marcada como GRÁTIS em ouro.

### Adicionado — validação de tags
68 tags oficiais em quatro categorias. Limite por rank aplicado, e tags opostas
bloqueadas (Ofensivo/Defensivo, Fogo/Água, Sagrado/Maldição, duas classes
diferentes…) — com a exceção do livro: no rank EX tudo é permitido.

### Adicionado — modificadores de alcance
Corpo-a-corpo fixa o alcance em 5m; em área usa sempre metade do alcance do
rank. São mutuamente exclusivos e recalculam o alcance na hora.

### Corrigido — REGRA: poder ativo fica preso ao personagem
O botão "−" no nível 1 removia o poder e devolvia o ponto, o que permitia
comprar e desfazer à vontade. Agora, com a ficha finalizada, só o mestre
remove; durante a criação segue liberado para corrigir erro de clique. E ao
remover um poder por completo, a habilidade Rank E gratuita que nasceu dele é
removida junto.

### Testes executados contra o código real
Os testes passaram a extrair o bloco Lua direto do `ficha.lfm`, e não de um
arquivo de trabalho paralelo — a primeira rodada passou num fonte defasado e
escondeu um erro de campo. Cobertura: teto de rank vindo do poder, bloqueio por
poder de nível baixo, Rank E grátis por poder ativo (e não valendo para
classe), EX grátis nos níveis 15 e 20, desconto do nível 19, preenchimento pela
tabela, corpo-a-corpo e área, tabela própria de feitiços com variante Bruxa,
limite de tags e tags opostas.

## v0.14.3 — correção do desalinhamento ao registrar bênçãos

### Corrigido — seção "FORA DOS KITS" pulava para o topo da aba
Ao registrar uma bênção **durante a sessão**, o poder Magia e seu cabeçalho
saltavam para cima da carteira de pontos e dos botões. Reabrir a ficha
corrigia sozinho — o que foi a pista decisiva.

Causa raiz: no Firecast, chamar `setVisible(true)` em runtime num elemento
`align="top"` que estava invisível o insere no **topo da pilha**, não na
posição em que foi declarado. Os slots já existentes no carregamento entravam
na ordem certa; o slot que aparecia depois ia para o topo.

Correção: os blocos da lista **nunca mais alternam visibilidade**. Cada linha
e cada cabeçalho de grupo agora vive dentro de um wrapper cuja **altura** é
alternada entre 0 e o valor cheio, o que preserva a ordem declarada no XML
independentemente de quando o elemento apareceu.

O mesmo tratamento preventivo foi aplicado a três outros pontos que tinham
exatamente o mesmo risco e ainda não haviam se manifestado:
- os pips de nível (se um reaparecesse no topo, a sequência de bolinhas
  cheias e vazias ficaria trocada);
- os dois botões do mestre na barra de ações (agora por largura);
- o bloco "registrar bênção" dentro do catálogo.

Não sobrou nenhum `setVisible` nos blocos posicionados da aba.

### Alterado — capacidade de 10 para 24 poderes
Cada bênção abre um kit inteiro de 5 poderes. Com 10 slots, um personagem com
três ou quatro bênçãos estouraria o limite de exibição. 24 cobre o kit do
pai/mãe mais três bênçãos completas com folga, e o aviso de limite continua
para o caso extremo.

### Testado — o cenário que motivou o relato
Simulação com pilha de widgets: kit do pai/mãe + Magia, depois bênção de Ammis
registrada em runtime, depois bênçãos de Mungus, Din e Aslot. Em todos os
passos a ordem se manteve — pai/mãe no topo, bênçãos no meio na ordem de
concessão, Magia sempre por último — e os slots não usados ficaram com altura
zero. Também verificado o retorno ao estado vazio.

### Ajustado
Selo de origem passou de 150px para 170px, para caber nomes de divindade mais
longos com o sufixo "· BÊNÇÃO".

## v0.14.2 — mestiçagem para qualquer raça, e reorganização da aba de Poderes

### Corrigido — REGRA: mestiçagem não é exclusiva de Humanos
A implementação anterior cravava "Humanos" como primeira metade da herança, em
sete pontos do código. Agora a base é a **raça principal** selecionada no campo
do topo da aba, e a única exigência é que ela seja das **Jogáveis** — a segunda
raça pode ser qualquer uma, respeitadas as travas de acesso já existentes.

Ajustado em todos os pontos: montagem do pool de características, cálculo de
Deslocamento e Dado de Vida (maior valor entre as duas raças), título e texto
de regra do popup, publicação no chat e textos da aba. Adicionadas duas travas
novas: não abre a mestiçagem sem raça principal ou com raça principal não
jogável, e a segunda raça não pode ser igual à principal.

Testado com as 10 raças jogáveis (todas funcionam como base) e as 12
não-jogáveis (todas bloqueadas como base).

### Corrigido — botões do mestre flutuavam no meio da lista
Os três botões apareciam em posições diferentes conforme o número de poderes.
Causa: o conteúdo da aba estava dentro de um `<rectangle height="1500">` usado
como moldura, e o empilhamento `align="top"` se perde dentro desse wrapper. As
abas que funcionam (Raça, Atributos) põem o conteúdo **direto no scrollBox** —
agora esta faz o mesmo.

### Alterado — layout da aba
- Carteira de pontos subiu para o topo, logo abaixo do título.
- Os três botões viraram uma barra fixa de largura igual: **ADICIONAR PODER**
  (roxo/aura), AUTORIZAR SUBIDA EXTRA (ouro) e ROMPER LACRE (vinho). O
  destrutivo ficou por último, longe do de uso frequente.
- Selo do lacre virou uma faixa própria acima da lista.
- Removido o cabeçalho "PODERES ADQUIRIDOS".

### Adicionado — origem visível de cada poder
Cada linha ganhou um selo com a divindade e o vínculo: **ouro** para o kit do
pai/mãe, **roxo** para os vindos de bênção, **azul-chuva** para Magia (Coração
de Mana). Os poderes agora também aparecem agrupados, com cabeçalho de seção
por origem.

### Alterado — ordem de exibição
Poderes do pai/mãe vêm sempre primeiro, depois cada bênção na ordem em que foi
concedida, e por último os que não vêm de divindade. A lista serializada
continua guardando a ordem de compra; a reordenação é só de exibição, e os
botões +/− seguem a lista reordenada.

## v0.14.1 — catálogo de poderes e correção do erro ao clicar em "+"

### Corrigido — "attempt to call a nil value (global 'dataHoraTexto')"
Causa raiz: `dataHoraTexto` é uma **`local function`** declarada na linha 1855,
e o bloco de poderes tinha sido inserido na linha 639. Em Lua uma `local` só
existe a partir da linha em que foi declarada — chamar de cima para baixo
devolve nil. É a mesma armadilha que já está anotada no topo do arquivo, na
declaração da paleta COR.

Duas correções: o bloco de poderes passou a ser inserido **depois de todas as
locais do arquivo** (logo antes de `inicializarFicha`), e o carimbo de data
agora é `carimboDeTempo()`, uma função global própria do bloco, sem depender
da ordem de declaração de ninguém.

### Alterado — a aba mostra só os poderes ADQUIRIDOS
Listar os 5 do kit em "nível 0" comunicava "preencha os cinco", exatamente o
oposto da regra da mesa. Agora a aba abre com um estado vazio explicando que o
kit é opcional, e poderes entram por um botão **ADICIONAR PODER**.

Cada linha adquirida mostra o poder, o tipo, a divindade de origem, os pips e
os botões +/−. No nível 1, o "−" remove o poder e devolve o ponto. Clicar no
nome abre o catálogo já naquele poder.

### Adicionado — catálogo de poderes (popup mestre-detalhe)
Mesmo padrão de Qualidades, Raças e Deuses: lista à esquerda, detalhe à
direita. A lista traz os kits dos 18 deuses grandes agrupados por divindade,
com o tipo de cada poder. O detalhe mostra descrição completa e **os 5 níveis
de progressão**, com o nível atual em ouro, os alcançáveis em roxo e os acima
do teto apagados. Nos poderes ativos, cada nível informa o rank de habilidade
que destrava (1→E/D até 5→EX).

O catálogo mostra TODOS os kits, mas só libera a compra do kit da própria
divindade ou de quem abençoou — e o botão diz o motivo do bloqueio em vez de
só ficar apagado.

### Adicionado — bênçãos
Trocar 3 Favores com um deus que não é seu pai/mãe dá a bênção dele, e com ela
o acesso ao seu kit. Registrado por botão **só do mestre**, dentro do catálogo,
e publicado no chat. Guardado em campo plano serializado, e o poder adquirido
grava de qual divindade veio — por isso o modelo de dados não usa campos
numerados fixos.

### Descoberto — "Magia" não pertence a kit nenhum
Dos 48 poderes, 47 estão em kits de divindade. **Magia** não: é o poder dos
feitiços, liberado pela qualidade Coração de Mana. Entrou no catálogo em uma
seção "FORA DOS KITS", com gate próprio ligado ao campo `temCoracaoDeMana`.
Sem isso o poder simplesmente sumiria da ficha.

### Corrigido — grafias divergentes geravam cards duplicados
Seis entradas de kit usavam grafia diferente da lista de poderes
("Carisma Sobrenatural", "Manipulação dos alimentos", etc.), o que produzia 50
cards para 48 poderes. Os nomes nos kits foram canonizados na fonte.

### Testes executados em Lua real
Correção do bug do lacre, gates de acesso por divindade e por Coração de Mana,
bênção só pelo mestre e coexistindo com o aspecto original, gravação da
divindade de origem por poder, estado vazio, operação dos botões por índice da
lista, teto de 10 slots — e a conferência de que as 48 chaves `chavePoder()`
batem exatamente com os cards `rectPod_*` do XML.

## v0.14.0 — Aba de Poderes: kit da divindade

Primeira fatia da aba V. Entra o kit de poderes; habilidades e feitiços
ficam para as próximas entregas.

### Adicionado — carteira de pontos de poder
TOTAL / GASTOS / SALDO, com um campo editável de CONCEDIDOS. Esse campo
existe porque Favores viram pontos (2 favores = 1 ponto, 3 favores = 3
pontos) e porque o mestre pode conceder por narrativa — a tabela de nível
sozinha não daria conta.

### Adicionado — kit da divindade, 5 slots com pips
Mesmo padrão visual das subclasses: 5 círculos por poder, ouro para
comprado, vazado para disponível, **invisível** acima do teto atual — sem
pips fantasma. Cada slot mostra o tipo (ATIVO/PASSIVO) e o que o nível
atual entrega.

O kit é OPCIONAL e a tela diz isso. Regra da mesa: o jogador pode adquirir
um único poder e investir todo o resto em habilidades e feitiços, e seguir
a campanha inteira assim. Nível 0 é estado legítimo, não slot vazio.

Slots com escolha ("Telepatia ou Manipulação dos sonhos") resolvem a
ambiguidade na primeira compra: a partir daí vale o poder adquirido.

### Adicionado — regras enforçadas
- 1 ponto por nível, teto de 5 níveis por poder.
- Teto de poder PASSIVO por nível de personagem (2/3/4/5/5 nos níveis
  1/5/9/13/17). Ativos não têm esse teto.
- Máximo de 3 poderes passivos no total.
- Máximo de 2 poderes que bonificam atributo (são 7 no catálogo, um por
  atributo do sistema).
- **Proibido subir o mesmo poder duas vezes no mesmo nível de personagem.**

### Adicionado — log de compra por nível
A regra acima é inaplicável sem registrar EM QUE nível cada ponto foi
gasto. Cada poder guarda um log compacto ("1@1,2@3,3@5" = nível 1 comprado
no nível 1 do personagem, nível 2 no 3, nível 3 no 5).

### Adicionado — lacre do Aspecto Divino
Mesma mecânica do lacre de mestiçagem. O lacre fecha sozinho ao gastar o
primeiro ponto de poder: a partir daí trocar de divindade zeraria o kit, e
é exatamente o exploit que isso fecha. O livro reforça — no rebalanceamento
dos níveis 9 e 18, "Aspecto Divino não pode ser modificado" e "não é
possível trocar poderes".

Dois botões só do mestre, ambos de uso único e publicados no chat:
- ROMPER LACRE DO ASPECTO — libera a próxima troca de divindade.
- AUTORIZAR SUBIDA EXTRA NESTE NÍVEL — abre exceção à regra do 2x.

### Decisão de arquitetura — por que texto serializado e não recordList
A UI do kit é de slots fixos, então recordList só traria a armadilha de
reciclagem conhecida sem ganho de layout. Mas a quantidade de poderes NÃO é
fixa: a mecânica de Bênção (3 favores com um deus que não é seu pai/mãe)
libera comprar do kit daquele deus também. Campos planos numerados
obrigariam a migrar fichas já preenchidas quando as bênçãos entrarem.

Serializar em campo plano resolve os dois: `nome|nível|log|deus`, registros
separados por ";". O campo "deus" já vai gravado desde agora, mesmo só
existindo o kit nativo. Nenhum dos 48 nomes de poder contém ";", "|" ou "@"
(conferido no catálogo).

### catalogoPoderes.lua enriquecido
Agora com a progressão nível a nível dos 48 poderes (todos têm exatamente
5 níveis descritos) e o campo `atributo`, preenchido nos 7 passivos que
bonificam atributo — é o que sustenta a regra do máximo de dois.

Nos ativos, cada nível destrava um rank de habilidade: 1→E/D, 2→C, 3→B,
4→A, 5→EX. Isso vai alimentar o construtor de habilidades da próxima
entrega.

### Testes de regra executados em Lua real
Economia por nível (1=2, 10=26, 20=53 pontos), compra e devolução, bloqueio
de 2x no mesmo nível, consumo de uso único da autorização do mestre, teto de
passivo mudando no nível 5, ativo chegando a 5, bloqueio do 4º passivo, do
3º poder de atributo, de compra sem saldo, round-trip da serialização e
resolução de slot ambíguo.

## v0.13.5 — reempacotamento (troca de PC)

Os dois catálogos criados na série 0.13.x — `catalogoDeuses.lua` e
`catalogoPoderes.lua` — foram **regerados a partir do `.bib`**, porque não
estavam no zip da v0.12.1 nem entre os arquivos soltos recuperados.

O `ficha.lfm` da v0.13.5, o `module.xml` e este changelog são os originais.

### Conferência de fidelidade da regeração
- 30 divindades: 9 primordiais, 18 grandes, 3 menores.
- As 30 `chave` batem 1:1 com os cards `rectDeus_<chave>` do `ficha.lfm`.
- 48 poderes: 27 ativos, 21 passivos.
- Todos os 18 kits têm 5 slots, com **3 ativos e 2 passivos** — a proporção
  que o livro da mesa exige. Nenhum kit fora do padrão.
- Todo poder citado em kit existe no catálogo (integridade referencial fechada).
- Uhtris e Unaris: 7 parágrafos, 3.752 caracteres — o mesmo número registrado
  no changelog da v0.13.5 original. Nellios: 3 parágrafos. A extração é
  equivalente à anterior, não uma aproximação.

### Divergências de grafia do próprio .bib, tratadas na regeração
O `.bib` grafa alguns poderes de um jeito na lista e de outro nos kits, então
`CatalogoPoderes.buscar()` normaliza caixa, acentuação, preposições e gênero
final:

| Nos kits | Na lista de poderes |
|---|---|
| Carisma Sobrenatural | Carisma sobrenatural |
| Fator de cura regenerativa | Fator de cura regenerativo |
| Fator de aura regenerativo | Fator de aura regenerativa |
| Manipulação dos alimentos | Manipulação de alimentos |
| Indução artística (Merewen) | Intuição artística |

O último é typo do documento (1 ocorrência contra 3 da forma correta) e está
mapeado explicitamente, com comentário no código.

Também: "Liderança absoluta" é o único poder cujo tipo o `.bib` escreve no
feminino ("Tipo: ativa"). O parser aceita os dois gêneros — sem isso, o poder
sumia do catálogo e três kits (Ras'buz, Oduwa, Ammis) ficavam quebrados.

## v0.13.5 — história dos deuses em um label só

### A diferença entre este popup e o de Raças
O popup de Raças nunca teve problema de espaçamento porque usa **UM label** com
o texto inteiro (`popRaca_lblLore`), dentro de um retângulo de altura fixa. O
`wordWrap` do próprio label quebra as linhas, e não existe espaço entre
parágrafos para a ficha errar.

O popup de Deuses usava **8 labels**, um por parágrafo, cada um com altura
calculada por estimativa. Como a ficha não consegue medir texto renderizado,
todo erro de estimativa virava um buraco visível no meio do texto — e eram
oito chances de errar.

Agora é igual ao de Raças: um label, parágrafos separados por linha em branco,
e uma única estimativa para a altura do bloco. Errar nessa estimativa só gera
espaço em branco no fim da rolagem, onde ninguém repara.

Verificado com o deus de maior lore da mesa (Uhtris e Unaris: 7 parágrafos,
3.752 caracteres) e com o menor (Nellios, 3 parágrafos).

### Lição para o projeto
Para texto longo de tamanho variável, **um label com o texto inteiro**. Dividir
em vários labels de altura calculada multiplica as chances de erro sem ganhar
nada — a ficha não tem como medir o texto depois de renderizado.

## v0.13.4 — buracos entre parágrafos, causa raiz

A v0.13.3 corrigiu duas causas e deixou a terceira, que era a maior.

**A largura era lida do próprio label (`lbl.width`) dentro de um popup que
ainda não tinha sido desenhado.** Nesse momento o controle não foi posicionado
e devolve um valor pequeno. Com largura ~300 em vez de ~740, cada parágrafo era
estimado com o dobro de linhas — daí os buracos de ~170px.

Agora a largura vem de `tamanhoPopupDeuses()`, calculada a partir do tamanho da
ficha, conhecida **antes** de qualquer desenho e independente de timing de
layout. A história da Qhyrana passou de ~700px para 340px, com folga máxima de
uma linha por parágrafo (sobra invisível; texto cortado, não).

Testado em ficha de 1100, 1266 e 1920px de largura.

### As três armadilhas desta função, para o histórico
1. `#texto` em Lua conta **bytes**, não caracteres — acentuação UTF-8 ocupa 2.
2. Largura chutada em número fixo, sem relação com o popup real.
3. Ler dimensão de um controle antes dele existir na tela.

## v0.13.3 — painel de detalhe do deus rola inteiro

### Corrigido — história espremida em tela pequena
Mesmo erro da aba de Raças, em escala menor: só a história rolava, dentro da
sobra de espaço de um painel de altura fixa. Em tela baixa isso virava três
linhas visíveis.

Agora **o painel direito inteiro é um scrollBox** — nome, categoria, kit e
história rolam juntos, com tudo `align="top"`. O botão de escolher fica fora do
scroll, sempre alcançável no rodapé.

### Corrigido — buracos entre os parágrafos da história
A altura de cada parágrafo era estimada com dois erros que se somavam:
1. **`#p` em Lua conta bytes, não caracteres.** Acentuação em UTF-8 ocupa 2
   bytes, então texto em português inflava a contagem em ~6% (num parágrafo de
   68 caracteres, 73 bytes).
2. A largura era chutada em 92 caracteres por linha, fixa, sem olhar a largura
   real do label.

Agora a ficha lê a largura real do label e conta caracteres com `utf8.len`.
Margem entre parágrafos reduzida de 8px para 4px — o resto do espaço vinha da
altura superestimada, não da margem.

### Alterado
O painel de kit encolhe de 188px para 62px quando a divindade não tem kit
definido, em vez de deixar cinco caixas vazias.

## v0.13.2 — só deuses grandes são selecionáveis

### Corrigido — ortografia dos deuses menores
O documento escreve os nomes em dois blocos de negrito separados
("**Vista,** **A Deusa da Colheita**"), e a extração perdia a vírgula.
Corrigido nos três: "Haliana, a Deusa da Pesca", "Morgara, a Deusa das Aves"
e "Vista, a Deusa da Colheita".

### Alterado — apenas deuses grandes concedem Aspecto Divino
Antes grandes e menores eram selecionáveis. Agora só os 18 grandes; os 3
menores e os 9 primordiais ficam no catálogo como lore, com o botão de escolha
desligado.

A ficha **explica o motivo** em vez de apenas desabilitar o botão:
- Primordiais: são entidades da criação e não concedem Aspecto Divino.
- Menores: ainda não têm kit de poderes definido no livro da mesa.

Se um dia os kits dos menores forem escritos, basta trocar `selecionavel` no
catálogo — o resto da ficha já trata os dois casos.

## v0.13.1 — catálogo de divindades completo (mestre-detalhe)

### Alterado — popup de Aspecto Divino
Virou mestre-detalhe, no mesmo padrão de Raças, Qualidades e Classes: lista à
esquerda agrupada por categoria, painel completo à direita com nome, categoria,
kit de poderes e a história completa da divindade.

- **30 divindades** agora (antes 19): 18 grandes, 3 menores e **9 primordiais**.
- Os primordiais aparecem como referência de lore, com o botão de escolha
  desligado e aviso explícito — só grandes e menores são selecionáveis.
- Cada slot do kit mostra o tipo do poder (ativo/passivo), lido do
  `catalogoPoderes.lua`. Slots com alternativa aparecem como "A ou B".
- A história vem em até 8 parágrafos, com altura calculada por parágrafo.

### Removido — vagas por divindade
As vagas do livro saíram da ficha e do popup. A ficha não tem como saber o que
as outras fichas da mesa escolheram, então exibir um número desatualizado seria
pior do que não exibir nada. O controle fica com o mestre, fora da ficha.

## v0.13.0 — Aspecto Divino com catálogo + base de dados de Poderes

### Adicionado — seletor de Aspecto Divino
O campo de texto livre virou campo clicável com catálogo, no mesmo padrão do
Traço de Personalidade (cards estáticos, cada um com o nome no próprio
`onClick` — nada de recordList reciclada).

- Novo `catalogoDeuses.lua`: **19 divindades** com categoria, vagas e o KIT DE
  PODERES completo (5 slots, com as alternativas "A ou B" preservadas).
- O card mostra o kit inteiro, que é a informação que de fato decide a escolha.
- Valores digitados à mão antes do catálogo são **preservados** e marcados como
  "fora do catálogo", em vez de apagados.

### Adicionado — `catalogoPoderes.lua` (base para a próxima aba)
- **48 poderes** (27 ativos, 21 passivos), árvores de 5 níveis.
- Tabela de pontos de poder por nível de personagem (2 no nv1 … 53 no nv20).
- Tabela de **nível máximo de poder passivo** por nível de personagem
  (2 até o nv4, 3 no nv5, 4 no nv9, 5 do nv13 em diante).
- Mapeamento dos 7 passivos de atributo e das 10 listas de perícias, para as
  regras de acumulação.
- Pares antagônicos evidentes, usados apenas para aviso.

### Divergências entre documentos (corrigidas no catálogo)
O documento "Deuses" e o "Poderes e Perícias" escrevem alguns nomes de forma
diferente: "Fator de cura regenerativa/o", "Indução/Intuição artística",
"Manipulação dos/de alimentos". Além disso "Liderança absoluta" está marcada
como `Tipo: ativa`. Todos reconciliados, com verificação automática de que
todo poder citado nos kits existe no catálogo.

## v0.12.5 — círculos de nível corrigidos

Os marcadores estavam ovais: 20px de largura contra 26px de altura (a linha do
slot tem 52px úteis e as margens verticais eram 13). Círculo exige largura ==
altura. Agora 14x14 com raio 7 — menores e redondos de verdade.

## v0.12.4 — atributos base do mestiço + redesenho dos níveis de subclasse

### Adicionado — regra de mesa: mestiço fica com o maior atributo base
**Esta regra não está escrita no `.bib`** — busquei nos 15 documentos e a
entrada da qualidade Mestiço só trata das habilidades raciais. Implementada
como regra da mesa, declarada no código.

O mestiço recebe o **maior valor entre as duas raças, atributo por atributo**
(não "o pacote da melhor raça"). Humanos (10m / 1d10) + Minotauros (8m / 1d12)
resulta em **10m / 1d12**.

Só é gravado nos momentos de decisão (escolher a raça, confirmar a mestiçagem),
nunca a cada refresh — os dois campos são editáveis à mão em Cálculos & Combate
e sobrescrever sempre brigaria com o jogador. O painel "Atributos Base" agora
explica de onde veio o valor quando o personagem é mestiço.

### Alterado — marcadores de nível de subclasse
- As "bolinhas" deixaram de ser os caracteres ● ○ dentro do texto e viraram
  **círculos de verdade** (rectangles com `xradius`/`yradius`), de 20px:
  preenchidos em ouro para níveis comprados, vazios em cinza para disponíveis,
  invisíveis para os que estão fora do teto daquela árvore.
- Rótulo numérico "3 / 8" ao lado, em verde quando a árvore está completa.
- **Removida a descrição do último nível comprado** da linha do slot.
- Linhas de slot de 44px para 58px; bloco de classe de 164px para 186px.

### Alterado — clicar na subclasse abre o catálogo nela
Clicar em um slot preenchido abre o catálogo **já posicionado naquela
subclasse**, com todos os níveis descritos. Antes abria na última visitada.

## v0.12.3 — aba Raça & Classe reestruturada com barra de rolagem

### Correção de abordagem
A v0.12.2 tratou o sintoma: espremia os blocos até caberem na altura da aba.
Isso parou a sobreposição, mas deixou a aba feia e com texto cortado
("SITUAÇÃO" chegava a truncar). A aba simplesmente tem conteúdo demais para
uma altura fixa — a resposta certa é **rolar**, não encolher, exatamente como
as abas de Atributos e Combate já fazem.

### Alterado — estrutura da aba
- Todo o conteúdo passou a viver dentro de um `<scrollBox align="client">`.
- **Todos os blocos agora são `align="top"`**, na ordem natural de leitura.
  Sumiu a acrobacia de `align="bottom"` (que só existia porque a lista de
  características era `align="client"` e precisava do espaço do meio) e sumiu
  junto o comentário sobre ordem de empilhamento invertida.
- A `recordList` de características passou de `align="client"` para
  `align="top"` com `height` calculado (`ajustarAlturaListaCaracs`): a lista
  cresce conforme os itens e quem rola é a aba. Lista com scroll próprio
  dentro de área com scroll é ruim de usar.

### Removido
- Todo o sistema de compactação em três níveis (`ajustarLayoutAbaRaca`,
  `ALTURAS_ABA_RACA`, `ALTURA_MINIMA_LISTA`) e o `onResize` do painel.
  Nada mais encolhe: cada bloco tem sua altura natural em qualquer monitor.

### Alturas restauradas (estavam apertadas)
- Situação: 46 → 54
- Atributos Base: 42 → 50 (e volta a aparecer sempre)
- Mestiçagem: 112 → 124

### Regra do projeto (atualizada)
Aba com conteúdo de altura imprevisível → `scrollBox` com tudo `align="top"`.
`align="client"` só quando existe exatamente um bloco elástico e a altura total
é garantida. Nunca resolver estouro de layout encolhendo conteúdo.

## v0.12.2 — layout responsivo (monitores menores)

Todos os três problemas tinham a mesma causa: dimensões travadas em pixel, que
só davam a proporção certa numa resolução específica.

Por que não migrar para o Grid System do SDK: ele resolveria isso nativamente,
mas exige SDK 3.7 e **não pode ser misturado com o atributo `align=`** — ou
seja, obrigaria a reescrever a ficha inteira. Como todo controle tem o evento
`onResize` e as propriedades `width`/`height` são graváveis, dá para fazer
proporção e adaptação em Lua, cirurgicamente.

### Corrigido — colunas de Qualidades & Defeitos 50/50 em qualquer tela
A coluna da esquerda tinha `width="895"` fixo: em 1920px dava meio a meio por
coincidência, em 1266px virava 70/30. Agora um `onResize` no container calcula
metade da largura disponível.

### Corrigido — popups cortados embaixo
Popups com `height` fixo maior que a janela do Firecast tinham o rodapé cortado.
A nova função `abrirPopupAjustado()` trata o tamanho declarado como **teto** e
limita o real a 94% do espaço da ficha. Aplicada aos 13 popups.

### Corrigido — aba Raça & Classe embaralhada
A aba tem muita altura fixa (topo: título, seletor, situação, atributos base,
mestiçagem; rodapé: título de seção e bloco de classe) e uma única área
elástica, a lista de características. Quando a soma das fixas passava da altura
do painel, o `align="client"` da lista colapsava e os elementos `align="bottom"`
subiam por cima dos `align="top"` — daí a sobreposição.

Agora `ajustarLayoutAbaRaca()` escolhe entre três níveis de compactação,
garantindo sempre no mínimo 120px para a lista:
- **Normal** — como estava, em telas altas.
- **Compacto** — blocos encolhidos; a linha de aviso do bloco de classe some.
- **Mínimo** — esconde também "Atributos Base" (que é informativo e aparece
  igual em Cálculos & Combate) e o slot 2 de subclasse quando está vazio.

Quando o personagem não tem a qualidade Mestiço, o painel de mestiçagem já
encolhe pela metade sozinho, porque vira só uma linha informativa.

### Regra nova do projeto
Largura/altura fixa em pixel **apenas para molduras** (botões, ícones, rótulos,
fotos). Onde a proporção importa, calcular no `onResize`.

## v0.12.1 — ajustes visuais e regra de árvores curtas

### Corrigido
- **Bug de entidade XML no cabeçalho das abas**: o campo `nome` da tabela
  `abasDef` está dentro de `<![CDATA[ ]]>`, onde `&amp;` NÃO é decodificado —
  o cabeçalho mostrava literalmente "SEÇÃO 04 • RAÇA &amp;amp; CLASSE".
  Trocado por `&` real nas 5 abas afetadas.
- **Rodapé do popup de Classes cortado**: os botões somavam 828px num painel
  de ~750px e o `+` ficava fora da área visível. Reduzidos para 528px.
- Retângulo do bloco de Classe subiu de 150px para 164px: a linha de aviso do
  rodapé estava sendo cortada.

### Alterado
- Título da aba passou a ser **RAÇAS**, e o bloco de Classe ganhou um
  **cabeçalho de seção próprio** no mesmo padrão (estrela violeta + Cinzel
  Decorative 19 + linha dourada de largura total), para o jogador enxergar
  onde termina uma seção e começa a outra.
- **Removidos os botões LIMPAR 1ª / LIMPAR 2ª.** Zerar o nível de uma
  subclasse (botão `−` no nível 1) agora a remove da ficha e devolve os
  pontos ao saldo — uma ação em vez de duas.

### Alterado — árvores curtas são regra, não dado faltando
Correção de premissa: "Combatente crítico", "Samurai" e "Ninja" têm 5 níveis
**de propósito**. Quem escolhe uma árvore curta chega ao topo mais cedo e
precisa investir os pontos restantes em outra subclasse; quem escolhe uma de 8
pode concentrar tudo numa só.
- O teto passou a ser **por subclasse** (`totalNiveis`), não um 8 fixo.
- Sumiram os avisos de "nível não descrito"; a lista mostra "· 5 níveis" e o
  detalhe informa o tamanho da árvore.
- Ao completar uma árvore, a ficha avisa que os próximos pontos precisam ir
  para a outra subclasse.
- Cards de nível acima do teto ficam invisíveis em vez de exibirem texto de
  pendência.

## v0.12.0 — Lacre de Sorteio (mestiçagem) + Classe & Subclasse

### Adicionado — LACRE DE SORTEIO
- O sorteio das características de mestiço agora grava um **lacre** na ficha
  (`mesticoLacre`, `mesticoLacreAutor`, `mesticoLacreData`, `mesticoLacreTier`).
  A partir dele, as características **SORTEADAS são imutáveis**; as
  **ESCOLHIDAS continuam trocáveis** à vontade.
- O popup de mestiçagem passou a ter dois modos: primeiro sorteio (escolhe,
  sorteia, lacra e publica no chat) e troca de escolhidas (nenhuma rolagem
  nova; as sorteadas são preservadas exatamente como estavam).
- Cards lacrados aparecem em azul-chuva com o prefixo `[LACRADA]` e não
  respondem a clique. Na aba, o card mostra `SORTEADA • IMUTÁVEL • <origem>`.
- **Publicação no chat da mesa** (TaleMark) do sorteio, da quebra de lacre e do
  reajuste de tier, com autor e data.
- Popup **LACRE / MESTRE** com três ações: quebrar o lacre (libera UM novo
  sorteio), autorizar reajuste de tier e cancelar autorizações pendentes
  (relacra). As autorizações são de **uso único**: consumidas na próxima ação
  do jogador, para não deixar ficha destravada por esquecimento.

### Corrigido — as quatro portas de re-sorteio
Antes, o jogador podia rolar as características quantas vezes quisesse até
cair um conjunto bom, sem custo. Existiam quatro caminhos, não dois:
1. `REFAZER HERANÇA` — agora bloqueado com o lacre (botão vira "LACRADA").
2. `LIMPAR RAÇA` — agora apaga a raça mas **preserva** a herança lacrada.
3. **Remover e recomprar a qualidade Mestiço** — o "x" da linha fica bloqueado
   para o jogador enquanto houver lacre (o mestre continua podendo remover).
   Como o lacre vive em campos planos, recomprar a qualidade devolve
   exatamente o mesmo sorteio.
4. **Trocar a raça secundária** — congelada: faz parte do sorteio lacrado.

### Decisão de regra da mesa (upgrade de tier)
Subir de Mestiço 1 PQ para 2 PQ **depois** do sorteio NÃO converte sorteadas em
escolhidas automaticamente. O tier fica congelado no lacre; só a autorização do
mestre aplica o tier atual. Downgrade segue a mesma lógica: nada acontece
sozinho.

### Adicionado — CLASSE & SUBCLASSE
- Novo `catalogoClasses.lua`, extraído do documento "Classes e Traços" do
  `.bib`: **12 classes, 36 subclasses**, árvores de 8 níveis, incluindo as
  observações `★` de Sacerdote e Mártir.
- Bloco no rodapé da aba Raça & Classe (`align="bottom"`) com os dois slots de
  subclasse, saldo de pontos, campo de ajuste manual e autorização do mestre.
- Popup mestre-detalhe no padrão de Raças/Qualidades: 36 cards estáticos à
  esquerda, árvore de 8 níveis à direita (adquiridos em ouro), rodapé com
  definir 1ª/2ª, subir/descer nível e limpar slot.
- Regras automatizadas: pontos de classe nos níveis 1/3/5/8/11/14/17/20;
  1 ponto por nível de subclasse; teto de 8; máximo de 2 subclasses; a segunda
  só a partir do nível 11 e com a primeira no nível 4 — tudo ignorável pelo
  checkbox de autorização do mestre.
- Válvula de escape: `pontosClasseAjuste` soma ou subtrai pontos à mão.

### Dados incompletos no documento (não inventados)
Cinco subclasses só têm os níveis 1 a 5 escritos no `.bib`: "Combatente
crítico" (Atirador, Duelista e Guerreiro), "Samurai" e "Ninja". Ficam marcadas
com ⚠ na lista e os níveis 6-8 exibem "nível ainda não descrito no documento da
mesa — combine o efeito com o narrador".

### Armadilha nova documentada
`&#9679;` e afins **dentro de `<![CDATA[ ]]>` não são decodificados** — a
entidade apareceria literal na tela. Dentro de CDATA use o caractere UTF-8 de
verdade (● ○ •). É a irmã da armadilha do `&#10;` em `text=`.

## v0.1.3 — compilação bem-sucedida, correções de instalação e runtime
### Corrigido
- `<form>` não declarava `formType="sheetTemplate"` nem `dataType`, então o plugin instalava mas não aparecia como "Modelo de ficha" ao criar personagem. Adicionado `formType="sheetTemplate" dataType="com.petrichor.fichapersonagem.Ficha" title="Petrichor"`.
- Os módulos `.lua` (`dadosSistema.lua`, `calculos.lua`, `catalogoPericias.lua`, `catalogoQualidadesDefeitos.lua`) estavam em uma subpasta `scripts/`; o `require()` do Firecast só resolve arquivos na raiz do projeto. Movidos para a raiz — isso também corrigia a ficha abrindo em branco (o `require` falhava antes de qualquer widget ser criado).
- Linhas do `catalogoQualidadesDefeitos.lua` geraram avisos de "linha muito longa" no compilador (cosmético, não bloqueia) — candidato a quebra de linha em versão futura.

## v0.1.2 — correção via código-fonte real do GitHub oficial
### Corrigido
- Fui ao repositório oficial (`rrpgfirecast/firecast` no GitHub) e achei um `.lfm` fonte real (não compilado): `FichaMultiaba_Aba.lfm`. Confirmei que o atributo correto para tipar um `<edit>` é `type="number"` / `type="text"`, não `dataType="D"`/`"S"` (que eu tinha inventado). Troquei em todos os arquivos.
- Confirmado também que `<tabControl>` não aceita `theme` (removido).
- Confirmado que `onClick`/`onChange` como atributo com código Lua inline também é sintaxe válida em alguns componentes (coexiste com `<event name="onClick">` filho) — a reescrita anterior para `<event>` continua correta e não precisou ser revertida.

## v0.1.1 — correção de padrão de eventos (pós-diagnóstico real)
### Corrigido
- `module.xml`: tag `<n>` trocada por `<name>` (exigida pelo rdk 3.7b).
- `<form>` não aceita `backgroundColor`/`fontColor`/`fontSize` diretamente — fundo movido para um `<rectangle>` filho, no padrão do SDK.
- Descobri (estudando `Main_lfm.lua`, um compilado real de uma ficha já usada na mesa) que minha suposição inicial de sintaxe estava errada em vários pontos:
  - Eventos são elementos filhos `<event name="onClick">...</event>`, nunca atributos `onClick="funcao"`.
  - `self` e `sheet` nunca são parâmetros de função — já existem prontos no escopo de todo o `<script>` e de cada `<event>`.
  - Não existe `onLoad`; o evento de ciclo de vida real é `onNodeReady`, como filho do `<form>`.
  - Popups usam `:show()`/`:close()` (não existe `:hide()`).
  - `recordList` precisa de `field="campo"` e `itemHeight` (não `recordHeight`).
  - Criar item: `self.nomeDaLista:append()`. Iterar: `NDB.getChildNodes(sheet.campo)`. Remover (de dentro do item): `NDB.deleteNode(sheet)`.
  - `comboBox` não tem getter direto — leitura via campo vinculado (`field=`) na ficha.
- Reescrevi `ficha.lfm`, `itemPericia.lfm` e `itemQualidadeDefeito.lfm` inteiros com o padrão correto. Todos os 41 eventos convertidos, recordLists e comboBoxes corrigidos, XML revalidado.

## v0.1.0 — primeira entrega
### Adicionado
- Estrutura do módulo (`module.xml`) e ficha raiz (`ficha.lfm`) com `tabControl` de 9 abas.
- Motor de nível/rank/proficiência (`dadosSistema.lua`), cobrindo níveis 1–20 com herança de valores (rank, limite de atributo, nível máx. de poder passivo).
- Motor de cálculos derivados (`calculos.lua`): Hp, Mp, Ap, Pv (vitae), Deslocamento, Iniciativa, 4 Defesas, capacidade de mochila — todos testados com Lua real (ver testes em `/tmp/test_calc.lua` durante o desenvolvimento).
- Catálogo completo de Perícias por atributo (`catalogoPericias.lua`) — 64 perícias em 6 atributos.
- Catálogo completo de Qualidades & Defeitos (`catalogoQualidadesDefeitos.lua`) — 49 itens com descrição/efeito completos.
- Templates de item: `itemPericia.lfm`, `itemQualidadeDefeito.lfm` — ambos com popup de descrição carregado ao vivo do catálogo (sem duplicar texto, sem cair na armadilha do popup vs. raiz da ficha).
- Aba **Dados Pessoais** completa.
- Aba **Atributos & Perícias** completa.
- Aba **Cálculos & Combate** completa, com campo de ajuste manual em todo valor automático.
- Aba **Qualidades & Defeitos** completa.
- Abas **Raça & Classe**, **Poderes & Habilidades**, **Favores Divinos**, **Inventário** — placeholders (`Em construção`).
- Aba **Background** — campo de texto livre já plugado ao `dataType`.

### Preservado / decisões de design
- Idade e Aniversário separados em dois campos (ver LEIA-ME.txt).
- "Rank" nas fórmulas numéricas assumido como E=1...EX=6 (a validar com a mesa).
- Mp e Pv ocultos por padrão até a qualidade correspondente ser marcada (Coração de mana / Vampiro).

### Pendente para próxima versão
- Catálogos de Raças e Classes/Traços (documentos extensos, entrega dedicada).
- Catálogo de Poderes por divindade + habilidades.
- Favores Divinos, Inventário completo (com automação de equipados → bônus de defesa).
- Compile real via `rdk c` + ajustes de layout com base em screenshots.

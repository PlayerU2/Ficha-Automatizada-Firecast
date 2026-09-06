-- =====================================================================
-- CATALOGO DO BESTIARIO - Ficha Petrichor
-- Fonte: [2.9] Elementos e Bestiario (compilacao .bib), secoes "Tamanho",
-- "Natureza", "Intelecto", "Dieta", "Tipos", "Raridade", "Rank" e
-- "Criando a ficha de uma criatura".
--
-- O livro fecha a secao dizendo, com todas as letras, para que serve isto:
--   "E necessario primeiro definir toda as caracteristicas da mesma:
--    tamanho, natureza, intelecto, dieta, tipo, raridade e rank. Unindo
--    essas informacoes sera possivel saber a base de algumas informacoes, e
--    a partir disso o narrador podera personalizar a mesma da forma como bem
--    entender, respeitando as regras definidas por classificacao/rank. Este
--    sistema vale tanto para a criacao de inimigos, quanto para criacao de
--    pets, montarias e criaturas auxiliares, mas jamais para inimigos que
--    sao Seres Mortais."
--
-- "o narrador podera personalizar da forma como bem entender" e por que o
-- gerador da aba SUGERE e nunca impoe: tudo o que ele escreve continua
-- editavel.
--
-- ATENCAO - "Tamanho" aqui NAO e o mesmo "Tamanho" do personagem. As seis
-- categorias tem os mesmos NOMES e efeitos completamente diferentes:
--   * personagem (Sistema e Evolucao) -> alcance efetivo, espaco no grid,
--     bonus de ocultacao, diferenca de categoria entre oponentes;
--   * criatura (aqui)                 -> bonus de atributo e de vida/CD.
-- Nunca compartilhar um campo de tamanho entre os dois.
--
-- CAMPOS COM ESCOLHA: varios efeitos dizem "+N em FORCA ou DESTREZA". O
-- gerador NAO escolhe por ninguem - ele lista a pendencia em texto, dizendo
-- onde lancar. Ver "instrucoes" em cada entrada.
-- =====================================================================

local CatalogoBestiario = {}

-- ---------------------------------------------------------------------
-- TAMANHO (da criatura)
-- ---------------------------------------------------------------------
CatalogoBestiario.tamanhos = {
  { nome = "Minúsculo", altura = "até 80 cm",
    cd = 2, vida = 0,
    instrucao = "+1 de FORÇA ou DESTREZA (escolha uma)" },
  { nome = "Pequeno", altura = "81 cm a 1,40 m",
    cd = 1, vida = 0,
    instrucao = "+2 de FORÇA ou DESTREZA (escolha uma)" },
  { nome = "Médio", altura = "1,41 m a 2,10 m",
    cd = 0, vida = 25,
    instrucao = "+3 de FORÇA ou CONSTITUIÇÃO (escolha uma)" },
  { nome = "Grande", altura = "2,11 m a 3,50 m",
    cd = 0, vida = 50,
    instrucao = "+4 de FORÇA ou CONSTITUIÇÃO (escolha uma)" },
  { nome = "Enorme", altura = "acima de 3,50 m",
    cd = 0, vida = 100,
    instrucao = "+4 de FORÇA ou CONSTITUIÇÃO (escolha uma)" },
  { nome = "Colossal", altura = "acima de 7,50 m",
    cd = 0, vida = 200,
    instrucao = "+8 de FORÇA ou CONSTITUIÇÃO (escolha uma)" },
}

-- ---------------------------------------------------------------------
-- NATUREZA - sociabilidade
-- ---------------------------------------------------------------------
CatalogoBestiario.naturezas = {
  { nome = "Agressivo", carisma = 0,
    descricao = "pré-disposição a atacar aquilo que não compreende",
    instrucao = "+2 em testes de intimidação" },
  { nome = "Solitário", carisma = 0,
    descricao = "recluso, mantém distância do desconhecido, mas ataca quando assediado",
    instrucao = "+1 em testes de intimidação" },
  { nome = "Neutro", carisma = 1,
    descricao = "ataca ou foge quando se sente ameaçado; não teme o desconhecido",
    instrucao = "" },
  { nome = "Dócil", carisma = 2,
    descricao = "foge quando ameaçado; pré-disposto a interagir com desconhecidos",
    instrucao = "" },
}

-- ---------------------------------------------------------------------
-- INTELECTO
-- O bonus e "+N em SABEDORIA ou INTELIGENCIA" a partir do Instintivo -
-- escolha, portanto instrucao. So o Irracional nomeia um atributo so.
-- ---------------------------------------------------------------------
CatalogoBestiario.intelectos = {
  { nome = "Irracional", sabedoria = 1,
    descricao = "incapaz de pensar no futuro ou agir de forma lógica; guiado por instintos",
    instrucao = "" },
  { nome = "Instintivo", sabedoria = 0,
    descricao = "age de forma minimamente lógica, mas guiado primariamente por instintos",
    instrucao = "+2 de SABEDORIA ou INTELIGÊNCIA (escolha uma)" },
  { nome = "Racional", sabedoria = 0,
    descricao = "resolve problemas e planeja, com alcance limitado",
    instrucao = "+3 de SABEDORIA ou INTELIGÊNCIA (escolha uma)" },
  { nome = "Organizado", sabedoria = 0,
    descricao = "plena habilidade lógica e estratégica; pensa no futuro e aprende rápido",
    instrucao = "+4 de SABEDORIA ou INTELIGÊNCIA (escolha uma)" },
}

-- ---------------------------------------------------------------------
-- DIETA - inteiramente narrativa, sem numero nenhum
-- ---------------------------------------------------------------------
CatalogoBestiario.dietas = {
  { nome = "Carnívoro", descricao = "carne de qualquer criatura viva; adora carne fresca, odeia plantas e vegetais" },
  { nome = "Herbívoro", descricao = "plantas e vegetais; adora fitomorfos, odeia rochas e metais" },
  { nome = "Necrófago", descricao = "tudo que está morto; tem repulsa ao que está vivo" },
  { nome = "Metáfago", descricao = "rochas e metais; não odeia nenhum tipo de alimento em especial" },
  { nome = "Onívoro", descricao = "carne, plantas e vegetais; repulsa a alimentos podres, rochas e metais" },
}

-- ---------------------------------------------------------------------
-- TIPOS - narrativos, com duas excecoes que trazem regra dura
-- ---------------------------------------------------------------------
CatalogoBestiario.tipos = {
  { nome = "Aberração",
    descricao = "não criada de forma natural: fenômenos, quimerismos ou mutações extremas. Todo ser vindo dos Reinos Não-Materiais é classificado aqui.",
    regra = "Busca sempre se agrupar e encontrar forma de se reproduzir." },
  { nome = "Besta",
    descricao = "o reino animal inteiro, do inseto ao grande predador. As mais comuns do mundo.",
    regra = "" },
  { nome = "Constructo",
    descricao = "construída artificialmente com materiais não orgânicos e uma forma de vida imbuída no corpo sintético.",
    regra = "IMUNE a telepatia e a empatia. Fraqueza: descobrir seu propósito. Alguns podem ser exorcizados.",
    -- Livro [2.7], Constructos: "São imunes a telepatia e a empatia."
    imune = { "telepatia", "empatia" }, resistente = {} },
  { nome = "Elemental",
    descricao = "nascida da concentração de energia elemental num local, ou da reprodução de outros elementais.",
    regra = "Fraqueza: golpes e fisiologia presos a um elemento — combata com a energia oposta." },
  { nome = "Entidade",
    descricao = "influencia o mundo material sem existir fisicamente nele: sonhos, pesadelos, entidades sentimentais ou psíquicas.",
    regra = "Só pode ser morta no próprio habitat. Fraqueza: proteção da mente e do coração, ou reverter o fenômeno que a deixou influenciar." },
  { nome = "Fitomorfo",
    descricao = "composta de matéria vegetal: plantas, árvores ou fungos.",
    regra = "Sensível a mudanças climáticas e à destruição da flora local; a maioria é vulnerável ao fogo (os fungos, à luz)." },
  { nome = "Necromorfo",
    descricao = "reside no mundo material sem estar viva — \"não-viva\", que é diferente de morta. Zumbis, carniçais, fantasmas.",
    regra = "RESISTENTE a dano físico e a manipulação telepática; IMUNE a manipulação empática. Frágil contra banimento, exorcismo e o elemento Sagrado (e seus sub-elementos Vida e Morte).",
    -- Livro [2.7], Necromorfos: "especialmente resistentes a danos físicos,
    -- e comumente resistentes a manipulações telepáticas e Imunes a
    -- manipulações empáticas."
    imune = { "empatia" }, resistente = { "dano físico", "telepatia" } },
  { nome = "Simbionte",
    descricao = "depende de relação simbiótica para sobreviver, fundindo-se a outros organismos.",
    regra = "Força e vida limitadas às do hospedeiro. Eliminar curando ou eliminando aquilo a que se fundiu." },
}

-- ---------------------------------------------------------------------
-- RARIDADE - espolios. Nao mede poder: "uma criatura pode ser
-- excepcionalmente rara porem fraca".
-- ---------------------------------------------------------------------
CatalogoBestiario.raridades = {
  { nome = "Comum", frequencia = "encontrada diariamente, sem dificuldade",
    espolios = "1 espólio de raridade Comum" },
  { nome = "Incomum", frequencia = "encontrada ao menos uma vez por ano",
    espolios = "2 espólios: um Incomum e um Comum" },
  { nome = "Raro", frequencia = "encontrada ao menos uma vez a cada cinco anos",
    espolios = "3 espólios: um Raro, os outros Comuns ou Incomuns" },
  { nome = "Épico", frequencia = "uma vez a cada 50 anos ou mais",
    espolios = "4 espólios: um Épico, os outros Raros, Incomuns ou Comuns" },
}

-- ---------------------------------------------------------------------
-- RANK - a unica classificacao que traz a base numerica inteira.
--
-- Os valores do livro sao FAIXAS ("HP: 40 a 60"). O gerador SORTEIA dentro
-- da faixa (decisao da mesa, 22/08/2026) e diz de qual faixa o numero saiu.
--
-- Ate a v0.35.0 ele preenchia o MINIMO, com o argumento de que escolher o
-- meio da faixa seria inventar um numero que o livro nao escreveu. O
-- argumento nao para em pe: o livro escreveu a faixa INTEIRA, entao qualquer
-- numero dentro dela e do livro. O minimo e tao arbitrario quanto o meio, e
-- ainda tem o agravante de produzir sempre a criatura mais fraca possivel
-- daquele rank - o mestre acabava subindo tudo na mao, toda vez.
--
-- ATENCAO ao rank EX: hpMax = 0 e cdMax = 0 significam "sem teto escrito no
-- livro". Sortear entre 500 e 0 devolveria lixo; sortearFaixa() trata isso
-- devolvendo o minimo quando o teto nao existe.
-- ---------------------------------------------------------------------
CatalogoBestiario.ranks = {
  { nome = "E", descricao = "força de um mortal jovem comum e não treinado; as mais fracas, normalmente as muito jovens",
    percentual = "100%",
    atribMin = 1, atribMax = 2, profMin = 1, profMax = 2,
    hpMin = 40, hpMax = 60, cdMin = 11, cdMax = 13,
    xpMin = 8, xpMax = 20, habilidades = 1,
    acoesPadraoExtra = 0, acoesBonusExtra = 0, acaoLendaria = false },
  { nome = "D", descricao = "força de um mortal adulto com treinamento básico; as mais comuns",
    percentual = "70%",
    atribMin = 2, atribMax = 4, profMin = 2, profMax = 3,
    hpMin = 60, hpMax = 100, cdMin = 14, cdMax = 16,
    xpMin = 21, xpMax = 50, habilidades = 2,
    acoesPadraoExtra = 0, acoesBonusExtra = 0, acaoLendaria = false },
  { nome = "C", descricao = "exige um grupo de 2 a 4 adultos treinados; costuma ser o ápice da maioria",
    percentual = "35%",
    atribMin = 4, atribMax = 5, profMin = 3, profMax = 4,
    hpMin = 100, hpMax = 180, cdMin = 17, cdMax = 19,
    xpMin = 51, xpMax = 120, habilidades = 2,
    acoesPadraoExtra = 0, acoesBonusExtra = 1, acaoLendaria = false },
  { nome = "B", descricao = "criaturas que começam a sobressair; exigem de 4 a 8 adultos treinados",
    percentual = "15%",
    atribMin = 5, atribMax = 6, profMin = 4, profMax = 5,
    hpMin = 180, hpMax = 300, cdMin = 22, cdMax = 25,
    xpMin = 121, xpMax = 300, habilidades = 3,
    acoesPadraoExtra = 1, acoesBonusExtra = 1, acaoLendaria = false },
  { nome = "A", descricao = "nível superior de poder; ameaças nacionais, exigem um batalhão de até 100 mortais",
    percentual = "1%",
    atribMin = 6, atribMax = 7, profMin = 5, profMax = 6,
    hpMin = 300, hpMax = 500, cdMin = 26, cdMax = 29,
    xpMin = 301, xpMax = 700, habilidades = 4,
    acoesPadraoExtra = 1, acoesBonusExtra = 2, acaoLendaria = false },
  { nome = "EX", descricao = "ameaças internacionais; justificam missões militares inteiras",
    percentual = "0.1%",
    atribMin = 7, atribMax = 8, profMin = 6, profMax = 7,
    hpMin = 500, hpMax = 0, cdMin = 30, cdMax = 0,   -- 0 = "sem teto escrito"
    xpMin = 701, xpMax = 1500, habilidades = 4,
    acoesPadraoExtra = 2, acoesBonusExtra = 2, acaoLendaria = true },
}

-- ---------------------------------------------------------------------
-- MONTARIAS (Loja, secao "Montarias"). Ficam aqui, e nao no catalogo de
-- itens, porque uma montaria e uma CRIATURA - o livro diz que o sistema do
-- Bestiario vale "para criacao de pets, montarias e criaturas auxiliares".
-- O que se compra na loja e o animal ja treinado num certo grau.
--
-- "bonus de montaria" e citado tres vezes na Loja e NUNCA definido. A mesa
-- decidiu (21/08/2026) le-lo como metros somados ao deslocamento de quem
-- esta montado. Marcado como DEDUCAO.
-- ---------------------------------------------------------------------
CatalogoBestiario.montarias = {
  { nome = "Montaria Adulta", qualidade = "Comum", preco = "2 Aureus",
    treino = "Não-treinado", rank = "E", vida = 60, deslocamento = 25,
    prof = 2, defesas = 13, pontosAtributo = 14,
    bonusMontariaBase = 0,   -- + bonus de proficiencia
    texto = "Não-treinado; Rank E; 60 de Vida; 25m de Deslocamento; +2 de Proficiência; 13 de Defesas; 14 pontos de atributos; 0+(Bônus de proficiência)m de bônus de montaria" },
  { nome = "Montaria Adulta", qualidade = "Incomum", preco = "4 Aureus",
    treino = "Treino simples", rank = "D", vida = 100, deslocamento = 27,
    prof = 4, defesas = 16, pontosAtributo = 21,
    bonusMontariaBase = 1,
    texto = "Treino simples; Rank D; 100 de Vida; 27m de Deslocamento; +4 de Proficiência; 16 de Defesas; 21 pontos de atributos; 1+(Bônus de proficiência)m de bônus de montaria" },
}

-- ---------------------------------------------------------------------
-- CONSULTAS
-- ---------------------------------------------------------------------
local function buscarEm(lista, nome)
  nome = tostring(nome or "")
  for _, e in ipairs(lista) do
    if e.nome == nome then return e end
  end
  return nil
end

function CatalogoBestiario.tamanho(nome)  return buscarEm(CatalogoBestiario.tamanhos, nome) end
function CatalogoBestiario.natureza(nome) return buscarEm(CatalogoBestiario.naturezas, nome) end
function CatalogoBestiario.intelecto(nome) return buscarEm(CatalogoBestiario.intelectos, nome) end
function CatalogoBestiario.dieta(nome)    return buscarEm(CatalogoBestiario.dietas, nome) end
function CatalogoBestiario.tipo(nome)     return buscarEm(CatalogoBestiario.tipos, nome) end
function CatalogoBestiario.raridade(nome) return buscarEm(CatalogoBestiario.raridades, nome) end
function CatalogoBestiario.rank(nome)     return buscarEm(CatalogoBestiario.ranks, nome) end

-- Imunidades e resistencias do TIPO, prontas para a tela: "IMUNE: telepatia,
-- empatia · RESISTENTE: dano físico". Vazio quando o tipo nao traz nenhuma.
-- E a forma que o card da criatura e o editor usam (v0.42.0, C-04): antes a
-- regra ficava so no texto do painel, e o campo de defesa marcava 0 — que
-- na mesa se le como "sem defesa", o oposto de imune.
function CatalogoBestiario.marcasDoTipo(nome)
  local tp = CatalogoBestiario.tipo(nome)
  if tp == nil then return "" end
  local partes = {}
  if tp.imune ~= nil and #tp.imune > 0 then
    partes[#partes+1] = "IMUNE: " .. table.concat(tp.imune, ", ")
  end
  if tp.resistente ~= nil and #tp.resistente > 0 then
    partes[#partes+1] = "RESISTENTE: " .. table.concat(tp.resistente, ", ")
  end
  return table.concat(partes, "  ·  ")
end

-- Lista de nomes, para os seletores da aba.
function CatalogoBestiario.nomes(lista)
  local r = {}
  for _, e in ipairs(lista) do table.insert(r, e.nome) end
  return r
end

-- "40 a 60"  /  "500+"  (quando o livro nao escreve teto)
function CatalogoBestiario.faixa(minimo, maximo)
  if maximo == nil or maximo == 0 then return tostring(minimo) .. "+" end
  return tostring(minimo) .. " a " .. tostring(maximo)
end

-- ---------------------------------------------------------------------
-- O GERADOR
--
-- Devolve (valores, instrucoes):
--   valores    - o que da para preencher sem escolher nada por ninguem
--   instrucoes - o que depende de uma escolha ou e narrativo, em texto,
--                dizendo ONDE lancar cada coisa
--
-- Nada aqui grava na ficha: quem grava e a aba, e so no que o mestre
-- mandar. O livro autoriza a personalizacao ("o narrador podera
-- personalizar da forma como bem entender").
--
-- SEGUNDO PARAMETRO: uma funcao sorteio(min, max) que devolve um inteiro na
-- faixa. Existe para o TESTE poder injetar um sorteio previsivel - com
-- math.random direto nao daria para afirmar nada sobre o resultado, e um
-- gerador aleatorio sem teste e um gerador sem rede. Em producao a ficha nao
-- passa nada e cai no padrao abaixo.
-- ---------------------------------------------------------------------
local function sortearFaixa(minimo, maximo, sorteio)
  minimo = tonumber(minimo) or 0
  maximo = tonumber(maximo) or 0
  -- teto 0 = "o livro nao escreveu teto" (rank EX). Sem teto nao ha faixa
  -- para sortear: fica o minimo, que e o unico numero que o livro deu.
  if maximo <= minimo then return minimo end
  if type(sorteio) == "function" then return sorteio(minimo, maximo) end
  return math.random(minimo, maximo)
end

function CatalogoBestiario.gerar(classificacoes, sorteio)
  local c = classificacoes or {}
  local valores, instrucoes = {}, {}

  local rk = CatalogoBestiario.rank(c.rank)
  local tm = CatalogoBestiario.tamanho(c.tamanho)
  local nt = CatalogoBestiario.natureza(c.natureza)
  local it = CatalogoBestiario.intelecto(c.intelecto)
  local tp = CatalogoBestiario.tipo(c.tipo)
  local rr = CatalogoBestiario.raridade(c.raridade)
  local dt = CatalogoBestiario.dieta(c.dieta)

  if rk ~= nil then
    -- SORTEIO dentro de cada faixa do livro. Clicar de novo re-sorteia.
    valores.vida = sortearFaixa(rk.hpMin, rk.hpMax, sorteio)
    valores.cd = sortearFaixa(rk.cdMin, rk.cdMax, sorteio)
    valores.prof = sortearFaixa(rk.profMin, rk.profMax, sorteio)
    valores.xp = sortearFaixa(rk.xpMin, rk.xpMax, sorteio)
    valores.habilidadesEspeciais = rk.habilidades
    valores.acoesPadraoExtra = rk.acoesPadraoExtra
    valores.acoesBonusExtra = rk.acoesBonusExtra

    -- O numero sorteado vem ANTES da faixa de onde saiu: quem le confere de
    -- relance se o sorteio respeitou o livro, sem abrir o livro.
    table.insert(instrucoes, "Rank " .. rk.nome .. ", sorteado dentro das faixas: vida " ..
      valores.vida .. " (faixa " .. CatalogoBestiario.faixa(rk.hpMin, rk.hpMax) ..
      ")  ·  CD " .. valores.cd .. " (" .. CatalogoBestiario.faixa(rk.cdMin, rk.cdMax) ..
      ")  ·  proficiência " .. valores.prof .. " (" .. CatalogoBestiario.faixa(rk.profMin, rk.profMax) ..
      ")  ·  XP " .. valores.xp .. " (" .. CatalogoBestiario.faixa(rk.xpMin, rk.xpMax) ..
      "). Clique de novo para outro sorteio, ou digite o número que você quiser.")
    table.insert(instrucoes, "Rank " .. rk.nome .. ": atributos " ..
      CatalogoBestiario.faixa(rk.atribMin, rk.atribMax) ..
      ", e " .. rk.habilidades .. " habilidade(s) especial(is)" ..
      (rk.acaoLendaria and " mais uma AÇÃO LENDÁRIA." or "."))
    if rk.acoesPadraoExtra > 0 or rk.acoesBonusExtra > 0 then
      table.insert(instrucoes, "Rank " .. rk.nome .. ": +" ..
        rk.acoesPadraoExtra .. " ação padrão e +" .. rk.acoesBonusExtra ..
        " ação bônus além do padrão de 1 e 1.")
    end
  end

  if tm ~= nil then
    valores.vida = (valores.vida or 0) + tm.vida
    valores.cd = (valores.cd or 0) + tm.cd
    if tm.vida > 0 then
      table.insert(instrucoes, "Tamanho " .. tm.nome .. " (" .. tm.altura ..
        "): +" .. tm.vida .. " de vida-base, já somado.")
    end
    if tm.cd > 0 then
      table.insert(instrucoes, "Tamanho " .. tm.nome .. " (" .. tm.altura ..
        "): +" .. tm.cd .. " de CD, já somado.")
    end
    if tm.instrucao ~= "" then
      table.insert(instrucoes, "Tamanho " .. tm.nome .. ": " .. tm.instrucao ..
        " — lance no atributo, a ficha não escolhe por você.")
    end
  end

  if nt ~= nil then
    if nt.carisma > 0 then
      valores.carisma = (valores.carisma or 0) + nt.carisma
      table.insert(instrucoes, "Natureza " .. nt.nome .. ": +" .. nt.carisma ..
        " de CARISMA, já somado.")
    end
    if nt.instrucao ~= "" then
      table.insert(instrucoes, "Natureza " .. nt.nome .. ": " .. nt.instrucao ..
        " — vale no teste, não no atributo.")
    end
  end

  if it ~= nil then
    if it.sabedoria > 0 then
      valores.sabedoria = (valores.sabedoria or 0) + it.sabedoria
      table.insert(instrucoes, "Intelecto " .. it.nome .. ": +" .. it.sabedoria ..
        " de SABEDORIA, já somado.")
    end
    if it.instrucao ~= "" then
      table.insert(instrucoes, "Intelecto " .. it.nome .. ": " .. it.instrucao ..
        " — lance no atributo.")
    end
  end

  if tp ~= nil and tp.regra ~= "" then
    table.insert(instrucoes, "Tipo " .. tp.nome .. ": " .. tp.regra)
  end
  if rr ~= nil then
    -- Ate a v0.35.0 isto preenchia um campo ESPOLIOS proprio no editor. O
    -- campo foi removido a pedido da mesa (22/08/2026) para dar espaco ao de
    -- habilidades, e o espolio virou o que sempre foi de fato: uma SUGESTAO
    -- do livro sobre quantos e de que raridade - "3 espólios: um Raro, os
    -- outros Comuns ou Incomuns" nao e um valor, e um enunciado. Fica na
    -- lista de instrucoes, junto das outras escolhas que o gerador nao pode
    -- fazer sozinho, e o mestre escreve no campo de habilidades se quiser.
    table.insert(instrucoes, "Raridade " .. rr.nome .. " (" .. rr.frequencia ..
      "): " .. rr.espolios .. " — anote no campo de habilidades se quiser guardar.")
  end
  if dt ~= nil then
    table.insert(instrucoes, "Dieta " .. dt.nome .. ": " .. dt.descricao .. ".")
  end

  return valores, instrucoes
end

return CatalogoBestiario

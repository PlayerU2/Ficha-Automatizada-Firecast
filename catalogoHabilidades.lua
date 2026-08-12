-- catalogoHabilidades.lua
-- Tabela de balanceamento por rank, extraida da secao "Habilidades"
-- do .bib. Habilidades gastam AURA; feiticos gastam MANA e tem
-- valores proprios (varios deles ainda diferentes para "Bruxas").
--
-- O custo em pontos e o mesmo nos dois: E=1, D=2, C=3, B=5, A=6, EX=7.

local CatalogoHabilidades = {}

CatalogoHabilidades.ranks = { "E", "D", "C", "B", "A", "EX" }

-- indice numerico do rank (E=1 ... EX=6), para comparar tetos
CatalogoHabilidades.ordemRank = { E = 1, D = 2, C = 3, B = 4, A = 5, EX = 6 }

CatalogoHabilidades.habilidades = {
  ["E"] = {
    custo = 1,
    tagsMax = 2, tagsMaxBruxa = 2,
    energiaMin = 4, energiaMax = 6,
    dadoBase = "1d6", dadoBaseBruxa = "1d6",
    modificador = 2, modificadorBruxa = 2,
    alcanceMax = 04,
    duracao = "instantâneo",
    efeitoAdicional = "efeito básico.",
  },
  ["D"] = {
    custo = 2,
    tagsMax = 3, tagsMaxBruxa = 3,
    energiaMin = 5, energiaMax = 7,
    dadoBase = "2d6", dadoBaseBruxa = "2d6",
    modificador = 3, modificadorBruxa = 3,
    alcanceMax = 06,
    duracao = "até 2 turnos",
    efeitoAdicional = "pequeno aumento no efeito.",
  },
  ["C"] = {
    custo = 3,
    tagsMax = 3, tagsMaxBruxa = 3,
    energiaMin = 7, energiaMax = 9,
    dadoBase = "3d6", dadoBaseBruxa = "3d6",
    modificador = 4, modificadorBruxa = 4,
    alcanceMax = 08,
    duracao = "até 2 turnos",
    efeitoAdicional = "efeito aprimorado ou bônus menor.",
  },
  ["B"] = {
    custo = 5,
    tagsMax = 4, tagsMaxBruxa = 4,
    energiaMin = 10, energiaMax = 12,
    dadoBase = "3d8", dadoBaseBruxa = "3d8",
    modificador = 6, modificadorBruxa = 6,
    alcanceMax = 10,
    duracao = "até 3 turnos",
    efeitoAdicional = "efeito secundário",
  },
  ["A"] = {
    custo = 6,
    tagsMax = 4, tagsMaxBruxa = 4,
    energiaMin = 15, energiaMax = 17,
    dadoBase = "4d8", dadoBaseBruxa = "4d8",
    modificador = 7, modificadorBruxa = 7,
    alcanceMax = 14,
    duracao = "até 3 turnos",
    efeitoAdicional = "efeito maior e bônus por acerto crítico",
  },
  ["EX"] = {
    custo = 7,
    tagsMax = 5, tagsMaxBruxa = 5,
    energiaMin = 21, energiaMax = 25,
    dadoBase = "4d10", dadoBaseBruxa = "4d10",
    modificador = 8, modificadorBruxa = 8,
    alcanceMax = 20,
    duracao = "até 4 turnos",
    efeitoAdicional = "efeito especial único",
  },
}

CatalogoHabilidades.feiticos = {
  ["E"] = {
    custo = 1,
    tagsMax = 2, tagsMaxBruxa = 2,
    energiaMin = 5, energiaMax = 7,
    dadoBase = "1d4", dadoBaseBruxa = "1d6",
    modificador = 1, modificadorBruxa = 2,
    alcanceMax = 04,
    duracao = "instantâneo (1 turno).",
    efeitoAdicional = "efeito básico.",
  },
  ["D"] = {
    custo = 2,
    tagsMax = 2, tagsMaxBruxa = 2,
    energiaMin = 6, energiaMax = 8,
    dadoBase = "2d4", dadoBaseBruxa = "2d6",
    modificador = 2, modificadorBruxa = 3,
    alcanceMax = 06,
    duracao = "instantâneo (1 turno).",
    efeitoAdicional = "pequeno aumento no efeito.",
  },
  ["C"] = {
    custo = 3,
    tagsMax = 2, tagsMaxBruxa = 3,
    energiaMin = 8, energiaMax = 10,
    dadoBase = "3d4", dadoBaseBruxa = "3d6",
    modificador = 3, modificadorBruxa = 4,
    alcanceMax = 08,
    duracao = "até 2 turnos",
    efeitoAdicional = "efeito aprimorado ou bônus menor.",
  },
  ["B"] = {
    custo = 5,
    tagsMax = 3, tagsMaxBruxa = 3,
    energiaMin = 11, energiaMax = 13,
    dadoBase = "3d6", dadoBaseBruxa = "3d8",
    modificador = 4, modificadorBruxa = 5,
    alcanceMax = 10,
    duracao = "até 2 turnos",
    efeitoAdicional = "efeito secundário",
  },
  ["A"] = {
    custo = 6,
    tagsMax = 3, tagsMaxBruxa = 4,
    energiaMin = 16, energiaMax = 18,
    dadoBase = "4d6", dadoBaseBruxa = "4d8",
    modificador = 5, modificadorBruxa = 6,
    alcanceMax = 14,
    duracao = "até 3 turnos",
    efeitoAdicional = "efeito maior e bônus por acerto crítico",
  },
  ["EX"] = {
    custo = 7,
    tagsMax = 4, tagsMaxBruxa = 4,
    energiaMin = 22, energiaMax = 26,
    dadoBase = "4d8", dadoBaseBruxa = "4d10",
    modificador = 6, modificadorBruxa = 7,
    alcanceMax = 20,
    duracao = "até 3 turnos",
    efeitoAdicional = "efeito especial único",
  },
}

-- Tags oficiais, por categoria.
CatalogoHabilidades.tagsComuns = {
  "Ofensivo", "Defensivo", "Área", "Terreno", "Invocação", "Controle",
  "Cura", "Movimentação", "Fortalecimento", "Enfraquecimento",
}

CatalogoHabilidades.tagsClasses = {
  "Arcanista", "Artífice", "Artista", "Atirador", "Boticário", "Devoto",
  "Domador", "Duelista", "Espadachim", "Guerreiro", "Ladino", "Senescal",
}

CatalogoHabilidades.tagsElementais = {
  "Neutro", "Fogo", "Terra", "Eletricidade", "Planta", "Vento", "Gelo",
  "Água", "Maldição", "Noite", "Veneno", "Mental", "Sentimento", "Metal",
  "Dia", "Sagrado", "Sangue",
}

CatalogoHabilidades.tagsRaciais = {
  "Aarakocra", "Anão", "Banshee", "Dragão", "Centauro", "Criofênix", "Drow",
  "Elfo", "Fada", "Fênix", "Giff", "Gigante", "Goblin", "Gnomo", "Harpia",
  "Humano", "Kraken", "Licantropo", "Lizariano", "Minotauro", "Ninfa", "Orc",
  "Sátiro", "Sereias", "Selkies", "Tritões", "Unicórnio", "Ursari", "Vampiro",
}

-- Pares de tags OPOSTAS. Regra do livro: uma habilidade nao pode ter duas
-- tags de estilos opostos - EXCETO no rank EX, que e a unica excecao.
-- Alem destes pares, duas tags de CLASSES diferentes tambem sao opostas
-- (tratado em codigo, nao aqui).
CatalogoHabilidades.tagsOpostas = {
  {"Ofensivo", "Defensivo"},
  {"Fogo", "Água"},
  {"Fogo", "Gelo"},
  {"Planta", "Fogo"},
  {"Cura", "Enfraquecimento"},
  {"Fortalecimento", "Enfraquecimento"},
  {"Dia", "Noite"},
  {"Sagrado", "Maldição"},
  {"Sagrado", "Sangue"},
  {"Eletricidade", "Terra"},
}

function CatalogoHabilidades.tabela(ehFeitico)
  if ehFeitico then return CatalogoHabilidades.feiticos end
  return CatalogoHabilidades.habilidades
end

function CatalogoHabilidades.dadosDoRank(rank, ehFeitico)
  return CatalogoHabilidades.tabela(ehFeitico)[tostring(rank or "E")]
end

function CatalogoHabilidades.custoDoRank(rank, ehFeitico)
  local d = CatalogoHabilidades.dadosDoRank(rank, ehFeitico)
  if d == nil then return 0 end
  return d.custo
end

-- Lista de todas as tags, com a categoria de cada uma.
function CatalogoHabilidades.todasAsTags()
  local r = {}
  for _, t in ipairs(CatalogoHabilidades.tagsComuns) do
    table.insert(r, {nome = t, categoria = "Comum"})
  end
  for _, t in ipairs(CatalogoHabilidades.tagsElementais) do
    table.insert(r, {nome = t, categoria = "Elemental"})
  end
  for _, t in ipairs(CatalogoHabilidades.tagsClasses) do
    table.insert(r, {nome = t, categoria = "Classe"})
  end
  for _, t in ipairs(CatalogoHabilidades.tagsRaciais) do
    table.insert(r, {nome = t, categoria = "Racial"})
  end
  return r
end

function CatalogoHabilidades.categoriaDaTag(nome)
  for _, t in ipairs(CatalogoHabilidades.todasAsTags()) do
    if t.nome == nome then return t.categoria end
  end
  return nil
end

-- Devolve o par oposto encontrado, ou nil. No rank EX nunca ha conflito.
function CatalogoHabilidades.conflitoDeTags(lista, rank)
  if rank == "EX" then return nil end
  for _, par in ipairs(CatalogoHabilidades.tagsOpostas) do
    local a, b = false, false
    for _, t in ipairs(lista) do
      if t == par[1] then a = true end
      if t == par[2] then b = true end
    end
    if a and b then return par[1], par[2] end
  end
  -- duas classes diferentes tambem sao opostas
  local classe = nil
  for _, t in ipairs(lista) do
    if CatalogoHabilidades.categoriaDaTag(t) == "Classe" then
      if classe ~= nil and classe ~= t then return classe, t end
      classe = t
    end
  end
  return nil
end

return CatalogoHabilidades

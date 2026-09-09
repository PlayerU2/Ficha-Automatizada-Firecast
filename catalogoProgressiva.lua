-- ---------------------------------------------------------------------
-- HABILIDADES RACIAIS PROGRESSIVAS  e  FASES DA LUA
--
-- Duas coisas moram aqui porque as duas nasceram do mesmo pedido da mesa
-- (30/08/2026) e da mesma habilidade de exemplo, a "Forma bestial lupina
-- da lua" do lobisomem da mesa.
--
-- ---------------------------------------------------------------------
-- POR QUE UM EXTRATOR, E NAO TRINTA E SEIS CAMPOS
--
-- Uma habilidade progressiva tem SEIS blocos de efeito, um por rank:
--
--   Efeito - Rank C: +40 pontos de vida: +15% de Absorção; +2 em todas as
--   Defesas; +2 dado de dano; Recebe a habilidade [Uivo Lupino]
--
-- Pedir ao jogador que digite cinco numeros por rank em campos separados
-- seriam 30 caixas na tela, e ele teria de traduzir a mao um texto que ja
-- existe pronto. Em vez disso ele COLA a linha, e este arquivo le os
-- numeros dela.
--
-- A DISCIPLINA DO EXTRATOR (a mesma de extrair-regras.md): junto do
-- extrator vem o relatorio do que ele NAO reconheceu. Aqui isso aparece na
-- propria ficha - "a ficha entendeu: +40 vida, +15% absorcao, +2 defesas",
-- e o resto continua na tela como texto. Extrator que engole em silencio e
-- pior que nenhum: some com o efeito e ninguem percebe.
--
-- REGRA DA MESA: os efeitos de rank SUBSTITUEM, nao acumulam. No rank C
-- valem +40 de vida, e nao +20+30+40. Por isso nada aqui soma blocos.
-- ---------------------------------------------------------------------

CatalogoProgressiva = {}

CatalogoProgressiva.RANKS = {"E", "D", "C", "B", "A", "EX"}

-- Nivel em que cada rank comeca (dadosSistema): E=1 D=4 C=8 B=12 A=16 EX=19.
-- So para a ficha poder dizer "progride no nivel 12".
CatalogoProgressiva.NIVEL_DO_RANK = {
    E = 1, D = 4, C = 8, B = 12, A = 16, EX = 19,
}

-- ---------------------------------------------------------------------
-- O VOCABULARIO
--
-- Cada padrao foi tirado da habilidade real, e nao inventado. Se a mesa
-- escrever de outro jeito, o numero simplesmente nao e reconhecido e fica
-- como texto - que e o comportamento seguro. NUNCA chute.
--
-- Os padroes aceitam singular e plural ("dado"/"dados", "ponto"/"pontos")
-- porque a habilidade de exemplo mistura os dois na mesma habilidade:
-- "+1 dado de dano" no rank D e "+3 dados de dano" no rank B.
-- ---------------------------------------------------------------------
local PADROES = {
    {chave = "vida",      rotulo = "vida",      sufixo = "",
     pats = {"%+%s*(%d+)%s*pontos?%s+de%s+vida"}},
    {chave = "absorcao",  rotulo = "absorção",  sufixo = "%",
     pats = {"%+%s*(%d+)%s*%%%s*de%s+[Aa]bsor"}},
    {chave = "defesas",   rotulo = "defesas",   sufixo = "",
     pats = {"%+%s*(%d+)%s*em%s+todas%s+as%s+[Dd]efesas"}},
    {chave = "dadosDano", rotulo = "dados de dano", sufixo = "",
     pats = {"%+%s*(%d+)%s*dados?%s+de%s+dano"}},
    {chave = "regen",     rotulo = "regeneração", sufixo = "/turno",
     pats = {"regenera%s*(%d+)%s*de%s+vida%s+por%s+turno"}},
}

-- O TAMANHO FICA DE FORA DO EXTRATOR, DE PROPOSITO (decisao da mesa,
-- 09/09/2026). "Aumenta em 1 categoria de tamanho" aparece so no rank E da
-- furia, e a mesa confirmou que o aumento PERSISTE nos ranks seguintes - o
-- que a regra "os blocos SUBSTITUEM, nao acumulam" nao saberia expressar,
-- porque os blocos de D em diante nao repetem a frase.
--
-- E a mesa decidiu nao automatizar: "deixa para os players mexerem
-- manualmente no tamanho como ja estamos fazendo ate entao".
--
-- Entao o padrao SAIU do vocabulario, e nao ficou aqui sem consumidor. Um
-- padrao que reconhece e nao alimenta nada e pior que padrao nenhum: o
-- resumo diria "a ficha entendeu: +1 categoria de tamanho" para um efeito
-- que ela nao aplica, e o jogador confiaria. A frase continua valendo como
-- TEXTO, junto de [Garras Lupinas] e da resistencia a [Hemocinese], que
-- tambem sao mecanicos e tambem nao viram numero.

-- Devolve (numeros, reconhecidos) para UM bloco de rank.
--   numeros      = {vida=40, absorcao=15, defesas=2, dadosDano=2, regen=0}
--   reconhecidos = {"+40 vida", "+15% absorção", ...}  na ordem do vocabulario
function CatalogoProgressiva.lerBloco(texto)
    local t = tostring(texto or "")
    local numeros = {vida = 0, absorcao = 0, defesas = 0, dadosDano = 0, regen = 0}
    local reconhecidos = {}
    for _, p in ipairs(PADROES) do
        for _, pat in ipairs(p.pats) do
            local v = t:match(pat)
            if v ~= nil then
                numeros[p.chave] = tonumber(v) or 0
                table.insert(reconhecidos,
                    "+" .. numeros[p.chave] .. p.sufixo .. " " .. p.rotulo)
                break
            end
        end
    end
    return numeros, reconhecidos
end

-- Frase curta para a ficha mostrar embaixo do bloco. Sem isto o extrator
-- viraria caixa-preta.
function CatalogoProgressiva.resumoDoBloco(texto)
    local _, reconhecidos = CatalogoProgressiva.lerBloco(texto)
    if #reconhecidos == 0 then
        if tostring(texto or ""):gsub("%s", "") == "" then return "" end
        return "A ficha não reconheceu nenhum número aqui — vale como texto."
    end
    return "A ficha entendeu: " .. table.concat(reconhecidos, ", ") ..
           ". O resto do texto vale como está escrito."
end

-- ---------------------------------------------------------------------
-- AS DUAS HABILIDADES DE TRIBO  (v0.51.0)
--
-- O livro diz, nas caracteristicas raciais dos Lobisomens:
--   "[Forma bestial] receba a habilidade progressiva 'Forma Bestial', que
--    permite a um lobisomem se transformar da sua forma mortal para sua
--    forma bestial."
--
-- No singular. A MESA REFINOU (09/09/2026): a habilidade depende da TRIBO
-- que o lobisomem escolhe na criacao, e sao duas. Isso nao contradiz o
-- livro - ele proprio ja separa as duas faccoes nos tracos raciais, com
-- "[Odio Enraizado - Filhos da Furia]" e "[Lua Cheia - Vigilantes da Lua]"
-- cobrando coisas diferentes de cada uma.
--
-- POR QUE O TEXTO ESTA AQUI INTEIRO, E VERBATIM. O extrator continua sendo
-- quem le os numeros: instalar a habilidade escreve ESTE texto nos seis
-- blocos, e a ficha o le do mesmo jeito que leria o texto colado a mao. A
-- fonte da verdade continua sendo a frase da mesa, e nao um numero digitado
-- por mim num campo. Se eu cravasse os numeros aqui, existiriam duas
-- versoes da mesma regra - a frase e a tabela - e elas divergiriam calado.
--
-- fasesLua = true diz que ESTA habilidade recebe os bonus lunares. Ate a
-- v0.50.2 quem decidia isso era `personagemEhLobisomem()`, entao um Filho
-- da Furia transformado recebia, sem erro nenhum, os bonus de lua que
-- pertencem so aos Vigilantes.
-- ---------------------------------------------------------------------
CatalogoProgressiva.TRIBOS = {"Vigilantes da Lua", "Filhos da Fúria"}

CatalogoProgressiva.HABILIDADES = {
    ["Filhos da Fúria"] = {
        nome = "Forma bestial lupina da fúria",
        tags = "[Lobisomem], [Progressiva]",
        energia = "8 de Aura | Ação padrão",
        fasesLua = false,
        curaPrimeiraTransf = 100,
        descricao = [==[o lobisomem se transforma em um enorme lobisomem quadrúpede, como um lobo gigante
[Passiva] seus ataques causam 50% mais de dano contra [Vampiros] e [Aberrações]
[Primeira transformação] recupera 100% de vida máxima na primeira transformação a cada descanso longo
Restrição¹: quando um lobisomem se transforma, seu corpo se expande e muda de forma quebrando todos os equipamentos que carrega e soltando armas.
Restrição²: ao se transformar realize um teste de Vontade (Sabedoria) com meta 20, caso falhe no teste receba a condição de estado [Enfurecido]]==],
        blocos = {
            E  = [==[+40 pontos de vida; +10% de Absorção; Aumenta em 1 categoria de tamanho; Recebe a habilidade [Garras Lupinas]]==],
            D  = [==[+60 pontos de vida; +20% de Absorção; +2 em todas as Defesas; +2 dados de dano; Recebe a habilidade [Mordida Lupina]]==],
            C  = [==[+80 pontos de vida: +30% de Absorção; +3 em todas as Defesas; +3 dado de dano; Recebe a habilidade [Uivo Lupino]]==],
            B  = [==[+100 pontos de vida; +40% de Absorção; +4 em todas as Defesas; +4 dados de dano; regenera 10 de vida por turno; Recebe a habilidade [Licantropia]]==],
            A  = [==[+120 pontos de vida; +50% de Absorção; +5 em todas as Defesas; +5 dados de dano; regenera 20 de vida por turno; recebe resistência contra [Hemocinese]]==],
            EX = [==[+150 pontos de vida; +70% de Absorção; +7 em todas as Defesas; +7 dados de dano; regenera 30 de vida por turno; recebe imunidade contra [Hemocinese]]==],
        },
        -- O que a ficha NAO calcula, e por que. Vira aviso ao transformar,
        -- e nao numero: automatizar qualquer um destes seria a ficha
        -- decidindo pela mesa.
        avisos = {
            "Aumenta 1 categoria de TAMANHO e ela continua valendo nos ranks seguintes — ajuste à mão no card de Tamanho, a ficha não mexe nele.",
            "Quebra TODOS os equipamentos que carrega e solta as armas — desequipe você mesmo, a ficha não mexe no seu inventário.",
            "Role Vontade (Sabedoria) com meta 20. Se falhar, aplique a condição [Enfurecido].",
        },
    },

    ["Vigilantes da Lua"] = {
        nome = "Forma bestial lupina da lua",
        tags = "[Lobisomem], [Progressiva]",
        energia = "8 de Aura | Ação padrão",
        fasesLua = true,
        curaPrimeiraTransf = 50,
        descricao = [==[o usuário se transforma em um enorme lobisomem, que melhora suas capacidades de forma geral enquanto estiver transformado.
[Passiva] seus ataques causam 50% mais de dano contra [Vampiros] e [Aberrações]
[Primeira transformação] recupera 50% de vida máximo; recebe o bônus especial dependendo da fase da lua maior na primeira transformação a cada descanso longo.
Restrição: apenas é possível realizar esta transformação a noite.]==],
        blocos = {
            E  = [==[+20 pontos de vida; +5% de Absorção; Recebe a habilidade [Garras Lupinas]]==],
            D  = [==[+30 pontos de vida; +10% de Absorção; +1 em todas as Defesas; +1 dado de dano; Recebe a habilidade [Mordida Lupina]]==],
            C  = [==[+40 pontos de vida: +15% de Absorção; +2 em todas as Defesas; +2 dado de dano; Recebe a habilidade [Uivo Lupino]]==],
            B  = [==[+50 pontos de vida; +20% de Absorção; +3 em todas as Defesas; +3 dados de dano; regenera 5 de vida por turno; Recebe a habilidade [Licantropia]]==],
            A  = [==[+70 pontos de vida; +30% de Absorção; +4 em todas as Defesas; +4 dados de dano; regenera 10 de vida por turno; recebe resistência contra [Hemocinese]]==],
            EX = [==[+100 pontos de vida; +50% de Absorção; +5 em todas as Defesas; +5 dados de dano; regenera 15 de vida por turno; recebe imunidade contra [Hemocinese]]==],
        },
        avisos = {
            "Só é possível se transformar à NOITE. A ficha não sabe a hora da mesa.",
        },
    },
}

function CatalogoProgressiva.habilidadeDaTribo(tribo)
    return CatalogoProgressiva.HABILIDADES[tostring(tribo or "")]
end

-- Devolve a tribo dona de um nome de habilidade, ou nil. Serve para a ficha
-- reconhecer uma habilidade que o jogador colou a mao antes de as tribos
-- existirem, sem precisar de campo novo no registro (que teria de entrar em
-- CAMPOS_HABILIDADE e na checagem 29).
function CatalogoProgressiva.triboDaHabilidade(nome)
    local alvo = tostring(nome or "")
    for tribo, h in pairs(CatalogoProgressiva.HABILIDADES) do
        if h.nome == alvo then return tribo end
    end
    return nil
end

-- ---------------------------------------------------------------------
-- FASES DA LUA
--
-- Do texto da habilidade do lobisomem da mesa, verbatim em cada bloco.
-- So os efeitos NUMERICOS viram campo; o resto e narrativo e fica no texto
-- - a ficha nao sabe o que e "vantagem em testes relacionados a [Olfato]"
-- nem "imune a testes de resistencia a dor".
--
-- ECLIPSE CARMESIM: "Recebe todos os bônus das outras fases lunares." Por
-- isso ele carrega a soma dos numericos das outras quatro, e nao um valor
-- proprio inventado.
-- ---------------------------------------------------------------------
CatalogoProgressiva.FASES_LUA = {
    {nome = "Nova",
     deslocamento = 2, iniciativa = 0, tetoAbsorcao = 0,
     texto = "+2 metros de deslocamento e vantagem em testes relacionados a [Olfato]."},
    {nome = "Crescente",
     deslocamento = 0, iniciativa = 2, tetoAbsorcao = 0,
     texto = "+2 de iniciativa e imunidade a testes de resistência a dor."},
    {nome = "Cheia",
     deslocamento = 0, iniciativa = 0, tetoAbsorcao = 80,
     texto = "Recupera 100% da vida máxima na transformação, e o limite sistêmico de absorção passa a ser 80%."},
    {nome = "Minguante",
     deslocamento = 0, iniciativa = 0, tetoAbsorcao = 0,
     texto = "Ao eliminar um inimigo ou causar dano crítico, recupere 30 pontos de vida."},
    {nome = "Eclipse Carmesim",
     deslocamento = 2, iniciativa = 2, tetoAbsorcao = 80,
     texto = "A cada dano aplicado o oponente recebe 1d[rank] níveis de [Sangramento]. A regeneração continua sob qualquer ferimento ou amputação, desde que cabeça e coração fiquem intactos. Recebe todos os bônus das outras fases."},
}

function CatalogoProgressiva.faseLua(nome)
    for _, f in ipairs(CatalogoProgressiva.FASES_LUA) do
        if f.nome == nome then return f end
    end
    return nil
end

function CatalogoProgressiva.indiceDaFase(nome)
    for i, f in ipairs(CatalogoProgressiva.FASES_LUA) do
        if f.nome == nome then return i end
    end
    return 1
end

return CatalogoProgressiva

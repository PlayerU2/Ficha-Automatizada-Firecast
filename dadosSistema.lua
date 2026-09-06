-- =====================================================================
-- MOTOR DE NIVEL/RANK/PROFICIENCIA - Ficha Petrichor
-- Fonte: [2.3] Sistema e Evolucao, aba Evolucao (compilacao .bib)
-- Cobre niveis 1 a 20. Todo campo derivado desta tabela precisa de um
-- campo de compensacao manual na ficha (ex: "ajuste manual"), conforme
-- principio de design: automacao com valvula de escape.
-- =====================================================================

local DadosSistema = {}

-- Tabela mestre por nivel. Campos omitidos herdam o ultimo valor definido
-- (ex.: rank so muda em 1,4,8,12,16,19; limiteAtributo em 1,5,9,13,17;
-- poderPassivoMax em 1,5,9,13,17).
DadosSistema.niveis = {
    [1]  = { xp = 0,      prof = 2, rank = "E",  limiteAtributo = 4, poderPassivoMax = 2 },
    [2]  = { xp = 100,    prof = 2 },
    [3]  = { xp = 200,    prof = 2 },
    [4]  = { xp = 400,    prof = 2, rank = "D" },
    [5]  = { xp = 800,    prof = 3, limiteAtributo = 5, poderPassivoMax = 3 },
    [6]  = { xp = 1440,   prof = 3 },
    [7]  = { xp = 2600,   prof = 3 },
    [8]  = { xp = 4680,   prof = 3, rank = "C" },
    [9]  = { xp = 8400,   prof = 4, limiteAtributo = 6, poderPassivoMax = 4 },
    [10] = { xp = 15130,  prof = 4 },
    [11] = { xp = 24200,  prof = 4 },
    [12] = { xp = 38720,  prof = 4, rank = "B" },
    [13] = { xp = 62000,  prof = 5, limiteAtributo = 7, poderPassivoMax = 5 },
    [14] = { xp = 99200,  prof = 5 },
    [15] = { xp = 158720, prof = 5 },
    [16] = { xp = 221500, prof = 5, rank = "A" },
    [17] = { xp = 310100, prof = 6, limiteAtributo = 8, poderPassivoMax = 5 },
    [18] = { xp = 434140, prof = 6 },
    [19] = { xp = 607800, prof = 6, rank = "EX" },
    [20] = { xp = 850920, prof = 7 },
}

-- ---------------------------------------------------------------------
-- LIMITE DE ACOES POR TURNO
--
-- Texto integral, "[2.3] Sistema e Evolucao", secao "Limite de acoes":
--
--   "O limite de acoes serve para impedir que um personagem possa acumular
--    acoes principais/bonus atraves de itens, poderes e afins para
--    desbalancear o sistema. Ate o nivel 5 so e permitida uma acao
--    principal/bonus; A partir do nivel 6 os personagens ganham direito a
--    realizarem uma segunda acao; A partir do nivel 11 e possivel executar
--    tres acoes; No nivel 20 um personagem ganha o direito de utilizar
--    quatro acoes em um mesmo turno. Esta regra serve como uma limitacao
--    caso um personagem adquira acoes de combate por diversos meios ainda
--    assim precise respeitar tal limite."
--
-- DECISOES DA MESA (21/08/2026), porque o texto tem duas ambiguidades:
--
-- 1. O teto conta o TOTAL de acoes padrao + bonus SOMADAS, e nao cada tipo
--    separado nem apenas as extras. Leitura literal do texto.
--    CONSEQUENCIA CONHECIDA E ACEITA: o Tutorial de Ficha diz que todo
--    personagem comeca com 1 acao padrao E 1 acao bonus, o que ja da 2 - ou
--    seja, do nivel 1 ao 5 a base do personagem ja fica acima do teto. A
--    ficha nao esconde isso: mostra o valor cheio e avisa. Se o mestre
--    decidir que o Tutorial prevalece, muda-se so esta tabela.
--
-- 2. Os niveis sao 6 / 11 / 20, COMO ESTA ESCRITO. A versao anterior deste
--    arquivo usava 10 em vez de 6, anotado como "a mesa usa na pratica";
--    isso foi revertido para o texto do livro.
--
-- A ficha NAO corta o valor: ela soma tudo e avisa quando passa (decisao da
-- mesa). Ver a nota do bloco de Acoes na aba de Combate.
-- ---------------------------------------------------------------------
function DadosSistema.limiteAcoesPorNivel(nivel)
    nivel = tonumber(nivel) or 1
    if nivel >= 20 then return 4
    elseif nivel >= 11 then return 3
    elseif nivel >= 6 then return 2
    else return 1 end
end

-- XP necessaria para alcancar o proximo nivel. Devolve nil no nivel 20.
function DadosSistema.xpDoProximoNivel(nivel)
    nivel = math.floor(tonumber(nivel) or 1)
    if nivel >= 20 then return nil end
    local proximo = DadosSistema.niveis[nivel + 1]
    if proximo == nil then return nil end
    return proximo.xp
end

-- Retorna a tabela consolidada (com herança dos campos rank/limiteAtributo/
-- poderPassivoMax) para um nivel especifico, entre 1 e 20.
function DadosSistema.dadosDoNivel(nivel)
    nivel = math.max(1, math.min(20, math.floor(tonumber(nivel) or 1)))
    local resultado = { rank = "E", limiteAtributo = 4, poderPassivoMax = 2, xp = 0, prof = 2 }
    for n = 1, nivel do
        local dados = DadosSistema.niveis[n]
        if dados then
            for chave, valor in pairs(dados) do
                resultado[chave] = valor
            end
        end
    end
    resultado.limiteAcoes = DadosSistema.limiteAcoesPorNivel(nivel)
    return resultado
end

function DadosSistema.rankPorNivel(nivel)
    return DadosSistema.dadosDoNivel(nivel).rank
end

function DadosSistema.bonusProficienciaPorNivel(nivel)
    return DadosSistema.dadosDoNivel(nivel).prof
end

function DadosSistema.limiteAtributoPorNivel(nivel)
    return DadosSistema.dadosDoNivel(nivel).limiteAtributo
end

-- Dado um total de XP acumulado, retorna o maior nivel cujo requisito foi
-- atingido (nao faz o personagem "pular" niveis automaticamente na ficha,
-- apenas informa qual seria o nivel correto para conferencia).
function DadosSistema.nivelPorXP(xpAtual)
    xpAtual = tonumber(xpAtual) or 0
    local nivelEncontrado = 1
    for n = 1, 20 do
        local dados = DadosSistema.niveis[n]
        if dados and xpAtual >= dados.xp then
            nivelEncontrado = n
        end
    end
    return nivelEncontrado
end

-- Rank numerico auxiliar, util para ordenacao/comparacoes (E < D < C < B < A < EX)
DadosSistema.ordemRank = { E = 1, D = 2, C = 3, B = 4, A = 5, EX = 6 }

return DadosSistema

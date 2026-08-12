-- =====================================================================
-- MOTOR DE CALCULOS DERIVADOS - Ficha Petrichor
-- Fonte: [2.3] Sistema e Evolucao (compilacao .bib) + Tutorial de Ficha
--
-- Todas as funcoes sao PURAS (recebem uma tabela de entrada, devolvem um
-- numero) para poderem ser chamadas tanto pelo script da ficha quanto
-- testadas isoladamente fora do Firecast. A ficha (ficha.lfm) e responsavel
-- por ler os campos do "sheet", montar o "ctx" e escrever o resultado de
-- volta no campo calculado.
--
-- PREMISSA A VALIDAR COM A MESA: nas formulas do documento fonte que somam
-- "+ Rank" (Deslocamento, Iniciativa, AP, Mochila), assumimos que "Rank"
-- entra como valor numerico E=1, D=2, C=3, B=4, A=5, EX=6 (DadosSistema.
-- ordemRank). Se a intencao da mesa for outra, e so trocar o mapeamento em
-- DadosSistema.ordemRank que todos os calculos acompanham.
-- =====================================================================

local DadosSistema = require("dadosSistema.lua")
local Calculos = {}

local function n(v) return tonumber(v) or 0 end
local function rankNumero(rankLetra) return DadosSistema.ordemRank[rankLetra] or 1 end

-- ---------------------------------------------------------------------
-- Pontos de vida (Hp) = 15 + Dado de vida + (Constituicao/2 * Nivel)
-- "Dado de vida" = maximo do dado de vida da raca (campo manual ate os
-- catalogos de raca serem embutidos na ficha).
-- "progressaoVidaExtra" = soma das rolagens/metades acumuladas a cada level up.
-- ---------------------------------------------------------------------
function Calculos.hp(ctx)
    local base = 15 + n(ctx.dadoVida) + math.floor((n(ctx.constituicao) / 2) * n(ctx.nivel))
    return base + n(ctx.progressaoVidaExtra) + n(ctx.ajusteManual)
end

-- ---------------------------------------------------------------------
-- Pontos de mana (Mp) - somente para quem tem 'Coracao de mana'.
-- Mp = 15 + (soma acumulada por aniversario, faixa etaria) + (Nivel * 2)
-- Faixas: 1-50 anos = 2.0/ano | 51-99 = 1.5/ano | 100-300 = 0.5/ano | 301+ = 0.25/ano
-- ---------------------------------------------------------------------
function Calculos.baseManaPorIdade(idade)
    idade = math.max(0, math.floor(n(idade)))
    local total = 0.0
    for ano = 1, idade do
        if ano <= 50 then
            total = total + 2.0
        elseif ano <= 99 then
            total = total + 1.5
        elseif ano <= 300 then
            total = total + 0.5
        else
            total = total + 0.25
        end
    end
    return total
end

function Calculos.mp(ctx)
    if not ctx.temCoracaoDeMana then return 0 end
    local baseIdade = Calculos.baseManaPorIdade(ctx.idade)
    local total = 15 + baseIdade + (n(ctx.nivel) * 2)
    return math.floor(total + 0.5) + n(ctx.ajusteManual)
end

-- ---------------------------------------------------------------------
-- Pontos de aura (Ap) = [(20 + Sabedoria + Nivel) * Rank] + dado por nivel
-- ---------------------------------------------------------------------
function Calculos.ap(ctx)
    local base = (20 + n(ctx.sabedoria) + n(ctx.nivel)) * rankNumero(ctx.rank)
    return base + n(ctx.dadoPorNivelAcumulado) + n(ctx.ajusteManual)
end

-- ---------------------------------------------------------------------
-- Pontos de prana - exclusivo de BRUXAS (qualidade "Linhagem de Unaris").
--
-- ATENCAO A DISTINCAO, que e facil de confundir:
--   * "Coracao de Mana" e o que todo mago tem, e libera MANA. A Aura dele
--     continua existindo e sendo calculada normalmente.
--   * "Linhagem de Unaris" e a bruxa. Nela, Mana e Aura sao somadas numa
--     terceira barra, o PRANA, que e a energia que ela gasta.
-- Nenhuma das duas zera a Aura: a energia continua lá, o que muda e de
-- qual barra a personagem gasta.
-- ---------------------------------------------------------------------
function Calculos.prana(ctx)
    if not ctx.ehBruxa then return 0 end
    return n(ctx.mp) + n(ctx.ap) + n(ctx.ajusteManual)
end

-- ---------------------------------------------------------------------
-- Pontos de vitae (Pv) - apenas para vampiros.
-- Pv = 10 + (Constituicao * 1.5) + (Rank * 30)
-- ---------------------------------------------------------------------
function Calculos.pv(ctx)
    if not ctx.ehVampiro then return 0 end
    local total = 10 + (n(ctx.constituicao) * 1.5) + (rankNumero(ctx.rank) * 30)
    return math.floor(total + 0.5) + n(ctx.ajusteManual)
end

-- ---------------------------------------------------------------------
-- Deslocamento (metros) = deslocamento base da raca + Destreza + Rank
-- ---------------------------------------------------------------------
function Calculos.deslocamento(ctx)
    return n(ctx.deslocamentoBaseRaca) + n(ctx.destreza) + rankNumero(ctx.rank) + n(ctx.ajusteManual)
end

-- ---------------------------------------------------------------------
-- Iniciativa = Destreza + Rank
-- ---------------------------------------------------------------------
function Calculos.iniciativa(ctx)
    return n(ctx.destreza) + rankNumero(ctx.rank) + n(ctx.ajusteManual)
end

-- ---------------------------------------------------------------------
-- Defesas fisicas/mentais = base + atributo + bonus de proficiencia + itens/armaduras
-- ---------------------------------------------------------------------
function Calculos.defesaAparar(ctx)
    return 9 + n(ctx.forca) + n(ctx.bonusProficiencia) + n(ctx.bonusItensArmaduras) + n(ctx.ajusteManual)
end

function Calculos.defesaEsquiva(ctx)
    return 9 + n(ctx.destreza) + n(ctx.bonusProficiencia) + n(ctx.bonusItensArmaduras) + n(ctx.ajusteManual)
end

function Calculos.defesaEmpatica(ctx)
    return 10 + n(ctx.manipulacao) + n(ctx.bonusProficiencia) + n(ctx.bonusItensArmaduras) + n(ctx.ajusteManual)
end

function Calculos.defesaTelepatica(ctx)
    return 10 + n(ctx.sabedoria) + n(ctx.bonusProficiencia) + n(ctx.bonusItensArmaduras) + n(ctx.ajusteManual)
end

-- ---------------------------------------------------------------------
-- Corrida = o dobro do deslocamento.
-- Excecoes levantadas no documento:
--   * Satiros ("Maratonista"): o TRIPLO, e nao o dobro;
--   * Duelista/Passos de vento nivel 2: deslocamento padrao E corrida
--     dobram passivamente - por isso o multiplicador entra sobre o
--     deslocamento ja dobrado.
-- ---------------------------------------------------------------------
function Calculos.corrida(ctx)
    local mult = 2
    if ctx.ehSatiro then mult = 3 end
    return n(ctx.deslocamento) * mult
end

-- ---------------------------------------------------------------------
-- Acoes por turno. Todo personagem comeca com 1 de cada; os ganhos vem
-- da tabela de evolucao e sao de niveis DIFERENTES para cada tipo:
--   padrao +1 no nivel 19 | bonus +1 no nivel 10 | reacao +1 no nivel 15
-- Antes a ficha tinha um contador so, o que nao representava a regra.
-- ---------------------------------------------------------------------
function Calculos.acoesPadrao(ctx)
    local total = 1
    if n(ctx.nivel) >= 19 then total = total + 1 end
    return total + n(ctx.ajusteManual)
end

function Calculos.acoesBonus(ctx)
    local total = 1
    if n(ctx.nivel) >= 10 then total = total + 1 end
    return total + n(ctx.ajusteManual)
end

function Calculos.acoesReacao(ctx)
    local total = 1
    if n(ctx.nivel) >= 15 then total = total + 1 end
    return total + n(ctx.ajusteManual)
end

-- ---------------------------------------------------------------------
-- Capacidade da mochila (numero de slots) = 2 + Forca + Rank
-- ---------------------------------------------------------------------
function Calculos.capacidadeMochila(ctx)
    return 2 + n(ctx.forca) + rankNumero(ctx.rank)
end

return Calculos

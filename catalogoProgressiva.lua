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

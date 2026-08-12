-- =====================================================================
-- CATALOGO DE PERICIAS - Ficha Petrichor
-- Fonte: [2.4] Poderes & Pericias, aba Pericias (compilacao .bib)
-- Pericias magicas (Transmutacao, Evocacao, Clarividencia, Encantamentos,
-- Invocacao) exigem o poder 'Magia' (ou 'Criacao Sobrenatural' p/ Encantamentos).
-- Constituicao nao possui pericias vinculadas (regra do sistema).
-- =====================================================================

local CatalogoPericias = {}

CatalogoPericias.porAtributo = {
    ["Carisma"] = {
        {
            nome = "Animais",
            descricao = [==[determina a capacidade de compreender, se comunicar e treinar uma criatura, seja ela selvagem ou doméstica.]==],
        },
        {
            nome = "Boêmio",
            descricao = [==[esta perícia define a capacidade de uma pessoa em se sobressair em eventos de natureza informais, além de ser usado para teste de resistências ao àlcool, habilidade com jogos de azar e afins.]==],
        },
        {
            nome = "Discursar",
            descricao = [==[a habilidade de uma pessoa em convencer um grande número de pessoas através de discursos com argumentos honestos, sejam eles pautados na emoção ou racionalidade.]==],
        },
        {
            nome = "Encantamentos (magia/forja)",
            descricao = [==[utilizado por magos para realizarem feitiços de encantamentos, ou ferreiros utilizarem em testes de encantamento de forja.]==],
        },
        {
            nome = "Empatia",
            descricao = [==[o talento de uma pessoa em perceber os sentimentos e as intenções dos outros, usados para testes de detecção de fingimentos e mentiras.]==],
        },
        {
            nome = "Negociar",
            descricao = [==[utilizado em testes para negociações de cunho comercial, seja para compra, venda ou afins.]==],
        },
        {
            nome = "Performance",
            descricao = [==[determina a capacidade de uma pessoa de cantar, dançar, tocar instrumentos musicais, pintar ou fazer esculturas para fins artísticos, cada compra dá acesso a duas novas artes.]==],
        },
        {
            nome = "Persuasão",
            descricao = [==[habilidade de convencer um pessoa, ou um pequeno número, através de argumentos honestos, sejam eles pautados na emoção ou racionalidade.]==],
        },
    },
    ["Destreza"] = {
        {
            nome = "Alfaiataria",
            descricao = [==[talento de uma pessoa em realizar análise, criação, cópia ou desconstrução de quaisquer tipo de vestuários ou acessórios.]==],
        },
        {
            nome = "Arcos",
            descricao = [==[usado em testes para manuseio de arcos, sejam eles curtos ou longos.]==],
        },
        {
            nome = "Arremesso",
            descricao = [==[usado para determinar a habilidade de uma pessoa com arremessos, sejam de lanças, machadinhas ou até explosivos.]==],
        },
        {
            nome = "Bestas",
            descricao = [==[usado em testes para manuseio de bestas, sejam elas leves ou pesadas.]==],
        },
        {
            nome = "Condução - montarias aéreas",
            descricao = [==[determina a capacidade de um mortal de utilizar montarias áereas.]==],
        },
        {
            nome = "Condução - montarias aquáticas",
            descricao = [==[determina a capacidade de um mortal de utilizar montarias aquáticas.]==],
        },
        {
            nome = "Condução - montarias terrestres",
            descricao = [==[determina a capacidade de um mortal de utilizar montarias terrestres.]==],
        },
        {
            nome = "Condução - embarcações",
            descricao = [==[determina a capacidade de um mortal de manejar um barco, seja ele de qualquer natureza, esta perícia impossibilita a navegação.]==],
        },
        {
            nome = "Armas de fogo leves",
            descricao = [==[usado em testes para manuseios de armas de fogos leves, como pistolas e mosquetes médios.]==],
        },
        {
            nome = "Armas de fogo média",
            descricao = [==[usado em testes para manuseios de armas de fogo médias, como escopetas e mosquetes curtos.]==],
        },
        {
            nome = "Armas de fogo pesadas",
            descricao = [==[usado em testes para manuseios de armas de fogo pesadas, como mosquetes longos.]==],
        },
        {
            nome = "Armas de fogo canhões",
            descricao = [==[usados em testes para manuseios de canhões, morteiros e outras armas de cerco.]==],
        },
        {
            nome = "Esquiva",
            descricao = [==[capacidade do mortal em se esquivar com habilidade de golpes. Não é possível utilizar uma ação defensiva do tipo 'Esquiva' sem essa perícia.]==],
        },
        {
            nome = "Forja",
            descricao = [==[talento de uma pessoa em realizar análise, criação, cópia ou desconstrução de qualquer tipo de objeto de forja (metalurgia) como armas corpo-a-corpo, armaduras, escudos etc.]==],
        },
        {
            nome = "Furtividade",
            descricao = [==[o talento de uma pessoa em se mover sem ser detectada.]==],
        },
        {
            nome = "Gastronomia",
            descricao = [==[utilizado em testes para a preparação de pratos, sejam salgados, doces, mundanos ou encantados. Esta perícia também é usada para preparação de bebidas.]==],
        },
        {
            nome = "Ginástica",
            descricao = [==[o talento de uma pessoa em fazer esportes vinculados ao equilíbrio e a agilidade, usado em testes para corrida, acrobacias etc.]==],
        },
        {
            nome = "Prestidigitação",
            descricao = [==[talento de uma pessoa em roubar, mover objetos ou realizar manuseios furtivos, sem ser detectada.]==],
        },
        {
            nome = "Transmutação (magia)",
            descricao = [==[utilizado por magos para realizarem feitiços de transmutações.]==],
        },
    },
    ["Força"] = {
        {
            nome = "Aparar",
            descricao = [==[capacidade do mortal em aparar golpes dados contra si usando objetos. Não é possível utilizar uma ação defensiva do tipo 'Aparar' sem essa perícia.]==],
        },
        {
            nome = "Armas brancas - cortantes de uma mão",
            descricao = [==[usado em testes para manuseios de armas cortantes de uma mão, como machados, espadas, punhais, foices etc.]==],
        },
        {
            nome = "Armas brancas - cortantes de duas mãos",
            descricao = [==[usado em testes para manuseios de armas cortantes de duas-mãos, como machados, espadas, foices etc.]==],
        },
        {
            nome = "Armas brancas - perfurantes de uma mão",
            descricao = [==[usado em testes para manuseios de armas perfurantes de uma-mão, como lanças, alabardas, agulhas etc.]==],
        },
        {
            nome = "Armas brancas - perfurantes de duas mãos",
            descricao = [==[usado em testes para manuseios de armas perfurantes de duas-mãos, como lanças, alabardas etc.]==],
        },
        {
            nome = "Armas brancas - concussão de uma mão",
            descricao = [==[usado em testes para manuseio de armas de concussão de uma-mão, como maças, porretes, martelos etc.]==],
        },
        {
            nome = "Armas brancas - concussão de duas mãos",
            descricao = [==[usado em testes para manuseio de armas de concussão de uma-mão, como maças, porretes, martelos etc.]==],
        },
        {
            nome = "Atletismo",
            descricao = [==[o talento de uma pessoa em fazer esportes vinculados ao fôlego e a resistência, usado para testes de escalada, natação, salto, disputas de força etc.]==],
        },
        {
            nome = "Briga",
            descricao = [==[usado em testes onde um personagem luta desarmado, usando as partes de seu corpo como fonte de dano e defesa.]==],
        },
        {
            nome = "Subjugar",
            descricao = [==[habilidade em utilizar o porte físico para subjulgar emocionalmente um ou mais alvos.]==],
        },
    },
    ["Inteligência"] = {
        {
            nome = "Acadêmicos",
            descricao = [==[determina a compreensão do mortal de assuntos acadêmicos mundanos como matemática, ortografia, geografia etc; Não possuir esta perícia e menos de 3 de Inteligência significa que você é analfabeto.]==],
        },
        {
            nome = "Estratégia",
            descricao = [==[sua capacidade em compreender, elaborar e executar estratégias militares seja em jogos ou no campo de batalha.]==],
        },
        {
            nome = "Evocação (magia)",
            descricao = [==[utilizado por magos para realizarem feitiços de evocações.]==],
        },
        {
            nome = "Heráldica",
            descricao = [==[usado em testes para compreender a história dos reinos, líderes, reconhecer os brasões das famílias nobres, seus lemas e quais cidades estão sob seu domínio, além de suas grandes figuras.]==],
        },
        {
            nome = "Investigação",
            descricao = [==[o talento de uma pessoa em analisar um conjunto de evidências em sua posse e verificar se possuem ligação entre si, ou com uma hipótese que o investigador tenha.]==],
        },
        {
            nome = "Linguística",
            descricao = [==[usado em testes onde o personagem precise compreender ou se comunicar em idiomas mundanos, cada compra dá acesso a dois novos idiomas.]==],
        },
        {
            nome = "Mecânica",
            descricao = [==[talento de uma pessoa em realizar análise, criação, cópia ou desconstrução de qualquer tipo de equipamentos industriais, além de munições, armas-de-fogo e explosivos.]==],
        },
        {
            nome = "Natureza",
            descricao = [==[determina a capacidade de compreender o funcionamento da árvores, fungos, flores etc. também usado em testes de agricultura.]==],
        },
        {
            nome = "Navegação",
            descricao = [==[habilidade de um mortal em se locomover e orientar no mar, além da compreensão das faunas e floras marítimas de forma geral.]==],
        },
        {
            nome = "Ocultismo",
            descricao = [==[determina a compreensão do mortal de assuntos acadêmicos de natureza não-mundana, como rituais, idiomas místicos, conhecimentos sombrios e afins.]==],
        },
    },
    ["Manipulação"] = {
        {
            nome = "Atuação",
            descricao = [==[capacidade de uma pessoa em se disfarçar e agir como uma outra, usado também em testes de teatro e de canto.]==],
        },
        {
            nome = "Diplomacia",
            descricao = [==[usado em testes para negociações políticas de qualquer natureza.]==],
        },
        {
            nome = "Enganação",
            descricao = [==[usado em testes para convencer ou negociar com uma pessoa, ou um grupo de pessoas, usando argumentos desonestos]==],
        },
        {
            nome = "Etiqueta",
            descricao = [==[habilidade em compreender e agir de acordo com costumes de círculos que o personagem não frequente, sejam eles refinados ou coloquiais.]==],
        },
        {
            nome = "Intimidação",
            descricao = [==[habilidade de subjugar emocionalmente terceiros através de intimidação social.]==],
        },
        {
            nome = "Invocação",
            descricao = [==[utilizado por magos para realizarem feitiços de invocação, e pré-requisito para seres usarem habilidades que invocam criaturas, pactos e afins.]==],
        },
        {
            nome = "Sedução",
            descricao = [==[usado em testes para seduzir uma ou mais pessoas, seja através da lábia ou do corpo.]==],
        },
        {
            nome = "Volição",
            descricao = [==[capacidade do mortal de resistir a tentativas de sedução ou manipulação emocional. Não é possível utilizar uma ação defensiva 'Volição' sem essa perícia.]==],
        },
    },
    ["Sabedoria"] = {
        {
            nome = "Alquimia",
            descricao = [==[é a capacidade de uma pessoa de criar poções, a partir da união de ingredientes, bases e receitas previamente estudadas.]==],
        },
        {
            nome = "Clarividência (magia/oráculos)",
            descricao = [==[utilizado por magos para realizarem feitiços de clarividência; Pode ser adquirido por possuidores da qualidade 'Dom oracular']==],
        },
        {
            nome = "Intuição",
            descricao = [==[capacidade de sentir presenças e energias espirituais ou mágicas, permitindo ao personagem reagir diante de ameaças não-físicas em tempo.]==],
        },
        {
            nome = "Medicina",
            descricao = [==[usado em testes para diagnosticar e tratar ferimentos e doenças tanto em si quanto em terceiros.]==],
        },
        {
            nome = "Percepção",
            descricao = [==[capacidade de sentir presenças físicas, permitindo ao personagem reagir diante de ameaças em tempo.]==],
        },
        {
            nome = "Religião",
            descricao = [==[determina a compreensão do mortal de assuntos religiosos como a história, os deuses, os locais sagrados, profetas e artefatos divinos famosos.]==],
        },
        {
            nome = "Sobrevivência",
            descricao = [==[habilidade de uma pessoa em se locomover e orientar em ambientes hostis, montar acampamentos, fogueiras, cozinhas improvisadas e saber direções.]==],
        },
        {
            nome = "Resistir",
            descricao = [==[capacidade do mortal de resistir a tentativas de manipulação telepática. Não é possível utilizar uma ação defensiva 'Resistir' sem essa perícia.]==],
        },
        {
            nome = "Vontade",
            descricao = [==[usado em testes onde o personagem precisa utilizar sua vontade para executar ações que seu instinto se recusa a fazê-lo, como superar medos, seduções, controles etc.]==],
        },
    },
}

CatalogoPericias.atributos = {"Carisma", "Destreza", "Força", "Inteligência", "Manipulação", "Sabedoria"}

-- Helpers -------------------------------------------------------------

function CatalogoPericias.nomesPorAtributo(atributo)
    local lista = {}
    local grupo = CatalogoPericias.porAtributo[atributo] or {}
    for _, p in ipairs(grupo) do table.insert(lista, p.nome) end
    return lista
end

function CatalogoPericias.buscar(atributo, nome)
    local grupo = CatalogoPericias.porAtributo[atributo] or {}
    for _, p in ipairs(grupo) do
        if p.nome == nome then return p end
    end
    return nil
end

return CatalogoPericias

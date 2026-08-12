-- =====================================================================
-- CATALOGO DE TRACOS DE PERSONALIDADE - Ficha Petrichor
-- Fonte: [2.6] Classes & Tracos, secao 'Lista de tracos' (compilacao .bib)
--
-- 'chave' e um identificador ASCII (sem acento/espaco) usado para nomear
-- o componente XML de cada card no popup de selecao (rectTraco_<chave>).
--
-- Regras de mesa relacionadas (para o texto de ajuda do popup):
--  * No inicio da ficha o jogador atrela UM traco ao personagem; outros
--    podem ser ganhos ou perdidos ao longo das aventuras.
--  * Recusa: gastar 1 ponto de inspiracao permite recusar ganhar/perder
--    um traco.
--  * Acoes opostas ao traco: o narrador pode pedir teste puro de Sabedoria
--    (meta 20) ou cobrar 1 ponto de inspiracao.
-- =====================================================================

local CatalogoTracos = {}

CatalogoTracos.itens = {
    {
        chave = "Lascivo",
        nome = "Lascivo",
        oposto = "Casto",
        descricao = [==[Sua chance de gerar um descendente é aumentada, bem como a chance de cair em truques e/ou habilidades de sedução em -2, porém sua chance de seduzir alguém é aumentada em +2, você terá desvantagem em testes sociais contra personagens Castos.]==],
    },
    {
        chave = "Casto",
        nome = "Casto",
        oposto = "Lascivo",
        descricao = [==[Sua chance de gerar um descendente é drasticamente reduzida, aumente sua resistência a truques e/ou habilidades de sedução em +2, você terá desvantagem em testes sociais contra personagens Lascivos.]==],
    },
    {
        chave = "Glutao",
        nome = "Glutão",
        oposto = "Moderado",
        descricao = [==[Você deve obrigatoriamente gastar 20% de todo o dinheiro que recebe por estação com comida, você deve se alimentar com o dobro da comida que um indivíduo comum da sua raça comeria para se sentir satisfeito e possui desvantagem em testes sociais contra personagens Moderados. Enquanto você estiver perfeitamente saciado, rolagens que causam alteração de humor são roladas com desvantagem contra você.]==],
    },
    {
        chave = "Moderado",
        nome = "Moderado",
        oposto = "Glutão",
        descricao = [==[Expectativa de vida 10% maior, personagens moderados possuem uma chance maior de serem bem sucedidos em ações que envolvam administração e possui desvantagem em testes sociais contra personagens Glutões.]==],
    },
    {
        chave = "Ganancioso",
        nome = "Ganancioso",
        oposto = "Generoso",
        descricao = [==[Sempre que houver a oportunidade de você obter algum lucro numa missão, pacto ou acordo você irá lutar para obtê-lo, por vezes se colocando em risco por isso, aumente em 10% todo lucro monetário obtido, entretanto reduza em 20% todo lucro relacionado a contratos estabelecidos. Você terá desvantagem em testes sociais contra Seguidores do Supremo.]==],
    },
    {
        chave = "Generoso",
        nome = "Generoso",
        oposto = "Ganancioso",
        descricao = [==[Você obrigatoriamente doa 10% de todo o ouro que recebe por estação para aqueles que precisam, personagens generosos possuem uma chance maior em serem bem sucedidos em ações que envolvam diplomacia e discursos, além de serem bem vistos por aqueles que vivem no local que recebe suas doações.]==],
    },
    {
        chave = "Preguicoso",
        nome = "Preguiçoso",
        oposto = "Diligente",
        descricao = [==[Aumente em 20% o tempo necessário para fazer qualquer viagem, você irá receber um bônus de +2 em todos os embates sociais enquanto estiver perfeitamente descansado e -2 caso não esteja.]==],
    },
    {
        chave = "Diligente",
        nome = "Diligente",
        oposto = "Preguiçoso",
        descricao = [==[Reduza em 20% o tempo para executar qualquer tarefa que dependa diretamente do seu esforço, você se recusará veementemente de abandonar seu trabalho enquanto este não estiver concluído e caso alguém deseje lhe compelir a abandona-lo terá desvantagem nesta tarefa. Você terá desvantagem em testes sociais contra personagens preguiçosos e -1 em todas as suas rolagens caso tenha saído em missão tendo deixado uma tarefa inacabada para trás.]==],
    },
    {
        chave = "Colerico",
        nome = "Colérico",
        oposto = "Calmo",
        descricao = [==[Você possui vantagem em quaisquer testes que envolvam entrar em estado de fúria ou perda de controle por conta da raiva e quando neste estado você terá um bônus de +2 para causar medo. Você sempre irá buscar a penalidade máxima para aqueles que considera criminosos. (Ex: caso a punição máxima seja a pena de morte, você não irá aceitar menos que isso)]==],
    },
    {
        chave = "Calmo",
        nome = "Calmo",
        oposto = "Colérico",
        descricao = [==[Você possui vantagem em quaisquer testes que envolvam resistir a fúria ou perda de controle por conta da raiva e enquanto se mantiver calmo você terá +2 de resistência bônus contra efeitos de medo. Você possui desvantagem em testes sociais contra personagens Coléricos.]==],
    },
    {
        chave = "Paciente",
        nome = "Paciente",
        oposto = "Impaciente",
        descricao = [==[Personagens pacientes possuem vantagem em quaisquer testes que envolvam uma preparação longa (maior que 10 dias), sendo igualmente válido para tarefas prolongadas. Você terá desvantagem em testes sociais contra personagens Impacientes.]==],
    },
    {
        chave = "Impaciente",
        nome = "Impaciente",
        oposto = "Paciente",
        descricao = [==[Reduza em 25% o tempo necessário para executar qualquer viagem, você é psicologicamente incapaz de realizar preparações longas (maiores que 10 dias) e caso seja forçado a realiza-las reduza em -1 todas as suas rolagens. Você possui desvantagem em rolagens sociais contra personagens pacientes.]==],
    },
    {
        chave = "Arrogante",
        nome = "Arrogante",
        oposto = "Humilde",
        descricao = [==[Uma vez por aventura/missão/evento você poderá re-rolar qualquer dado cuja rolagem anterior tenha sido igual ou menor que 10 (dado). Você tem desvantagem em testes sociais contra personagens humildes.]==],
    },
    {
        chave = "Humilde",
        nome = "Humilde",
        oposto = "Arrogante",
        descricao = [==[Você possui vantagem em testes para conquistar a opinião popular e espalhar uma imagem positiva sua se torna mais fácil. Você tem desvantagem em testes sociais contra personagens arrogantes.]==],
    },
    {
        chave = "Traicoeiro",
        nome = "Traiçoeiro",
        oposto = "Honesto",
        descricao = [==[Você possui um bônus de +2 em todas as rolagens que envolvam enganação, caso o esquema de enganação seja prolongado dobre este bônus. Uma vez que seu esquema seja revelado estes bônus se tornam deméritos sociais caso você tente enganar os mesmos alvos. Você possui desvantagem em testes sociais contra personagens honestos.]==],
    },
    {
        chave = "Honesto",
        nome = "Honesto",
        oposto = "Traiçoeiro",
        descricao = [==[Você possui um bônus de +2 em todas as rolagens de diplomacia, este bônus é dobrado caso seja um acordo igualitário, você possui -4 em rolagens de enganação. Você possui vantagem em testes sociais contra outros personagens honestos e desvantagem contra personagens traiçoeiros.]==],
    },
    {
        chave = "Medroso",
        nome = "Medroso",
        oposto = "Valente",
        descricao = [==[Personagens covardes possuem +25% de chance de não se envolverem em problemas na rolagem do D100 e caso estes estejam liderando uma batalha de larga escala (1000 combatentes ou mais) e ordene uma retirada, o número de tropas abatidas pela ordem de retirado é reduzidada em 50%. Você possui um bônus de +2 em rolagens sociais contra outros personagens medrosos e desvantagem em rolagens para resistir ao efeito Medo.]==],
    },
    {
        chave = "Valente",
        nome = "Valente",
        oposto = "Medroso",
        descricao = [==[Personagens valentes possuem +1 em todas as rolagens de ataque em combate e perde -1 em defesas, este bônus é dobrado caso esteja lutando contra um oponente muito mais forte que você (5 níveis ou mais), caso você esteja liderando uma batalha de larga escala (1000 combatentes ou mais) e ordene um ataque total, aumente o número de tropas abatidas em 100%. Você possui desvantagem em testes sociais contra personagens Medrosos.]==],
    },
    {
        chave = "Timido",
        nome = "Tímido",
        oposto = "Gregário",
        descricao = [==[Você leva apenas 75% do tempo necessário para aprender uma nova língua, e qualquer teste feito com o intuito de obter informações a seu respeito é realizado com desvantagem.]==],
    },
    {
        chave = "Gregario",
        nome = "Gregário",
        oposto = "Tímido",
        descricao = [==[Gregários possuem vantagem em qualquer teste que envolva mobilizar, instruir ou comandar um grupo de pessoas menor que 500. Gregários quando acompanhados pelo seu grupo possuem um bônus de +2 em defesas sociais e -2 caso esteja sozinho.]==],
    },
    {
        chave = "Ambicioso",
        nome = "Ambicioso",
        oposto = "Satisfeito",
        descricao = [==[Você possui +1 em todas as rolagens contra personagens nobres, influentes e/ou poderosos, todavia possui -2 em rolagens contra todos os outros. Você tem vantagem em rolagens sociais contra reis, imperadores ou líderes de raça e desvantagem em rolagens contra outros personagens ambiciosos. Estes bônus se aplicam apenas a seres humanoides inteligentes que vivem em sociedade.]==],
    },
    {
        chave = "Satisfeito",
        nome = "Satisfeito",
        oposto = "Ambicioso",
        descricao = [==[Você possui +1 em todas as rolagens contra personagens ordinários, todavia possui -2 em rolagens contra todos os outros. Você tem desvantagem em rolagens sociais contra reis, imperadores ou líderes de raça. Estes bônus se aplicam apenas a seres humanoides inteligentes que vivem em sociedade.]==],
    },
    {
        chave = "Arbitrario",
        nome = "Arbitrário",
        oposto = "Justo",
        descricao = [==[Sempre que tomar uma decisão para favorecer alguém, você poderá requerer um favor desta pessoa em troca, sendo estes: 25% do ouro total do alvo, um dos equipamentos ou lhe ajudar a conseguir algo. Este favor deve ser feito em segredo, caso seja descoberto o mesmo irá automaticamente falhar.]==],
    },
    {
        chave = "Justo",
        nome = "Justo",
        oposto = "Arbitrário",
        descricao = [==[Sempre que você intervier num embate significativo, seja este social ou militar em prol de outras pessoas e sair bem sucedido, obtenha um ponto de Legitimidade, ao acumular 5 pontos de Legitimidade o personagem poderá requisitar um título de nobreza. Você possui desvantagens em testes sociais contra personagens Arbitrários.]==],
    },
    {
        chave = "Cinico",
        nome = "Cínico",
        oposto = "Zeloso",
        descricao = [==[Personagens cínicos podem adotar o costume de qualquer religião, raça ou cultura sem receber deméritos. Você recebe +2 em rolagens sociais contra personagens com o mesmo traço e -2 contra personagens zelosos.]==],
    },
    {
        chave = "Zeloso",
        nome = "Zeloso",
        oposto = "Cínico",
        descricao = [==[Personagens zelosos seguem uma única fé durante toda a vida, recebendo um bônus de +2 em rolagens de dano contra personagens de fés diferentes. Você possui -3 em rolagens sociais contra personagens de fé diferente que não envolvam lhe converter e +2 contra contra personagens Cínicos.]==],
    },
    {
        chave = "Paranoico",
        nome = "Paranóico",
        oposto = "Confiante",
        descricao = [==[Aumente em 15% o tempo necessário para realizar qualquer viagem e aumente em 15% a chance de sucesso nas rolagens D100. Você possui vantagem em quaisquer testes para descobrir armações contra a sua pessoa.]==],
    },
    {
        chave = "Confiante",
        nome = "Confiante",
        oposto = "Paranóico",
        descricao = [==[A qualquer momento (exceto em combate) um personagem confiante pode auxiliar um outro personagem a realizar uma tarefa, este o faz apenas por estar ali e sua positividade afetar o alvo e com isso lhe provê 1d4 no teste auxiliado. Personagens confiantes possuem desvantagem em testes para descobrir esquemas.]==],
    },
    {
        chave = "Compassivo",
        nome = "Compassivo",
        oposto = "Insensível",
        descricao = [==[Você possui um bônus de +3 em testes sociais contra seguidores do Supremo desde que fora de combate. Você possui desvantagens em testes sociais contra personagens insensíveis e sádicos.]==],
    },
    {
        chave = "Insensivel",
        nome = "Insensível",
        oposto = "Compassivo",
        descricao = [==[Você possui um bônus de +3 para resistir a todos os testes sociais e -3 em todas as suas rolagens sociais que não estejam diretamente ligadas a sua aparência.]==],
    },
    {
        chave = "Sadico",
        nome = "Sádico",
        oposto = nil,
        descricao = [==[Você possui vantagem em testes para causar medo, você pode abrir mão desta vantagem para receber +1d6 no teste, você causa +1d6 de dano adicional contra alvos que estejam sob influência de medo. Um personagem sádico sempre irá tentar matar o seu oponente e se recusará a deixar qualquer inimigo vivo.]==],
    },
    {
        chave = "Teimoso",
        nome = "Teimoso",
        oposto = nil,
        descricao = [==[Personagens teimosos recebem um bônus de +1d4 para resistir a terem sua opinião mudada.]==],
    },
    {
        chave = "Indeciso",
        nome = "Indeciso",
        oposto = nil,
        descricao = [==[Seu personagem não possui um traço de personalidade marcante pois sua mentalidade ainda está em formação, durante seu primeiro ano você não terá nenhum traço de personalidade para além deste e no segundo ano deverá obter um novo que seja condizente com seu personagem. Indeciso é descartado após isso.]==],
    },
    {
        chave = "Excentrico",
        nome = "Excêntrico",
        oposto = nil,
        descricao = [==[Você recebe +20% de experiência em narrativas que não envolvam combate, porém recebe -20% em narrativas em que combates acontecem.]==],
    },
    {
        chave = "Vingativo",
        nome = "Vingativo",
        oposto = nil,
        descricao = [==[Um personagem vingativo possui um bônus de +2 em todas as suas rolagens enquanto enfrentando diretamente o objeto de sua vingança. Não é possível ter mais que 1 alvo de vingança por vez.]==],
    },
    {
        chave = "Clemente",
        nome = "Clemente",
        oposto = nil,
        descricao = [==[Quando um personagem clemente perdoa alguém que lhe fez mal, este recebe um bônus de +1 a ser utilizado em qualquer rolagem que este desejar, podendo acumular até um bônus de +10 desta maneira.]==],
    },
}

function CatalogoTracos.buscarPorNome(nome)
    for _, item in ipairs(CatalogoTracos.itens) do
        if item.nome == nome then return item end
    end
    return nil
end

function CatalogoTracos.listarNomes()
    local lista = {}
    for _, item in ipairs(CatalogoTracos.itens) do table.insert(lista, item.nome) end
    return lista
end

return CatalogoTracos

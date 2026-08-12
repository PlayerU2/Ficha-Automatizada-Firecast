-- =====================================================================
-- CATALOGO DE CLASSES E SUBCLASSES - PETRICHOR
-- Extraido do documento "Classes e Tracos" do .bib da mesa.
--
-- REGRAS DA MESA (secao introdutoria do documento):
--   * Pontos de classe nos niveis 1, 3, 5, 8, 11, 14, 17 e 20.
--   * Uma ficha pode ter no maximo DUAS subclasses, nao necessariamente
--     da mesma classe.
--   * A segunda subclasse so e liberada no NIVEL 11, e apenas se a
--     primeira ja estiver no nivel 4 ou mais.
--
-- ARVORES DE TAMANHOS DIFERENTES - ISTO E DE PROPOSITO:
--   A maioria das subclasses tem 8 niveis, mas algumas ("Combatente
--   critico", "Samurai" e "Ninja") tem apenas 5. Nao e dado faltando: e
--   uma escolha de design da mesa. Quem pega uma arvore curta chega ao
--   topo dela mais cedo e precisa gastar os pontos restantes em OUTRA
--   subclasse; quem pega uma arvore de 8 pode concentrar tudo em uma so.
--   Por isso o teto de nivel e por subclasse (campo totalNiveis), nunca
--   um 8 fixo.
-- =====================================================================
local CatalogoClasses = {}

CatalogoClasses.NIVEIS_COM_PONTO = {1, 3, 5, 8, 11, 14, 17, 20}
CatalogoClasses.MAX_NIVEL_SUBCLASSE = 8   -- maior arvore existente (uso em layout)
CatalogoClasses.MAX_SUBCLASSES = 2
CatalogoClasses.NIVEL_LIBERA_SEGUNDA = 11
CatalogoClasses.NIVEL_MIN_PRIMEIRA_PARA_SEGUNDA = 4

CatalogoClasses.classes = {
    {
        nome = [=[Artificie]=],
        subclasses = {
            {
                nome = [=[Mestre da forja]=],
                descricao = [=[classe para aqueles que gostam de forjar armas, armaduras e outros objeto do gênero.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Você é capaz de realizar reparos simples e forjas simples sem possuir um kit de ferreiro.]=],
                    [=[Você consegue identificar a origem, a qualidade e o tipo de material de um objeto forjado sem precisar de teste.]=],
                    [=[Role testes para forjar armas, armaduras e demais objetos com +3 de modificador.]=],
                    [=[Desmonte objetos de forja para aprender os encantamentos dos mesmos e recuperar metade do material.]=],
                    [=[Ganhe uma habilidade de classe rank C, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank B, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank A, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank EX, dentro dos limites desta árvore.]=],
                },
            },
            {
                nome = [=[Tecelão]=],
                descricao = [=[para os que pretendem fabricar vestimentas, jóias, tanto as comuns, quanto as de luxo ou as especiais.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Você consegue realizar reparos simples em vestimentas sem possuir um kit de tecelagem.]=],
                    [=[Você consegue identificar a origem, a qualidade e o tipo de materiais de um vestuário sem precisar de teste.]=],
                    [=[Role testes para costurar roupas e tapeçarias com +3 de modificador.]=],
                    [=[Desconstrói vestimentas e acessórios em sua bancada para aprender os encantamentos das mesmas e recuperar metade do material.]=],
                    [=[Ganhe uma habilidade de classe rank C, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank B, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank A, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank EX, dentro dos limites desta árvore.]=],
                },
            },
            {
                nome = [=[Mecânico]=],
                descricao = [=[para os especialistas em criar armadilhas, minas, armas-de-fogo, granadas e demais mecanismos industriais.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Você é capaz de montar armadilhas, granadas e balas sem possuir um kit de engenharia.]=],
                    [=[Você consegue identificar a melhor forma de desmontar armadilhas apenas observando-as.]=],
                    [=[Role com vantagem testes para compreender o funcionamento de motores e demais mecanismos industriais.]=],
                    [=[Gaste uma ação bônus e 1 porção de pólvora para montar uma "Granada do Artíficie" durante um combate.]=],
                    [=[Ganhe uma habilidade de classe rank C, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank B, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank A, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank EX, dentro dos limites desta árvore.]=],
                },
            },
        },
    },
    {
        nome = [=[Artista]=],
        subclasses = {
            {
                nome = [=[Mestre do palco]=],
                descricao = [=[para aqueles voltados para atuação e teatro, e que desejam investir seu estilo de roleplay nas habilidades artísticas.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Adicione +2 em sua Defesa Social quando estiver em um ambiente com mais de 5 Seres]=],
                    [=[Você ganha descontos de 20% na cidade em que realizou sua última performance.]=],
                    [=[Role testes da perícia "Atuação" com vantagem.]=],
                    [=[Receba +4 em testes de performances artísticas.]=],
                    [=[Ganhe uma habilidade de classe rank C, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank B, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank A, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank EX, dentro dos limites desta árvore.]=],
                },
            },
            {
                nome = [=[Camaleão social]=],
                descricao = [=[para os que desejam transformar suas habilidades sociais em capacidades de espionagem, usando disfarces e engenharia social.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Você pode usar roupas e maquiagens para se disfarçar como outra pessoa específica sem precisar de kit de disfarce.]=],
                    [=[Adicione +3 em sua Defesa Telepática sempre que estiver exercendo uma função de espionagem.]=],
                    [=[Você pode se infiltrar em multidões - 10 pessoas ou mais - e se camuflar em plena vista sem precisar de teste.]=],
                    [=[Cada ponto de Manipulação que você possuir, te dará 1 espião na cidade que se encontra, que realizará pequenas tarefas.]=],
                    [=[Ganhe uma habilidade de classe rank C, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank B, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank A, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank EX, dentro dos limites desta árvore.]=],
                },
            },
            {
                nome = [=[Bardo]=],
                descricao = [=[classe daqueles que buscam serem cantores, aproveitando suas habilidades musicais para auxiliar companheiros e conquistar benefícios sociais.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Você se torna capaz de utilizar instrumentos musicais como Canalizadores Energéticos; Estas habilidades precisam ser musicadas.]=],
                    [=[Aliados próximos recebem +1 de Defesa mental e empática, enquanto estiverem em um raio de 10m de você.]=],
                    [=[Você ganha +3 em testes para seduzir outra pessoa, e a duração do efeito é o dobro do comum.]=],
                    [=[Você recebe dicas em qualquer taverna ou feira local para resolver narrativas que você participa.]=],
                    [=[Ganhe uma habilidade de classe rank C, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank B, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank A, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank EX, dentro dos limites desta árvore.]=],
                },
            },
        },
    },
    {
        nome = [=[Atirador]=],
        subclasses = {
            {
                nome = [=[Combatente crítico]=],
                descricao = [=[classe para os atiradores que desejam transformar a mecânica de acerto crítico em mais benefícios em seus disparos.]=],
                nota = [=[]=],
                totalNiveis = 5,
                niveis = {
                    [=[Dobre o dano do golpe caso o resultado do teste de acerto seja um crítico positivo.]=],
                    [=[Adicione 1 em todas as suas defesas até o final do combate para cada acerto crítico que realizar em um ataque.]=],
                    [=[Ganhe uma ação padrão após acertar seu oponente com um acerto crítico, devendo gastá-la na hora.]=],
                    [=[Você se torna imune ao efeito "crítico negativo" quando tirar o resultado "1" em dados ofensivos.]=],
                    [=[Reduz sua margem de acerto crítico em 1, para disparos.]=],
                },
            },
            {
                nome = [=[Atirador de sequência]=],
                descricao = [=[para os atiradores que desejam focar sua força de combate na cadência de seus tiros.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Você ganha a habilidade de recarregar a flecha no arco ou munição na arma sem gastar ação para isto.]=],
                    [=[Sua arma nunca se quebra enquanto estiver equipada com você, permanecendo com 1 de Durabilidade.]=],
                    [=[Você pode pegar os restos de munição para fabricar mais durante um descanso curto, em uma relação de 3 para 1.]=],
                    [=[Ao tirar um crítico positivo no teste de acerto, seu tiro irá atravessar o alvo e acertar o inimigo de trás.]=],
                    [=[Ganhe uma habilidade de classe rank C, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank B, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank A, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank EX, dentro dos limites desta árvore.]=],
                },
            },
            {
                nome = [=[Franco atirador]=],
                descricao = [=[para os atiradores que focam em realizar tiros mais fortes, de distâncias maiores, em seus oponentes.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Você consegue realizar disparos com o dobro do alcance de sua arma.]=],
                    [=[Ganhe o direito de carregar arcos, bestas e armas-de-fogo pesadas mesmo que não tenha a FORÇA mínima necessária.]=],
                    [=[Você pode tornar todos os seus disparos elementais, vinculados a sua afinidade natural, sem gastar ações para isto.]=],
                    [=[Gaste uma ação bônus se concentrando para desconsiderar os redutores para acerto de áreas específicas.]=],
                    [=[Ganhe uma habilidade de classe rank C, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank B, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank A, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank EX, dentro dos limites desta árvore.]=],
                },
            },
        },
    },
    {
        nome = [=[Boticário]=],
        subclasses = {
            {
                nome = [=[Curandeiro]=],
                descricao = [=[classe daqueles que querem seguir pelo caminho da medicina, usando o conhecimento de boticário para a vida.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Você consegue realizar atendimentos médicos com itens do dia-a-dia sem a necessidade de kits de cura.]=],
                    [=[Pode realizar diagnósticos de aflições médicas que você desconheça sem nenhum redutor.]=],
                    [=[Pacientes sob seus cuidados possuem uma taxa de recuperação por dia dobrada.]=],
                    [=[Poções, unguentos e tônicos de cura aplicados por você curam 50% mais.]=],
                    [=[Ganhe uma habilidade de classe rank C, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank B, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank A, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank EX, dentro dos limites desta árvore.]=],
                },
            },
            {
                nome = [=[Venenomante]=],
                descricao = [=[classe daqueles que transformam seus conhecimentos como boticários em capacidade produzir venenos e atingir seus inimigos com os mesmos.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Você consegue encontrar ingredientes para venenos sem precisar rolar dados, apenas procurando.]=],
                    [=[Você consegue identificar a origem de envenamentos e produzir antídotos com metade da dificuldade.]=],
                    [=[Sempre que produzir um veneno, você imediatamente também produz uma dose de antídoto.]=],
                    [=[Nenhum veneno preparado por você lhe aflige de qualquer forma.]=],
                    [=[Ganhe uma habilidade de classe rank C, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank B, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank A, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank EX, dentro dos limites desta árvore.]=],
                },
            },
            {
                nome = [=[Gastroquimista]=],
                descricao = [=[para os apaixonados por comida, que buscam converter a elegante arte da culinária em força.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Refeições preparadas por você em um descanso curto dão efeitos de descanso longo aos que comerem.]=],
                    [=[Com um pouco de pano, um vasilhame e fogo você torna qualquer líquido mundano em água potável.]=],
                    [=[Durante seu processo de culinária, você purifica os ingredientes de quaisquer venenos e doenças.]=],
                    [=[Você pode gerar refeições completas e duráveis com apenas metade dos ingredientes.]=],
                    [=[Ganhe uma habilidade de classe rank C, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank B, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank A, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank EX, dentro dos limites desta árvore.]=],
                },
            },
        },
    },
    {
        nome = [=[Domador]=],
        subclasses = {
            {
                nome = [=[Caçador primal]=],
                descricao = [=[para os personagens que querem focar seu caminho como caçadores de monstros e criaturas.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Você constrói armadilhas para criaturas específicas com metade da dificuldade e tempo.]=],
                    [=[Role testes com vantagem para estudar sobre as criaturas que você deseja caçar.]=],
                    [=[Ao derrotar uma criatura que você estava caçando, escolha um espólio dela para esfolar e obter automaticamente.]=],
                    [=[Ao iniciar uma caçada contra uma criatura ou monstro, a mesma fica marcada e receberá 30% mais de danos oriundos de você.]=],
                    [=[Ganhe uma habilidade de classe rank C, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank B, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank A, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank EX, dentro dos limites desta árvore.]=],
                },
            },
            {
                nome = [=[Montador selvagem]=],
                descricao = [=[para os obcecados por lutar e viver com montarias, sejam elas de qualquer natureza.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Você pode realizar qualquer tipo de manobra em qualquer velocidade com sua montaria e nunca perder o equilíbrio.]=],
                    [=[Adicione o seu deslocamento ao da sua montaria, quando montado nela.]=],
                    [=[Adicione +2 em suas defesas quando estiver lutando em cima de sua montaria.]=],
                    [=[Você consegue comunicar suas intenções com sua montaria empaticamente.]=],
                    [=[Ganhe uma habilidade de classe rank C, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank B, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank A, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank EX, dentro dos limites desta árvore.]=],
                },
            },
            {
                nome = [=[Mestre dos ninhos]=],
                descricao = [=[classe daqueles que querem focar seu estilo na criação de criaturas tipo 'Bestas']=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Criaturas em sua posse se desenvolvem e reproduzem em metade do tempo natural.]=],
                    [=[As criaturas que você cria geram para você o dobro de espólios que normalmente gerariam.]=],
                    [=[Você pode dar ordens as criaturas em seu criadouro mesmo que não estejam domadas.]=],
                    [=[Você pode invocar as criaturas do seu viveiro para lhe auxiliar em combate.]=],
                    [=[Ganhe uma habilidade de classe rank C, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank B, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank A, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank EX, dentro dos limites desta árvore.]=],
                },
            },
        },
    },
    {
        nome = [=[Duelista]=],
        subclasses = {
            {
                nome = [=[Combatente crítico]=],
                descricao = [=[classe para os que desejam transformar a mecânica de acerto crítico em mais benefícios em seus golpes de briga.]=],
                nota = [=[]=],
                totalNiveis = 5,
                niveis = {
                    [=[Dobre o dano do golpe caso o resultado do teste de acerto seja um crítico positivo.]=],
                    [=[Adicione 1 em suas defesas até o final do combate para cada acerto crítico que realizar em um ataque.]=],
                    [=[Ganhe uma ação padrão após acertar seu oponente com um acerto crítico, devendo gastá-la na hora.]=],
                    [=[Você se torna imune ao efeito "crítico negativo" quando tirar o resultado "1" em dados ofensivos.]=],
                    [=[Você passa a tirar crítico positivo quando tira 19 e 20 em dados ofensivos.]=],
                },
            },
            {
                nome = [=[Punhos de aço]=],
                descricao = [=[para aqueles que querem focar seu estilo em destruir os inimigos com a força de seus punhos.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Suas mãos se tornam imunes a qualquer dano de acerto específico, e não sofre ferimentos em tentativa de golpes em criaturas ou construções endurecidas.]=],
                    [=[Seus golpes com as mãos se tornam a distância, acertando inimigos até a 5 metros de você.]=],
                    [=[Uma vez por turno, ao acertar um golpe com a mão em um alvo, ganha direito de tentar acertar outro golpe com a mão em outro alvo no seu alcance.]=],
                    [=[Você passa a conseguir imbuir seus punhos com sua afinidade elemental, e tornar seus golpes elementais.]=],
                    [=[Ganhe uma habilidade de classe rank C, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank B, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank A, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank EX, dentro dos limites desta árvore.]=],
                },
            },
            {
                nome = [=[Passos de vento]=],
                descricao = [=[para aqueles que querem focar seu estilo em destruir os inimigos com a agilidade de seus chutes.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Seus pés se tornam imunes a qualquer dano de acerto específico, e não sofre ferimentos em tentativa de golpes em criaturas ou construções endurecidas.]=],
                    [=[Seu deslocamento padrão e de corrida passivamente dobram.]=],
                    [=[Uma vez por turno, ao acertar um golpe com seu pé em um alvo, ganha direito de tentar acertar outro golpe em outro alvo no seu alcance.]=],
                    [=[Você adquire uma agilidade natural em que te torna imune a ataques de oportunidade, esquivando-se naturalmente.]=],
                    [=[Ganhe uma habilidade de classe rank C, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank B, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank A, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank EX, dentro dos limites desta árvore.]=],
                },
            },
        },
    },
    {
        nome = [=[Espadachim]=],
        subclasses = {
            {
                nome = [=[Samurai]=],
                descricao = [=[Para os espadachins que seguem um código de honra e disciplina, tornando-se guerreiros letais e estratégicos.]=],
                nota = [=[]=],
                totalNiveis = 5,
                niveis = {
                    [=[Uma vez durante um combate, após sacar sua Katana, você pode escolher ignorar a CA de bloqueio do alvo, isto não se aplica a habilidades]=],
                    [=[Sempre que realizar um ataque, você pode sacrificar sua movimentação para ganhar +3 no teste de acerto.]=],
                    [=[Uma vez por combate, você pode aumentar seu passo de dano.]=],
                    [=[Você ganha +3 em suas defesas mentais e empáticas.]=],
                    [=[Você pode gastar uma ação bônus para ativar um estado de concentração absoluta no turno atual, aumentando sua margem de crítico em 3.]=],
                },
            },
            {
                nome = [=[Ninja]=],
                descricao = [=[Para os espadachins furtivos que preferem velocidade, precisão e ataques surpresa.]=],
                nota = [=[]=],
                totalNiveis = 5,
                niveis = {
                    [=[Você ganha +2 em testes de furtividade e ao executar um ataque surpresa bem sucedido aplica **1d8** de dano adicional]=],
                    [=[Seu primeiro ataque em combate, caso seja feito em furtividade e acerte, causa dano dobrado.]=],
                    [=[Você recebe uma ação de movimento extra para se mover depois de um ataque corpo a corpo.]=],
                    [=[Uma vez por turno pode desaparecer temporariamente após um ataque bem-sucedido, tornando-se invisível até o início do seu próximo turno.]=],
                    [=[Você pode se mover através das sombras e ignorar obstáculos não mágicos enquanto estiver oculto.]=],
                },
            },
            {
                nome = [=[Mestre das Lâminas]=],
                descricao = [=[Para os espadachins que buscam a perfeição absoluta no uso de qualquer tipo de lâmina.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Você ignora 1 ponto de requisito de atributo por armas de duas mãos e adiciona +1 dado de dano de ataques corpo a corpo com elas.]=],
                    [=[Sempre que desferir três ataques consecutivos sem errar, você pode realizar um quarto ataque gratuitamente.]=],
                    [=[Seu crítico positivo agora acontece com 19 e 20 nos dados ofensivos em ataques armados.]=],
                    [=[Você pode equipar duas lâminas simultaneamente, e quando acertar um golpe com uma, você pode rolar um ataque com a outra aplicando 30% do primeiro dano.]=],
                    [=[Ganhe uma habilidade de classe rank C, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank B, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank A, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank EX, dentro dos limites desta árvore.]=],
                },
            },
        },
    },
    {
        nome = [=[Guerreiro]=],
        subclasses = {
            {
                nome = [=[Combatente crítico]=],
                descricao = [=[para os guerreiros que desejam transformar a mecânica de acerto crítico em mais benefícios com suas armas corpo-a-corpo.]=],
                nota = [=[]=],
                totalNiveis = 5,
                niveis = {
                    [=[Dobre o dano do golpe caso o resultado do teste de acerto seja um crítico positivo.]=],
                    [=[Adicione 1 nas suas Defesas até o final do combate para cada acerto crítico que realizar em um ataque.]=],
                    [=[Ganhe uma ação padrão após acertar seu oponente com um acerto crítico, devendo gastá-la na hora.]=],
                    [=[Você se torna imune ao efeito "crítico negativo" quando tirar o resultado "1" em dados ofensivos.]=],
                    [=[Você passa a tirar crítico positivo quando tira 19 e 20 em dados ofensivos.]=],
                },
            },
            {
                nome = [=[Lâmina elemental]=],
                descricao = [=[classe dos guerreiros que querem aproveitar a força dos elementos em suas armas para combater.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Você pode tornar todos os seus golpes elementais, vinculados a sua afinidade natural, sem gastar ações para isto.]=],
                    [=[Adicione 1d6 de dano da sua afinidade elemental em todos os seus golpes.]=],
                    [=[Uma vez por estação você pode expor sua arma ao seu elemento natural e recuperar 1 de durabilidade.]=],
                    [=[Você passa a conseguir imbuir suas armas com um segundo elemento a sua escolha, além da sua afinidade.]=],
                    [=[Ganhe uma habilidade de classe rank C, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank B, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank A, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank EX, dentro dos limites desta árvore.]=],
                },
            },
            {
                nome = [=[Inabalável]=],
                descricao = [=[classe daqueles que desejam se especializar em defesa e na capacidade de receber golpes e continuarem de pé.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Adicione +2 em suas defesas sempre que usar [Armadura ou Vestimenta protetora] + Escudo.]=],
                    [=[Quando um oponente tirar crítico negativo para lhe atacar, você refletirá passivamente sua (Defesa "Aparar"/2) como dano no mesmo.]=],
                    [=[Os escudos e armaduras equipados por você nunca se quebrarão em combate, ficando no máximo com 1 de Durabilidade.]=],
                    [=[Você é imune aos efeitos negativos atordoado, caído, exausto e paralisado, quando em combate.]=],
                    [=[Ganhe uma habilidade de classe rank C, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank B, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank A, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank EX, dentro dos limites desta árvore.]=],
                },
            },
        },
    },
    {
        nome = [=[Ladino]=],
        subclasses = {
            {
                nome = [=[Saqueador]=],
                descricao = [=[para os que desejam se tornar grandes larápios, realizando grandes roubos e furtos.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Você consegue abrir fechaduras e cadeados com grampos improvisados, sem e necessidade de kits de roubo.]=],
                    [=[Sempre que você tirar crítico, você rola um dado para roubar aleatoriamente um item que está com o inimigo em seus bolsos, saque rápido, consumíveis ou mochila.]=],
                    [=[Seu deslocamento é dobrado enquanto você estiver furtivo.]=],
                    [=[Você é capaz de encontrar o mercado negro em qualquer local que você esteje - desde que exista.]=],
                    [=[Ganhe uma habilidade de classe rank C, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank B, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank A, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank EX, dentro dos limites desta árvore.]=],
                },
            },
            {
                nome = [=[Sicário]=],
                descricao = [=[classe dos que querem seguir como grandes assassinos e executores, transformando o ato de matar em uma arte refinada.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Você não precisa rolar testes para estudar, durante um período, o hábito e a rotina dos seus futuros alvos.]=],
                    [=[Ao observar um alvo por 1 minuto você identifica sua idade estimada, classe, rank, atributo mais forte e se tem mana.]=],
                    [=[Receba +3 em testes de furtividade quando está em uma tarefa de assassinato.]=],
                    [=[Seus ataques surpresa aplicam o triplo do dano no alvo, ao invés do dobro. Este efeito não se acumula com outras bonificações relacionadas a furtividade.]=],
                    [=[Ganhe uma habilidade de classe rank C, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank B, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank A, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank EX, dentro dos limites desta árvore.]=],
                },
            },
            {
                nome = [=[Malandro]=],
                descricao = [=[para os personagens que desejam fazer da sua capacidade de enganar e seduzir um estilo de vida.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Uma vez por quinzena você automaticamente é informado dos principais boatos e fofocas do local onde está.]=],
                    [=[Receba vantagem em quaisquer testes envolvendo: jogos de azar, bebedeira, consumo de entorpecentes ou de natureza sexual.]=],
                    [=[Você tem direito a possuir uma gangue com 3 vagabundos, e a cada ponto de manipulação ganha um membro adicional; Esta gangue serve a você.]=],
                    [=[Suas operações ilegais lhe darão 50% mais lucro que o esperado.]=],
                    [=[Ganhe uma habilidade de classe rank C, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank B, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank A, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank EX, dentro dos limites desta árvore.]=],
                },
            },
        },
    },
    {
        nome = [=[Senescal]=],
        subclasses = {
            {
                nome = [=[Magnata]=],
                descricao = [=[classe dos que querem focar sua gameplay no enriquecimento através de grandes impérios econômicos.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Negócios legais administrados por você dão 50% mais lucro que o esperado.]=],
                    [=[Você consegue estimar o valor aproximado de qualquer mercadoria ou serviço sem precisar de teste.]=],
                    [=[Diminua em 1 a dificuldade de testes sociais contra pessoas mais pobres que você para cada Aureu que você gastar.]=],
                    [=[No início de cada ano o dinheiro que você possuí na ficha rende 10% automaticamente.]=],
                    [=[Ganhe uma habilidade de classe rank C, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank B, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank A, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank EX, dentro dos limites desta árvore.]=],
                },
            },
            {
                nome = [=[Embaixador]=],
                descricao = [=[para os personagens focados na arte da diplomacia e das negociações sem abrir mão da etiqueta e elegância.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Você não precisa rolar testes pra compreender a etiqueta e os costumes principais de qualquer corte nobre.]=],
                    [=[Uma vez por estação você pode pedir um favor a um aliado da corte em que você está inserido.]=],
                    [=[Você pode usar as pessoas que seduzir, intimidar ou contratar para espionar na corte em seu nome.]=],
                    [=[Você é imune aos efeitos amedrontado, enfurecido e seduzido.]=],
                    [=[Ganhe uma habilidade de classe rank C, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank B, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank A, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank EX, dentro dos limites desta árvore.]=],
                },
            },
            {
                nome = [=[Castelão]=],
                descricao = [=[classe daqueles que buscam focar sua gameplay na administração e liderança, seja de castelos, casas ou organizações.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Casas, grupos e organizações administradas por você tem um custo 50% menor.]=],
                    [=[Receba vantagem em testes sociais contra qualquer pessoa que esteja abaixo de você na organização.]=],
                    [=[Obras e planos orquestrados por você serão concluídos na metade do tempo.]=],
                    [=[Você recebe +4 em testes para levantar a moral de qualquer forma dos seus comandados.]=],
                    [=[Você recebe vantagem em testes que envolvam administração e liderança, você é imunte ao status hipnotizado.]=],
                    [=[Ganhe uma habilidade de classe rank B, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank A, dentro dos limites desta árvore.]=],
                    [=[Ganhe uma habilidade de classe rank EX, dentro dos limites desta árvore.]=],
                },
            },
        },
    },
    {
        nome = [=[Arcanista]=],
        subclasses = {
            {
                nome = [=[Alquimista]=],
                descricao = [=[classe daqueles que buscam utilizar a força de sua Aura/Mana com ingredientes para criar poções e unguentos com efeitos poderosos.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Você consegue criar poções e unguentos alquímicos sem a necessidade de utilizar um Kit de Alquimia.]=],
                    [=[Sempre que você falhar no teste para criar uma poção, você poderá rerolar ele mais uma vez, prevalecendo o segundo resultado.]=],
                    [=[Você consegue fabricar suas poções/criar receitas em um tempo 30% menor que o definido.]=],
                    [=[Ao realizar uma produção de poções, você sempre produz um lote a mais que o definido na receita.]=],
                    [=[Você pode sacrificar uma poção e gastar 7 dias de trabalho para descobrir a receita da mesma, se passar em um teste de Alquimia meta 25 a 30.]=],
                    [=[Você não possui limite de consumo de poções.]=],
                    [=[Todas as poções criadas e fabricadas são mais poderosas: +1 dado; +1 de efeito positivo; -1 de efeito negativo; +1 turno de duração ou +24 horas fora de combate]=],
                    [=[Se torna capaz de produzir Elixires: que combinam três poções com efeitos distintos em uma única poção.]=],
                },
            },
            {
                nome = [=[Especialista arcano]=],
                descricao = [=[classe que representa os Magos ou Bruxas que se focam em uma tradição mágica para elevar suas capacidades na mesma aos limites.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Escolha uma tradição mágica para que a mesma se torne seu foco de estudos e práticas, ganhando um feitiço de Rank D gratuitamente.]=],
                    [=[Os feitiços da tradição mágica escolhida custam -20% de Mana ou Prana para serem executados.]=],
                    [=[Sempre que você tirar 1 em um teste da especialidade escolhida, ele será considerado uma falha simples e não uma crítica.]=],
                    [=[Sempre que você tirar 19 em um teste da especialidade escolhida, ele será considerado um acerto crítico.]=],
                    [=[Receba um feitiço de rank C gratuitamente da tradição mágica escolhida.]=],
                    [=[Receba um feitiço de rank B gratuitamente da tradição mágica escolhida.]=],
                    [=[Receba um feitiço de rank A gratuitamente da tradição mágica escolhida.]=],
                    [=[Receba um feitiço de rank EX gratuitamente da tradição mágica escolhida.]=],
                },
            },
            {
                nome = [=[Mago de batalha]=],
                descricao = [=[classe voltada para os portadores do coração de mana que utilizam sua energia mágica para se tornarem grandes combatentes]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Quando um mago de batalha utiliza armas invocadas/feitas de mana, o teste de manuseio da arma é feito usando sua perícia mágica ao invés das perícias da arma.]=],
                    [=[Uma vez por combate o mago de batalha pode usar o poder de seu coração de mana para recuperar 2 pontos de vida para cada ponto de mana sacrificado.]=],
                    [=[Sempre que tirar um crítico positivo contra um oponente em combate, você recupera 20% de sua mana total.]=],
                    [=[Quando estiver lutando em desvantagem numérica, você ganha 1 Ação Padrão e 1 Ação Bônus adicionais.]=],
                    [=[Receba a habilidade "pacto da lâmina" permitindo que qualquer arma portado por você, seja tratada como uma arma de mana.]=],
                    [=[Quando estiver usando uma armadura mágica, você absorverá uma quantidade de dano equivalente ao seu [Bônus de Proficiência + Rank] em cada golpe sofrido.]=],
                    [=[Você fica imune a qualquer tipo de silenciamento mágico quando estiver em combate.]=],
                    [=[Receba +1 em todas suas Defesas para cada aliado que estiver fortalecido por um feitiço seu durante uma batalha, ao máximo de +10.]=],
                },
            },
        },
    },
    {
        nome = [=[Devoto]=],
        subclasses = {
            {
                nome = [=[Estudioso]=],
                descricao = [=[classe voltada para aqueles que canalizam seus esforços no estudo dos deuses e do oculto, para a produção de novos conhecimentos e teorias.]=],
                nota = [=[]=],
                totalNiveis = 8,
                niveis = {
                    [=[Você sabe ler e escrever sem a necessidade da perícia 'Acadêmicos', e aprende qualquer idioma em metade do tempo padrão.]=],
                    [=[Qualquer rolagem envolvendo uma pesquisa é feita com vantagem, mesmo em temas que você não conhece.]=],
                    [=[Sempre que você tirar 1 em um teste de pesquisa, análise de mapas, leitura de texto ou runas, ele será considerado uma falha simples e não uma crítica.]=],
                    [=[Dobre seu bônus de proficiência nas rolagens de qualquer habilidade ou feitiço que use como acerto os atributos Inteligência ou Sabedoria.]=],
                    [=[Sempre que você tirar 19 em um teste de pesquisa, análise de mapas, leitura de texto ou runas, ele será considerado um acerto crítico.]=],
                    [=[Se torna capaz de produzir e copiar pergaminhos de feitiços ou habilidades, mesmo as que você não possuí, apenas recebendo um pouco da Aura ou Mana de um portador.]=],
                    [=[Você consegue restaurar qualquer pergaminho ou artefato antigo até seu estado original com efeitos originais.]=],
                    [=[Você consegue executar feitiços e habilidades usando pergaminhos indefinidamente, sem consumi-los no primeiro uso.]=],
                },
            },
            {
                nome = [=[Sacerdote]=],
                descricao = [=[classe daqueles que focam suas vidas para serem servos dos deuses e conselheiros espirituais no mundo dos vivos.]=],
                nota = [=[Personagens com a qualidade "Dom Oracular" podem, uma vez por estação, fazer um ritual pedindo orientação ao deus para ajudá-lo a tomar a melhor decisão envolvendo uma situação, missão etc.]=],
                totalNiveis = 8,
                niveis = {
                    [=[Escolha uma divindade para ser o seu patrono religioso, você começará com 1 ponto de favor com a mesma gratuitamente, e receberá favores advindos dela com maior facilidade.]=],
                    [=[Você rola com vantagem qualquer teste de religião, ocultismo ou acadêmicos envolvendo a divindade escolhida ou os aspectos/elementos envolvidos.]=],
                    [=[Quando estiver em um templo da divindade, ou na casa de um seguidor, você recuperará Aura/Mana e Vida com o dobro do ritmo comum e receberá +2 em quaisquer testes sociais.]=],
                    [=[Escolha uma divindade primordial, você se tornará capaz de obter favores da divindade escolhida e se tornará um Arauto Divino, nome dado àqueles que falam em nome dos primordiais.]=],
                    [=[Você ganha gratuitamente um Artefato Divino Aprimorado, ou aprimore o seu caso ele já exista.]=],
                    [=[Você recebe um bônus de +4 para resistir a efeitos negativos.]=],
                    [=[Receba imunidade a quaisquer danos do elemento [Sagrado], com exceção de quando o dano vem das duas divindades que você segue.]=],
                    [=[Receba gratuitamente a habilidade única Ascensão Divina, que lhe confere status de uma divindade menor, temporariamente.]=],
                },
            },
            {
                nome = [=[Mártir]=],
                descricao = [=[classe voltada para os guerreiros que focam suas capacidades de combate em prol de seus deuses e seus respectivos devotos, entregando suas vidas a grande guerra do Círculo da Mãe contra a Fé do Pai.]=],
                nota = [=[Personagens com a qualidade "Encarnação Divina", emanam passivamente +1 de resistência a medo e dor a aliados próximos em até 10m. Obs.: os efeitos de um Mártir jamais podem se aplicar a outro da mesma subclasse; Esta ressalva não se aplica caso um dos dois tenha a qualidade 'Encarnação Divina']=],
                totalNiveis = 8,
                niveis = {
                    [=[Você ganha uma "Ação de Reação" na ficha; A partir do nível 10 serão duas, que só podem ser usadas para receber um dano que acertaria um aliado a até 15 metros de você.]=],
                    [=[Sempre que estiver com 30% ou menos de sua vida, todos os seus golpes aplicam 1d6 de dano sagrado adicional, dobrando caso esteja abaixo de 10%.]=],
                    [=[Uma vez por combate, ao receber um dano que te mataria, metade deste é convertido em uma Cura que recupera sua vida.]=],
                    [=[Cada vez que você curar, aplicar um escudo ou levar dano por um aliado, você recebe +1 em todas as suas defesas; Acumula somente ao máximo de (1 + Nível de classe).]=],
                    [=[Receba a habilidade Última Prece, que lhe permite fazer uma oração para um aliado caído, inconsciente ou morto a até 2 turnos, e transferir metade de sua vida atual para ele; levantando-o em seguida.]=],
                    [=[Você pode absorver efeitos de controle mental e sociais que seus aliados estão submetidos, e tentar resistir aos mesmos com vantagem.]=],
                    [=[Ao ficar com status Caído ou Inconsciente, seus aliados recebem o dobro de Bônus de Proficiência e recuperam 25% da vida, aura/mana máximas.]=],
                    [=[Receba o título de Escudo da Mãe, recebendo a passiva única Coração da Mãe, que lhe confere pontos de atributos, vida e aura/mana permanentemente.]=],
                },
            },
        },
    },
}

function CatalogoClasses.pontosNoNivel(nivel)
    nivel = tonumber(nivel) or 1
    local total = 0
    for _, marco in ipairs(CatalogoClasses.NIVEIS_COM_PONTO) do
        if nivel >= marco then total = total + 1 end
    end
    return total
end

function CatalogoClasses.buscarClasse(nome)
    nome = tostring(nome or "")
    for _, c in ipairs(CatalogoClasses.classes) do
        if c.nome == nome then return c end
    end
    return nil
end

-- O nome "Combatente critico" se repete em tres classes com textos
-- levemente diferentes, entao o nome da classe e obrigatorio.
function CatalogoClasses.buscarSubclasse(nomeClasse, nomeSub)
    local c = CatalogoClasses.buscarClasse(nomeClasse)
    if c == nil then return nil end
    nomeSub = tostring(nomeSub or "")
    for _, s in ipairs(c.subclasses) do
        if s.nome == nomeSub then return s, c end
    end
    return nil
end

-- Teto de nivel DESTA subclasse (5 ou 8, conforme a arvore).
function CatalogoClasses.tetoDaSubclasse(nomeClasse, nomeSub)
    local s = CatalogoClasses.buscarSubclasse(nomeClasse, nomeSub)
    if s == nil then return CatalogoClasses.MAX_NIVEL_SUBCLASSE end
    return s.totalNiveis
end

function CatalogoClasses.textoNivel(sub, indice)
    if sub == nil then return "" end
    return sub.niveis[indice] or ""
end

return CatalogoClasses

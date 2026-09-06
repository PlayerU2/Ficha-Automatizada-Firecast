-- catalogoPoderes.lua
-- Gerado do .bib (secao Poderes, "Lista de poderes").
-- 49 poderes: 28 ativos, 21 passivos. Cada um com progressao de 5 niveis.
--
-- 48 vem da lista do livro. O 49o e "Hemocinese", que o livro promete nas
-- racas Orcs e Vampiros e nunca coloca na lista - ver o comentario no
-- proprio item. Todo item com "inferido = true" nao saiu do livro.
--
-- CAMPO "atributo": preenchido apenas nos 7 poderes passivos que
-- bonificam um atributo (um por atributo do sistema). Serve a regra
-- "maximo de dois poderes que bonifiquem atributos".
--
-- ATIVOS: cada nivel destrava um rank de habilidade -
--   1 -> E/D | 2 -> C | 3 -> B | 4 -> A | 5 -> EX
-- PASSIVOS: cada nivel da um bonus constante, descrito em progressao.
--
-- NOTA: o .bib escreve o Tipo ora no masculino ora no feminino
-- ("Lideranca absoluta" usa "Tipo: ativa"). Normalizado aqui.

local CatalogoPoderes = {}

-- Rank de habilidade destravado por nivel de poder ATIVO.
CatalogoPoderes.rankPorNivel = { "E/D", "C", "B", "A", "EX" }

CatalogoPoderes.itens = {
  {
    nome = "Artesão épico",
    tipo = "passivo",
    atributo = nil,
    descricao = "sua capacidade natural na análise, reparo e criação de itens é maior do que o comum, enquanto alguns passam anos estudando, você sempre teve um talento natural. Você deve escolher duas das perícias a seguir para receber os bônus desta passiva: Alfaiataria (Destreza), Forja (Destreza), Mecânica (Inteligência), Encantamentos (Carisma)",
    progressao = {
      "+2 em todos os seus testes com as perícias escolhidas",
      "+2 em todos os seus testes com as perícias escolhidas",
      "+2 em todos os seus testes com as perícias escolhidas",
      "+2 em todos os seus testes com as perícias escolhidas",
      "+2 em todos os seus testes com as perícias escolhidas",
    },
  },
  {
    nome = "Atirador épico",
    tipo = "passivo",
    atributo = nil,
    descricao = "você tem uma habilidade sobrenatural em lidar com armas a distância, como arcos, bestas, armas de arremesso e armas-de-fogo. Você deve escolher duas das perícias a seguir para receber os bônus com elas a medida que a progressão do poder aumenta: Arcos, Arremesso, Bestas, Armas de fogo leves, Armas de fogo pesadas",
    progressao = {
      "+2 em todos os seus testes com as perícias escolhidas",
      "+2 em todos os seus testes com as perícias escolhidas",
      "+2 em todos os seus testes com as perícias escolhidas",
      "+2 em todos os seus testes com as perícias escolhidas",
      "+2 em todos os seus testes com as perícias escolhidas",
    },
  },
  {
    nome = "Audiocinese",
    tipo = "ativo",
    atributo = nil,
    descricao = "o semideus é capaz de controlar as ondas sonoras e a música em um nível detalhado, podendo utilizá-las para se fortalecer, aumentar sua velocidade ou para realizar ataques ou criar efeitos especiais únicos. A audiocinese não se trata da manipulação do som como uma ilusão, mas o controle das ondas sonoras em si para diversos efeitos como imitar, intensificar, silenciar, distorcer bem como usar a própria energia mística para absorver ou expandir o som",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX",
    },
  },
  {
    nome = "Carisma sobrenatural",
    tipo = "passivo",
    atributo = "Carisma",
    descricao = "você possuí uma capacidade de se comunicar e expressar além do normal, seus discursos são mais emocionantes, seu talento para discursos muito maiores. Este poder não só torna suas palavras mais impactantes, mas os semideuses que o possuem são sempre mais belos que os outros",
    progressao = {
      "+1 no Atributo Carisma; Receba a qualidade \"Beleza Sobrenatural\"",
      "+1 no Atributo Carisma; +1 no cálculo \"Defesa empática\"",
      "+1 no Atributo Carisma; É capaz de realizar encantamentos de forma silenciosa",
      "+1 no Atributo Carisma; Você recebe vantagem nos testes envolvendo este atributo",
      "+2 no Atributo Carisma; Imunidade a seduções de qualquer natureza",
    },
  },
  {
    nome = "Cavaleiro épico",
    tipo = "passivo",
    atributo = nil,
    descricao = "Você não sabe como, mas possui grande conhecimento e habilidade natural em condução. Você deve escolher duas das perícias a seguir para receber os bônus com elas a medida que a progressão do poder aumenta: Condução: montarias aéreas, Condução: montarias navais e Condução: montarias terrestres",
    progressao = {
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em CD enquanto em cima de uma montaria do tipo selecionado",
      "+2 em rolagens de ataque enquanto em cima da montaria do tipo selecionado",
      "+2 em todos os seus testes com as duas perícias escolhidas",
    },
  },
  {
    nome = "Charme sobrenatural",
    tipo = "passivo",
    atributo = nil,
    descricao = "sua habilidade de comunicar-se de forma persuasiva é incomparável, capaz de convencer e influenciar os outros com facilidade e sutileza em diversas situações diferentes, bem como discursos e negociações. Você deve escolher duas das perícias a seguir para receber os bônus com elas a medida que a progressão do poder aumenta: Persuasão, Etiqueta e Negociar",
    progressao = {
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
    },
  },
  {
    nome = "Conhecimento enciclopédico",
    tipo = "passivo",
    atributo = nil,
    descricao = "você tem uma capacidade extraordinária de compreender e produzir conhecimentos teóricos de natureza mundana, encontrá-los em bibliotecas, copiá-los, fazer resumos e até compreender mesmo o mais difícil dos conceitos é mais fácil do que para os outros. Você deve escolher duas das perícias a seguir para receber os bônus com elas a medida que a progressão do poder aumenta: Acadêmicos, Estratégia, Natureza, Heráldica ou Alquimia",
    progressao = {
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
    },
  },
  {
    nome = "Constituição sobrenatural",
    tipo = "passivo",
    atributo = "Constituição",
    descricao = "este poder lhe garante um corpo mais resistente do que os outros da sua raça, é preciso causar mais danos para derrubá-lo além de conseguir suportar prolongados esforços, como dias correndo sem parar ou treinos instensos",
    progressao = {
      "+1 no Atributo Constituição; Receba a qualidade 'Vigor expandido(2)' gratuitamente",
      "+1 no Atributo Constituição; Suas rolagens de vida por nível sempre serão o valor máximo do dado",
      "+1 no Atributo Constituição; Você recebe +1 de vida adicional por nível de personagem (Cumulativo com o Nv. 1)",
      "+1 no Atributo Constituição; Você recebe outra vantagem nos testes de resistência deste atributo",
      "+2 no Atributo Constituição; Você recebe +3 de vida adicional por nível de personagem (Cumulativo com o Nv. 1 e 3)",
    },
  },
  {
    nome = "Criação sobrenatural",
    tipo = "ativo",
    atributo = nil,
    descricao = "O poder daqueles tocado pelos deuses ferreiros e artesãos do mundo. Garante aos usuários a capacidade de manufaturar, compreender e reparar objetos de natureza mística e não mística. Um artesão sobrenatural consegue imbuir sua centelha em um objeto para dar-lhe efeitos especiais de forma permanente, transformando um conjunto de materiais simples em artefatos poderosos e especiais para os mais diversos fins",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D; Habilita o uso de encantamentos de forja de classe I",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B; Habilita o uso de encantamentos de forja de classe II",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX; Habilita o uso de encantamentos de forja de classe III",
    },
  },
  {
    nome = "Cura",
    tipo = "ativo",
    atributo = nil,
    descricao = "você possui domínio sobre o dom divino da cura. Não se trata só de curar ferimentos, mas diagnosticar doenças existentes, gerar antídotos para venenos e até realizar a ressuscitação daqueles que caíram em combate ou por doenças. Diferentemente daqueles que estudam durante anos para se tornarem curandeiros, os usuários deste poder conseguem converter sua vontade e aura em oportunidades para curar aqueles a sua volta sem dificuldade",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX",
    },
  },
  {
    nome = "Destreza sobrenatural",
    tipo = "passivo",
    atributo = "Destreza",
    descricao = "você tem pleno controle sobre seu corpo, tem um equilíbrio maior do que os outros, seus movimentos para realizar determinadas tarefas podem ser tanto mais sutis, quanto mais ágeis para sua realização. Este poder amplifica seu talento natural com o atributo",
    progressao = {
      "+1 no Atributo Destreza; Você recebe uma reação extra",
      "+1 no Atributo Destreza; +1 no cálculo \"Defesa - Esquiva\"",
      "+1 no Atributo Destreza; +1 Ação Bônus por Turno",
      "+1 no Atributo Destreza; Você recebe vantagem nos testes envolvendo este atributo",
      "+2 no Atributo Destreza; +1 Ação padrão por Turno",
    },
  },
  {
    nome = "Duelista épico",
    tipo = "passivo",
    atributo = nil,
    descricao = "este poder lhe dá uma habilidade natural em brigar utilizando golpes corpo-a-corpo desarmados, bem como intimidar seus oponentes através do seu físico e técnicas defensivas. Você deve escolher duas das perícias a seguir para receber os bônus com elas a medida que a progressão do poder aumenta: Aparar, Atletismo e Briga",
    progressao = {
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
    },
  },
  {
    nome = "Escudo psíquico",
    tipo = "passivo",
    atributo = nil,
    descricao = "sua capacidade de autocontrole sempre foi excepcional graças a este poder, isto significa que enquanto outros facilmente são pegos em manipulações/ofensas mentais e emocionais, existe um tipo específico que você sempre foi mais resistente. Escolha uma das defesas a seguir para receber os bônus na mesma a medida que a progressão do poder aumenta: Defesa mental (DM) e Defesa social (DS)",
    progressao = {
      "+1 na defesa escolhida",
      "+1 na defesa escolhida",
      "+1 na defesa escolhida; Você ganha resistência a danos do tipo escolhido",
      "+1 na defesa escolhida",
      "+2 na defesa escolhida; Você se torna imune a danos do tipo escolhido que sejam oriundos de golpes com menor rank que o seu",
    },
  },
  {
    nome = "Fator de aura regenerativa",
    tipo = "passivo",
    atributo = nil,
    descricao = "você possui capacidades sobrenaturais que garantem que sua aura esteja sempre em recuperação, não somente entre as mecânicas de descanso. Enquanto as criaturas recuperam uma parte desta energia a cada conjunto de horas, os usuários deste poder regeneram constantemente",
    progressao = {
      "Recupera 5% de sua aura total por hora; Regenere 2 de aura por turno em combate",
      "Recupera 10% de sua aura total por hora; Regenere 3 de aura por turno em combate",
      "Recupera 15% de sua aura total por hora; Regenere 5 de aura por turno em combate",
      "Recupera 20% de sua aura total por hora; Regenere 7 de aura por turno em combate",
      "Recupera 25% de sua aura total por hora; Regenere 10 de aura por turno em combate",
    },
  },
  {
    nome = "Fator de cura regenerativo",
    tipo = "passivo",
    atributo = nil,
    descricao = "este poder lhe confere a capacidade de regenerar sua saúde constantemente, não somente entre as mecânicas de descanso. Enquanto criaturas recuperam sua vida enquanto estão descansando, ou em casos mais graves quando hospitalizadas, você está o tempo todo se regenerando",
    progressao = {
      "Recupera 5% da sua vida total por hora; Regenere 2 de vida por turno em combate",
      "Recupera 10% da sua vida total por hora; Regenere 3 de vida por turno em combate",
      "Recupera 15% da sua vida total por hora; Regenere 5 de vida por turno em combate",
      "Recupera 20% da sua vida total por hora; Regenere 7 de vida por turno em combate",
      "Recupera 25% da sua vida total por hora; Regenere 10 de vida por turno em combate",
    },
  },
  {
    nome = "Fitocinese",
    tipo = "ativo",
    atributo = nil,
    descricao = "permite criar, modelar, dissipar e manipular plantas, incluindo madeira, cipós, plantas, musgo e partes das plantas, como folhas, sementes, raízes, frutas e flores. O usuário pode fazer com que as plantas cresçam, se movam, ataquem ou até se levantem do solo e \"caminhem\", reviver plantas murchas ou mortas, além de demais aspectos como manipular coisas feitas de madeira",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX",
    },
  },
  {
    nome = "Força sobrenatural",
    tipo = "passivo",
    atributo = "Força",
    descricao = "este poder te garante uma força acima do que é natural para uma criatura mortal, lhe conferindo a capacidade de realizar feitos inacreditáveis, não só como dar grandes saltos ou socos poderosos, mas garantindo que sua aptidão neste atributo lhe confira benefícios especiais que outros não tem acesso",
    progressao = {
      "+1 no Atributo Força; Escolha uma perícia vinculada a este atributo e recebe-a gratuitamente",
      "+1 no Atributo Força; +1 no cálculo \"Defesa - Aparar\"",
      "+1 no Atributo Força; +1 Ação de Ataque Extra por Turno",
      "+1 no Atributo Força; Você recebe vantagem nos testes envolvendo este atributo",
      "+2 no Atributo Força; +1 Ação de Ataque Extra por Turno",
    },
  },
  {
    nome = "Guerreiro épico",
    tipo = "passivo",
    atributo = nil,
    descricao = "quando se trata de habilidades com armas brancas, você é verdadeiramente um Mestre das Lâminas, sua destreza e técnica são incomparáveis. Seus movimentos são uma dança mortal, combinando agilidade, precisão e velocidade de maneira fluida e letal, enquanto alguns demandam anos de treinamento, para você tais talentos são naturais. Você deve escolher duas das perícias a seguir para receber os bônus com elas a medida que a progressão do poder aumenta: Armas brancas: cortantes de uma mão, Armas brancas: cortantes de duas mãos, Armas brancas: perfurantes de uma mão, Armas brancas: perfurantes de duas mãos, Armas brancas: concussão de uma mão, Armas brancas: concussão de duas mãos",
    progressao = {
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
    },
  },
  {
    -- ------------------------------------------------------------------
    -- HEMOCINESE — NAO SAI DA LISTA DE PODERES DO LIVRO.
    --
    -- O livro cita o poder DUAS vezes, sempre como caracteristica racial, e
    -- nunca escreve a progressao dele:
    --
    --   Racas / Orcs:
    --     "[Hemocinese] receba o poder exclusivo 'Hemocinese' em sua ficha,
    --      comecando com 1 ponto no mesmo e recebendo upgrades automaticos
    --      nos niveis 5, 10, 15 e 20; Se voce ja tiver upado o poder, os
    --      pontos recebidos se convertem em pontos de poder comuns."
    --
    --   Racas / Vampiros:
    --     "[Hemocinese] receba o poder exclusivo 'Hemocinese', substituindo
    --      um poder ativo em sua ficha; Este poder pode coexistir com o poder
    --      'Magia'."
    --
    -- A DESCRICAO e a PROGRESSAO abaixo sao INFERIDAS do molde dos outros
    -- poderes "cinese" (Audiocinese, Fitocinese) e dos "Manipulacao de X",
    -- todos ativos com a mesma escada de ranks. Decisao alinhada em
    -- 21/08/2026; PENDENTE de o mestre escrever a progressao oficial.
    -- Quando ela chegar, troque este bloco e nada mais precisa mudar.
    -- ------------------------------------------------------------------
    nome = "Hemocinese",
    tipo = "ativo",
    atributo = nil,
    inferido = true,
    descricao = "poder exclusivo das linhagens que carregam o sangue como arma: permite pressentir, moldar, atrair e manipular o sangue — o próprio, o dos aliados e o dos inimigos. (Descrição INFERIDA do molde dos demais poderes 'cinese': o livro cita o poder nas raças Orcs e Vampiros mas não descreve seus níveis.)",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX",
    },
  },
  {
    nome = "Ilusão",
    tipo = "ativo",
    atributo = nil,
    descricao = "você é capaz de utilizar suas habilidades místicas para manipular a percepção dos sentidos dos outros seres, sejam eles humanos ou não, comuns ou seres/criaturas. A medida, que um semideus se torna mais poderoso nesta capacidade, passa a ter o poder de controlar mais sentidos e com mais influência de uma quantidade maior de alvos simultaneamente. É importante ressaltar que a ilusão não altera a realidade, somente a percepção dos outros da mesma",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX",
    },
  },
  {
    nome = "Indução do medo",
    tipo = "ativo",
    atributo = nil,
    descricao = "você tem a capacidade de pressentir, induzir, dissipar e manipular o sentimento do medo em outras criaturas. Esta capacidade única lhe garante usar a psiquê e os traumas das pessoas em seu entorno como suas ferramentas e armas, os indutores do medo podem materializar e até imbuir tal sentimento em objetos e criaturas para transformá-las e corrompê-las ou protegê-las de seus grandes temores",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX",
    },
  },
  {
    nome = "Inteligência sobrenatural",
    tipo = "passivo",
    atributo = "Inteligência",
    descricao = "o semideus possui um intelecto superior ao dos outros seres, sua memória é mais afiada e a capacidade de seu corpo de produzir a energia vital usada para os poderes místicos é naturalmente maior. Os usuários deste poder são grandes estrategistas e acadêmicos, conseguindo usar suas mentes superiores como se fossem verdadeiras armas",
    progressao = {
      "+1 no Atributo Inteligência; Receba a qualidade 'Genialidade' gratuitamente",
      "+1 no Atributo Inteligência; Suas rolagens de aura/mana por nível sempre serão o valor máximo do dado",
      "+1 no Atributo Inteligência; Receba uma perícia deste atributo gratuitamente",
      "+1 no Atributo Inteligência; Você recebe vantagem nos testes envolvendo este atributo",
      "+2 no Atributo Inteligência; Receba uma perícia deste atributo gratuitamente",
    },
  },
  {
    nome = "Intuição artística",
    tipo = "passivo",
    atributo = nil,
    descricao = "você tem uma afinidade especial com as artes, encontrando beleza e significado nos detalhes mais sutis do mundo ao seu redor, enquanto algumas pessoas precisam de anos de estudo e prática para se destacarem com as artes, você desenvolveu essas capacidades naturalmente. Você deve escolher duas das perícias a seguir para receber os bônus com elas a medida que a progressão do poder aumenta: Atuação, Performance e Sedução",
    progressao = {
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
    },
  },
  {
    nome = "Ladinagem",
    tipo = "passivo",
    atributo = nil,
    descricao = "sua habilidade em furtividade é lendária, permitindo que você se mova silenciosamente e passe despercebido pelos sentidos mais aguçados. Cada passo é calculado, cada movimento é uma dança sutil com a escuridão. A prestidigitação também é sua arte, e suas mãos são mais hábeis do que os olhos podem captar. Você deve escolher duas das perícias a seguir para receber os bônus com elas a medida que a progressão do poder aumenta: Enganação, Furtividade e Prestidigitação",
    progressao = {
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
    },
  },
  {
    nome = "Liderança absoluta",
    tipo = "ativo",
    atributo = nil,
    descricao = "este poder concede ao usuário a capacidade de transformar a força de sua autoridade em poder para si próprio e os seus comandados. Um semideus com a Liderança Absoluta pode compartilhar as capacidades entre seus aliados, conceder as suas próprias aos outros ou tomar o poder dos comandados temporariamente para si, além de outros efeitos específicos envolvendo esta natureza",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX",
    },
  },
  {
    nome = "Magia",
    tipo = "ativo",
    atributo = nil,
    descricao = "garante a você a capacidade de compreender e manipular a energia primordial da Mana para produzir efeitos e fenômenos diversos. Enquanto as habilidades dos poderes garantem efeitos especializados, a magia permite aos seus usuários criarem feitiços de praticamente qualquer efeito com uma força mais simples. Não é necessário ser um semideus para ter magia, mas possuir o chamado 'Coração de Mana', que pode ser hereditário ou repassado através de um ritual",
    progressao = {
      "permite o aprendizado de feitiços de Rank E/D",
      "permite o aprendizado de feitiços de Rank C",
      "permite o aprendizado de feitiços de Rank B",
      "permite o aprendizado de feitiços de Rank A",
      "permite o aprendizado de feitiços de Rank EX",
    },
  },
  {
    nome = "Manipulação sobrenatural",
    tipo = "passivo",
    atributo = "Manipulação",
    descricao = "suas capacidades de se comunicar e expressar são claramente sobrenaturais, suas mentiras são mais convincentes, com você sempre demonstrando um talento natural para enganar, intimidar e seduzir. Essa sua habilidade não demandou treinamento, e você consegue manipular os outros sem precisar pensar ou planejar muito, como se sua mente estivesse o tempo todo trabalhando para exerces",
    progressao = {
      "+1 no atributo Manipulação; Escolha uma perícia deste atributo a sua escolha para ganhá-la de graça",
      "+1 no atributo Manipulação; +1 re-rolagem por narrativa em testes deste atributo",
      "+1 no atributo Manipulação; Seus efeitos de Invocação tem o dobro de duração para skills ou feitiços",
      "+1 no atributo Manipulação; Você recebe vantagem nos testes envolvendo este atributo",
      "+2 no atributo Manipulação; Receba resistência aos efeitos 'Enfurecido' e 'Seduzido'",
    },
  },
  {
    nome = "Manipulação da água",
    tipo = "ativo",
    atributo = nil,
    descricao = "O usuário pode criar, manipular, moldar, dissipar e imbuir o elemento água por completo, utilizando-o para criar os mais variados efeitos e fenômenos. As habilidades vinculadas a este elemento o permitem controlar a água em seu estado de vapor, mas não em seu estado de neve ou gelo, além de permitir interações específicas com criaturas vinculadas ao elemento água",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX",
    },
  },
  {
    nome = "Manipulação do amor",
    tipo = "ativo",
    atributo = nil,
    descricao = "se torna capaz de sentir e manipular completamente todos os aspectos do amor, tanto para si mesmo quanto para outras pessoas ou criaturas de forma geral, seja amplificando, diminuindo, causando e dissipando este sentimento. Também é possível canalizar este sentimento em energia física, ou em efeitos derivados diversos",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX",
    },
  },
  {
    nome = "Manipulação das armas",
    tipo = "ativo",
    atributo = nil,
    descricao = "os usuários deste poder se tornam capazes de manipular as propriedades das armas, modificá-las e controlá-las da forma como achar melhor. Esta capacidade se estende não somente as armas que o semideus porta, mas as portadas por terceiros, incluindo aliados e inimigos durante o combate",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX",
    },
  },
  {
    nome = "Manipulação de alimentos",
    tipo = "ativo",
    atributo = nil,
    descricao = "é o poder que garante aos seus usuários a habilidade de utilizar suas capacidades místicas em prol da culinária. Os semideuses e criaturas dotados deste poder se tornam capazes de realizar tarefas culinárias que demorariam horas de forma instantânea, podem dar efeitos mágicos a ingredientes, purificar alimentos, dar vida aos alimentos e afins",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX",
    },
  },
  {
    nome = "Manipulação do ar",
    tipo = "ativo",
    atributo = nil,
    descricao = "o usuário pode criar, manipular, moldar, dissipar e imbuir o elemento vento por completo, utilizando-o para criar os mais variados efeitos e fenômenos. As habilidades vinculadas a este elemento o permitem controlar o ar em qualquer estado gasoso, manipular a pressão atmosférica, além de permitir interações específicas com criaturas vinculadas ao vento",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX",
    },
  },
  {
    nome = "Manipulação do clima",
    tipo = "ativo",
    atributo = nil,
    descricao = "este poder lhe permite sentir, criar, modificar e manipular o clima, ou seja, os padrões meteorológicos, criando chuva, vento, granizo, raios, neve, gelo, névoas e mudanças de temperatura. Isso inclui a habilidade de gerar vários fenômenos naturais ou controlar a intensidade do clima de uma maneira densa em áreas concentradas ou mais amena em áreas maiores. Esta não é a manipulação de elementos, mas de um fenômeno em si",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX",
    },
  },
  {
    nome = "Manipulação da eletricidade",
    tipo = "ativo",
    atributo = nil,
    descricao = "o usuário pode criar, manipular, moldar, dissipar e imbuir ondas elétricas por completo, utilizando-as para criar os mais variados efeitos e fenômenos, seja canalizando o elemento por um objeto, construção, um alvo ou pelo seu próprio corpo. A abrangência deste poder também inclui trovões e ondas magnéticas, além de que passa a ser possível interações específicas com criaturas vinculadas ao elemento eletricidade",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX",
    },
  },
  {
    nome = "Manipulação do fogo",
    tipo = "ativo",
    atributo = nil,
    descricao = "permite criar, manipular, moldar, dissipar e imbuir o fogo por completo, utilizando-o para criar os mais variados efeitos e fenômenos. As habilidades vinculadas a este poder permitem o controle também do calor, do magma e de explosões, além de permitir interações específicas com criaturas vinculadas ao respectivo elemento",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX",
    },
  },
  {
    nome = "Manipulação do gelo",
    tipo = "ativo",
    atributo = nil,
    descricao = "você cria, manipula, molda, dissipa e imbui neve e gelo totalmente, utilizando-as para criar os mais variados efeitos e fenômenos, incluindo granizo, geleiras e o próprio frio. Este poder também contempla a redução da energia cinética dos átomos tornando as coisas mais frias e lentas, além de permitir interações específicas com criaturas vinculadas a este elemento",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX",
    },
  },
  {
    nome = "Manipulação da luz",
    tipo = "ativo",
    atributo = nil,
    descricao = "dá ao portador a capacidade de criar, manipular, moldar, dissipar e imbuir a luz totalmente, utilizando-a para gerar diversos efeitos e fenômenos. É possível também controlar os aspectos do dia, do laser e do plasma, além de permitir interações específicas com criaturas vinculadas a este elemento",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX",
    },
  },
  {
    nome = "Manipulação da raiva",
    tipo = "ativo",
    atributo = nil,
    descricao = "esta capacidade dá ao usuário a capacidade de sentir e manipular completamente todos os aspectos da raiva, tanto para si quanto para outras pessoas ou criaturas de forma geral, seja amplificando, diminuindo, causando e dissipando este sentimento. Também é possível canalizar este sentimento em energia física, ou em efeitos derivados diversos",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX",
    },
  },
  {
    nome = "Manipulação das sombras",
    tipo = "ativo",
    atributo = nil,
    descricao = "o usuário pode criar, manipular, moldar, dissipar e imbuir as sombras totalmente, utilizando este elemento para gerar diversos efeitos e fenômenos, também vinculados aos aspectos da noite. Aqueles que portam este poder se tornam capazes de terem interações específicas com as criaturas vinculadas as sombras e a própria noite",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX",
    },
  },
  {
    nome = "Manipulação dos sonhos",
    tipo = "ativo",
    atributo = nil,
    descricao = "este poder garante ao seu portador a capacidade de manipular todos os aspectos dos sonhos e da própria terra do Sonhar. Os usuários conseguem detectar os que estão dormindo, enviar mensagens através dos sonhos, trazer pesadelos ao mundo material e utilizar sua aura para criar efeitos e fenômenos diversos. Também se torna possível realizar interações específicas com criaturas ligadas ao reino dos Sonhos",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX",
    },
  },
  {
    nome = "Manipulação da terra",
    tipo = "ativo",
    atributo = nil,
    descricao = "permita que o usuário crie, manipule, molde, dissipe e imbua a terra por completo, utilizando-a para criar os mais variados efeitos e fenômenos. Este poder também capacita seus usuários a controlarem areia, pedra, metais e demais minérios, além de permitir interações específicas com criaturas vinculadas ao elemento terra",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX",
    },
  },
  {
    nome = "Metamorfose animal",
    tipo = "ativo",
    atributo = nil,
    descricao = "o semideus tem um vínculo com animais ao ponto em que consegue compreendê-los, influenciá-los e se transformar em tais criaturas. Não se trata apenas de mudar o próprio corpo, mas sim o fato de que este poder cria um vínculo entre o usuário deste e determinadas criaturas, que por algum motivo misterioso o mesmo possui uma ligação, aumentando a quantidade de criaturas e a força da conexão quanto mais poderoso o semideus é",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX",
    },
  },
  {
    nome = "Metamorfose mortal",
    tipo = "ativo",
    atributo = nil,
    descricao = "garante ao usuário a capacidade de mudar a aparência e outros aspectos de sua própria fisiologia e existência, não só copiando de seres que já existem, mas podendo criar identidade inteiramente novas, incluindo trejeitos e até as capacidades únicas de seus alvos. A metamorfose também pode permitir a transformação de terceiro, a cópia de capacidades e mudanças parciais, se tornando mais eficazes quanto mais poderoso um semideus é",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX",
    },
  },
  {
    nome = "Necromancia",
    tipo = "ativo",
    atributo = nil,
    descricao = "este poder permite que o semideus se comunique com os mortos, traga almas de volta à vida e manipule os dons da morte de acordo com suas vontades e necessidades. Sendo um dos poderes mais poderosos e cobiçados, a necromancia também é uma capacidade polêmica, porque permite que seus usuários mexam com o reino dos mortos desconsiderando regras, leis e até mesmo a vontade dos deuses",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX",
    },
  },
  {
    nome = "Omnilinguismo",
    tipo = "passivo",
    atributo = nil,
    descricao = "dota seus usuários de capacidades naturais para aprender e compreender diferentes idiomas com facilidade e fluência. Seja qual for o idioma, se torna natural assimiá-lo rapidamente, como se as palavras e estruturas linguísticas lhe fossem intrinsicamente familiares, podendo se comunicar com precisão e sutileza, se estendendo tanto aos idiomas comuns quanto aos idiomas e formas de expressão místicas",
    progressao = {
      "+2 em todos os seus testes com as perícias Linguística e Ocultismo",
      "+2 em todos os seus testes com as perícias Linguística e Ocultismo",
      "+2 em todos os seus testes com as perícias Linguística e Ocultismo",
      "+2 em todos os seus testes com as perícias Linguística e Ocultismo",
      "+2 em todos os seus testes com as perícias Linguística e Ocultismo",
    },
  },
  {
    nome = "Radiestesia",
    tipo = "ativo",
    atributo = nil,
    descricao = "concede aos semideuses a habilidade única de desvendar mistérios: ao tocar em objetos, suas mentes se tornam pontes para o passado, sintonizando-se com as últimas memórias impressas no item, também permitindo que seja possível rastrear o dono objeto ou os locais por onde ambos passaram. Uma ferramenta crucial para investigadores divinos, a Radiestesia é descrita como a habilidade de visitar as memórias de objetos ou de criaturas vivas, enquanto os mais versados neste poder conseguem também manipular e até dissipar a memória dos seres e itens",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX",
    },
  },
  {
    nome = "Sabedoria sobrenatural",
    tipo = "passivo",
    atributo = "Sabedoria",
    descricao = "Mesmo jovem o você demonstrava ter uma sabedoria desproporcional ao esperado. A capacidade de deliberar entre o certo e o errado, o simples e o complexo, e uma facilidade em encontrar as decisões mais acertadas a serem tomadas com a menor quantidade de esforço sempre foram características naturais suas",
    progressao = {
      "+1 no Atributo Sabedoria; Receba a qualidade \"Vontade de ferro\"",
      "+1 no Atributo Sabedoria; +1 no cálculo \"Defesa telepática\"",
      "+1 no Atributo Sabedoria; Receba uma perícia adicional à sua escolha, vinculada a este atributo",
      "+1 no Atributo Sabedoria; Você recebe vantagem nos testes envolvendo este atributo",
      "+2 no Atributo Sabedoria; Receba resistência aos efeitos negativos Hipnotizado, Atormentado e Amedrontado",
    },
  },
  {
    nome = "Ultra sensoriamento",
    tipo = "passivo",
    atributo = nil,
    descricao = "Você tem um talento natural para manter-se sempre atento, tanto as coisas que acontecem ao seu arredor, quanto pequenos detalhes do dia-a-dia. Essas capacidades lhe auxiliam em investigações e a evitar surpresas de diversas naturezes, não é algo que você precise treinar, mas que de alguma forma parece que sempre possuiu. Você deve escolher duas das perícias a seguir para receber os bônus com elas a medida que a progressão do poder aumenta: Percepção, Investigação e Intuição",
    progressao = {
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
      "+2 em todos os seus testes com as duas perícias escolhidas",
    },
  },
  {
    nome = "Telepatia",
    tipo = "ativo",
    atributo = nil,
    descricao = "os semideuses com o dom da telepatia são àqueles que se tornaram capazes de usar o próprio intelecto para subjulgar a mente de outros ao seu bel prazer. As capacidades dos telepatas envolvem não só um embate mental, mas inclusive o poder de influenciar o mundo físico através de suas capacidades mentais, criando fenômenos psíquicos que vão além das barreiras físicas existentes no mundo material",
    progressao = {
      "permite o aprendizado de habilidades deste poder de Rank E/D",
      "permite o aprendizado de habilidades deste poder de Rank C",
      "permite o aprendizado de habilidades deste poder de Rank B",
      "permite o aprendizado de habilidades deste poder de Rank A",
      "permite o aprendizado de habilidades deste poder de Rank EX",
    },
  },
}

local function normalizar(s)
  s = tostring(s or ""):lower()
  local de = {
    ["á"]="a",["à"]="a",["ã"]="a",["â"]="a",["é"]="e",["ê"]="e",["í"]="i",
    ["ó"]="o",["ô"]="o",["õ"]="o",["ú"]="u",["ü"]="u",["ç"]="c",
  }
  for k, v in pairs(de) do s = s:gsub(k, v) end
  s = s:gsub("%s+", " ")
  s = " " .. s .. " "
  for _, prep in ipairs({"de","do","da","dos","das"}) do
    s = s:gsub("%s" .. prep .. "%s", " ")
  end
  s = s:gsub("[^a-z ]", "")
  s = s:gsub("([a-z])[oa](%s)", "%1%2")
  s = s:gsub("([a-z])[oa]$", "%1")
  s = s:gsub("%s", "")
  return s
end

local indice = {}
for _, p in ipairs(CatalogoPoderes.itens) do
  indice[normalizar(p.nome)] = p
end
-- Typo do .bib: kit de Merewen diz "Inducao artistica".
indice[normalizar("Inducao artistica")] = indice[normalizar("Intuicao artistica")]

function CatalogoPoderes.buscar(nome)
  return indice[normalizar(nome)]
end

-- Texto do que o nivel N entrega. Para ativos inclui o rank destravado.
function CatalogoPoderes.textoNivel(poder, nivel)
  if poder == nil or nivel == nil then return "" end
  local t = poder.progressao[nivel]
  if t == nil or t == "" then return "" end
  return t
end

function CatalogoPoderes.listarPorTipo(tipo)
  local r = {}
  for _, p in ipairs(CatalogoPoderes.itens) do
    if p.tipo == tipo then table.insert(r, p) end
  end
  return r
end

return CatalogoPoderes

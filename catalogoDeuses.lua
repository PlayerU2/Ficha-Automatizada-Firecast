-- catalogoDeuses.lua
-- Gerado a partir de "Compliado_para_a_ficha_de_Petrichor.bib", secao Deuses.
-- 30 divindades: 9 primordiais, 18 grandes, 3 menores.
--
-- REGRA DA MESA: somente deuses GRANDES concedem Aspecto Divino.
--   - Primordiais: entidades da criacao, nao concedem Aspecto Divino.
--   - Menores: ainda sem kit de poderes definido no livro da mesa.
-- Se um dia os kits dos menores forem escritos, basta marcar
-- selecionavel = true; o resto da ficha ja trata os dois casos.
--
-- As "vagas disponiveis" do .bib foram OMITIDAS de proposito: exigiriam
-- sincronizacao entre fichas, o que o SDK nao oferece.
--
-- IMPORTANTE: o campo "chave" alimenta os cards estaticos do popup
-- (rectDeus_<chave> no ficha.lfm). Nao renomeie sem alterar o XML.

local CatalogoDeuses = {}

CatalogoDeuses.itens = {
  {
    nome = "Asta",
    chave = "Asta",
    categoria = "Primordial",
    selecionavel = false,
    kitConhecido = false,
    slots = {},
    lore = {
      "O mais antigo dos deuses primordiais e também o responsável por dar forma ao firmamento superior, onde seus pais e irmãos habitariam, Asta é o supremo governante do céu. Por muito tempo, atuou como mediador, servindo à vontade de seus pais com lealdade incomparável, auxiliando cada um de seus irmãos em suas tarefas e acumulando conhecimento para realizar o seu próprio destino. As nuvens que hoje povoam o céu foram carregadas com as águas de Isydras e em outras partes com o gelo de Oskarion, enquanto o vento foi instruído a varrer a terra de Erinor com moderação. Tenebria e Khelion ensinaram a Asta a importância dos ciclos, enquanto os gêmeos Uthris e Unaris revelaram diversos mistérios da criação. As chamas de Bran foram colocadas no firmamento para que a luz pudesse alcançar a todos, sendo a mais brilhante responsável por dar vida a sua filha Ditrys, o dia, seguida por Noctefir, a noite, pois o ônus de sustentar as luzes do céu era grande demais para ser carregado por um único ser.",
      "Em uma época remota, quando o mundo ainda era jovem e os deuses ocasionalmente caminhavam sobre a terra, Erinor solicitou uma conversa com Asta, alegando que o vento estava causando estragos em seu reino, criando tornados e redemoinhos que feriam o solo. Logo, o senhor do céu chamou o vento e indagou-lhe o motivo de sua conduta, e este revelou sua tristeza por não possuir uma forma como as demais criaturas, pedindo ao criador que lhe desse uma forma, dando origem a Nellios, o vento.",
      "A raça que personifica o senhor do céu são os Dragões, criaturas com quatro patas e asas. Existem outras raças derivadas ou com ascendência de dragão, como os Wyverns, que possuem duas patas e asas que funcionam como braços, mas estes não devem ser confundidos com os verdadeiros dragões. Acredita-se que a vida de um dragão seja incalculável; são considerados filhotes durante os primeiros cinco anos, jovens adultos até os cem anos e adultos até atingirem a idade de oitocentos anos, mas acredita-se que os dragões nunca param de crescer, e a morte de um deles nunca foi registrada, o que sugere que são imortais. Os dragões são criaturas vivas que carregam elementos dentro de si, o que os torna poderosos, e suas personalidades variam de acordo com esses elementos, mas não apenas por isso. Assim como os humanos, os dragões têm suas próprias crenças, aliados e inimigos, herdando o desejo por conhecimento de seu criador.",
      "Não há documentos, livros ou registros concretos sobre a aparência do deus Asta, o que ocasionalmente o retrata como um gigantesco dragão branco, assemelhado às nuvens, ou dourado como o sol. Ele é adorado principalmente por cavaleiros, que pintam seus escudos com o símbolo do dragão, representando coragem e justiça. Curiosamente, no continente de Sindoria, o deus é representado como uma grande serpente, uma mistura de vários animais místicos: olhos de tigre, corpo de serpente, patas de águia, chifres de veado e orelhas de boi. Acredita-se que essa representação seja devido ao fato de os dragões desse continente possuírem formas diferentes dos de seus irmãos.",
    },
  },
  {
    nome = "Bran",
    chave = "Bran",
    categoria = "Primordial",
    selecionavel = false,
    kitConhecido = false,
    slots = {},
    lore = {
      "Como o deus de um dos elementos mais selvagens da natureza, Bran é retratado nos livros com características bastante similares ao seu elemento e muito distinta de todos os outros deuses, sendo ele de uma personalidade totalmente imprevisível, ora explosivo, ora paciente. Nunca teve um lado claro em relação á ruptura entre o Pai e a Mãe, sendo um dos últimos a tomar uma posição, essa sendo a Mãe, seus motivos permanecendo até os dias de hoje como um mistério.",
      "Sua aparência é descrita de diversas formas, sendo impossível saber qual é a verdadeira, algumas fontes dizem ser um homem adulto, alto e imponente, com olhos vermelhos ardentes e grande porte físico, outras já alegam um homem esguio na flor da idade portando um martelo de chamas, já os adeptos de seu culto ainda dizem que ele apenas se manifesta através de fontes diretamente de fogo, sem forma específica.",
      "A efemeridade das chamas, que queimavam intensamente e depois se apagavam sempre foi um fato conhecido, visto isso Bran decidiu criar uma raça que incorporasse a natureza transitória do fogo, seu poder e também sua capacidade regenerativa e sua beleza única, assim nasceram as fênix. Estas magníficas criaturas foram concebidas para refletir a dualidade do fogo: a capacidade de destruir e renascer das cinzas. Bran dotou as fênix com a habilidade de renascer das próprias chamas, emergindo renovadas e ainda mais poderosas após cada ciclo de vida. Ele esperava que, ao criar uma raça tão extraordinária, pudesse ensinar aos seres vivos sobre a importância da transformação, da renovação e da superação, tudo o que o fogo representa em sua essência. As fênix ainda dotam de capacidades curativas e purificadoras extraordinárias a partir de suas lágrimas, sendo elas um dos ingredientes mais caros e escassos conhecidos.",
      "Não existem registros ainda da morte de uma fênix até o presente momento, apenas que, um ciclo entre queimar na velhice e renascer em seguida jovem e mais forte, ocorrem mais ou menos a cada 100 anos. Além disso o surgimento de tal raça data desde a Era Ancestral de Petrichor e, ainda assim, existe um número extremamente pequeno destas voando pelos céus, nada mais do que algumas dezenas. Avistar uma fênix, dizem alguns, que é sinal de boa sorte, já outros alegam que o próprio Bran consegue observar o mundo pelos olhos destas criaturas.",
    },
  },
  {
    nome = "Erinor",
    chave = "Erinor",
    categoria = "Primordial",
    selecionavel = false,
    kitConhecido = false,
    slots = {},
    lore = {
      "O segundo filho dos deuses-criadores Pai e Mãe, deus primordial da terra e pai dos gigantes, criador de todos os mundos sejam aqueles conhecidos ou não, e senhor de todos os reinos terrestres e as riquezas que constituem tais reinos. Erinor sempre foi dos deuses, aquele mais próximo dos criadores, unindo o espírito criativo da Mãe, e a vontade de proteger do Pai, tomou para si como propósito da existência a criação de algo que não só permitisse a si próprio exercitar sua dádiva criativa, mas também que seus irmão pudessem fazê-lo. Enquanto Asta, seu irmão mais velho, criou um reino para que os seres celestiais pudessem viver, coube ao Supremo Senhor da Terra a criação do mundo em que os seres celestiais pudessem exercer suas vocações, e criarem seus próprios reinos e súditos.",
      "Asta desejava um espaço onde suas criações e seu conhecimento pudessem se expandir, e onde os indomáveis espíritos sob seu controle se manifetassem, e a partir disso fez-se o céu; Isydras desejava uma terra inundada onde sua mente pudesse fluir para criar sua própria biodiversidade, então criou-se os oceanos e os rios; Oskarion desejava influir sua alma sobre este novo mundo, então Erinor deu a ela as temporadas frias e as terras geladas dos polos; Bran, como sua irmã, desejava que seu espírito quente fluisse sobre a terra, então Erinor deu a ele as temporadas quentes e a responsabilidade de aquecer e iluminar este novo mundo; Uthris e Unaris pediram que suas leis e conhecimentos misteriosos pudessem influenciar nesta nova terra, e assim a magia permeou os mundos terrestres e se tornou a espinha dorsal de quase todas as existências; Tenebria e Khelion, em eterno conflito e amor, desejavam cada um influenciar o mundo de uma forma: a deusa queria tornar tudo finito, enquanto o deus manteria tudo sempre rejuvenescido, então Erinor deu a eles a soberania sobre as leis da vida e da morte nesta terra; Zeno, audacioso e inventivo, pediu o direito de ir e vir nesta terra quando desejasse, e o senhor da Terra assim permitiu.",
      "Aquela terra, inicialmente vazia, floresceu quando os nove primordiais a transformaram em um mosaico de si mesmos e suas influências. Erinor, então, foi indagado por Zeno pela possibilidade de que um dia aquele grande corpo de terra que foi usado para que cada divindade construísse o que desejasse poderia ser simplesmente reclamado pelo Governante da Terra, ofendido, Erinor sacrificou sua primeira e mais amada filha, Gundanna - a mãe de todos os gigantes - dividindo seu coração em nove diferentes partes, que se transformaria em nove diferentes criaturas para governar este novo mundo em nome de cada um dos nove deuses, como um símbolo do pacto de que o senhor da terra, das montanhas e dos vulcões teve com seus irmãos de que o Mundo embora feito de rocha e terra, pertencia a todos. De Gundanna surgiram os gigantes das nuvens, os gigantes de gelo, os gigantes da água, os gigantes do fogo e da água, os eternos da magia, os gigantes da morte, os gigantes da vida, e os gigantes de Zenos. Cada uma dessas criaturas tomou uma forma, de acordo com a vontade de seus senhores, e se tornaram seres primordiais e símbolos de imenso poder.",
      "Assim, Erinor viu sua obra tornar-se um mosaico para criação de seus irmãos, e sob deleite o Senhor da Terra adormeceu porque já não havia mais o que criar, ou o que cuidar. Seu despertar somente deu-se durante a Grande Cisão, quando para a surpresa de todos - imaginando uma neutralidade do segundo filho - este ficou ao lado do Pai, trazendo consigo grande parte de seus filhos e abandonando o Círculo da Mãe. A despeito disso, até os dias atuais o pacto de Erinor com seus irmãos é respeitado, e a influência do Mundo é repartida entre os Nove igualmente.",
    },
  },
  {
    nome = "Isydras",
    chave = "Isydras",
    categoria = "Primordial",
    selecionavel = false,
    kitConhecido = false,
    slots = {},
    lore = {
      "Isydras era um deus que raramente se fazia presente, de personalidade reservada vivia sempre nas profundezas de seus domínios, poucos foram os seres que conseguiram vê-lo vagando por Petrichor nas margens de rios ou lagos, mínimos foram os que de fato interagiram com ele. Não existe nenhum registro de sua aparência, apenas poucas estátuas em ruínas pelo continente que mal distinguem-se traços, seu culto hoje em dia é praticamente inexistente, isso se deve mais ao fato de Isydras ter tomado o lado do Pai, sendo absorvido pelo mesmo.",
      "Na Era Ancestral, as fontes de águas mais abundantes, os mares, era onde Isydras se sentia mais solitário, uma época onde ainda não haviam seres ali, então a primeira raça que nasceu foram os guardiões abissais, os Krakens, criaturas que representasse a imensidão e o mistério das águas, mas também sua força e sua serenidade, moldadas à imagem do oceano, com tentáculos que se estendem como os rios que fluem para o mar, e olhos que brilham com a luz mágica das profundezas. Isydras dotou os Krakens com inteligência e poder, tornando-os os senhores das águas profundas. Os Krakens representam tanto a beleza quanto a força avassaladora das águas, lembrando aos mortais que, apesar de sua imponência, devem sempre honrar e preservar, rios, lagos, mares e oceanos, cujos detém a fonte de vida.",
      "Krakens são criaturas muito temidas nos dias atuais, havendo indícios de que muitos deles são controlados ou respondem aos paladinos de Zion, por isso aos que seguem a Mãe viajar pelos mares se mostra extremamente perigoso sempre.",
    },
  },
  {
    nome = "Khelion",
    chave = "Khelion",
    categoria = "Primordial",
    selecionavel = false,
    kitConhecido = false,
    slots = {},
    lore = {
      "Nos reinos etéreos onde a luz da vida brilha em sua plenitude e as sombras da morte se encontram em seu ponto mais distante, havia um deus cuja presença era tão radiante quanto o sol e cujo coração pulsava com a energia da criação.",
      "Bem na encruzilhadas dos mundos, onde os suspiros da vida se misturam com os murmúrios da morte, ergue-se uma lenda marcada pela luz dos unicórnios e pelo lamento das banshees. No cerne dessa história está Khelion, o deus da vida, cujos passos deixavam uma trilha de flores e cujo toque era capaz de curar as feridas mais profundas da alma. Ao seu lado, reinava Tenebria, a deusa da morte, envolta em sombras que dançavam ao redor dela como um véu etéreo, enquanto suas lágrimas ecoavam como prenúncios sombrios. Juntos, criam uma harmonia única que sustentava o equilíbrio do mundo.",
      "Juntos, Khelion e Tenebria eram como as duas faces de uma moeda, complementando-se em sua dualidade divina entretanto, um sacrifício precisou ser feito. Em um momento crucial, quando o chamado de seu destino ressoou como um eco ancestral, Khelion sentiu-se compelido a tomar uma decisão que mudaria o curso dos eventos divinos: ele escolheu deixar a Morte, sua amada esposa, para seguir seu caminho ao lado de seu pai, o deus primordial, cujo chamado ele não podia ignorar. Essa decisão não foi tomada de ânimo leve; estava enraizada na necessidade de cumprir seu propósito divino e honrar as tradições ancestrais que moldaram seu ser desde o início dos tempos.",
      "A decisão ecoou como um trovão nos reinos, ecoando através dos ventos e das marés do destino. Tenebria, agora deixada para trás em um mar de sombras, viu seu coração mergulhado em uma escuridão mais profunda do que qualquer noite jamais poderia conhecer. E assim, enquanto Khelion partia para cumprir seu destino ao lado de seu pai, ela permaneceu, seu olhar fixo nos horizontes distantes, onde as estrelas sussurravam segredos antigos e o eco dos lamentos das banshees preenchia o vazio deixado por sua partida.",
    },
  },
  {
    nome = "Oskarion",
    chave = "Oskarion",
    categoria = "Primordial",
    selecionavel = false,
    kitConhecido = false,
    slots = {},
    lore = {
      "A quarta filha dos criadores, deusa primordial do gelo e das Fênix de Gelo, criadora do inverno e senhora da renovação das estações. Oskarion é gêmea mais velha de Bran, deus primordial do fogo, e sempre foi representada como o oposto de seu irmão: se Bran é um deus instável, Oskarion é previsível, se Bran marca o mundo com suas chamas e seu calor intenso, Oskarion marca o mundo com o gelo e seu vento refrescante, se o irmão do fogo é selvagem, Oskarion é sábia e controlada. Sua existência se dá para trazer equilíbrio as estações e inclusive sendo capaz de esfriar até mesmo os poderosos vulcões moldados por Erinor.",
      "Sua forma é misteriosa. Existem relatos de que a divindade é um homem com cabelos prateados e longos, outros tantos que é uma dama de aparência severa e dos mesmos cabelos de neve, e não foram poucos os profetas que sonharam com a divindade relatando-a como uma fênix gigante de gelo, que no bater de suas asas provocavam ventanias geladas. Oskarion é retratada como uma deusa solitária, pouco sentimental, que vive por um senso de dever próprio e pode passar milênios sem sequer exibir sua existência até mesmo para seus irmãos e pais.",
      "Quando o deus Erinor presenteou cada um de seus irmãos com um fragmento do coração de Gundanna - a mãe de todos os gigantes - Oskarion criou a partir disso a primeira Criofênix, que viriam a ser uma rara espécie de criaturas que seriam representações da senhora de gelo pelo mundo. A primeira dessas criaturas se destacou pela beleza, inteligência e imenso poder, enquanto as várias outras filhas da deusa primordial se espalharam pela existência, lançando sua vontade e influencia nos mundos conhecidos e desconhecidos, a primogênita das Criofênix ficou e aprendeu com sua mãe os segredos que uma deusa primordial poderia ensinar, sendo a única que realmente sabia como encontrar a primordial.",
      "A Grande Cisão veio, e nela Oskarion se posicionou ao lado do Círculo da Mãe. Sabia-se que Bran estava indeciso, então avisada da situação pela sua mais velha filha, a deusa primordial retornou de seu exílio para convencer o próprio irmão a juntar-se com ela ao Círculo e assim impedir que todo o panteão fosse absorvido pelo Pai. Oskarion decidiu então, por motivos misteriosos, presentear a primeira das Criofênix com o inverno - já que agora que o Pai procurava pelos seus filhos para absorvê-los - e fazer de sua cria uma deusa e herdeira, dando a luz assim a Wenti.",
      "Desde então ela desapareceu, embora alguns dizem que a deusa seja capaz de observar o mundo pelos olhos das Fênix de Gelo, e sua voz ainda possa ser escutada como sussurros nos sonhos dos seres durante os dias mais frios de inverno, voando sob a existência com objetivos misteriosos, enquanto sua filha governa o inverno em seu nome.",
    },
  },
  {
    nome = "Tenebria",
    chave = "Tenebria",
    categoria = "Primordial",
    selecionavel = false,
    kitConhecido = false,
    slots = {},
    lore = {
      "Ali, onde o véu entre os mundos é fino e os suspiros dos mortos ecoam nas sombras e onde os fios do destino eram tecidos em segredos sombrios, há uma deusa cujo nome inspira temor e reverência: Tenebria, a Senhora da Morte e das Banshees, as Anunciadoras. Sua beleza sombria rivaliza com a própria noite, e sua existência se dá nas margens do cosmos, onde a luz da vida desvanece e a escuridão da morte se ergue como um manto negro. Sua presença é imponente como a própria morte, sua essência tão fria quanto o abraço final.",
      "Tenebria é irmã e consorte de Khelion, o deus da Vida e dos Unicórnios, cujos passos eram tão leves quanto os raios do sol. Juntos, eles são a personificação do equilíbrio entre a criação e a destruição, unidos em um vínculo sagrado que transcendia os limites dos mundos conhecidos e determinando o tempo de existência de cada ser que caminha por Petrichor. Apenas os dois sabem o Destino de cada um, responsáveis pelos fios da vida e o seu fim e então, o recomeço. A existência é um ciclo, coordenado por ambas as dividindades.",
      "Entretanto, como todas as grandes histórias, a deles também estava fadada a um destino amargo. No ápice de sua harmonia, quando o amor parecia eterno e imutável, o deus da vida fez uma escolha que abalou os alicerces do próprio cosmos. Ele decidiu deixar Tenebria, abandonando-a para seguir o caminho do Pai, deixando-a para trilhar os corredores sombrios da eternidade sozinha.",
      "A dor da traição ecoou como um lamento através dos reinos celestiais, tingindo o céu com sombras mais profundas do que qualquer noite jamais poderia conhecer. E assim, a deusa da morte ficou só, seu coração pesado com a perda daquele que ela havia amado acima de tudo. Mas enquanto os séculos passavam, Tenebria não permaneceu imóvel em sua dor. Ela continuou a governar sobre os reinos dos mortos com uma determinação implacável, enquanto o eco dos lamentos das banshees ecoava através das eras, lembrando a todos da tragédia que havia separado os deuses da vida e da morte.",
    },
  },
  {
    nome = "Uhtris e Unaris",
    chave = "UhtriseUnaris",
    categoria = "Primordial",
    selecionavel = false,
    kitConhecido = false,
    slots = {},
    lore = {
      "Os deuses gêmeos Uhtris e Unaris emergiram dos primordiais como os filhos da essência mágica pura que permeava o universo. Enquanto Asta moldava o firmamento e governava o céu, Uhtris e Unaris eram os guardiões da magia, responsáveis por desvendar seus segredos e ensinar seus mistérios aos seres do mundo. Conta-se que quando juntos, ambos possuem as chaves para acessar o conhecimento de toda a criação.",
      "Em um momento crucial da história, os gêmeos Uhtris e Unaris, buscando aprofundar seu conhecimento sobre os mistérios da magia, convocaram representantes das diversas raças para serem seus aprendizes e compartilharem suas experiências e sabedoria. Este evento lendário ficou conhecido como o Grande Convite e marcou o início da disseminação do conhecimento mágico entre as criaturas mortais.",
      "Os Alados foram representados pelos nobres Aaracrokas, os majestosos Dragões, as ágeis Harpias e as encantadoras Fadas. Dos reinos Aquáticos vieram os robustos Giff, os sagazes Lizarianos, as sedutoras Sereias, os misteriosos Selkies e os orgulhosos Tritões. Das terras Terrestres, compareceram os sábios Centauros, os graciosos Elfos, as serenas Ninfas, os imponentes Gigantes, os versáteis Humanos, os selvagens Licantropos, os labirínticos Minotauros, os brutais Orcs, os festivos Sátiros, os resilientes Ursaris e os misteriosos Vampiros. Dos reinos Subterrâneos vieram os habilidosos Anões, os astutos Drow, os travessos Goblins e os inventivos Gnomos. E dos domínios desconhecidos vieram os enigmáticos Ghiscari.",
      "Durante um ciclo de estações, os representantes de cada raça foram instruídos por Uhtris e Unaris sobre os fundamentos da magia, os fluxos de energia e os princípios que regem o equilíbrio do universo. Cada criatura trouxe consigo suas próprias perspectivas e entendimentos únicos, enriquecendo assim o aprendizado conjunto. Ao final do Grande Convite, os representantes retornaram às suas terras, compartilhando o conhecimento adquirido com seus povos e estabelecendo as bases para as tradições mágicas que perdurariam através das eras. Desde então, a magia tornou-se uma parte intrínseca das sociedades mortais, moldando destinos e alimentando os sonhos daqueles que buscam compreender os segredos do universo.",
      "Porém, como toda dualidade, também havia conflito entre os dois. Enquanto Uhtris buscava a harmonia através da luz e da ordem, Unaris encontrava beleza na escuridão e no caos. Suas disputas moldavam os caminhos da magia, criando escolas e tradições que refletiam suas naturezas contrastantes. Apesar de suas diferenças, ambos compartilhavam um vínculo inquebrável como irmãos e guardiões da magia.",
      "Entretanto, essa união foi interrompida pela grande cisão, quando Uhtris foi levado pelo Pai, deixando Unaris verdadeiramente sozinha pela primeira vez desde a gênese. Medo, tristeza e diversos outros sentimentos negativos tomavam conta de sua mente, fazendo-a recorrer aos seus irmãos em busca de auxílio. Porém, nenhum deles foi capaz de apresentar uma solução. Unaris então seguiu até os pés da Mãe Celestial, implorando que interviesse em seu favor e trouxesse Uhtris de volta. Durante sete dias e sete noites, ela derramou lágrimas. Alguns dizem que suas lágrimas caíram sobre um lago onde mulheres se banhavam sob a lua, dando origem às primeiras bruxas.",
      "Desde a separação, Unaris nunca mais foi a mesma. O conteúdo da conversa entre ela e a Mãe Celestial segue sendo um dos grandes mistérios. Hoje, a natureza selvagem e por vezes impiedosa da deusa da magia passou a ser a representação mais popular no mundo e sua imagem mais comum é a de uma mulher jovem com o rosto oculto por um véu negro. Enquanto isso, o culto ao deus Uhtris foi quase que totalmente extinto e as imagens de deste são consideradas tesouros perdidos.",
    },
  },
  {
    nome = "Zeno",
    chave = "Zeno",
    categoria = "Primordial",
    selecionavel = false,
    kitConhecido = false,
    slots = {},
    lore = {
      "O filho mais novo do Pai e da Mãe, e de longe a divindade mais misteriosa de todas. Quando Zeno foi concebido, os senhores da existência não lhe deram um elemento, mas sim entregaram ao caçula dos primordiais o domínio sobre a fortuna e o caos. Na concepção do mundo material, cada um dos primordiais recebeu o direito sobre um aspecto do novo reino, e quando chegou a vez de Zeno, este solicitou a Erinor que gostaria apenas do direito de caminhar sem restrições por esta nova terra. Contrariado, Erinor aceitou, já que não lhe cabia o direito a recusar nada a nenhum de seus irmãos, mas advertiu a Zeno de que ele como o único a ter este direito deveria usá-lo com sabedoria.",
      "Sabe-se que o senhor da fortuna e do caos, diferente dos outros, não criou espécies de acordo com sua visão. Os humanos foram concebidos a imagem dos próprios deuses primordiais, inclusive nos aspectos de aparência, a divindade deu origem as várias tribos espalhadas pelos três continentes existentes do mundo a época, e então desapareceu quando compreendeu que seu trabalho estava feito.",
      "Zeno era o mais querido de todos os primordiais tanto pelo Pai quanto pela Mãe, e esta sua característica transcendeu aos seus filhos, já que os humanos notoriamente conseguem o favor dos deuses mais facilmente que as demais raças.",
      "Desde que o continente de Atheron foi destruído, toda a informação sobre a divindade se perdeu, e o que se resta são fragmentos que tornam uma das mais importantes entidades do panteão em um ser misterioso a ser redescoberto.",
    },
  },
  {
    nome = "Ammis",
    chave = "Ammis",
    categoria = "Grande",
    selecionavel = true,
    kitConhecido = true,
    slots = {
      { "Carisma sobrenatural" },
      { "Cavaleiro épico", "Fator de cura regenerativo" },
      { "Fitocinese" },
      { "Manipulação do amor" },
      { "Liderança absoluta" },
    },
    lore = {
      "Ammis é a conhecida deusa da primavera, filha de Khelion, e rainha dos sátiros. Sua figura representa a mudança da estação mais severa de todas - o inverno - para a primavera agradável, onde os campos voltam a dar frutos, as flores renascem e os seres podem aproveitar uma nova temporada de climas amenos. Ammis é das divindades, uma das que caminha entre o mundo terrestre com mais frequência, especialmente durante sua respectiva estação do ano. É representada como uma dama belíssima, com um vestido feito de seda, uma coroa de rosas na cabeça e cabelos coloridos, de uma beleza única capaz de encantar qualquer criatura que ponha seus olhos sobre a deusa.",
      "Durante as primeiras estações, Ammis espalhou sua presença durante todos os campos, todas as florestas, lagos, rios e montanhas sozinha. Solitária e entristecida, então deu a luz aos Sátiros, seres que abençoou com seu sangue para que pudessem fazer companhia a si e ajudá-la a espalhar o dom da primavera pelo mundo durante a estação. Ammis uniu-se com Sýdos, depois que os deuses encantaram-se um pelo outro, e juntos produziram uma quantidade tão grande de filhos quanto o próprio Pai e Mãe o fizeram.",
      "É uma deusa particularmente generosa, normalmente cultuada entre xamãs, druídas e as raças mais ligadas as florestas, no entanto a lady Primavera nunca recusa um seguidor, e como a primavera que vem para limpar a morte e a tristeza após o inverno, Ammis jamais deixa de estender sua mão e ser a esperança no coração daquelas que escolhem segui-la. Os festivais do Equinócio são o período com mais relatos de visitação da deusa, sendo que todos os filhos de Ammis - sejam eles Sátiros ou semideuses - nascem neste dia, que é considerada uma semana de milagres por aqueles que cultuam a divindade.",
    },
  },
  {
    nome = "Aslot",
    chave = "Aslot",
    categoria = "Grande",
    selecionavel = true,
    kitConhecido = true,
    slots = {
      { "Manipulação sobrenatural", "Carisma sobrenatural" },
      { "Fator de aura regenerativa" },
      { "Indução do medo", "Manipulação da raiva" },
      { "Necromancia" },
      { "Manipulação da água" },
    },
    lore = {
      "Também conhecida como Aslot dos muitos encantos, Aslot do beijo traiçoeiro, Mãe dos afogados e Senhora das mil faces, Aslot é filha do deus Isydras e irmã de Qosis, Oduwa e Merewen. Ela veio ao mundo como uma forma de vida frágil e instável, fruto do pecado de seu pai em querer o que não lhe pertencia. Movido pela raiva e vergonha, Isydras removeu Aslot do ventre que a nutria, lançando-a nas águas mais profundas e escuras, onde nenhuma luz lhe alcançava. Conta-se que Aslot demorou muito mais tempo para se desenvolver em comparação com seus irmãos ou mesmo outros deuses mais jovens.",
      "A deusa cresceu sozinha na escuridão profunda do mar, onde nada havia para preencher o vazio. Seu corpo passou a imitar aquilo que via, tornando-se uma imitadora de sombras e luzes lúgubres, até que chegou o dia em que finalmente teve forças suficientes para nadar até a superfície. Lá, encontrou-se com sua irmã Merewen. Pouco se sabe a respeito do encontro de Aslot e Merewen, porém conta-se que, ao vê-la pela primeira vez, Aslot sentiu vergonha de sua própria imagem desfocada e sem vida, enquanto a irmã era a mais pura representação do belo. Sejam deidades, mortais ou quaisquer outros, todos a adoravam e queriam estar próximos de Merewen. Assim, Aslot deu-lhe as costas e, amaldiçoando sua própria sorte, retornou às profundezas.",
      "Os domínios de Aslot correspondem às profundezas, e ela conhece todos os cantos mais profundos do mundo. Além disso, dizem que é capaz de ver os desejos que se escondem na alma de cada ser. Aslot tem muitos filhos, com homens e mulheres. Sempre que deita-se com um homem, dará à luz um Tritão; ao deitar-se com uma mulher, nascerá uma Sereia. Esses são as mais puras representações que Aslot teve de seus pais no período em que estiveram juntos. Portanto, os filhos de Aslot possuem naturezas incrivelmente mutáveis, podendo ser cruéis, sádicos e assassinos, ou incrivelmente afáveis, gentis e cultos. Porém, há algo em que todos os que se encontraram com a deusa concordam e dizem em seus relatos: \"Sua face nunca se repete, seu sorriso enlaça o coração, seu beijo leva à perdição e, como uma criança que está aprendendo a nadar, você facilmente se afogaria em seus braços.\"",
    },
  },
  {
    nome = "Din",
    chave = "Din",
    categoria = "Grande",
    selecionavel = true,
    kitConhecido = true,
    slots = {
      { "Sabedoria sobrenatural" },
      { "Escudo psíquico", "Conhecimento enciclopédico" },
      { "Cura" },
      { "Manipulação da terra" },
      { "Manipulação de alimentos" },
    },
    lore = {
      "Primeiro houve a criação da existência, quando tudo aquilo que é conhecido ou desconhecido foi criado... de início houve conflito, inveja, ciúme e caos; houve ganância e enganação. De que adiantavam os deuses darem a luz e moldarem seus filhos com tanto cuidado, se no final eles seriam responsáveis por destruírem um ao outro? Antes dos povos se organizarem e se assentarem em cidades, quando as tribos nômades ainda vagavam disputando territórios e verdades, Din surgiu a partir da genuína vontade daqueles que repudiavam a discórdia e a guerra, e que oravam para que os deuses pudessem prover uma existência mais pacífica entre toda a criação.",
      "Khelion deu forma a este desejo, criando Din, o deus da paz. Diferentemente das outras divindades ele não era responsável por um lugar, não era responsável por uma estação do ano ou um fenômeno místico. Criado a partir do contraponto a guerra, Din existe como aquele que olha contra a matança, que cuida dos indefesos e atende as preces do povo comum que deseja uma vida próspera.",
      "O deus da paz foi responsável direto pela criação dos Gnomos, um povo pequenino de criaturas místicas, alegres e travessas. Diferentemente das outras raças, os gnomos são criados quando um inocente é morto de forma injusta em um ato de violência, e em seus últimos suspiros faz uma prece para a divindade, que acolhe sua alma atormentada e a transforma em um dos seus, para que possa viver uma vida como um seguidor e tenha a oportunidade de trilhar um caminho diferente daquele que lhe foi imposto antes da morte que ceifou sua vida.",
      "O Rei dos Gnomos uniu-se com Sidharis, senhora das fadas e do verão. Unidos por seu coração puro, Din também é considerado um senhor pelas fadas, enquanto Sidharis também é a mãe de todo Gnomo, com uma aliança forte entre os povos simbolizando o amor sincero entre as duas divindades. Seu culto não é muito famoso, já que Din não é um deus para os ambiciosos e heróis, mas para aqueles que desejam viver uma vida justa e próspera.",
      "Os deuses menores surgiram em uma era posterior à fundação do mundo, quando as primeiras raças já caminhavam sobre a terra, navegavam pelos mares e erguiam as primeiras cidades. Ao contrário dos Deuses Primordiais, que moldaram os alicerces da Criação e regem aspectos primordiais como a vida, a morte, o tempo e os elementos, os deuses menores nasceram de necessidades mais específicas, ligadas ao crescimento, à cultura e às particularidades de cada povo. A medida que as civilizações floresciam, novos valores, ofícios e desafios surgiam — e com eles, manifestações divinas que refletiam esses aspectos. Foram os deuses menores que tomaram para si os domínios da colheita, da guerra justa, da pesca, da música, das tempestades locais, da cura de enfermidades e de inúmeras outras áreas que moldavam o cotidiano das raças.",
      "Embora menos poderosos que os Grandes Deuses, os deuses menores possuem papel essencial como auxiliadores da Criação. São eles que atuam como guardiões, patronos e inspiradores, respondendo às orações mais próximas do coração mortal e intercedendo em questões práticas e imediatas. Sua influência não se restringe a um único ponto do mundo: seus cultos, ainda que muitas vezes menores e descentralizados, se espalham em templos, santuários e altares improvisados — cada um adaptado à cultura local.",
      "Alguns desses deuses menores mantêm laços de servidão, aliança ou devoção aos Grandes Deuses, servindo como seus emissários e executores da vontade maior. Outros, porém, são independentes, guiando-se por seus próprios princípios e mantendo cultos únicos, às vezes regionais, que podem crescer até rivalizar em popularidade com os dos próprios deuses primordiais. No tecido do mundo, os deuses menores são como fios delicados, mas indispensáveis, que unem a vida cotidiana ao divino. Eles representam a ligação íntima entre o sagrado e o mundano, mesmo nos pequenos gestos e nas atividades mais comuns, há espaço para o toque da divindade.",
    },
  },
  {
    nome = "Ditrys",
    chave = "Ditrys",
    categoria = "Grande",
    selecionavel = true,
    kitConhecido = true,
    slots = {
      { "Carisma sobrenatural" },
      { "Atirador épico" },
      { "Manipulação da luz" },
      { "Metamorfose mortal" },
      { "Cura" },
    },
    lore = {
      "Ditrys nasceu de uma rara conjunção astral que ocorreu em um momento de grande harmonia entre os elementos. Foi quando os raios de sol dançaram em perfeita sincronia com os ventos suaves, as águas serenas e o esplendor dos céus de seu pai, Asta, criando uma explosão de luz e calor que inundou os céus e a terra. Nesse momento mágico, Ditrys emergiu, envolta em um halo dourado, emanando calor e luminosidade.",
      "Como uma deusa nascida dessa convergência celestial, Ditrys carrega em si a energia vibrante e revigorante do sol, mas também a suavidade e a gentileza dos ventos e das águas. Ela é uma personificação da vitalidade e da renovação que o dia traz consigo.",
      "É uma deusa muito cultuada pelos seguidores da mãe, tendo templos espalhados por toda Petrichor e, apesar da ausência dos deuses, muitos acreditam que tanto os primeiros raios de luz do dia, quanto os últimos, contém sua presença, sempre observando. Sua aparência é descrita como uma mulher extremamente elegante e de uma graciosidade sem igual, cabelos longos, negros e encaracolados, com um sorriso que irradia todo o ambiente e uma pele jovial muito brilhante.",
      "Ditrys sempre sentiu o desejo de criar uma raça que fosse tão graciosa e radiante quanto o próprio sol. Assim, ela deu vida aos elfos. Estas criaturas são a personificação da elegância e da harmonia, com corpos esguios e olhos brilhantes que refletem a luz do dia.",
      "Ditrys presenteou os elfos com agilidade, inteligência e uma conexão profunda com a natureza, tornando-os os guardiões das florestas e dos reinos selvagens. Ela os ensinou a respeitar e a honrar a luz do dia, que é símbolo de vida, esperança e renovação. Os elfos ainda são conhecidos por uma raça muito mística, possuindo uma afinidade muito grande com a magia de Unaris.",
      "Os elfos, como filhos da Deusa do Dia, carregam consigo a luz interior que os guia através das trevas e das adversidades. Eles são embaixadores da beleza e da bondade, lembrando aos mortais que, mesmo nos momentos mais sombrios, sempre há um raio de esperança e uma nova aurora a ser celebrada. Essa raça é dotada também de uma longevidade maior do que a expectativa de um humano normal, vivendo por volta de 1.000 anos.",
    },
  },
  {
    nome = "Grún",
    chave = "Grun",
    categoria = "Grande",
    selecionavel = true,
    kitConhecido = true,
    slots = {
      { "Constituição sobrenatural", "Conhecimento enciclopédico" },
      { "Artesão épico" },
      { "Criação sobrenatural" },
      { "Manipulação da terra" },
      { "Manipulação do fogo" },
    },
    lore = {
      "Nos picos mais altos e nas profundezas mais profundas, onde a terra toca os céus e o fogo interior arde eternamente, há uma deusa cujo domínio se estende sobre as vastidões escarpadas das montanhas de todo o mundo, sejam elas dominadas pelo fogo interior ou pelas pedras preciosas. Ela é conhecida como Grún, a deusa das montanhas, cujo coração é tão firme quanto a pedra e cujo espírito é tão indomável quanto os ventos uivantes que esculpem as encostas.",
      "Mãe dos anões, uma raça de seres forjadores que vivem nas entranhas das montanhas, onde os segredos das pedras e dos minérios são revelados apenas aos que possuem a coragem de adentrar seus domínios. Desde tempos imemoriais, os anões têm forjado seus lares nas profundezas das montanhas, moldando o ferro e o aço como se fossem extensões de seus próprios corações.",
      "Mas por trás de cada martelo batendo e cada fole queimando, há a presença silenciosa de Grun, a deusa cujo amor nutre as raízes das montanhas e cuja sabedoria permeia cada rocha e cada caverna. Ela é a guardiã dos segredos das profundezas, a protetora dos tesouros ocultos sob a superfície da terra; a própria essência das montanhas, cujo espírito forte e inabalável é tão antigo quanto as rochas que a cercam. Ela é a guardiã dos segredos das profundezas da terra, a protetora dos túneis e galerias onde os anões forjam suas obras-primas de metal. Seus olhos são tão profundos quanto as cavernas mais escuras, e seu cabelo é feito das cascata de rochas esculpidas pelo tempo.",
      "Sua voz é ouvida através das rochas quando a pedra e o metal cantam suas formas e há quem diga que, quando há ameaça, seu corpo estrala e atravessa tudo o que está em seu caminho. Desde tempos imemoriais, os anões e os ferreiros veneram Grún como sua mãe e mentora. Eles acreditam que foi ela quem os moldou a partir da própria rocha das montanhas, soprando vida em seus corpos e habilidades em suas mãos ágeis. Para todos aqueles que trabalham com o metal e a pedra, a divindade é a fonte de sua força e resiliência, a inspiração por trás de cada obra de arte que eles criam e cada batalha que eles enfrentam.",
      "Em seus domínios rochosos, os anões forjam não apenas armas e armaduras, mas também o destino de suas próprias almas, enquanto Grún os observa com um olhar que é tão antigo quanto as montanhas que ela chama de lar.",
    },
  },
  {
    nome = "Kaern",
    chave = "Kaern",
    categoria = "Grande",
    selecionavel = true,
    kitConhecido = true,
    slots = {
      { "Força sobrenatural", "Constituição sobrenatural" },
      { "Duelista épico", "Cavaleiro épico" },
      { "Necromancia" },
      { "Manipulação da raiva" },
      { "Manipulação das armas" },
    },
    lore = {
      "Kaern é uma figura imponente cuja presença inspira temor e respeito. Seu porte robusto e musculoso é adornado com armaduras feitas dos metais mais resistentes, marcadas por cicatrizes de batalhas passadas. Seu olhar é penetrante e extremamente intimidador, refletindo a ferocidade e a determinação que ele incute em seus seguidores. Como filho da deusa da morte, Tenebria, Kaern nasceu em meio às sombras das batalhas mais sangrentas e brutais. Ele é o produto da união entre a escuridão da morte e a fúria da guerra, tornando-o uma força formidável e implacável.",
      "Os cultos de Kaern são escassos, porém de grande fervor, principalmente em épocas de guerra ou tensões entre as civilizações deste vasto mundo. Todos os rituais conhecidos a Kaern exigem o derramamento de sangue, mais especificamente sacrifícios, principalmente sangue de inimigos de quem o convoca, sendo apenas assim que o deus costuma mostrar sinais de reconhecimento ao seu chamado. \"Piedade se dá apenas aos amigos\" é uma frase dita por seus devotos.",
      "Kaern criou a raça dos orcs à sua imagem e semelhança. Estes guerreiros são dotados de uma força física incomparável e uma resistência que desafia qualquer adversidade. Sua pele é áspera e resistente, marcada por tatuagens e cicatrizes de batalhas passadas. Eles são os filhos da guerra, criados para lutar e conquistar em nome de seu deus.",
      "Sob a orientação de Kaern, os orcs formam exércitos poderosos e muito numerosos, capazes de dominar territórios e esmagar seus inimigos com uma determinação implacável. Eles são os instrumentos da vontade de seu deus, marchando para a guerra com o ímpeto de um furacão e a ferocidade de uma avalanche. Em sua busca por conquista e glória, os orcs veem Kaern como seu líder supremo e protetor, dispostos a seguir suas ordens até mesmo para os confins do mundo e além. Para eles, ele é a encarnação da própria guerra, uma força da natureza que não pode ser contida nem derrotada.",
      "Como filho da Deusa da Morte, Kaern entende o valor da vida e da morte na balança da existência. Ele guia seus seguidores com uma mão de ferro, lembrando-lhes que a guerra é tanto uma arte quanto uma ciência, e que a morte é apenas o preço a ser pago pela vitória e pelo domínio sobre os fracos e os adversários.",
    },
  },
  {
    nome = "Merewen",
    chave = "Merewen",
    categoria = "Grande",
    selecionavel = true,
    kitConhecido = true,
    slots = {
      { "Destreza sobrenatural" },
      { "Intuição artística", "Charme sobrenatural" },
      { "Manipulação da água" },
      { "Criação sobrenatural" },
      { "Manipulação do amor" },
    },
    lore = {
      "Nas vastas extensões dos mares e oceanos, onde as ondas dançavam ao ritmo das marés e os segredos do abismo ecoavam em murmúrios sussurrantes, reinava Merewen, a deusa dos mares e dos Selkies. Filha das águas primordiais, ela personificava a beleza e a serenidade das profundezas azuis, sua presença envolvendo os seres marinhos em um abraço de amor e proteção. Desde os tempos imemoriais, Merewen se erguia como uma luz brilhante nas trevas do oceano, sua beleza inigualável refletida nas águas cristalinas. Seus olhos, tão profundos quanto os abismos mais sombrios, emanavam uma sabedoria antiga e uma compaixão infinita por todas as criaturas marinhas.",
      "Enquanto seu pai, Isydras, permanecia nas profundezas, raramente visível e ainda mais raramente alcançável, Merewen caminhava entre os reinos terrestres e marítimos, tecendo laços de harmonia e equilíbrio entre ambos. Seu toque era suave como a brisa marinha e poderoso como as correntes oceânicas, guiando os destinos dos que buscavam seu favor. Entre todas as criaturas marinhas, os Selkies eram os mais próximos do coração de Merewen.",
      "Com sua habilidade mágica de se transformar em seres humanos ao remover sua pele, os Selkies eram os guardiões dos segredos das profundezas, mantendo viva a conexão entre os mundos terrestres e marítimos, as tribos Selkies, cada uma representando uma faceta única da vastidão dos oceanos, veneravam Merewen como sua mãe e protetora. Entre elas, os Selkies da Baleia Azul erguiam-se como os mais poderosos e majestosos, suas formas refletindo a grandiosidade das criaturas mais imponentes dos mares.",
    },
  },
  {
    nome = "Mungus",
    chave = "Mungus",
    categoria = "Grande",
    selecionavel = true,
    kitConhecido = true,
    slots = {
      { "Destreza sobrenatural", "Manipulação sobrenatural" },
      { "Ladinagem" },
      { "Ilusão" },
      { "Audiocinese" },
      { "Manipulação das sombras" },
    },
    lore = {
      "Mungus é uma figura sinuosa e astuta, cujos passos ecoam nas sombras mais escuras e nos becos mais ocultos. Seus olhos são como brasas ardentes, sempre alertas para oportunidades e intriga. Ele veste-se com roupas escuras e esfarrapadas, camuflando-se nas trevas que ele tanto domina, sua aparência nunca foi descrita em livros.",
      "Como filho da Deusa da Morte, Tenebria, Mungus nasceu em um reino de sombras e engano, onde a morte e o roubo são irmãos gêmeos. Ele é o arquétipo do trapaceiro, o mestre das artes furtivas e o senhor dos mundos clandestinos. Um deus pouco cultuado, seus adeptos frequentemente sendo os ladrões, golpistas e assassinos, possuindo templos escondidos e que exigem enigmas para serem adentrados.",
      "Mungus criou a raça dos goblins à sua imagem e semelhança. Estes seres pequenos e ágeis são muito semelhantes aos filhos da noite, habilidosos em furtividade e trapaça. Sua pele varia do verde ao marrom, permitindo-lhes camuflar-se facilmente na escuridão dos bosques e cavernas.",
      "Sob a orientação de Mungus, os goblins formam bandos de ladrões e saqueadores, pilhando vilarejos e cidades, e acumulando riquezas para seu deus e para si mesmos. Eles são mestres na arte do roubo e da sabotagem, sempre à espreita nas sombras, esperando por sua próxima oportunidade. Em sua busca por poder e riqueza, os goblins veem Mungus como seu líder supremo e protetor, dispostos a seguir suas ordens até mesmo para os lugares mais sombrios e perigosos. Para eles, ele é a personificação da própria trapaça, um deus cujo nome é sussurrado em temor e admiração pelos ladrões e vigaristas de todo o mundo.",
      "Como filho da Deusa da Morte, Mungus compreende a fragilidade da vida e a inevitabilidade da morte. Ele guia seus seguidores com uma mão habilidosa e implacável, lembrando-lhes que na luta pela sobrevivência, qualquer meio é justificável, e que o mais astuto sempre prevalece sobre o mais forte.",
    },
  },
  {
    nome = "Nellios",
    chave = "Nellios",
    categoria = "Grande",
    selecionavel = true,
    kitConhecido = true,
    slots = {
      { "Inteligência sobrenatural" },
      { "Ultra sensoriamento" },
      { "Telepatia", "Radiestesia" },
      { "Manipulação do ar" },
      { "Metamorfose animal" },
    },
    lore = {
      "Nellios é o deus dos ventos, senhor das Aaracrokas e filho de Asta, deus primordial dos Dragões. Diferentemente de grande parte das divindades, que foram concebidas do zero por seus pais, o vento enquanto entidade já existia muito antes da criação de Nellios, sendo quase tão antigo quanto os primordiais. Sua criação se deu quando seus ventos arrasavam as criações de Erinor, destruindo montanhas, florestas e biomas inteiros, fazendo-se necessária a intervenção do Deus Primordial do Céu para dar forma ao fenômeno do vento, nascendo assim Nellios.",
      "É retratado como um homem velho, sendo a Águia o animal que tem como símbolo. Nellios garante que os ventos correrão da forma como precisam, sem serem calmos ou destrutivos demais, e auxiliando Asta na proteção e integridade dos céus e das nuvens. O velho vento também é considerado o Senhor dos Povos Alados, venerado como o protetor, sendo inclusive o pai das Aaracrokas. A história da criação se deu quando o deus uniu-se com uma jovem deusa menor chamada Morgara, filha de Ras'buz e dama dos animais alados, e juntos conceberam as Aarakocras. Se Nellios é a águia, sua esposa é a coruja, e tal simbologia é vista com frequência nos templos da divindade.",
      "Seu culto vai além das tribos de Aarakocras, mas dos animais alados, aos pilotos das máquinas aéreas que oram e fazem sacrifícios a Nellios para que possam ter bons ventos em suas jornadas, e é até comum em embarcações a presença de um pequeno altar em homenagem ao deus dos ventos. O Velho Vento é orgulhoso, sábio, nobre e implacável. Exige muito daqueles que o seguem, e suas recompensas nem sempre estão a altura de suas exigências, mas sua força é reconhecida e seu culto é forte.",
    },
  },
  {
    nome = "Noctefir",
    chave = "Noctefir",
    categoria = "Grande",
    selecionavel = true,
    kitConhecido = true,
    slots = {
      { "Constituição sobrenatural" },
      { "Cavaleiro épico" },
      { "Manipulação das sombras" },
      { "Metamorfose mortal" },
      { "Telepatia", "Manipulação dos sonhos" },
    },
    lore = {
      "O cavaleiro negro que marcha por todo o mundo montado em seu cavalo Érebo, cujos cascos dizem ser tão silenciosos quanto os passos de um gato, nas suas costas o manto de sombras e estrelas, seu elmo de corona solar é o responsável pelas luzes que são vistas no crepúsculo dos dias. O deus da noite, nasceu das sombras tecidas pela própria escuridão, filho de Asta, o senhor supremo do céu, e irmão de Ditrys, o dia, e Nellios, o vento. Desde o momento de sua concepção, Noctefir estava destinado a governar sobre os domínios da escuridão, embalado pela suave melodia das estrelas e pela serenidade da noite eterna.",
      "A figura de Noctefir sempre foi envolta em um manto de mistério e quietude. Enquanto sua irmã Ditrys brilhava com a luz ardente do sol e Nellios corria livremente pelos céus, Noctefir preferia as profundezas silenciosas da noite, onde as estrelas dançavam em torno dele como pérolas luminosas em um manto negro. Seu pai, Asta, observava com orgulho o desenvolvimento de seu filho, vendo nele a essência da escuridão que equilibrava a luz do dia. Noctefir era a personificação da tranquilidade noturna, da reflexão profunda e do descanso merecido após o brilho do sol ter se recolhido.",
      "No entanto, a jornada de Noctefir não foi sem desafios. Assim como Ditrys e Nellios tinham seus próprios domínios para governar, Noctefir enfrentou o fardo de sustentar as luzes da noite, guiando os viajantes perdidos com a luz das estrelas e protegendo os sonhadores com o manto de suas sombras, sua natureza solitária e contemplativa, encontrou companhia nas criaturas da noite: as corujas sábias, os lobos solitários e os morcegos ágeis. Ele ensinou a eles os segredos ocultos das trevas e as maravilhas que só podem ser vistas sob o manto da noite.",
      "À medida que os séculos passavam, Noctefir tornou-se uma figura venerada por aqueles que apreciavam a beleza e a calma da noite. Ele era adorado por poetas que encontravam inspiração sob o brilho das estrelas, por amantes que se encontravam à luz da lua e por todos aqueles que buscavam refúgio nas sombras reconfortantes da noite, mas também era igualmente temido por todos aqueles que ousavam lhe desrespeitar e invadir seus domínios sem permissão, fazendo com que este viesse a se tornar um dos mais populares deuses da atualidade.",
    },
  },
  {
    nome = "Oduwa",
    chave = "Oduwa",
    categoria = "Grande",
    selecionavel = true,
    kitConhecido = true,
    slots = {
      { "Manipulação sobrenatural" },
      { "Destreza sobrenatural" },
      { "Metamorfose mortal", "Liderança absoluta" },
      { "Manipulação da água" },
      { "Ilusão" },
    },
    lore = {
      "Oduwa é o deus dos rios e dos lagos, pai dos povos Giff, também conhecido como \"O Grande Hipopótamo\" entre aqueles em seu culto. Filho de Isydras, deus primordial da água, protetor dos biomas de água doce que existem em todo o mundo conhecido. Enquanto seu irmão Qosis nasceu como um valente guerreiro, e suas irmãs Merewen e Aslot são criaturas temíveis e misteriosas, o deus dos Giff é de todos os deuses um dos mais afáveis. De todos os filhos dos primordiais, Oduwa é reconhecido como um dos mais resistentes, com relatos de que sua pele é tão resistente que o senhor dos rios certa vez lançou um desafio para seus irmãos, primos e tios de que ninguém seria capaz de perfurar sua pele, e nenhum dos deuses de fato conseguiu.",
      "No entanto, a despeito de seu estilo afável e sua astúcia, o Grande Hipopótamo não pode ser subestimado: tanto a si quanto seus filhos são conhecidos como criaturas vastamente maliciosas, mestres na arte da enganação. Oduwa nunca aceita um acordo que não seja vantajoso para si mesmo, seja pela arte da negociação, ou pela enganação. Essa característica é reconhecida em seus filhos mais próximos, os Giff.",
      "O Grande Hipopótamo também é reverenciado pelos pescadores. Charmoso e compadecido, Oduwa certa vez viu um pescador se lamentando do fato de que era incapaz de encontrar uma mulher para amar, devido ao forte cheiro de enguias impregnado em seu corpo devido a sua profissão, o deus então ensinou ao jovem pescador que o charme de um homem reside em sua capacidade de encantar e fazer uma mulher se sentir amada, e não em sua riqueza ou beleza. Depois de ensinado, o pobre pescador se tornou tão bom com as palavras que até mesmo deitou-se com uma deusa, produzindo um filho com ela. Esta criança se tornou o primeiro dos Giff, e desde então os pescadores se tornaram conhecidos pelas suas habilidades de encantar os outros com suas palavras.",
    },
  },
  {
    nome = "Qhyrana",
    chave = "Qhyrana",
    categoria = "Grande",
    selecionavel = true,
    kitConhecido = true,
    slots = {
      { "Sabedoria sobrenatural" },
      { "Escudo psíquico" },
      { "Manipulação do ar" },
      { "Radiestesia", "Telepatia" },
      { "Manipulação dos sonhos" },
    },
    lore = {
      "Quando as folhas começam a cair e o ar se torna frio, Qhyrana volta a ser lembrada por todo o mundo, como a deusa do outono e senhora das harpias. Filha da deusa da morte, Tenebria, Qhyrana é uma figura solitária e implacável, cuja presença é sentida em cada sopro de vento outonal e em cada grito crocito dos rapinantes do céu, sua morada podia ser encontrada entre as folhas douradas e os ventos cortantes do outono. Seus olhos cinzentos sendo capazes de ver além das aparências, sondando a verdadeira natureza de todos os seres vivos e mortos.",
      "Desde jovem, Qhyrana mostrou-se distante e reservada, de natureza selvagem, raramente associando-se com outras divindades. Sua única exceção era o deus do vento, Nellios, cuja liberdade e imprevisibilidade ecoavam em harmonia com a própria essência da deusa do outono. Juntos, eles dançavam pelos céus, tecendo padrões de folhas douradas e fios de vento em um eterno balé sazonal.",
      "No entanto, mesmo com essa rara conexão, Qhyrana preferia as florestas outonais e as montanhas ventosas, onde as harpias cantavam suas canções selvagens e os animais se preparavam para o inverno que se aproximava. Ela era a guardiã das mudanças de estação, testemunhando o ciclo eterno de vida e morte que ecoava através da natureza. Suas filhas, as harpias, eram conhecidas por sua beleza selvagem e sua fúria implacável, eram os aliados mais próximos de Qhyrana. Elas eram suas mensageiras, voando pelos céus para espalhar os ventos outonais e anunciar a chegada da estação da colheita e da preparação para o inverno, caçando sempre que sentiam fome.",
      "Apesar de sua personalidade, Qhyrana continua sendo respeitada, temida e adorada, ainda que por vezes o seu culto seja associado ao deus Ras'buz ou ao próprio Nellios. hoje o que mais atrai atenção são os oráculos em sua homenagem, templos criados próximos a florestas e montanhas onde pessoas buscam receber revelações através dos olhos da deusa.",
    },
  },
  {
    nome = "Qosis",
    chave = "Qosis",
    categoria = "Grande",
    selecionavel = true,
    kitConhecido = true,
    slots = {
      { "Constituição sobrenatural", "Fator de cura regenerativo" },
      { "Guerreiro épico" },
      { "Indução do medo" },
      { "Manipulação do clima" },
      { "Manipulação da eletricidade", "Manipulação da água" },
    },
    lore = {
      "Conhecido como o deus que representa os pântanos, as chuvas e as cheias, além de ser o senhor dos Lizarianos. Sua representação é a de um homem de pele negra, com olhos dourados e dreadlocks longos, embora seja o criador dos Lizarianos, poucas são as representações que tratam Qosis como uma divindade dos grande lagartos. Seu símbolo, no entanto é costumeiramente um crocodilo, e seus seguidores cultuam tal animal porque acreditam que são a figura mais próxima da divindade. Foi o filho mais velho de Isydras, e portanto aquele incubido de carregar consigo a responsabilidade de banhar os campos com a chuva e manter a terra úmida.",
      "Dos filhos do Deus da Água, Qosis é um dos mais silenciosos, é uma figura séria e implacável embora não seja necessariamente de um caráter ruim ou maligno. Devido a importância que tem, sempre foi uma divindade muito cultuada, especialmente entre os agricultores que buscavam por chuvas constantes, ou os pescadores em épocas de secas quando os rios se mostravam em níveis abaixo do esperado. 'Os deuses estão na chuva' é um ditado comum pelo culto a Qosis, uma vez que existe uma lenda que de tempos em tempos é possível ouvir as vontades da divindade quando se ora a ele em meio a uma tempestade.",
      "Durante o início da existência, Qosis desejava também para si uma raça de criaturas que lhe representasse, e que pudesse espalhar sua vontade pelo mundo, e assim os Lizarianos foram criados. Eles foram feitos a semelhança de um presente que certa feita Ras'Buz fez para o deus dos pântanos: os Crocodilos. Tão maravilhado com o presente ofertado pelo seu primo, que criou sua raça de súditos em honra a tais animais, chamando-os de Lizarianos. Seus filhos foram feitos como seres fortes, com magia forte e inteligência, de forma que eram naturalmente poderosos.",
      "Os Lizarianos ascenderam com ancestral Império de Korus, se tornaram imensamente poderosos e, pouco depois do início da Segunda Era mergulharam em direção a ruína pelo seu próprio deus, como punição pela arrogância de tais criaturas, as terras do antigo Império de Korus, hoje formam um árido e inóspito deserto de mesmo nome, onde nada cresce, nenhuma chuva caí e praticamente nenhuma criatura vive. Desde então os fortes e orgulhosos Lizarianos se tornaram uma sombra daquilo que um dia já foram, e vivem suas vidas buscando formas de se redimir para com seu criador.",
    },
  },
  {
    nome = "Ras'buz",
    chave = "Rasbuz",
    categoria = "Grande",
    selecionavel = true,
    kitConhecido = true,
    slots = {
      { "Força sobrenatural" },
      { "Omnilinguismo" },
      { "Metamorfose animal" },
      { "Manipulação da água", "Manipulação da terra", "Manipulação do ar" },
      { "Liderança absoluta" },
    },
    lore = {
      "Filho de Erinor, o deus primordial da terra, Ras'buz era uma figura poderosa e venerada por todos os povos feras que habitavam as vastas terras selvagens. O povo Ghiscari, conhecido também como o povo fera, era formado por tribos que carregavam características distintas de animais. De leões a águias, de serpentes a ursos, cada tribo tinha sua própria cultura e tradição, mas todas elas adoravam Ras'buz como seu único e verdadeiro deus, as aparências dos Ghiscari variavam de tribo para tribo, mas todas compartilhavam uma característica comum: uma forma humana que escondia suas verdadeiras naturezas animais.",
      "Essa habilidade de assumir uma forma humana permitia que os Ghiscari se misturassem entre outras raças sem levantar suspeitas sobre sua verdadeira identidade, Ras'buz era o criador e protetor de todos os animais que habitavam a terra, nomeando e designando espaço e função para cada uma de suas criaturas. No entanto, o fardo dessa responsabilidade pesava sobre seus ombros divinos, e a história conta que o esforço de criar e cuidar de tantos seres o fez mergulhar em um sono profundo por eras. Quando finalmente despertou, Ras'buz encontrou seu povo Ghiscari sendo caçado e oprimido por outras raças. Uma fúria imensa inflamou seu coração, pois ele via seus filhos serem tratados como bestas, suas culturas sendo desrespeitadas e seu modo de vida ameaçado.",
      "Essa experiência despertou em Ras'buz uma profunda desconfiança e até mesmo aversão às outras raças. Ele jurou proteger seu povo a todo custo, ensinando-lhes a arte da sobrevivência e da guerra. Sob sua orientação, os Ghiscari aprenderam a se defender e a preservar suas tradições, mantendo viva a chama da adoração por seu deus, ras'buz tornou-se uma figura temida, reverenciada não apenas como o deus dos animais, mas como o protetor e líder de seu povo. Sua presença imponente ecoa pelas terras selvagens, lembrando a todos que os Ghiscari não eram apenas animais, mas uma civilização antiga e orgulhosa, destinada a reivindicar seu lugar no mundo.",
    },
  },
  {
    nome = "Sidharis",
    chave = "Sidharis",
    categoria = "Grande",
    selecionavel = true,
    kitConhecido = true,
    slots = {
      { "Charme sobrenatural" },
      { "Fator de aura regenerativa", "Intuição artística" },
      { "Manipulação da luz" },
      { "Metamorfose mortal" },
      { "Ilusão" },
    },
    lore = {
      "Nos reinos etéreos onde os raios dourados do sol aquecem a terra e as cores vivas da natureza dançam em harmonia, existe uma deusa cujo domínio é tão efervescente quanto os dias quentes do verão. Seu nome é Sidharis, a senhora da calidez e das criaturas encantadas que se deleitam sob sua luz. Filha de Bran, o deus primordial da terra e dos gigantes, Sidharis irradia a energia calorosa e alegre do verão. Sua essência é tão radiante quanto os raios do sol que dão vida a cada canto do mundo. Ela é irmã de Grún, a deusa das montanhas, cuja presença sólida e majestosa complementa a sua própria.",
      "Mas é entre os campos floridos e os bosques exuberantes que vivem o seus filho e filhas, as fadas. Essas criaturas nascem da magia e da energia do verão, cada uma delas uma manifestação da própria essência de Sidharis. Porém, seu nascimento é tido como único a cada vez que acontece e podem nascer a partir da energia de qualquer objeto: uma gota de orvalho, uma joia, um reflexo na água, grama... Porém, é necessário que uma criatura viva esteja as observando em seu nascimento, para que então a deusa atue em sua criação. Com suas asas translúcidas e seus risos melodiosos, as fadas enchem os dias de luz e encanto, trazendo alegria e vitalidade para todas as criaturas que com elas convivem.",
      "Aqueles que voltam sua fidelidade a esta divindade é considerado um amigo das fadas e por elas pode ser bem quisto, uma vez a buscam para celebrar as estações, o desejo de prosperidade, alegria e proteção.",
    },
  },
  {
    nome = "Sýdos",
    chave = "Sydos",
    categoria = "Grande",
    selecionavel = true,
    kitConhecido = true,
    slots = {
      { "Carisma sobrenatural", "Charme sobrenatural" },
      { "Intuição artística" },
      { "Fitocinese" },
      { "Manipulação do amor" },
      { "Cura" },
    },
    lore = {
      "Nos reinos verdejantes onde a vida pulsa em cada raiz e cada broto, a majestosa presença de Sýdos rege sobre o renascimento da natureza e o florescer da vida. Ele é o senhor da fertilidade, cujo toque mágico faz os campos florescerem em um esplendor de cores vibrantes e os frutos darem abundantes colheitas. Reverenciado como o rei das ninfas, as belas e sedutoras criaturas da natureza que dançam entre as folhagens e deslizam pelas águas límpidas dos riachos, sua presença é uma sinfonia de vida e amor, que enche os corações daqueles que o buscam com uma sensação de renovação e fertilidade.",
      "Ao lado de Sýdos está Ammis, a gloriosa divindade cujo retorno anuncia o despertar da natureza após os meses gélidos do inverno. Juntos, formam um casal divino cujo amor é como um bálsamo que fertiliza a terra e faz os campos florescerem em um espetáculo de cores e aromas exuberantes. Essa união é celebrada com grande fervor como uma festa da vida, um hino à fertilidade e à renovação que ecoa através dos tempos, inspirando a cada novo ciclo de primavera.",
      "Desde tempos imemoriais, Sýdos tem sido reverenciado como o guardião dos campos e jardins, o protetor das sementes e o patrono dos agricultores. Sua presença benevolente é sentida em cada broto que desponta e em cada fruto que amadurece, como uma bênção da própria terra. Junto a Ammis, ele lidera os festivais da primavera, onde as ninfas dançam em seu louvor e os mortais oferecem suas preces por uma colheita farta e pela continuidade da vida em harmonia com a natureza.",
    },
  },
  {
    nome = "Thaleessa",
    chave = "Thaleessa",
    categoria = "Grande",
    selecionavel = true,
    kitConhecido = true,
    slots = {
      { "Força sobrenatural" },
      { "Sabedoria sobrenatural" },
      { "Indução do medo" },
      { "Fitocinese", "Manipulação da terra" },
      { "Metamorfose animal" },
    },
    lore = {
      "Nos recantos mais profundos e exuberantes das florestas antigas, onde a vegetação dança ao ritmo da brisa e os rios fluem com a serenidade das águas intocadas, Thaleessa reina em majestade, com uma presença tão imponente quanto as próprias árvores que ela protege. Thaleessa é a guardiã dos bosques e das criaturas que os habitam, uma divindade cuja essência está entrelaçada com a vida e a vitalidade das florestas. Companheira e aliada de Ras'buz, o deus dos animais, cujo domínio se estende sobre as feras selvagens e os animais que percorrem os bosques e pradarias. Seu amor pela natureza e sua habilidade de se comunicar com os animais o tornam um aliado valoroso para Thaleessa em sua missão de proteger e preservar a harmonia das florestas.",
      "A união entre Thaleessa e Ras'buz é uma aliança sagrada, uma simbiose entre a beleza serena das florestas e a força selvagem dos animais. Juntos, eles trabalham para manter o equilíbrio natural, protegendo as criaturas da floresta e garantindo que a vida floresça em sua plenitude, protetores dos animais e juntos, criaram os centauros e minotauros, seres majestosos e imponentes com a tarefa de auxiliar seus pais a defender seus irmãos.",
      "Ao longo dos tempos, Thaleessa e Ras'buz têm sido venerados como os guardiões da natureza, os protetores das criaturas selvagens e os patronos dos que vivem em harmonia com o mundo natural. Seu amor mútuo pela vida selvagem e seu compromisso com a preservação das florestas os tornam figuras veneradas não apenas pelos habitantes das florestas, mas por todos aqueles que reconhecem a importância de cuidar e respeitar o ambiente natural que nos rodeia.",
    },
  },
  {
    nome = "Wenti",
    chave = "Wenti",
    categoria = "Grande",
    selecionavel = true,
    kitConhecido = true,
    slots = {
      { "Constituição sobrenatural" },
      { "Ultra sensoriamento", "Duelista épico" },
      { "Manipulação do gelo" },
      { "Radiestesia" },
      { "Manipulação do clima" },
    },
    lore = {
      "Wenti é uma divindade majestosa que emana uma aura de frieza e serenidade, que emergiu das frias brumas que envolvem as terras geladas do Norte, onde o vento cortante e a neve eterna reinam supremos. Como uma divindade nascida das profundezas do inverno, ela personifica a calma implacável e a força silenciosa da estação mais fria do ano. Sua aparência é descrita com seus cabelos feitos de flocos de neve cintilantes, seus olhos brilham como estrelas no céu noturno, sua pele é de um tom frio, literalmente quase branca como a própria cor da neve. Ela veste um manto feito de gelo cristalino, que brilha com tons azulados à luz do sol.",
      "O culto de Wenti é muito poderoso no Norte de Petrichor, onde a maioria de seus templos se concentra, o maior presente no Forte Grizzlemont, porém ainda muito respeitada pelo continente, visto que existem outros templos em menor quantidade por toda Petrichor, de devotos que sempre oram por invernos menos rigorosos.",
      "Ao contemplar a vastidão congelada das terras do Norte, Wenti sentiu o impulso de criar uma raça que incorporasse a essência do inverno. Assim, ela deu origem aos Ursari. Estes poderosos ursos são dotados de pelagens espessas que os protegem do frio intenso e músculos robustos que os tornam formidáveis guerreiros. Sob a orientação de Wenti, sua nobre criação prospera como uma raça poderosa e respeitada em todo o continente de Petrichor. Eles são a personificação da força do inverno, lembrando aos mortais que mesmo nas condições mais adversas, a determinação e a coragem podem prevalecer.",
    },
  },
  {
    nome = "Haliana, a Deusa da Pesca",
    chave = "HalianaaDeusadaPesca",
    categoria = "Menor",
    selecionavel = false,
    kitConhecido = false,
    slots = {},
    lore = {
      "Haliana nasceu da união entre Merewen, a Senhora dos Mares e protetora das grandes águas, e Thandor, o Guardião dos Cardumes, um deus menor reverenciado por pescadores costeiros e comunidades ribeirinhas. Sua concepção foi celebrada como a fusão perfeita entre a vastidão do oceano e a abundância dos rios, simbolizando a generosidade das águas para com aqueles que delas dependem para sobreviver. Desde seu nascimento, Haliana foi associada ao movimento tranquilo e cíclico das marés, à paciência necessária para lançar redes e à sabedoria de saber quando colher e quando preservar. Ao contrário de muitos deuses menores que surgiram apenas como manifestações de um único domínio, Haliana herdou atributos tanto de sua mãe quanto de seu pai, tornando-se uma divindade intermediária entre os pescadores de águas salgadas e doces.",
      "Quando jovem entre os deuses, Haliana não se contentou em reinar sobre um único porto ou povoado. Ela caminhou entre as comunidades costeiras, viveu com ribeirinhos, navegou com marinheiros e dividiu-se entre os grandes navios baleeiros e as pequenas canoas de pesca artesanal. Dizem que aprendeu cada técnica, cada nó, cada cântico entoado para acalmar as águas. Em cada local, deixou um presente: um novo tipo de rede, um canto para afastar tempestades, ou a bênção para que um rio nunca secasse. Ela é frequentemente representada como uma mulher jovem com pele que reflete tons de água — ora verde, ora azul, ora prateada — e cabelos longos como algas, adornados com conchas e pérolas enevoadas como nuvens. Carrega um cajado de bambu entalhado com runas de maré e, nas costas, uma rede de pesca feita com fios de luz lunar. Seus devotos dizem que, quando essa rede é lançada, ela não captura apenas peixes, mas também sonhos e boas fortunas para quem acredita em seu favor.",
      "O culto a Haliana é forte em vilarejos costeiros e à beira de rios. Seus festivais geralmente ocorrem no início da estação de pesca, quando as primeiras redes são lançadas ao mar ou ao rio. Nesse dia, os pescadores oferecem a ela as primeiras presas do dia, devolvendo-as à água em sinal de respeito e para garantir fartura durante todo o ciclo de pesca. Entre suas histórias mais conhecidas, há a do Juramento das Redes Vazias. Conta-se que Haliana, ao ver uma vila inteira se afogar na ganância de pescar mais do que precisava, puniu-os secando o mar diante deles por três dias e três noites. Apenas quando prometeram devolver metade de sua pesca futura aos famintos de outros lugares é que as águas voltaram, repletas de vida. Haliana não é apenas padroeira dos pescadores, mas também guardiã da partilha, da paciência e da harmonia com a natureza aquática. É uma deusa que lembra a todos que o mar e o rio podem ser generosos, mas apenas para aqueles que os respeitam.",
    },
  },
  {
    nome = "Morgara, a Deusa das Aves",
    chave = "MorgaraaDeusadasAves",
    categoria = "Menor",
    selecionavel = false,
    kitConhecido = false,
    slots = {},
    lore = {
      "Filha de Ras’buz, o Senhor das Bestas, e de Serelyne, a antiga deusa dos céus diurnos já perdida na memória dos mortais, Morgara nasceu no limiar entre a luz e a escuridão — naquele momento de transição em que o dia se despede e a noite começa a vigiar o mundo. Desde o início, suas asas eram invisíveis aos olhos comuns, mas seu espírito sempre carregou o farfalhar suave das penas e o chamado silencioso da noite. Seu pai, Ras’buz, lhe concedeu o dom de compreender todas as aves, de sentir o bater de asas a quilômetros de distância e de guiar suas migrações mesmo sem se mover. Já Serelyne lhe legou o domínio da visão aguçada e da leitura dos ventos, para que pudesse observar o mundo do alto e enxergar aquilo que se oculta na penumbra. Morgara cresceu, assim, entre os ninhos mais altos e as florestas mais densas, aprendendo a se mover como sombra e a ouvir os segredos que apenas os céus e as aves conhecem.",
      "Ao atingir sua maturidade divina, Morgara cruzou os céus e encontrou Nellios, o deus dos ventos, em uma disputa de território aéreo que durou sete noites e sete dias. Ele a desafiava com correntes tempestuosas, e ela respondia com esquadrões de corujas e falcões que cortavam o ar como lâminas. No oitavo amanhecer, reconheceram no outro não um inimigo, mas um igual. Da rivalidade nasceu a admiração, e desta, o laço que uniu seus destinos. Casaram-se sobre um penhasco que tocava as nuvens, enquanto bandos de aves em milhares de cores giravam ao redor, formando um anel vivo no céu. Morgara assumiu então o papel de guardiã das aves e mensageira dos céus noturnos. Seu símbolo maior é a coruja — em especial a coruja-de-asas-prateadas, criatura sagrada que se diz ser capaz de carregar mensagens entre mundos. Os pescadores invocam seu nome para pedir que gaivotas e albatrozes lhes guiem até cardumes; caçadores a reverenciam para que falcões e águias se tornem seus aliados; e viajantes noturnos agradecem suas corujas, que aparecem nos ramos como faróis silenciosos, apontando caminhos seguros. Dizem que quando a noite está calma e o vento sopra de maneira ritmada, é Nellios dançando com Morgara nos céus, e o farfalhar das asas que se ouve entre as árvores é o sussurro dela, guiando seu bando eterno.",
    },
  },
  {
    nome = "Vista, a Deusa da Colheita",
    chave = "VistaaDeusadaColheita",
    categoria = "Menor",
    selecionavel = false,
    kitConhecido = false,
    slots = {},
    lore = {
      "Vista nasceu do enlace entre Sýdos, o poderoso deus da fertilidade, e Ammis, a graciosa deusa da primavera. Seu nascimento foi celebrado com grande júbilo, pois unia, pela primeira vez, dois dos ciclos mais vitais à sobrevivência de mortais e imortais: a fertilidade da terra e o renascimento das estações. Desde criança, Vista demonstrava um temperamento sereno, uma voz suave e um olhar que parecia compreender tanto as dores do campo quanto as alegrias da abundância. Ao contrário de muitos deuses que se colocam acima dos mortais, Vista caminhava entre eles. Ajudava nas plantações, ensinava técnicas de cultivo e, por vezes, se sentava em torno das fogueiras para ouvir as histórias de famílias que viviam da terra. Era considerada uma deusa com direitos e deveres, algo incomum para uma divindade: não se via como soberana distante, mas como guardiã e parceira no ciclo de plantar, cuidar e colher.",
      "Seu domínio abrangia todo o processo agrícola, desde a escolha das sementes até o armazenamento do grão. Os cultos a Vista se espalharam por vilas, aldeias e cidades rurais, especialmente entre povos que dependiam de safras anuais para sobreviver. Para eles, Vista não era apenas uma figura a ser reverenciada em festivais, mas uma presença constante, invocada em cada início de safra e agradecida a cada colheita bem-sucedida. Vista possuía três deveres sagrados:",
      "1. Abençoar a terra para que permanecesse fértil.",
      "2. Proteger os agricultores das pragas e desastres naturais, sempre que a balança cósmica permitisse.",
      "3. Ensinar o equilíbrio, lembrando que a terra deve ser respeitada, nunca explorada além de seu limite.",
      "Os direitos de Vista eram igualmente claros, e até mesmo os mortais mais humildes os reconheciam: ela podia recolher oferendas na forma de parte da primeira colheita, exigir que a terra descansasse quando necessário e ser consultada antes de mudanças radicais nas práticas agrícolas de um povoado. A deusa é frequentemente retratada com um manto feito de espigas de trigo e flores silvestres, segurando uma foice dourada em uma mão e um cesto transbordando de frutos na outra. Seu símbolo é um círculo de ouro que representa o sol, cercado por oito espigas — as estações do plantio e colheita. Vista, apesar de sua natureza compassiva, não hesita em retirar suas bênçãos daqueles que desrespeitam o equilíbrio da terra. Há histórias de vilas inteiras que, após abusarem do solo e queimarem florestas sagradas, viram suas plantações murcharem até o último talo. Entre todos os deuses menores, Vista é lembrada como a mais próxima dos mortais, e talvez por isso sua fé tenha resistido por tantas gerações. Para os camponeses, ela não é apenas uma deusa — é a vizinha que caminha descalça pelos campos, que ri com eles no tempo de fartura e que chora junto quando a seca chega.",
    },
  },
}

local porNome = {}
for _, d in ipairs(CatalogoDeuses.itens) do porNome[d.nome] = d end

function CatalogoDeuses.buscarPorNome(nome)
  return porNome[tostring(nome or "")]
end

-- Texto de um slot do kit. Um slot pode oferecer escolha entre poderes,
-- e nesse caso o .bib os separa por "ou".
function CatalogoDeuses.textoSlot(slot)
  return table.concat(slot or {}, " ou ")
end

-- Explica POR QUE a divindade nao pode ser escolhida. As duas razoes sao
-- diferentes e uma delas e temporaria, entao a ficha diz qual e qual em vez
-- de apenas desabilitar o botao.
function CatalogoDeuses.motivoBloqueio(d)
  if d == nil then return "" end
  if d.categoria == "Primordial" then
    return "entidades da criação não concedem Aspecto Divino"
  elseif d.categoria == "Menor" then
    return "ainda sem kit de poderes definido no livro da mesa"
  end
  return ""
end

function CatalogoDeuses.listarPorCategoria(cat)
  local r = {}
  for _, d in ipairs(CatalogoDeuses.itens) do
    if d.categoria == cat then table.insert(r, d) end
  end
  return r
end

return CatalogoDeuses

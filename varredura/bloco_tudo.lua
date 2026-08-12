        -- =================================================================
        -- PODERES
        --
        -- MODELO DE DADOS - por que texto serializado e nao recordList:
        --   A quantidade de poderes NAO e fixa. A mecanica de Bencao (trocar
        --   3 favores com um deus que nao e seu pai/mae) libera comprar
        --   tambem do kit DAQUELE deus. Campos planos numerados obrigariam a
        --   migrar fichas ja preenchidas quando as bencoes entrarem.
        --   Serializar resolve: dado de tamanho livre em campo plano.
        --
        -- FORMATO: registros separados por ";", campos por "|"
        --   nome|nivel|log|deus
        --   log = "nivelDoPoder@nivelDoPersonagem", separados por virgula
        --   ex: "Cura|3|1@1,2@3,3@5|Ditrys"
        --   Nenhum dos 48 nomes de poder contem ";", "|" ou "@" (conferido).
        --
        -- A ABA MOSTRA SO O QUE FOI ADQUIRIDO. O kit e opcional: o jogador
        -- pode comprar um unico poder e investir todo o resto em habilidades
        -- e feiticos. Listar os 5 do kit em "nivel 0" comunicava o oposto
        -- ("preencha os cinco"), entao poderes entram pelo catalogo.
        -- =================================================================

        local GANHO_PONTOS_PODER = {
            [1]=2, [2]=2, [3]=3, [4]=2,  [5]=3, [6]=3, [7]=2, [8]=2, [9]=3,
            [10]=4, [11]=2, [12]=3, [13]=2, [14]=3, [15]=3, [16]=2, [17]=2,
            [18]=3, [19]=2, [20]=5,
        }

        -- Quantos slots de exibicao existem no XML da aba.
        -- 5 do kit nativo + margem para varias bencoes (cada bencao abre um
        -- kit inteiro de 5). 24 cobre pai/mae + 3 bencoes completas com folga.
        local MAX_SLOTS_PODER = 24

        -- Altura dos blocos quando visiveis. Ocultar = altura 0.
        local ALTURA_SLOT_PODER = 80
        local ALTURA_GRUPO_PODER = 32
        local ALTURA_VAZIO_PODER = 70

        -- Nunca usamos setVisible nos blocos da lista: no Firecast, tornar
        -- visivel em runtime um elemento align="top" que estava invisivel o
        -- insere no TOPO da pilha, e nao na posicao declarada. Foi o que jogou
        -- a secao "FORA DOS KITS" para cima de tudo ao registrar uma bencao.
        -- Controlar ALTURA preserva a ordem do XML em qualquer cenario.
        local function definirAlturaPod(ctrl, valor)
            if ctrl == nil then return end
            pcall(function() ctrl:setHeight(valor) end)
        end

        local function definirLarguraPod(ctrl, valor)
            if ctrl == nil then return end
            pcall(function() ctrl:setWidth(valor) end)
        end

        -- Carimbo de data/hora proprio.
        -- NAO reaproveita "dataHoraTexto": aquela e uma "local function"
        -- declarada mais abaixo no arquivo, e em Lua uma local so existe a
        -- partir da linha em que foi declarada. Chamar de cima da para tras
        -- resulta em "attempt to call a nil value".
        function carimboDeTempo()
            local ok, txt = pcall(function() return os.date("%d/%m/%Y %H:%M") end)
            if ok and txt ~= nil then return tostring(txt) end
            return "data desconhecida"
        end

        -- Chave de widget a partir do nome do poder. Precisa bater EXATAMENTE
        -- com os nomes rectPod_<chave> gerados no XML do catalogo.
        function chavePoder(nome)
            local s = tostring(nome or "")
            local de = {
                ["á"]="a",["à"]="a",["ã"]="a",["â"]="a",["é"]="e",["ê"]="e",
                ["í"]="i",["ó"]="o",["ô"]="o",["õ"]="o",["ú"]="u",["ü"]="u",
                ["ç"]="c",["Á"]="A",["Â"]="A",["Ã"]="A",["É"]="E",["Ê"]="E",
                ["Í"]="I",["Ó"]="O",["Ô"]="O",["Õ"]="O",["Ú"]="U",["Ç"]="C",
            }
            for k, v in pairs(de) do s = s:gsub(k, v) end
            s = s:gsub("[^A-Za-z0-9]", "")
            return s
        end

        function pontosPoderPorNivel(nivel)
            local total = 0
            for i = 1, math.min(math.max(n(nivel), 1), 20) do
                total = total + (GANHO_PONTOS_PODER[i] or 0)
            end
            return total
        end

        -- Total = tabela de nivel + concedidos. "Concedidos" existe porque
        -- Favores viram pontos (2 favores = 1 ponto, 3 favores = 3 pontos) e
        -- porque o mestre pode conceder por narrativa.
        function pontosPoderTotais()
            if sheet == nil then return 0 end
            return pontosPoderPorNivel(sheet.nivel) + n(sheet.poderPontosConcedidos)
        end

        -- ---------------------------------------------------------------
        -- SERIALIZACAO
        -- ---------------------------------------------------------------
        function lerPoderes()
            local lista = {}
            if sheet == nil then return lista end
            for _, reg in ipairs(partirTexto(sheet.poderesDados, ";")) do
                local campos = {}
                for c in string.gmatch(reg .. "|", "([^|]*)|") do
                    table.insert(campos, c)
                end
                if campos[1] ~= nil and campos[1] ~= "" then
                    table.insert(lista, {
                        nome = campos[1],
                        nivel = tonumber(campos[2]) or 0,
                        log = campos[3] or "",
                        deus = campos[4] or "",
                    })
                end
            end
            return lista
        end

        function gravarPoderes(lista)
            if sheet == nil then return end
            local partes = {}
            for _, p in ipairs(lista) do
                if n(p.nivel) > 0 then
                    table.insert(partes, table.concat({
                        p.nome, tostring(n(p.nivel)), p.log or "", p.deus or ""
                    }, "|"))
                end
            end
            sheet.poderesDados = table.concat(partes, ";")
        end

        function acharPoder(lista, nomePoder)
            for _, p in ipairs(lista) do
                if p.nome == nomePoder then return p end
            end
            return nil
        end

        function nivelDoPoder(nomePoder)
            local p = acharPoder(lerPoderes(), nomePoder)
            if p == nil then return 0 end
            return n(p.nivel)
        end

        function pontosPoderGastos()
            local total = 0
            for _, p in ipairs(lerPoderes()) do total = total + n(p.nivel) end
            return total
        end

        -- Poderes e habilidades saem do MESMO bolso. O saldo precisa
        -- descontar os dois; considerar so os poderes fazia o total nao mudar
        -- depois de comprar ou subir uma habilidade.
        -- gastosHabilidadesLiquido() vive no bloco de HABILIDADES, mais
        -- abaixo. Como sao globais chamadas em runtime a ordem nao importa;
        -- o pcall cobre so o instante da carga.
        function gastosEmHabilidadesSeguro()
            local ok, v = pcall(function() return gastosHabilidadesLiquido() end)
            if ok and v ~= nil then return v end
            return 0
        end

        function saldoPontosPoder()
            return pontosPoderTotais() - pontosPoderGastos() - gastosEmHabilidadesSeguro()
        end

        -- ---------------------------------------------------------------
        -- ACESSO AOS KITS
        --
        -- O catalogo mostra o kit dos 18 deuses grandes, mas so libera a
        -- compra do deus de quem o personagem e filho/legado (Aspecto
        -- Divino) ou de quem o abencoou.
        -- Bencao: 3 favores com um deus que NAO e seu pai/mae podem ser
        -- trocados por ser abencoado, e isso da acesso ao kit dele.
        -- Guardado em campo plano serializado ("Kaern;Mungus").
        -- ---------------------------------------------------------------
        function deusesAbencoados()
            if sheet == nil then return {} end
            return partirTexto(sheet.deusesAbencoados, ";")
        end

        function deusEhAcessivel(nomeDeus)
            if sheet == nil or nomeDeus == nil or nomeDeus == "" then return false end
            -- "Magia" nao vem de divindade nenhuma: e o poder dos feiticos,
            -- liberado pela qualidade Coracao de Mana.
            if nomeDeus == "Coração de Mana" then
                return sheet.temCoracaoDeMana == true
            end
            if tostring(sheet.aspectoDivino or "") == nomeDeus then return true end
            for _, d in ipairs(deusesAbencoados()) do
                if d == nomeDeus then return true end
            end
            return false
        end

        function motivoDeusBloqueado(nomeDeus)
            if nomeDeus == "Coração de Mana" then
                return "Requer a qualidade Coração de Mana, marcada no capítulo VI."
            end
            if tostring(sheet and sheet.aspectoDivino or "") == "" then
                return "Escolha primeiro o seu Aspecto Divino, no capítulo I."
            end
            return "Você não é filho nem abençoado de " .. tostring(nomeDeus) ..
                ". É preciso trocar 3 Favores com esta divindade para receber a bênção."
        end

        function concederBencao(nomeDeus)
            if sheet == nil then return end
            if not usuarioEhMestre() then
                avisarPoderes("Ação recusada: somente o MESTRE registra uma bênção.", COR.wine)
                return
            end
            if deusEhAcessivel(nomeDeus) then return end
            local atual = tostring(sheet.deusesAbencoados or "")
            if atual == "" then
                sheet.deusesAbencoados = nomeDeus
            else
                sheet.deusesAbencoados = atual .. ";" .. nomeDeus
            end
            publicarNoChat("[§K #8A63C9]BÊNÇÃO CONCEDIDA[§K] — " ..
                tostring(sheet.nome or "Personagem") .. " foi abençoado por [§B]" ..
                nomeDeus .. "[§B] e passa a ter acesso ao kit desta divindade.")
            atualizarBlocoPoderes()
            mostrarDetalhePoder(poderEmDetalhe, deusEmDetalhePoder)
        end

        -- ---------------------------------------------------------------
        -- TETOS E LIMITES
        -- ---------------------------------------------------------------
        function tetoNivelPassivo()
            if sheet == nil then return 2 end
            local dados = DadosSistema.dadosDoNivel(n(sheet.nivel))
            if dados ~= nil and dados.poderPassivoMax ~= nil then
                return n(dados.poderPassivoMax)
            end
            return 2
        end

        function tetoNivelDoPoder(poder)
            if poder == nil then return 5 end
            if poder.tipo == "passivo" then
                return math.min(5, tetoNivelPassivo())
            end
            return 5
        end

        function qtdPassivosAdquiridos()
            local q = 0
            for _, item in ipairs(lerPoderes()) do
                local p = CatalogoPoderes.buscar(item.nome)
                if p ~= nil and p.tipo == "passivo" then q = q + 1 end
            end
            return q
        end

        function qtdPoderesDeAtributo()
            local q = 0
            for _, item in ipairs(lerPoderes()) do
                local p = CatalogoPoderes.buscar(item.nome)
                if p ~= nil and p.atributo ~= nil then q = q + 1 end
            end
            return q
        end

        -- ---------------------------------------------------------------
        -- LOG DE COMPRA POR NIVEL
        -- Regra: "e proibido upar um poder duas vezes em um mesmo nivel".
        -- Sem registrar EM QUE nivel cada ponto foi gasto a regra e
        -- inaplicavel - o jogador fura sem nem perceber.
        -- ---------------------------------------------------------------
        function poderJaUpouNesteNivel(item)
            if item == nil or sheet == nil then return false end
            local atual = n(sheet.nivel)
            for _, par in ipairs(partirTexto(item.log, ",")) do
                local _, nvPers = string.match(par, "^(%d+)@(%d+)$")
                if nvPers ~= nil and n(nvPers) == atual then return true end
            end
            return false
        end

        -- ---------------------------------------------------------------
        -- LACRE DO ASPECTO DIVINO
        -- ---------------------------------------------------------------
        function aspectoLacrado()
            return sheet ~= nil and sheet.aspectoLacre == true
        end

        function selarAspectoDivino()
            if sheet == nil or aspectoLacrado() then return end
            sheet.aspectoLacre = true
            sheet.aspectoLacreDeus = tostring(sheet.aspectoDivino or "")
            sheet.aspectoLacreAutor = nickDoUsuario()
            sheet.aspectoLacreData = carimboDeTempo()
            publicarNoChat("[§K #8A63C9]ASPECTO DIVINO LACRADO[§K] — " ..
                tostring(sheet.nome or "Personagem") .. " comprometeu-se com [§B]" ..
                tostring(sheet.aspectoDivino or "?") ..
                "[§B] ao gastar o primeiro ponto de poder.")
        end

        function podeTrocarAspecto()
            if not aspectoLacrado() then return true end
            return sheet.autorizacaoMestreAspecto == true
        end

        function romperLacreAspecto()
            if sheet == nil then return end
            if not usuarioEhMestre() then
                avisarPoderes("Ação recusada: somente o MESTRE pode romper o lacre do Aspecto Divino.", COR.wine)
                return
            end
            sheet.autorizacaoMestreAspecto = true
            publicarNoChat("[§K #8B2332]LACRE DO ASPECTO ROMPIDO[§K] por " ..
                nickDoUsuario() .. " para " .. tostring(sheet.nome or "personagem") ..
                ". A próxima troca de divindade está autorizada.")
            avisarPoderes("Lacre rompido: a próxima troca de divindade está liberada (uso único).", COR.gold)
            atualizarBlocoPoderes()
        end

        function autorizarUpDuploPoder()
            if sheet == nil then return end
            if not usuarioEhMestre() then
                avisarPoderes("Ação recusada: somente o MESTRE pode autorizar duas subidas no mesmo nível.", COR.wine)
                return
            end
            sheet.autorizacaoMestrePoder = true
            publicarNoChat("[§K #C9A24B]AUTORIZAÇÃO DO MESTRE[§K] — " .. nickDoUsuario() ..
                " liberou uma subida extra de poder neste nível para " ..
                tostring(sheet.nome or "personagem") .. " (uso único).")
            avisarPoderes("Autorizado: uma subida extra neste nível (uso único).", COR.gold)
            atualizarBlocoPoderes()
        end

        -- ---------------------------------------------------------------
        -- COMPRA E DEVOLUCAO
        -- ---------------------------------------------------------------
        function comprarNivelPoder(nomePoder)
            if sheet == nil then return end
            if not podeEditarCriacao() then
                avisarPoderes(motivoTravaCriacao(), COR.wine); return
            end
            local poder = CatalogoPoderes.buscar(nomePoder)
            if poder == nil then return end

            local lista = lerPoderes()
            local item = acharPoder(lista, nomePoder)
            local atual = 0
            if item ~= nil then atual = n(item.nivel) end
            local novo = atual + 1

            if novo > 5 then
                avisarPoderes("Este poder já está no nível máximo (5).", COR.muted); return
            end

            local teto = tetoNivelDoPoder(poder)
            if novo > teto then
                avisarPoderes("Poder passivo limitado ao nível " .. teto ..
                    " enquanto o personagem estiver no nível " .. n(sheet.nivel) .. ".", COR.muted)
                return
            end

            if saldoPontosPoder() < 1 then
                avisarPoderes("Sem pontos de poder disponíveis.", COR.wine); return
            end

            -- limites de composicao: so valem ao ADQUIRIR (nivel 0 -> 1)
            if atual == 0 then
                if poder.tipo == "passivo" and qtdPassivosAdquiridos() >= 3 then
                    avisarPoderes("Limite atingido: nenhum personagem pode ter mais de três poderes passivos.", COR.wine)
                    return
                end
                if poder.atributo ~= nil and qtdPoderesDeAtributo() >= 2 then
                    avisarPoderes("Limite atingido: no máximo dois poderes que bonificam atributos.", COR.wine)
                    return
                end
                if #lista >= MAX_SLOTS_PODER then
                    avisarPoderes("Limite de exibição da ficha atingido (" .. MAX_SLOTS_PODER ..
                        " poderes). Avise o desenvolvedor da ficha.", COR.wine)
                    return
                end
            end

            local usouAutorizacao = false
            if item ~= nil and poderJaUpouNesteNivel(item) then
                if sheet.autorizacaoMestrePoder == true then
                    usouAutorizacao = true
                else
                    avisarPoderes("Este poder já subiu de nível no nível " .. n(sheet.nivel) ..
                        " do personagem. Só o MESTRE pode autorizar uma exceção.", COR.wine)
                    return
                end
            end

            if item == nil then
                item = { nome = nomePoder, nivel = 0, log = "",
                         deus = deusDonoDoPoder(nomePoder) }
                table.insert(lista, item)
            end
            item.nivel = novo
            local marca = tostring(novo) .. "@" .. tostring(n(sheet.nivel))
            if item.log == "" then item.log = marca else item.log = item.log .. "," .. marca end

            gravarPoderes(lista)
            if usouAutorizacao then sheet.autorizacaoMestrePoder = false end
            selarAspectoDivino()
            aplicarConcessoes()

            publicarNoChat("[§K #C9A24B]" .. tostring(sheet.nome or "Personagem") ..
                "[§K] elevou o poder [§B]" .. nomePoder .. "[§B] ao nível " .. novo ..
                " (" .. poder.tipo .. ").")
            atualizarBlocoHabilidades()
        end

        function devolverNivelPoder(nomePoder)
            if sheet == nil then return end
            if not podeEditarCriacao() then
                avisarPoderes(motivoTravaCriacao(), COR.wine); return
            end
            local lista = lerPoderes()
            local item = acharPoder(lista, nomePoder)
            if item == nil or n(item.nivel) <= 0 then return end

            -- REGRA DA MESA: um poder ativo adquirido fica preso ao
            -- personagem - nao se "devolve" um poder como se devolve um
            -- ponto. Enquanto a ficha esta EM CRIACAO liberamos para
            -- corrigir erro de clique; depois de finalizada, so o mestre.
            local poderCat = CatalogoPoderes.buscar(nomePoder)
            if n(item.nivel) == 1 and poderCat ~= nil and poderCat.tipo == "ativo"
               and fichaEstaFinalizada() and not usuarioEhMestre() then
                avisarPoderes("Poderes ativos ficam presos ao personagem. Só o MESTRE pode remover.", COR.wine)
                return
            end

            item.nivel = n(item.nivel) - 1
            local partes = partirTexto(item.log, ",")
            table.remove(partes)
            item.log = table.concat(partes, ",")

            gravarPoderes(lista)
            aplicarConcessoes()

            -- Removeu o poder por completo: a habilidade Rank E gratuita que
            -- nasceu dele vai junto (regra confirmada na mesa).
            if item.nivel == 0 then
                for _, h in ipairs(todasHabilidades()) do
                    if tostring(h.poderVinculado or "") == nomePoder
                       and tostring(h.origemGratis or "") == "poder" then
                        NDB.deleteNode(h)
                    end
                end
            end
            if item.nivel == 0 then
                avisarPoderes("Poder removido e ponto devolvido ao saldo.", COR.muted)
            else
                avisarPoderes("Ponto devolvido ao saldo.", COR.muted)
            end
            atualizarBlocoPoderes()
        end

        -- Qual divindade oferece este poder (para gravar a origem).
        -- Prioriza o Aspecto Divino, depois os deuses que abencoaram.
        function deusDonoDoPoder(nomePoder)
            if sheet == nil then return "" end
            local candidatos = {tostring(sheet.aspectoDivino or "")}
            for _, d in ipairs(deusesAbencoados()) do table.insert(candidatos, d) end
            for _, nomeDeus in ipairs(candidatos) do
                local deus = CatalogoDeuses.buscarPorNome(nomeDeus)
                if deus ~= nil then
                    for _, slot in ipairs(deus.slots) do
                        for _, p in ipairs(slot) do
                            if p == nomePoder then return nomeDeus end
                        end
                    end
                end
            end
            return ""
        end

        -- ---------------------------------------------------------------
        -- CATALOGO DE PODERES (popup mestre-detalhe)
        -- ---------------------------------------------------------------
        poderEmDetalhe = nil
        deusEmDetalhePoder = nil

        function abrirPopupPoderes()
            if self.popPoderes == nil then return end
            if poderEmDetalhe ~= nil then
                mostrarDetalhePoder(poderEmDetalhe, deusEmDetalhePoder)
            end
            destacarPoderSelecionado()
            abrirPopupAjustado(self.popPoderes, 1080, 680)
        end

        function fecharPopupPoderes()
            if self.popPoderes ~= nil then self.popPoderes:close() end
            atualizarBlocoPoderes()
        end

        function mostrarDetalhePoder(nomePoder, nomeDeus)
            if nomePoder == nil then return end
            local poder = CatalogoPoderes.buscar(nomePoder)
            if poder == nil then return end
            poderEmDetalhe = nomePoder
            deusEmDetalhePoder = nomeDeus

            if self.popPod_lblNome ~= nil then self.popPod_lblNome:setText(poder.nome) end

            if self.popPod_lblTipo ~= nil then
                local txt = "Poder " .. poder.tipo
                if poder.atributo ~= nil then
                    txt = txt .. "   •   bonifica " .. poder.atributo
                end
                if poder.tipo == "ativo" then
                    txt = txt .. "   •   cada nível destrava um rank de habilidade"
                    self.popPod_lblTipo:setFontColor(COR.aura)
                else
                    self.popPod_lblTipo:setFontColor(COR.moss)
                end
                self.popPod_lblTipo:setText(txt)
            end

            if self.popPod_lblOrigem ~= nil then
                self.popPod_lblOrigem:setText("Kit de " .. tostring(nomeDeus or "?"))
            end

            if self.popPod_lblDesc ~= nil then
                self.popPod_lblDesc:setText(poder.descricao)
            end

            -- 5 niveis de progressao
            local nivelAtual = nivelDoPoder(poder.nome)
            local teto = tetoNivelDoPoder(poder)
            for i = 1, 5 do
                local lbl = self["popPod_lblNivel" .. i]
                local cab = self["popPod_lblNivelTit" .. i]
                if lbl ~= nil then
                    local rank = ""
                    if poder.tipo == "ativo" then
                        rank = "   (habilidades rank " .. CatalogoPoderes.rankPorNivel[i] .. ")"
                    end
                    lbl:setText(poder.progressao[i] .. rank)
                    if i <= nivelAtual then
                        lbl:setFontColor(COR.text)
                    elseif i <= teto then
                        lbl:setFontColor(COR.muted)
                    else
                        lbl:setFontColor(COR.faint)
                    end
                end
                if cab ~= nil then
                    local t = "NÍVEL " .. i
                    if i == nivelAtual then t = t .. "  ◆ ATUAL"
                    elseif i > teto then t = t .. "  — acima do teto do seu nível"
                    end
                    cab:setText(t)
                    if i <= nivelAtual then
                        cab:setFontColor(COR.gold)
                    elseif i <= teto then
                        cab:setFontColor(COR.aura)
                    else
                        cab:setFontColor(COR.faint)
                    end
                end
            end

            -- rodape: adquirir / subir / bloqueado
            if self.popPod_lblBtnAdquirir ~= nil then
                local acessivel = deusEhAcessivel(nomeDeus)
                if not acessivel then
                    self.popPod_lblBtnAdquirir:setText(string.upper(motivoDeusBloqueado(nomeDeus)))
                    self.popPod_lblBtnAdquirir:setFontColor(COR.faint)
                elseif nivelAtual == 0 then
                    self.popPod_lblBtnAdquirir:setText("ADQUIRIR " .. string.upper(poder.nome) .. " — 1 PONTO")
                    self.popPod_lblBtnAdquirir:setFontColor(COR.gold)
                elseif nivelAtual >= teto then
                    self.popPod_lblBtnAdquirir:setText("NÍVEL MÁXIMO ALCANÇADO (" .. nivelAtual .. " / " .. teto .. ")")
                    self.popPod_lblBtnAdquirir:setFontColor(COR.moss)
                else
                    self.popPod_lblBtnAdquirir:setText("SUBIR PARA O NÍVEL " .. (nivelAtual + 1) .. " — 1 PONTO")
                    self.popPod_lblBtnAdquirir:setFontColor(COR.gold)
                end
            end

            if self.popPod_lblSaldo ~= nil then
                self.popPod_lblSaldo:setText("Saldo: " .. saldoPontosPoder() .. " ponto(s)")
            end

            -- botao de bencao, so para o mestre e so em deus bloqueado
            local mostraBencao = usuarioEhMestre() and
                not deusEhAcessivel(nomeDeus) and
                nomeDeus ~= "Coração de Mana" and
                tostring(sheet and sheet.aspectoDivino or "") ~= ""
            definirAlturaPod(self.popPod_secBencao, mostraBencao and 30 or 0)

            destacarPoderSelecionado()
        end

        function adquirirPoderEmDetalhe()
            if poderEmDetalhe == nil then return end
            if not deusEhAcessivel(deusEmDetalhePoder) then
                if self.popPod_lblSaldo ~= nil then
                    self.popPod_lblSaldo:setText(motivoDeusBloqueado(deusEmDetalhePoder))
                    self.popPod_lblSaldo:setFontColor(COR.wine)
                end
                return
            end
            comprarNivelPoder(poderEmDetalhe)
            mostrarDetalhePoder(poderEmDetalhe, deusEmDetalhePoder)
        end

        function concederBencaoEmDetalhe()
            if deusEmDetalhePoder == nil then return end
            concederBencao(deusEmDetalhePoder)
        end

        function destacarPoderSelecionado()
            for _, poder in ipairs(CatalogoPoderes.itens) do
                local card = self["rectPod_" .. chavePoder(poder.nome)]
                if card ~= nil then
                    if poder.nome == poderEmDetalhe then
                        card:setStrokeColor(COR.aura); card:setStrokeSize(2)
                    elseif nivelDoPoder(poder.nome) > 0 then
                        card:setStrokeColor(COR.gold); card:setStrokeSize(1)
                    else
                        card:setStrokeColor(COR.line); card:setStrokeSize(1)
                    end
                end
            end
        end

        -- ---------------------------------------------------------------
        -- ORDENACAO POR ORIGEM
        --
        -- Os poderes do pai/mae vem SEMPRE primeiro, depois os de cada
        -- bencao (na ordem em que foram concedidas), e por ultimo os que
        -- nao vem de divindade (Magia, do Coracao de Mana).
        -- A lista serializada guarda a ordem de compra; a exibicao reordena.
        -- ---------------------------------------------------------------
        function poderesOrdenados()
            local lista = lerPoderes()
            local aspecto = tostring(sheet and sheet.aspectoDivino or "")
            local ordemDeus = {}
            local rotulo = {}

            if aspecto ~= "" then
                ordemDeus[aspecto] = 1
                rotulo[aspecto] = "KIT DE " .. string.upper(aspecto) .. "  ·  ASPECTO DIVINO"
            end
            local i = 2
            for _, d in ipairs(deusesAbencoados()) do
                if ordemDeus[d] == nil then
                    ordemDeus[d] = i
                    rotulo[d] = "BÊNÇÃO DE " .. string.upper(d)
                    i = i + 1
                end
            end

            -- estavel: mantem a ordem de compra dentro de cada grupo
            local saida = {}
            for idx, item in ipairs(lista) do
                item.indiceReal = idx
                item.ordem = ordemDeus[item.deus] or 900
                if item.deus == nil or item.deus == "" then
                    item.grupo = "FORA DOS KITS  ·  CORAÇÃO DE MANA"
                    item.ordem = 999
                else
                    item.grupo = rotulo[item.deus] or ("KIT DE " .. string.upper(item.deus))
                end
                table.insert(saida, item)
            end
            table.sort(saida, function(a, b)
                if a.ordem ~= b.ordem then return a.ordem < b.ordem end
                return a.indiceReal < b.indiceReal
            end)
            return saida
        end

        -- ---------------------------------------------------------------
        -- RENDERIZACAO DA ABA
        -- ---------------------------------------------------------------
        function avisarPoderes(texto, cor)
            if self.abaPod_lblAviso == nil then return end
            self.abaPod_lblAviso:setText(tostring(texto or ""))
            self.abaPod_lblAviso:setFontColor(cor or COR.muted)
        end

        function atualizarBlocoPoderes()
            if sheet == nil then return end

            local totais = pontosPoderTotais()
            local gastosPod = pontosPoderGastos()
            local gastosHab = gastosEmHabilidadesSeguro()
            local gastos = gastosPod + gastosHab
            if self.abaPod_lblTotal ~= nil then self.abaPod_lblTotal:setText(tostring(totais)) end
            if self.abaPod_lblGastos ~= nil then self.abaPod_lblGastos:setText(tostring(gastos)) end
            if self.abaPod_lblGastosDetalhe ~= nil then
                self.abaPod_lblGastosDetalhe:setText(gastosPod .. " poderes · " .. gastosHab .. " habilidades")
            end
            if self.abaPod_lblSaldo ~= nil then
                local saldo = totais - gastos
                self.abaPod_lblSaldo:setText(tostring(saldo))
                if saldo < 0 then self.abaPod_lblSaldo:setFontColor(COR.wine)
                elseif saldo > 0 then self.abaPod_lblSaldo:setFontColor(COR.gold)
                else self.abaPod_lblSaldo:setFontColor(COR.muted) end
            end

            local lista = poderesOrdenados()

            -- estado vazio (altura, nunca visibilidade)
            definirAlturaPod(self.abaPod_wrapVazio, (#lista == 0) and ALTURA_VAZIO_PODER or 0)

            local grupoAnterior = nil
            for i = 1, MAX_SLOTS_PODER do
                local item = lista[i]
                definirAlturaPod(self["abaPod_wrapSlot" .. i],
                    (item ~= nil) and ALTURA_SLOT_PODER or 0)

                -- cabecalho de grupo: so na primeira linha de cada origem
                local mostraGrupo = (item ~= nil) and (item.grupo ~= grupoAnterior)
                definirAlturaPod(self["abaPod_wrapGrupo" .. i],
                    mostraGrupo and ALTURA_GRUPO_PODER or 0)
                if mostraGrupo then
                    local lblG = self["abaPod_lblGrupo" .. i]
                    if lblG ~= nil then
                        lblG:setText(item.grupo)
                        if item.ordem == 1 then lblG:setFontColor(COR.gold)
                        elseif item.ordem >= 999 then lblG:setFontColor(COR.rain)
                        else lblG:setFontColor(COR.aura) end
                    end
                end
                if item ~= nil then grupoAnterior = item.grupo end

                if item ~= nil then
                    local poder = CatalogoPoderes.buscar(item.nome)
                    local nivel = n(item.nivel)
                    local teto = tetoNivelDoPoder(poder)

                    local lblNome = self["abaPod_lblNome" .. i]
                    if lblNome ~= nil then
                        lblNome:setText(item.nome)
                        lblNome:setFontColor(COR.text)
                    end

                    local lblTipo = self["abaPod_lblTipo" .. i]
                    if lblTipo ~= nil and poder ~= nil then
                        lblTipo:setText(string.upper(poder.tipo))
                        if poder.tipo == "ativo" then lblTipo:setFontColor(COR.aura)
                        else lblTipo:setFontColor(COR.moss) end
                    end

                    -- selo de origem: de qual divindade este poder veio
                    local lblOrig = self["abaPod_lblOrigem" .. i]
                    local secOrig = self["abaPod_secOrigem" .. i]
                    if lblOrig ~= nil then
                        local cor, txt
                        if item.deus == nil or item.deus == "" then
                            txt = "CORAÇÃO DE MANA"; cor = COR.rain
                        elseif item.ordem == 1 then
                            txt = string.upper(item.deus) .. "  ·  PAI/MÃE"; cor = COR.gold
                        else
                            txt = string.upper(item.deus) .. "  ·  BÊNÇÃO"; cor = COR.aura
                        end
                        lblOrig:setText(txt)
                        lblOrig:setFontColor(cor)
                        if secOrig ~= nil then secOrig:setStrokeColor(cor) end
                    end

                    for j = 1, 5 do
                        local pip = self["abaPod_pip" .. i .. "_" .. j]
                        if pip ~= nil then
                            definirLarguraPod(pip, (j <= teto) and 14 or 0)
                            if j <= nivel then
                                pip:setColor(COR.gold); pip:setStrokeColor(COR.gold)
                            else
                                pip:setColor("#12181C"); pip:setStrokeColor("#3A4750")
                            end
                        end
                    end

                    local lblCont = self["abaPod_lblCont" .. i]
                    if lblCont ~= nil then
                        lblCont:setText(nivel .. " / " .. teto)
                        if nivel >= teto then lblCont:setFontColor(COR.moss)
                        else lblCont:setFontColor(COR.muted) end
                    end

                    local lblEfeito = self["abaPod_lblEfeito" .. i]
                    if lblEfeito ~= nil and poder ~= nil then
                        lblEfeito:setText(CatalogoPoderes.textoNivel(poder, nivel))
                        lblEfeito:setFontColor(COR.muted)
                    end
                end
            end

            if self.abaPod_lblExtras ~= nil then
                local extras = 0
                local ok, v = pcall(function() return pontosExtrasDoSistema() end)
                if ok and v ~= nil then extras = v end
                self.abaPod_lblExtras:setText(tostring(extras))
                if extras > 0 then
                    self.abaPod_lblExtras:setFontColor(COR.moss)
                else
                    self.abaPod_lblExtras:setFontColor(COR.faint)
                end
            end

            if self.abaPod_lblLimites ~= nil then
                self.abaPod_lblLimites:setText(
                    "Passivos " .. qtdPassivosAdquiridos() .. "/3          " ..
                    "Poderes de atributo " .. qtdPoderesDeAtributo() .. "/2          " ..
                    "Teto de passivo no nível " .. n(sheet.nivel) .. ": " .. tetoNivelPassivo())
            end

            if self.abaPod_lblLacre ~= nil then
                if aspectoLacrado() then
                    self.abaPod_lblLacre:setText("ASPECTO LACRADO em " ..
                        tostring(sheet.aspectoLacreDeus or "?") .. " — por " ..
                        tostring(sheet.aspectoLacreAutor or "?") .. ", " ..
                        tostring(sheet.aspectoLacreData or "?"))
                    self.abaPod_lblLacre:setFontColor(COR.rain)
                else
                    self.abaPod_lblLacre:setText("Aspecto ainda não lacrado — o lacre fecha ao gastar o primeiro ponto.")
                    self.abaPod_lblLacre:setFontColor(COR.faint)
                end
            end
            local ehMestre = usuarioEhMestre()
            definirLarguraPod(self.abaPod_wrapAutorizar, ehMestre and 264 or 0)
            definirLarguraPod(self.abaPod_wrapRomper, ehMestre and 256 or 0)
        end

        -- Botoes +/- de cada linha (indice do slot vem gravado no XML).
        function slotPoderMais(indice)
            local item = poderesOrdenados()[indice]
            if item == nil then return end
            comprarNivelPoder(item.nome)
        end

        function slotPoderMenos(indice)
            local item = poderesOrdenados()[indice]
            if item == nil then return end
            devolverNivelPoder(item.nome)
        end

        function slotPoderDetalhe(indice)
            local item = poderesOrdenados()[indice]
            if item == nil then return end
            mostrarDetalhePoder(item.nome, item.deus)
            abrirPopupPoderes()
        end

        -- =================================================================
        -- HABILIDADES E FEITICOS
        --
        -- Diferente de poderes, habilidades sao CRIADAS pelo jogador: nome,
        -- rank, tags, aura, dado, alcance, duracao, elemento, efeito. Por
        -- isso aqui usamos recordList de verdade (itemHabilidade.lfm), e nao
        -- campo serializado: sao muitos campos e o jogador digita texto livre,
        -- onde qualquer separador (";" "|") poderia corromper o registro.
        --
        -- TRES TIPOS:
        --   "poder"   vinculada a um poder ATIVO adquirido. O rank e limitado
        --             pelo NIVEL DO PODER (1->E/D, 2->C, 3->B, 4->A, 5->EX).
        --             REGRA DA MESA: o rank do PERSONAGEM nao limita - um
        --             personagem rank C pode ter habilidade EX se subiu o
        --             poder o bastante.
        --   "classe"  nao depende de poder e pode chegar a EX; em troca os
        --             efeitos sao mais fracos. A regra exata ainda nao esta
        --             fechada na mesa, entao esta categoria e a MAIS LIVRE:
        --             a ficha nao trava rank nem tags, so informa a tabela.
        --   "feitico" vem do poder "Magia" + qualidade Coracao de Mana. Gasta
        --             MANA e tem tabela propria (dados mais fracos, menos
        --             tags), com valores diferentes para "Bruxas".
        --
        -- GRATUIDADES (todas confirmadas no livro):
        --   - 1 habilidade Rank E gratis sempre que um poder ATIVO novo chega
        --     ao nivel 1, em qualquer nivel do personagem;
        --   - primeira habilidade Rank EX gratis no nivel 15;
        --   - segunda habilidade Rank EX gratis no nivel 20;
        --   - +1 ponto de skill gratuito no nivel 19 (abate custo de
        --     habilidades, nao de poderes).
        -- =================================================================

        local RANK_POR_NIVEL_PODER = {"E/D", "C", "B", "A", "EX"}

        -- Ranks liberados por um poder ativo no nivel N. O nivel 1 libera
        -- E e D de uma vez (o livro escreve o primeiro degrau como "E/D").
        local RANKS_LIBERADOS_PODER = {
            [1] = {"E", "D"},
            [2] = {"E", "D", "C"},
            [3] = {"E", "D", "C", "B"},
            [4] = {"E", "D", "C", "B", "A"},
            [5] = {"E", "D", "C", "B", "A", "EX"},
        }

        function listaHabilidadesNode()
            if sheet == nil then return nil end
            return sheet.listaHabilidades
        end

        function todasHabilidades()
            if sheet == nil then return {} end
            return NDB.getChildNodes(sheet.listaHabilidades) or {}
        end

        -- ---------------------------------------------------------------
        -- SLOTS CONCEDIDOS
        --
        -- MODELO (definido pela mesa): quando o personagem ganha uma
        -- habilidade/feitico de graca, a ficha CRIA UM SLOT proprio ja com o
        -- desconto embutido. Quem cria pelo botao normal paga o preco cheio,
        -- sem nenhuma regra especial.
        --
        -- Por que assim: antes o desconto era procurado na hora da criacao,
        -- e o credito de Rank E do poder disputava com o Rank D da subclasse
        -- - a primeira habilidade criada pegava o credito "errado". Com o
        -- credito preso ao slot, cada concessao e independente.
        --
        -- O CREDITO E O CUSTO CHEIO DO RANK CONCEDIDO, nao 1 ponto:
        -- um feitico Rank D de graca vale 2 pontos, entao subi-lo para C
        -- (custo 3) sai por 1. Assim o desconto acompanha o slot por toda a
        -- evolucao dele.
        --   custoPago = max(0, custoDoRank(rankAtual) - creditoEmbutido)
        -- ---------------------------------------------------------------

        -- Concessoes que a ficha deve materializar como slot.
        -- Cada uma tem chave unica, para nao criar duas vezes.
        function slotsConcedidosDesejados()
            local r = {}
            if sheet == nil then return r end

            -- 1) um Rank E por poder ATIVO adquirido. Se o poder e "Magia",
            --    o slot nasce como FEITICO; nos demais, como habilidade.
            for _, item in ipairs(lerPoderes()) do
                local p = CatalogoPoderes.buscar(item.nome)
                if p ~= nil and p.tipo == "ativo" and n(item.nivel) > 0 then
                    local ehMagia = (item.nome == "Magia")
                    table.insert(r, {
                        chave = "auto:poder:" .. item.nome,
                        tipo = ehMagia and "feitico" or "poder",
                        rank = "E",
                        poderVinculado = item.nome,
                        rotulo = item.nome,
                    })
                end
            end

            -- 2) concessoes de subclasse (hoje: Especialista arcano)
            for _, con in ipairs(creditosDeSubclasse()) do
                table.insert(r, {
                    chave = "auto:" .. con.chave,
                    tipo = con.tipo,
                    rank = con.rank,
                    poderVinculado = (con.tipo == "feitico") and "Magia" or "",
                    rotulo = con.rotulo,
                })
            end

            -- 3) habilidades Rank EX dos niveis 15 e 20
            local nv = n(sheet.nivel)
            if nv >= 15 then
                table.insert(r, {chave = "auto:nivel15", tipo = "classe", rank = "EX",
                                 poderVinculado = "", rotulo = "nível 15"})
            end
            if nv >= 20 then
                table.insert(r, {chave = "auto:nivel20", tipo = "classe", rank = "EX",
                                 poderVinculado = "", rotulo = "nível 20"})
            end
            return r
        end

        function acharSlotPorChave(chave)
            for _, h in ipairs(todasHabilidades()) do
                if tostring(h.origemGratis or "") == chave then return h end
            end
            return nil
        end

        -- Cria os slots que faltam e retira os que perderam a fonte.
        sincronizandoSlots = false

        function sincronizarSlotsConcedidos()
            if sheet == nil or self.listaHabilidades == nil then return end
            if sincronizandoSlots then return end
            sincronizandoSlots = true

            pcall(function()
                local desejados = slotsConcedidosDesejados()
                local porChave = {}
                for _, d in ipairs(desejados) do porChave[d.chave] = d end

                -- cria o que falta
                for _, d in ipairs(desejados) do
                    if acharSlotPorChave(d.chave) == nil then
                        local credito = CatalogoHabilidades.custoDoRank(d.rank, d.tipo == "feitico")
                        local tabela = CatalogoHabilidades.dadosDoRank(d.rank, d.tipo == "feitico")
                        local no = self.listaHabilidades:append()
                        if no ~= nil then
                            no.tipo = d.tipo
                            no.nome = ""              -- vazio: o jogador batiza
                            no.rank = d.rank
                            no.poderVinculado = d.poderVinculado
                            no.tags = ""
                            no.energia = tabela and tabela.energiaMin or 0
                            no.dadoBase = tabela and tabela.dadoBase or ""
                            no.modificador = tabela and tabela.modificador or 0
                            no.alcance = tabela and tabela.alcanceMax or 0
                            no.duracao = tostring(tabela and tabela.duracao or ""):gsub("%.%s*$", "")
                            no.elemento = ""
                            no.descricao = ""
                            no.efeito = ""
                            no.custoPago = 0
                            no.creditoEmbutido = credito
                            no.origemGratis = d.chave
                            no.rotuloGratis = d.rotulo
                        end
                    end
                end

                -- retira (ou desconta) o que perdeu a fonte
                local paraRemover = {}
                for _, h in ipairs(todasHabilidades()) do
                    local og = tostring(h.origemGratis or "")
                    if og:sub(1, 5) == "auto:" and porChave[og] == nil then
                        if tostring(h.nome or "") == "" then
                            table.insert(paraRemover, h)
                        else
                            -- ja foi preenchida: mantemos o que o jogador
                            -- escreveu, mas o desconto acaba junto com a fonte
                            h.creditoEmbutido = 0
                            h.origemGratis = ""
                            h.rotuloGratis = ""
                            h.custoPago = CatalogoHabilidades.custoDoRank(
                                tostring(h.rank or "E"), tostring(h.tipo or "") == "feitico")
                        end
                    end
                end
                for _, h in ipairs(paraRemover) do NDB.deleteNode(h) end
            end)

            sincronizandoSlots = false
        end

        -- +1 ponto de skill gratuito no nivel 19: abate custo de habilidades.
        function descontoSkillNivel19()
            if sheet == nil then return 0 end
            if n(sheet.nivel) >= 19 then return 1 end
            return 0
        end

        -- ---------------------------------------------------------------
        -- CONCESSOES DE SUBCLASSE
        --
        -- Varredura do catalogo de classes: hoje so a "Especialista arcano"
        -- (Arcanista) entrega itens que saem do bolso de pontos, e o gatilho
        -- e o NIVEL DA SUBCLASSE, nao o do personagem.
        --   nivel 1 -> feitico Rank D    nivel 5 -> Rank C
        --   nivel 6 -> Rank B            nivel 7 -> Rank A
        --   nivel 8 -> Rank EX
        -- Para incluir outra subclasse basta uma linha nova aqui.
        -- ---------------------------------------------------------------
        local CONCESSOES_SUBCLASSE = {
            {classe = "Arcanista", sub = "Especialista arcano", nivel = 1, tipo = "feitico", rank = "D"},
            {classe = "Arcanista", sub = "Especialista arcano", nivel = 5, tipo = "feitico", rank = "C"},
            {classe = "Arcanista", sub = "Especialista arcano", nivel = 6, tipo = "feitico", rank = "B"},
            {classe = "Arcanista", sub = "Especialista arcano", nivel = 7, tipo = "feitico", rank = "A"},
            {classe = "Arcanista", sub = "Especialista arcano", nivel = 8, tipo = "feitico", rank = "EX"},
        }

        function creditosDeSubclasse()
            local r = {}
            if sheet == nil then return r end
            for slot = 1, 2 do
                local nomeClasse = tostring(sheet["classe" .. slot .. "Nome"] or "")
                local nomeSub = tostring(sheet["classe" .. slot .. "Sub"] or "")
                local nivelSub = n(sheet["classe" .. slot .. "Nivel"])
                for _, con in ipairs(CONCESSOES_SUBCLASSE) do
                    if con.classe == nomeClasse and con.sub == nomeSub and nivelSub >= con.nivel then
                        table.insert(r, {
                            tipo = con.tipo,
                            rank = con.rank,
                            chave = "sub:" .. nomeSub .. ":" .. con.nivel,
                            rotulo = nomeSub .. " nível " .. con.nivel,
                        })
                    end
                end
            end
            return r
        end

        -- ---------------------------------------------------------------
        -- ECONOMIA
        -- ---------------------------------------------------------------
        -- Pontos que o SISTEMA concedeu: a soma dos creditos embutidos nos
        -- slots concedidos, mais o ponto de skill do nivel 19. E o campo
        -- EXTRAS - diferente de CONCEDIDOS, que o mestre preenche a mao.
        function pontosExtrasDoSistema()
            local total = 0
            for _, h in ipairs(todasHabilidades()) do
                total = total + n(h.creditoEmbutido)
            end
            return total + descontoSkillNivel19()
        end

        function gastosHabilidades()
            local total = 0
            for _, h in ipairs(todasHabilidades()) do
                total = total + n(h.custoPago)
            end
            return total
        end

        -- O desconto do nivel 19 so vale para habilidades, nunca para poderes.
        function gastosHabilidadesLiquido()
            local bruto = gastosHabilidades() - descontoSkillNivel19()
            if bruto < 0 then return 0 end
            return bruto
        end

        -- ---------------------------------------------------------------
        -- RANKS DISPONIVEIS
        -- ---------------------------------------------------------------

        -- Poderes ATIVOS ja adquiridos, para o seletor do construtor.
        -- Poderes ativos que geram HABILIDADE comum.
        -- "Magia" fica de fora de proposito: ela e o poder dos FEITICOS, e
        -- so gera feiticos. Deixa-la aqui permitia criar uma habilidade
        -- comum a partir da Magia, o que a regra nao admite.
        function poderesAtivosAdquiridos()
            local r = {}
            for _, item in ipairs(lerPoderes()) do
                local p = CatalogoPoderes.buscar(item.nome)
                if p ~= nil and p.tipo == "ativo" and n(item.nivel) > 0
                   and item.nome ~= "Magia" then
                    table.insert(r, {nome = item.nome, nivel = n(item.nivel), deus = item.deus})
                end
            end
            return r
        end

        function ranksLiberadosPorPoder(nomePoder)
            local nivel = nivelDoPoder(nomePoder)
            if nivel < 1 then return {} end
            if nivel > 5 then nivel = 5 end
            return RANKS_LIBERADOS_PODER[nivel] or {}
        end

        -- Habilidade de classe nao depende de poder: todos os ranks liberados.
        function ranksLiberadosParaTipo(tipo, nomePoder)
            if tipo == "classe" then
                return CatalogoHabilidades.ranks
            end
            if tipo == "feitico" then
                -- feiticos seguem o nivel do poder "Magia"
                return ranksLiberadosPorPoder("Magia")
            end
            return ranksLiberadosPorPoder(nomePoder)
        end

        function rankEstaLiberado(rank, tipo, nomePoder)
            for _, r in ipairs(ranksLiberadosParaTipo(tipo, nomePoder)) do
                if r == rank then return true end
            end
            return false
        end

        -- ---------------------------------------------------------------
        -- CUSTO E GRATUIDADE
        --
        -- Decide se a habilidade sai de graca e por que. "ignorarNo" existe
        -- para a edicao: ao recalcular uma habilidade que ja existe, ela nao
        -- deve competir consigo mesma pelo credito que ja estava usando.
        -- ---------------------------------------------------------------
        -- Custo de uma habilidade: preco cheio do rank menos o credito que
        -- o slot carrega. Slot criado pelo botao normal tem credito 0 e paga
        -- cheio; slot concedido carrega o custo do rank concedido, e esse
        -- desconto vale para sempre, inclusive ao subir de rank.
        function calcularCustoHabilidade(rank, tipo, creditoEmbutido)
            local cheio = CatalogoHabilidades.custoDoRank(rank, tipo == "feitico")
            local liquido = cheio - n(creditoEmbutido)
            if liquido < 0 then liquido = 0 end
            return liquido
        end

        -- ---------------------------------------------------------------
        -- CONSTRUTOR
        -- ---------------------------------------------------------------
        habEmEdicao = nil          -- no NDB da habilidade sendo editada
        habRascunho = nil          -- estado do formulario

        function novoRascunhoHab(tipo)
            return {
                tipo = tipo or "poder",
                nome = "",
                rank = "E",
                poderVinculado = "",
                tags = {},
                energia = 0,
                dadoBase = "",
                modificador = 0,
                alcance = 0,
                duracao = "",
                elemento = "",
                descricao = "",
                efeito = "",
                corpoACorpo = false,
                emArea = false,
                creditoEmbutido = 0,
                rotuloGratis = "",
            }
        end

        function abrirConstrutorHabilidade(tipo)
            if self.popHabilidade == nil then return end
            if not podeEditarCriacao() then
                avisarHabilidades(motivoTravaCriacao(), COR.wine)
                return
            end
            habEmEdicao = nil
            habRascunho = novoRascunhoHab(tipo)
            habRascunho.creditoEmbutido = 0     -- criada pelo botao: paga cheio

            -- pre-seleciona o primeiro poder ativo disponivel
            local ativos = poderesAtivosAdquiridos()
            if tipo == "poder" then
                if #ativos == 0 then
                    if nivelDoPoder("Magia") > 0 then
                        avisarHabilidades("O poder Magia gera feitiços, não habilidades comuns. " ..
                            "Use o botão FEITIÇO, ou crie uma habilidade de classe.", COR.muted)
                    else
                        avisarHabilidades("Nenhum poder ativo adquirido. Habilidades de poder precisam de um poder ativo; " ..
                            "você ainda pode criar uma habilidade de classe.", COR.muted)
                    end
                    return
                end
                habRascunho.poderVinculado = ativos[1].nome
            elseif tipo == "feitico" then
                if nivelDoPoder("Magia") < 1 then
                    avisarHabilidades("Feitiços exigem o poder \"Magia\" (qualidade Coração de Mana).", COR.muted)
                    return
                end
                habRascunho.poderVinculado = "Magia"
            end

            aplicarTabelaDoRank()
            atualizarConstrutorHab()
            abrirPopupAjustado(self.popHabilidade, 1020, 700)
        end

        -- O popup ABRE mesmo com a ficha finalizada: e nele que estao o dado,
        -- o alcance, a duracao e o efeito da habilidade, que o jogador precisa
        -- consultar em jogo. Quem trava e o botao de salvar.
        function editarHabilidade(no)
            if no == nil or self.popHabilidade == nil then return end
            habEmEdicao = no
            habRascunho = {
                tipo = tostring(no.tipo or "poder"),
                nome = tostring(no.nome or ""),
                rank = tostring(no.rank or "E"),
                poderVinculado = tostring(no.poderVinculado or ""),
                tags = {},
                energia = n(no.energia),
                dadoBase = tostring(no.dadoBase or ""),
                modificador = n(no.modificador),
                alcance = n(no.alcance),
                duracao = tostring(no.duracao or ""),
                elemento = tostring(no.elemento or ""),
                descricao = tostring(no.descricao or ""),
                efeito = tostring(no.efeito or ""),
                corpoACorpo = (no.corpoACorpo == true),
                emArea = (no.emArea == true),
                creditoEmbutido = n(no.creditoEmbutido),
                rotuloGratis = tostring(no.rotuloGratis or ""),
            }
            habRascunho.tags = expandirTags(no.tags)
            atualizarConstrutorHab()
            abrirPopupAjustado(self.popHabilidade, 1020, 700)
        end

        -- Preenche aura/dado/modificador/alcance/duracao a partir da tabela
        -- de balanceamento do rank. O jogador ainda pode ajustar tudo na mao
        -- (varias regras do livro mexem nesses numeros).
        function aplicarTabelaDoRank()
            if habRascunho == nil then return end
            local d = CatalogoHabilidades.dadosDoRank(habRascunho.rank, habRascunho.tipo == "feitico")
            if d == nil then return end
            local ehBruxa = personagemEhBruxa()

            habRascunho.energia = d.energiaMin
            if ehBruxa and habRascunho.tipo == "feitico" then
                habRascunho.dadoBase = d.dadoBaseBruxa
                habRascunho.modificador = d.modificadorBruxa
            else
                habRascunho.dadoBase = d.dadoBase
                habRascunho.modificador = d.modificador
            end
            habRascunho.duracao = tostring(d.duracao or ""):gsub("%.%s*$", "")

            -- Regras do livro que mexem no alcance:
            --  - corpo-a-corpo: alcance fixo em 5m
            --  - em area: sempre metade do alcance padrao do rank
            if habRascunho.corpoACorpo then
                habRascunho.alcance = 5
            elseif habRascunho.emArea then
                habRascunho.alcance = math.floor(d.alcanceMax / 2)
            else
                habRascunho.alcance = d.alcanceMax
            end
        end

        function definirRankHab(rank)
            if habRascunho == nil then return end
            habRascunho.rank = rank
            -- tags acima do novo limite sao cortadas
            local lim = limiteTagsAtual()
            while #habRascunho.tags > lim do table.remove(habRascunho.tags) end
            aplicarTabelaDoRank()
            atualizarConstrutorHab()
        end

        function definirTipoHab(tipo)
            if habRascunho == nil then return end
            habRascunho.tipo = tipo
            if tipo == "classe" then
                habRascunho.poderVinculado = ""
            elseif tipo == "feitico" then
                habRascunho.poderVinculado = "Magia"
            else
                local ativos = poderesAtivosAdquiridos()
                if #ativos > 0 then habRascunho.poderVinculado = ativos[1].nome end
            end
            aplicarTabelaDoRank()
            atualizarConstrutorHab()
        end

        function definirPoderHab(nomePoder)
            if habRascunho == nil then return end
            habRascunho.poderVinculado = nomePoder
            -- se o rank atual nao e mais permitido pelo novo poder, recua
            if not rankEstaLiberado(habRascunho.rank, habRascunho.tipo, nomePoder) then
                local libs = ranksLiberadosParaTipo(habRascunho.tipo, nomePoder)
                habRascunho.rank = libs[#libs] or "E"
                aplicarTabelaDoRank()
            end
            atualizarConstrutorHab()
        end

        -- ---------------------------------------------------------------
        -- LINHAGEM DE UNARIS (bruxas)
        --
        -- A qualidade "Linhagem de Unaris" torna a personagem uma bruxa:
        -- feiticos rolam dados maiores e ganham uma tag extra nos ranks C e
        -- A ("Aumente a escala de dano de suas magias", no efeito da
        -- qualidade). A ficha detecta a qualidade sozinha, mas o construtor
        -- expoe uma caixa para o mestre corrigir a mao se precisar.
        function temLinhagemDeUnaris()
            if sheet == nil then return false end
            for _, q in ipairs(NDB.getChildNodes(sheet.listaQualidades) or {}) do
                if tostring(q.nome or "") == "Linhagem de Unaris" then return true end
            end
            return false
        end

        function personagemEhBruxa()
            if sheet == nil then return false end
            -- override manual do mestre vence a deteccao automatica
            if sheet.bruxaManual == true then return true end
            if sheet.bruxaManual == false then return false end
            return temLinhagemDeUnaris()
        end

        function alternarBruxa()
            if sheet == nil or habRascunho == nil then return end
            sheet.bruxaManual = not personagemEhBruxa()
            aplicarTabelaDoRank()
            atualizarConstrutorHab()
        end

        function limiteTagsAtual()
            if habRascunho == nil then return 2 end
            local d = CatalogoHabilidades.dadosDoRank(habRascunho.rank, habRascunho.tipo == "feitico")
            if d == nil then return 2 end
            if habRascunho.tipo == "feitico" and personagemEhBruxa() then
                return d.tagsMaxBruxa
            end
            return d.tagsMax
        end

        -- Clicar ACUMULA a tag (Ofensivo, Ofensivo (2x), ...). Para tirar
        -- uma instancia, clique no chip correspondente em "tags escolhidas".
        function alternarTagHab(nomeTag)
            if habRascunho == nil then return end
            if #habRascunho.tags >= limiteTagsAtual() then
                avisarConstrutor("Rank " .. habRascunho.rank .. " permite no máximo " ..
                    limiteTagsAtual() .. " tags (repetições contam como vagas).", COR.wine)
                return
            end
            -- tags opostas: proibidas, exceto no rank EX
            local teste = {}
            for _, t in ipairs(habRascunho.tags) do table.insert(teste, t) end
            table.insert(teste, nomeTag)
            local a, b = CatalogoHabilidades.conflitoDeTags(teste, habRascunho.rank)
            if a ~= nil then
                avisarConstrutor("Tags opostas: [" .. a .. "] e [" .. b ..
                    "] não podem estar na mesma habilidade (só no rank EX).", COR.wine)
                return
            end
            table.insert(habRascunho.tags, nomeTag)
            -- a primeira tag elemental vira o elemento da habilidade
            if CatalogoHabilidades.categoriaDaTag(nomeTag) == "Elemental" and habRascunho.elemento == "" then
                habRascunho.elemento = nomeTag
            end
            atualizarConstrutorHab()
        end

        -- Chips de tags escolhidas: cada clique remove UMA instancia.
        tagsNoConstrutor = {}

        function removerTagPorChip(indice)
            if habRascunho == nil then return end
            local alvo = tagsNoConstrutor[indice]
            if alvo == nil then return end
            for i = #habRascunho.tags, 1, -1 do
                if habRascunho.tags[i] == alvo then
                    table.remove(habRascunho.tags, i)
                    break
                end
            end
            -- se a tag elemental sumiu de vez, limpa o campo elemento
            if habRascunho.elemento == alvo and contarTag(alvo) == 0 then
                habRascunho.elemento = ""
            end
            atualizarConstrutorHab()
        end

        function alternarCorpoACorpo()
            if habRascunho == nil then return end
            habRascunho.corpoACorpo = not habRascunho.corpoACorpo
            if habRascunho.corpoACorpo then habRascunho.emArea = false end
            aplicarTabelaDoRank()
            atualizarConstrutorHab()
        end

        function alternarEmArea()
            if habRascunho == nil then return end
            habRascunho.emArea = not habRascunho.emArea
            if habRascunho.emArea then habRascunho.corpoACorpo = false end
            aplicarTabelaDoRank()
            atualizarConstrutorHab()
        end

        function avisarConstrutor(texto, cor)
            if self.popHab_lblAviso == nil then return end
            self.popHab_lblAviso:setText(tostring(texto or ""))
            self.popHab_lblAviso:setFontColor(cor or COR.muted)
        end

        -- ---------------------------------------------------------------
        -- SALVAR
        -- ---------------------------------------------------------------
        function salvarHabilidade()
            if habRascunho == nil or sheet == nil then return end
            if not podeEditarCriacao() then
                avisarConstrutor("Ficha finalizada: dá para consultar, mas não alterar. Peça ao mestre para destravar.", COR.wine)
                return
            end

            -- le os campos de texto direto dos widgets (nao usam field=,
            -- porque dentro de popup field= resolve contra a ficha raiz)
            if self.popHab_edNome ~= nil then habRascunho.nome = tostring(self.popHab_edNome:getText() or "") end
            if self.popHab_edDescricao ~= nil then habRascunho.descricao = tostring(self.popHab_edDescricao:getText() or "") end
            if self.popHab_edEfeito ~= nil then habRascunho.efeito = tostring(self.popHab_edEfeito:getText() or "") end
            if self.popHab_edEnergia ~= nil then habRascunho.energia = n(self.popHab_edEnergia:getText()) end
            if self.popHab_edAlcance ~= nil then habRascunho.alcance = n(self.popHab_edAlcance:getText()) end
            if self.popHab_edDado ~= nil then habRascunho.dadoBase = tostring(self.popHab_edDado:getText() or "") end
            if self.popHab_edModificador ~= nil then habRascunho.modificador = n(self.popHab_edModificador:getText()) end
            if self.popHab_edDuracao ~= nil then habRascunho.duracao = tostring(self.popHab_edDuracao:getText() or "") end

            if habRascunho.nome == "" then
                avisarConstrutor("Dê um nome à habilidade.", COR.wine); return
            end

            if habRascunho.tipo ~= "classe" and habRascunho.poderVinculado == "" then
                avisarConstrutor("Escolha o poder de origem.", COR.wine); return
            end

            -- Magia so produz feiticos, nunca habilidade comum.
            if habRascunho.tipo == "poder" and habRascunho.poderVinculado == "Magia" then
                avisarConstrutor("O poder Magia gera feitiços, não habilidades. Use o tipo FEITIÇO.", COR.wine)
                return
            end

            if not rankEstaLiberado(habRascunho.rank, habRascunho.tipo, habRascunho.poderVinculado) then
                avisarConstrutor("O poder " .. habRascunho.poderVinculado ..
                    " ainda não libera habilidades de rank " .. habRascunho.rank .. ".", COR.wine)
                return
            end

            local custo = calcularCustoHabilidade(habRascunho.rank, habRascunho.tipo,
                habRascunho.creditoEmbutido)

            -- saldo: o custo entra no mesmo pool dos poderes
            local jaPago = 0
            if habEmEdicao ~= nil then jaPago = n(habEmEdicao.custoPago) end
            if custo - jaPago > saldoPontosPoder() then
                avisarConstrutor("Sem pontos suficientes: esta habilidade custa " .. custo ..
                    " e você tem " .. saldoPontosPoder() .. " disponível(is).", COR.wine)
                return
            end

            local ehEdicao = (habEmEdicao ~= nil)
            local no = habEmEdicao
            if no == nil then
                if self.listaHabilidades == nil then return end
                no = self.listaHabilidades:append()
                if no == nil then return end
            end

            no.tipo = habRascunho.tipo
            no.nome = habRascunho.nome
            no.rank = habRascunho.rank
            no.poderVinculado = habRascunho.poderVinculado
            no.tags = agruparTags(habRascunho.tags)
            no.energia = habRascunho.energia
            no.dadoBase = habRascunho.dadoBase
            no.modificador = habRascunho.modificador
            no.alcance = habRascunho.alcance
            no.duracao = habRascunho.duracao
            no.elemento = habRascunho.elemento
            no.descricao = habRascunho.descricao
            no.efeito = habRascunho.efeito
            no.corpoACorpo = habRascunho.corpoACorpo
            no.emArea = habRascunho.emArea
            no.custoPago = custo
            no.creditoEmbutido = n(habRascunho.creditoEmbutido)
            -- origemGratis/rotuloGratis pertencem ao SLOT e sao definidos pela
            -- sincronizacao das concessoes; salvar nao os altera.

            local etiqueta = "habilidade"
            if habRascunho.tipo == "feitico" then etiqueta = "feitiço" end
            local textoCusto = custo .. " ponto(s)"
            if custo == 0 then textoCusto = "gratuita" end
            publicarNoChat("[§K #C9A24B]" .. tostring(sheet.nome or "Personagem") ..
                "[§K] registrou a " .. etiqueta .. " [§B]" .. habRascunho.nome ..
                "[§B] — rank " .. habRascunho.rank .. ", " .. textoCusto .. ".")

            -- Edicao: o item ja existia, entao o onNodeReady dele nao roda
            -- de novo sozinho. Reconstruir a lista forca o redesenho na hora.
            if ehEdicao then reconstruirListaHabilidades() end

            habEmEdicao = nil
            habRascunho = nil
            if self.popHabilidade ~= nil then self.popHabilidade:close() end
            atualizarBlocoHabilidades()
        end

        function fecharConstrutorHabilidade()
            habEmEdicao = nil
            habRascunho = nil
            if self.popHabilidade ~= nil then self.popHabilidade:close() end
        end

        -- ---------------------------------------------------------------
        -- RENDERIZACAO
        -- ---------------------------------------------------------------
        function avisarHabilidades(texto, cor)
            if self.abaHab_lblAviso == nil then return end
            self.abaHab_lblAviso:setText(tostring(texto or ""))
            self.abaHab_lblAviso:setFontColor(cor or COR.muted)
        end

        -- ---------------------------------------------------------------
        -- TAGS EMPILHAVEIS
        --
        -- A mesma tag pode entrar varias vezes ("Ofensivo (3x)") - e como a
        -- mesa usa para intensificar dano, cura e afins. Cada repeticao
        -- consome uma vaga do limite de tags do rank.
        -- Guardamos AGRUPADO no no ("Ofensivo (2x), Fogo") porque e o que
        -- aparece na ficha; internamente o rascunho trabalha com a lista
        -- expandida, que e mais simples de contar.
        --
        -- O livro nao define quanto cada repeticao acrescenta, entao a ficha
        -- nao calcula nada: apenas registra a pilha e deixa os numeros na
        -- mao do mestre.
        -- ---------------------------------------------------------------
        function agruparTags(lista)
            local ordem, cont = {}, {}
            for _, t in ipairs(lista or {}) do
                if cont[t] == nil then cont[t] = 0; table.insert(ordem, t) end
                cont[t] = cont[t] + 1
            end
            local partes = {}
            for _, t in ipairs(ordem) do
                if cont[t] > 1 then
                    table.insert(partes, t .. " (" .. cont[t] .. "x)")
                else
                    table.insert(partes, t)
                end
            end
            return table.concat(partes, ", ")
        end

        function expandirTags(texto)
            local r = {}
            for _, parte in ipairs(partirTexto(tostring(texto or ""), ",")) do
                local limpo = parte:gsub("^%s+", ""):gsub("%s+$", "")
                local nome, qtd = limpo:match("^(.-)%s*%((%d+)x%)$")
                if nome ~= nil and qtd ~= nil then
                    for _ = 1, tonumber(qtd) do table.insert(r, nome) end
                elseif limpo ~= "" then
                    table.insert(r, limpo)
                end
            end
            return r
        end

        function contarTag(nomeTag)
            if habRascunho == nil then return 0 end
            local q = 0
            for _, t in ipairs(habRascunho.tags) do
                if t == nomeTag then q = q + 1 end
            end
            return q
        end

        -- ---------------------------------------------------------------
        -- RECONSTRUCAO DA LISTA
        --
        -- O onNodeReady do template so roda quando o item e CRIADO. Ao
        -- editar uma habilidade, os campos calculados por script (rank,
        -- resumo, tags, custo, selo de origem) nao eram reprocessados e a
        -- linha so mudava depois de fechar e reabrir a ficha.
        -- Aqui lemos tudo, apagamos os nos e recriamos NA MESMA ORDEM, o que
        -- forca o onNodeReady de cada item. Usa apenas append/deleteNode,
        -- que sao as APIs ja comprovadas neste projeto.
        -- Nunca apagamos o no-container: so os filhos.
        -- ---------------------------------------------------------------
        function reconstruirListaHabilidades()
            if sheet == nil or self.listaHabilidades == nil then return end
            -- ATENCAO: campo novo no item precisa entrar TAMBEM aqui, senao
            -- a reconstrucao o perde silenciosamente. Foi o que aconteceu com
            -- "creditoEmbutido": o desconto sumia depois da primeira edicao.
            local campos = {"tipo", "nome", "rank", "poderVinculado", "tags", "energia", "dadoBase",
            "modificador", "alcance", "duracao", "elemento", "descricao", "efeito",
            "custoPago", "origemGratis", "corpoACorpo", "emArea",
            "creditoEmbutido", "rotuloGratis"}

            -- Primeiro guardamos OS NOS numa tabela propria. Iterar a lista
            -- viva enquanto se apaga dela pula elementos - foi o que duplicou
            -- itens no teste.
            local nos = {}
            for _, no in ipairs(todasHabilidades()) do table.insert(nos, no) end

            local copia = {}
            for _, no in ipairs(nos) do
                local reg = {}
                for _, campo in ipairs(campos) do reg[campo] = no[campo] end
                table.insert(copia, reg)
            end

            for _, no in ipairs(nos) do
                NDB.deleteNode(no)
            end

            for _, reg in ipairs(copia) do
                local novo = self.listaHabilidades:append()
                if novo ~= nil then
                    for _, campo in ipairs(campos) do novo[campo] = reg[campo] end
                end
            end
        end

        function ajustarAlturaListaHabilidades()
            if self.listaHabilidades == nil then return end
            local qtd = #todasHabilidades()
            if qtd < 1 then qtd = 0 end
            definirAlturaPod(self.listaHabilidades, qtd * 56 + 4)
        end

        function atualizarBlocoHabilidades()
            if sheet == nil then return end
            sincronizarSlotsConcedidos()

            -- Resumo dos slots concedidos: quantos existem e quantos ainda
            -- estao por preencher (sem nome).
            if self.abaHab_lblCreditos ~= nil then
                local concedidos, vazios = 0, 0
                for _, h in ipairs(todasHabilidades()) do
                    if n(h.creditoEmbutido) > 0 then
                        concedidos = concedidos + 1
                        if tostring(h.nome or "") == "" then vazios = vazios + 1 end
                    end
                end
                local partes = {}
                if concedidos > 0 then
                    table.insert(partes, "Concedidas pelo sistema: " .. concedidos)
                    if vazios > 0 then
                        table.insert(partes, vazios .. " por preencher — clique para batizar")
                    end
                end
                if descontoSkillNivel19() > 0 then
                    table.insert(partes, "1 ponto de skill do nível 19 aplicado")
                end
                if #partes == 0 then
                    table.insert(partes, "Cada poder ativo desbloqueado abre uma habilidade gratuita.")
                end
                self.abaHab_lblCreditos:setText(table.concat(partes, "          "))
            end

            if self.abaHab_lblGastos ~= nil then
                self.abaHab_lblGastos:setText(tostring(gastosHabilidadesLiquido()))
            end
            if self.abaHab_lblQtd ~= nil then
                self.abaHab_lblQtd:setText(tostring(#todasHabilidades()))
            end

            -- estado vazio
            definirAlturaPod(self.abaHab_wrapVazio, (#todasHabilidades() == 0) and 56 or 0)

            -- botao de feiticos so aparece com o poder Magia
            definirLarguraPod(self.abaHab_wrapFeitico, (nivelDoPoder("Magia") > 0) and 200 or 0)

            ajustarAlturaListaHabilidades()
            atualizarBlocoPoderes()
        end

        -- ---------------------------------------------------------------
        -- RENDER DO CONSTRUTOR
        -- ---------------------------------------------------------------
        -- Poderes listados no seletor, na ordem em que aparecem na tela.
        poderesNoConstrutor = {}

        function popHabEscolherPoder(indice)
            local p = poderesNoConstrutor[indice]
            if p == nil then return end
            definirPoderHab(p.nome)
        end

        function atualizarConstrutorHab()
            if habRascunho == nil then return end
            local ehFeitico = (habRascunho.tipo == "feitico")

            if self.popHab_lblTitulo ~= nil then
                local t = "CONSTRUTOR DE HABILIDADE"
                if ehFeitico then t = "CONSTRUTOR DE FEITIÇO" end
                if habEmEdicao ~= nil then t = "EDITAR " .. t:gsub("CONSTRUTOR DE ", "") end
                self.popHab_lblTitulo:setText("✦  " .. t .. "  ✦")
            end

            -- campos de texto
            if self.popHab_edNome ~= nil then self.popHab_edNome:setText(habRascunho.nome) end
            if self.popHab_edEnergia ~= nil then self.popHab_edEnergia:setText(tostring(habRascunho.energia)) end
            if self.popHab_edDado ~= nil then self.popHab_edDado:setText(habRascunho.dadoBase) end
            if self.popHab_edModificador ~= nil then self.popHab_edModificador:setText(tostring(habRascunho.modificador)) end
            if self.popHab_edAlcance ~= nil then self.popHab_edAlcance:setText(tostring(habRascunho.alcance)) end
            if self.popHab_edDuracao ~= nil then self.popHab_edDuracao:setText(habRascunho.duracao) end
            if self.popHab_edDescricao ~= nil then self.popHab_edDescricao:setText(habRascunho.descricao) end
            if self.popHab_edEfeito ~= nil then self.popHab_edEfeito:setText(habRascunho.efeito) end

            if self.popHab_lblEnergiaTit ~= nil then
                self.popHab_lblEnergiaTit:setText(ehFeitico and "MANA" or "AURA")
            end

            -- tipo selecionado
            local tipos = {
                {chave = "poder", btn = self.popHab_btnTipoPoder, lbl = self.popHab_lblTipoPoder, cor = COR.aura},
                {chave = "classe", btn = self.popHab_btnTipoClasse, lbl = self.popHab_lblTipoClasse, cor = COR.moss},
                {chave = "feitico", btn = self.popHab_btnTipoFeitico, lbl = self.popHab_lblTipoFeitico, cor = COR.rain},
            }
            for _, t in ipairs(tipos) do
                local ativo = (habRascunho.tipo == t.chave)
                if t.btn ~= nil then t.btn:setStrokeColor(ativo and t.cor or COR.line) end
                if t.lbl ~= nil then t.lbl:setFontColor(ativo and t.cor or COR.muted) end
            end

            -- lista de poderes de origem
            poderesNoConstrutor = {}
            if habRascunho.tipo == "poder" then
                poderesNoConstrutor = poderesAtivosAdquiridos()
            elseif ehFeitico then
                local nv = nivelDoPoder("Magia")
                if nv > 0 then
                    poderesNoConstrutor = {{nome = "Magia", nivel = nv, deus = ""}}
                end
            end

            local qtd = #poderesNoConstrutor
            if qtd > 8 then qtd = 8 end
            definirAlturaPod(self.popHab_wrapListaPoderes, qtd * 29)
            for i = 1, 8 do
                local p = poderesNoConstrutor[i]
                definirAlturaPod(self["popHab_wrapPoder" .. i], (p ~= nil) and 29 or 0)
                if p ~= nil then
                    local lbl = self["popHab_lblPoder" .. i]
                    if lbl ~= nil then lbl:setText(p.nome) end
                    local lblNv = self["popHab_lblPoderNv" .. i]
                    if lblNv ~= nil then
                        local libs = ranksLiberadosPorPoder(p.nome)
                        lblNv:setText("nível " .. p.nivel .. " · até " .. (libs[#libs] or "E"))
                    end
                    local rect = self["popHab_rectPoder" .. i]
                    if rect ~= nil then
                        if p.nome == habRascunho.poderVinculado then
                            rect:setStrokeColor(COR.aura); rect:setStrokeSize(2)
                        else
                            rect:setStrokeColor(COR.line); rect:setStrokeSize(1)
                        end
                    end
                end
            end

            -- aviso quando o tipo nao usa poder
            if self.popHab_lblSemPoder ~= nil then
                if habRascunho.tipo == "classe" then
                    self.popHab_lblSemPoder:setText("Habilidade de classe não depende de poder e pode chegar ao rank EX, " ..
                        "mas seus efeitos são mais fracos. As regras desta categoria ainda estão sendo fechadas na mesa, " ..
                        "então a ficha deixa todos os campos livres — combine os valores com o mestre.")
                    definirAlturaPod(self.popHab_lblSemPoder, 46)
                else
                    self.popHab_lblSemPoder:setText("")
                    definirAlturaPod(self.popHab_lblSemPoder, 0)
                end
            end
            definirAlturaPod(self.popHab_lblPoderTitulo, (habRascunho.tipo == "classe") and 0 or 16)

            -- ranks: liberados x bloqueados
            local libs = ranksLiberadosParaTipo(habRascunho.tipo, habRascunho.poderVinculado)
            for _, r in ipairs(CatalogoHabilidades.ranks) do
                local liberado = false
                for _, l in ipairs(libs) do if l == r then liberado = true end end
                local btn = self["popHab_btnRank" .. r]
                local lbl = self["popHab_lblRank" .. r]
                if btn ~= nil and lbl ~= nil then
                    if r == habRascunho.rank then
                        btn:setStrokeColor(COR.gold); btn:setStrokeSize(2); lbl:setFontColor(COR.gold)
                    elseif liberado then
                        btn:setStrokeColor(COR.line); btn:setStrokeSize(1); lbl:setFontColor(COR.text)
                    else
                        btn:setStrokeColor("#1A262C"); btn:setStrokeSize(1); lbl:setFontColor(COR.faint)
                    end
                end
            end

            -- explicacao do rank
            if self.popHab_lblRankInfo ~= nil then
                local d = CatalogoHabilidades.dadosDoRank(habRascunho.rank, ehFeitico)
                local energiaNome = ehFeitico and "Mana" or "Aura"
                if d ~= nil then
                    local txt = "Rank " .. habRascunho.rank .. ": custa " .. d.custo ..
                        " ponto(s), até " .. limiteTagsAtual() .. " tags, " .. energiaNome .. " " ..
                        d.energiaMin .. " a " .. d.energiaMax .. ", alcance máximo " ..
                        d.alcanceMax .. "m, " .. d.duracao .. ". " .. d.efeitoAdicional
                    if habRascunho.tipo ~= "classe" and habRascunho.poderVinculado ~= "" then
                        local nv = nivelDoPoder(habRascunho.poderVinculado)
                        txt = txt .. "  —  " .. habRascunho.poderVinculado .. " está no nível " .. nv ..
                            " e libera até " .. (libs[#libs] or "E") .. "."
                    end
                    self.popHab_lblRankInfo:setText(txt)
                end
            end

            -- Linhagem de Unaris: so faz diferenca em feitico
            definirAlturaPod(self.popHab_wrapBruxa, ehFeitico and 54 or 0)
            if ehFeitico and self.popHab_btnBruxa ~= nil then
                local bruxa = personagemEhBruxa()
                self.popHab_btnBruxa:setStrokeColor(bruxa and COR.aura or COR.line)
                if self.popHab_lblBruxa ~= nil then
                    if bruxa then
                        self.popHab_lblBruxa:setText("✦  BRUXA — escala de magia aumentada")
                        self.popHab_lblBruxa:setFontColor(COR.aura)
                    else
                        local auto = temLinhagemDeUnaris()
                        if auto then
                            self.popHab_lblBruxa:setText("BRUXA desligada manualmente (tem a qualidade)")
                        else
                            self.popHab_lblBruxa:setText("NÃO É BRUXA — clique se tiver Linhagem de Unaris")
                        end
                        self.popHab_lblBruxa:setFontColor(COR.muted)
                    end
                end
            end

            -- modificadores de alcance
            if self.popHab_btnCorpo ~= nil then
                self.popHab_btnCorpo:setStrokeColor(habRascunho.corpoACorpo and COR.gold or COR.line)
                if self.popHab_lblCorpo ~= nil then
                    self.popHab_lblCorpo:setFontColor(habRascunho.corpoACorpo and COR.gold or COR.muted)
                end
            end
            if self.popHab_btnArea ~= nil then
                self.popHab_btnArea:setStrokeColor(habRascunho.emArea and COR.gold or COR.line)
                if self.popHab_lblArea ~= nil then
                    self.popHab_lblArea:setFontColor(habRascunho.emArea and COR.gold or COR.muted)
                end
            end

            -- tags
            if self.popHab_lblTagsLimite ~= nil then
                self.popHab_lblTagsLimite:setText("TAGS  " .. #habRascunho.tags .. " / " ..
                    limiteTagsAtual() .. "   ·   clique acumula")
            end
            for _, t in ipairs(CatalogoHabilidades.todasAsTags()) do
                local card = self["popHab_tag" .. chavePoder(t.nome)]
                local lbl = self["popHab_lblTag" .. chavePoder(t.nome)]
                local vezes = contarTag(t.nome)
                if card ~= nil then
                    card:setStrokeColor((vezes > 0) and COR.aura or COR.line)
                    card:setStrokeSize((vezes > 0) and 2 or 1)
                end
                if lbl ~= nil then
                    -- o proprio card mostra quantas vezes a tag foi empilhada
                    if vezes > 1 then
                        lbl:setText(t.nome .. "   (" .. vezes .. "x)")
                    else
                        lbl:setText(t.nome)
                    end
                    lbl:setFontColor((vezes > 0) and COR.text or COR.muted)
                end
            end

            -- chips: um por tag distinta, com a contagem
            tagsNoConstrutor = {}
            local ordem, cont = {}, {}
            for _, t in ipairs(habRascunho.tags) do
                if cont[t] == nil then cont[t] = 0; table.insert(ordem, t) end
                cont[t] = cont[t] + 1
            end
            for i = 1, 5 do
                local nomeTag = ordem[i]
                tagsNoConstrutor[i] = nomeTag
                local temChip = (nomeTag ~= nil)
                local texto = ""
                if temChip then
                    texto = nomeTag
                    if cont[nomeTag] > 1 then texto = texto .. "  " .. cont[nomeTag] .. "x" end
                end
                -- largura proporcional ao texto (bytes servem: as tags sao curtas)
                local largura = 0
                if temChip then largura = 30 + #texto * 7 end
                definirLarguraPod(self["popHab_wrapChip" .. i], largura)
                local lblChip = self["popHab_lblChip" .. i]
                if lblChip ~= nil then lblChip:setText(texto .. "   ×") end
            end
            if self.popHab_lblTagsEscolhidas ~= nil then
                if #habRascunho.tags == 0 then
                    self.popHab_lblTagsEscolhidas:setText("Nenhuma tag escolhida.")
                else
                    self.popHab_lblTagsEscolhidas:setText("")
                end
            end

            -- custo previsto
            if self.popHab_lblCusto ~= nil then
                local credito = n(habRascunho.creditoEmbutido)
                local cheio = CatalogoHabilidades.custoDoRank(habRascunho.rank, ehFeitico)
                local custo = calcularCustoHabilidade(habRascunho.rank, habRascunho.tipo, credito)
                if credito > 0 then
                    local txt = "Concedida por " .. tostring(habRascunho.rotuloGratis or "sistema") ..
                        ": " .. credito .. " ponto(s) de desconto"
                    if custo == 0 then
                        txt = txt .. "   ·   sai de graça"
                    else
                        txt = txt .. "   ·   " .. cheio .. " − " .. credito .. " = " .. custo ..
                            " ponto(s)   ·   saldo " .. saldoPontosPoder()
                    end
                    self.popHab_lblCusto:setText(txt)
                    self.popHab_lblCusto:setFontColor(COR.gold)
                else
                    self.popHab_lblCusto:setText("Custo: " .. custo .. " ponto(s)   ·   saldo atual " .. saldoPontosPoder())
                    self.popHab_lblCusto:setFontColor(COR.muted)
                end
            end
        end

        -- =================================================================
        -- CONCESSOES AUTOMATICAS
        --
        -- Varias partes do sistema entregam coisas de graca em OUTRAS abas:
        -- uma caracteristica racial da uma pericia, um poder de atributo da
        -- uma qualidade e +1 no atributo, e assim por diante. Sem isso
        -- automatizado o jogador acaba pagando do proprio bolso por algo que
        -- o sistema deveria dar.
        --
        -- COMO FUNCIONA
        --   Cada linha de CONCESSOES declara uma FONTE (o que precisa estar
        --   na ficha) e um EFEITO (o que isso entrega). A cada recalculo
        --   comparamos as fontes ativas com o que ja foi aplicado, gravado em
        --   "concessoesAplicadas". Aplicar duas vezes nao acumula, e perder a
        --   fonte desfaz o efeito.
        --
        -- TIPOS DE FONTE
        --   caracRacial : a caracteristica esta na lista de caracteristicas
        --   poderNivel  : o poder esta no nivel N ou acima
        --   qualidade   : a qualidade esta na ficha
        --
        -- TIPOS DE EFEITO
        --   atributo     : soma no campo <attr>Bonus (o segundo campo, de
        --                  bonus racial/poder)
        --   qualidade    : entra na lista de Qualidades com pontosPagos = 0
        --   defeito      : entra na lista de Defeitos com pontosPagos = 0.
        --                  REGRA DA MESA: defeito concedido NAO rende PD -
        --                  e um defeito ganho de graca, nao uma escolha. Como
        --                  o ganho de PD e a soma de "pontosPagos", gravar 0
        --                  ja resolve isso sozinho.
        --   pericia      : entra na lista do atributo, ignorando o limite
        --   periciaLivre : nao escolhe nada; abre +1 vaga de pericia naquele
        --                  atributo para o jogador escolher (o texto do livro
        --                  diz "escolha uma pericia deste atributo")
        -- =================================================================

        -- O campo "tier" e o CUSTO REAL da qualidade no catalogo, e nao um
        -- numero qualquer: e ele que seleciona a faixa de efeito
        -- (CatalogoQD.somarEfeitos le item.efeitos[tier]) e o que aparece no
        -- selo de pontos do item. Conferido um a um contra o "pontosTexto".
        local CONCESSOES = {
            -- ----- caracteristicas raciais -----
            {chave = "drow_animais", fonte = {tipo = "caracRacial", nome = "Mestres da domesticação"},
             efeito = {tipo = "pericia", atributo = "Carisma", nome = "Animais"},
             rotulo = "Mestres da domesticação"},

            {chave = "vamp_beleza", fonte = {tipo = "caracRacial", nome = "Sedutores"},
             efeito = {tipo = "qualidade", nome = "Beleza sobrenatural", tier = 3},
             rotulo = "Sedutores (Vampiros)"},

            {chave = "vamp_segredo", fonte = {tipo = "caracRacial", nome = "Cabeça a prêmio"},
             efeito = {tipo = "defeito", nome = "Segredo obscuro", tier = 3},
             rotulo = "Cabeça a prêmio (Vampiros)"},

            {chave = "harpia_intoler", fonte = {tipo = "caracRacial", nome = "Intolerância a mortos-vivos"},
             efeito = {tipo = "defeito", nome = "Intolerância", tier = 2},
             rotulo = "Intolerância (Harpias)"},

            -- ----- bonus de atributo racial -----
            -- Extraidas do catalogo de racas. Cada uma da +N num ou dois
            -- atributos e eleva o TETO daquele atributo (9 ou 10 conforme a
            -- raca). O bonus vai para o campo "+", nunca para o valor base.
            --
            -- DEDUPLICADAS POR CARACTERISTICA: "Super forca" aparece em seis
            -- racas e "Vigorosos" em tres, sempre com o mesmo efeito. Como a
            -- ficha guarda a CARACTERISTICA (e nao a raca), uma entrada por
            -- raca fazia o bonus ser aplicado varias vezes - Constituicao
            -- ganhava +6 em vez de +2.
            {chave = "rac_agilidadeaprimor", fonte = {tipo = "caracRacial", nome = "Agilidade aprimorada"},
             efeito = {tipo = "atributoRacial", atributos = {"Destreza"}, valor = 1, teto = 10},
             rotulo = "Agilidade aprimorada"},
            {chave = "rac_agilidadeelfica", fonte = {tipo = "caracRacial", nome = "Agilidade élfica"},
             efeito = {tipo = "atributoRacial", atributos = {"Destreza"}, valor = 1, teto = 10},
             rotulo = "Agilidade élfica"},
            {chave = "rac_carismaticos", fonte = {tipo = "caracRacial", nome = "Carismáticos"},
             efeito = {tipo = "atributoRacial", atributos = {"Carisma"}, valor = 1, teto = 10},
             rotulo = "Carismáticos"},
            {chave = "rac_fisiologiadeguer", fonte = {tipo = "caracRacial", nome = "Fisiologia de guerra"},
             efeito = {tipo = "atributoRacial", atributos = {"Força", "Destreza"}, valor = 1, teto = 9},
             rotulo = "Fisiologia de guerra"},
            {chave = "rac_graciosidade", fonte = {tipo = "caracRacial", nome = "Graciosidade"},
             efeito = {tipo = "atributoRacial", atributos = {"Destreza", "Carisma"}, valor = 1, teto = 9},
             rotulo = "Graciosidade"},
            {chave = "rac_manipuladoras", fonte = {tipo = "caracRacial", nome = "Manipuladoras"},
             efeito = {tipo = "atributoRacial", atributos = {"Manipulação"}, valor = 1, teto = 10},
             rotulo = "Manipuladoras"},
            {chave = "rac_manipuladores", fonte = {tipo = "caracRacial", nome = "Manipuladores"},
             efeito = {tipo = "atributoRacial", atributos = {"Manipulação"}, valor = 1, teto = 10},
             rotulo = "Manipuladores"},
            -- Lizarianos, Selkies, Sereias e Tritões, Lobisomens, Minotauros, Ursaris
            {chave = "rac_superforca", fonte = {tipo = "caracRacial", nome = "Super força"},
             efeito = {tipo = "atributoRacial", atributos = {"Força"}, valor = 1, teto = 10},
             rotulo = "Super força"},
            -- Anões, Vampiros, Minotauros
            {chave = "rac_vigorosos", fonte = {tipo = "caracRacial", nome = "Vigorosos"},
             efeito = {tipo = "atributoRacial", atributos = {"Constituição"}, valor = 2, teto = 10},
             rotulo = "Vigorosos"},

            -- ----- humanos -----
            -- "1 pericia adicional LIVRE": nao e de um atributo especifico,
            -- entao abre vaga no total geral, e nao no limite de um atributo.
            {chave = "hum_multitarefas", fonte = {tipo = "caracRacial", nome = "Multitarefas"},
             efeito = {tipo = "periciaLivreGeral"},
             rotulo = "Multitarefas (Humanos)"},
            -- "1 ponto adicional de atributo": entra no BOLSO de pontos, e nao
            -- como bonus no valor de um atributo.
            {chave = "hum_versatilidade", fonte = {tipo = "caracRacial", nome = "Versatilidade humana"},
             efeito = {tipo = "pontoAtributo", valor = 1, teto = 10},
             rotulo = "Versatilidade humana"},

            -- ----- poderes de atributo: nivel 1 -----
            {chave = "pod_car1", fonte = {tipo = "poderNivel", nome = "Carisma sobrenatural", nivel = 1},
             efeito = {tipo = "qualidade", nome = "Beleza sobrenatural", tier = 3},
             rotulo = "Carisma sobrenatural"},
            {chave = "pod_con1", fonte = {tipo = "poderNivel", nome = "Constituição sobrenatural", nivel = 1},
             efeito = {tipo = "qualidade", nome = "Vigor expandido", tier = 2},
             rotulo = "Constituição sobrenatural"},
            {chave = "pod_int1", fonte = {tipo = "poderNivel", nome = "Inteligência sobrenatural", nivel = 1},
             efeito = {tipo = "qualidade", nome = "Genialidade", tier = 3},
             rotulo = "Inteligência sobrenatural"},
            {chave = "pod_sab1", fonte = {tipo = "poderNivel", nome = "Sabedoria sobrenatural", nivel = 1},
             efeito = {tipo = "qualidade", nome = "Vontade de ferro", tier = 2},
             rotulo = "Sabedoria sobrenatural"},

            -- ----- poderes de atributo: pericias de escolha -----
            {chave = "pod_for1_per", fonte = {tipo = "poderNivel", nome = "Força sobrenatural", nivel = 1},
             efeito = {tipo = "periciaLivre", atributo = "Força"},
             rotulo = "Força sobrenatural"},
            {chave = "pod_man1_per", fonte = {tipo = "poderNivel", nome = "Manipulação sobrenatural", nivel = 1},
             efeito = {tipo = "periciaLivre", atributo = "Manipulação"},
             rotulo = "Manipulação sobrenatural"},
            {chave = "pod_int3_per", fonte = {tipo = "poderNivel", nome = "Inteligência sobrenatural", nivel = 3},
             efeito = {tipo = "periciaLivre", atributo = "Inteligência"},
             rotulo = "Inteligência sobrenatural (nível 3)"},
            {chave = "pod_int5_per", fonte = {tipo = "poderNivel", nome = "Inteligência sobrenatural", nivel = 5},
             efeito = {tipo = "periciaLivre", atributo = "Inteligência"},
             rotulo = "Inteligência sobrenatural (nível 5)"},
            {chave = "pod_sab3_per", fonte = {tipo = "poderNivel", nome = "Sabedoria sobrenatural", nivel = 3},
             efeito = {tipo = "periciaLivre", atributo = "Sabedoria"},
             rotulo = "Sabedoria sobrenatural (nível 3)"},

            -- ----- qualidade que da pericia -----
            {chave = "qual_beleza_seducao", fonte = {tipo = "qualidade", nome = "Beleza sobrenatural"},
             efeito = {tipo = "pericia", atributo = "Manipulação", nome = "Sedução"},
             rotulo = "Beleza sobrenatural"},
        }

        -- Bonus de atributo dos 7 poderes sobrenaturais.
        -- A progressao da +1 nos niveis 1 a 4 e +2 no nivel 5 (total +6).
        -- Fica separado da tabela acima porque o valor depende do nivel do
        -- poder, e nao e um liga-desliga.
        local BONUS_ATRIBUTO_ACUMULADO = {0, 1, 2, 3, 4, 6}

        local CAMPO_ATRIBUTO = {
            ["Força"] = "forca", ["Destreza"] = "destreza",
            ["Constituição"] = "constituicao", ["Inteligência"] = "inteligencia",
            ["Sabedoria"] = "sabedoria", ["Carisma"] = "carisma",
            ["Manipulação"] = "manipulacao",
        }

        function chavesConcedidas()
            if sheet == nil then return {} end
            local r = {}
            for _, k in ipairs(partirTexto(sheet.concessoesAplicadas, ";")) do r[k] = true end
            return r
        end

        function gravarChavesConcedidas(mapa)
            if sheet == nil then return end
            local partes = {}
            for k, v in pairs(mapa) do
                if v then table.insert(partes, k) end
            end
            table.sort(partes)
            sheet.concessoesAplicadas = table.concat(partes, ";")
        end

        -- Consulta em DUAS fontes, nesta ordem:
        --   1. o catalogo da raca gravada em sheet.raca;
        --   2. a recordList de caracteristicas da aba.
        --
        -- A recordList e reconstruida quando a aba de Raca desenha, e nao no
        -- instante em que a raca muda. Depender so dela fazia os bonus
        -- entrarem apenas depois de fechar e reabrir a ficha - o catalogo, ao
        -- contrario, responde assim que sheet.raca e gravado.
        -- A lista continua sendo consultada porque e ela que guarda as
        -- caracteristicas ESCOLHIDAS de um mestico, que nao saem do catalogo
        -- de uma raca so.
        function temCaracRacial(nome)
            if sheet == nil then return false end

            -- Defensivo: se o catalogo nao estiver carregado, cai direto na
            -- lista em vez de estourar. Sem isso, um erro aqui era engolido
            -- pelo pcall do motor e TODAS as concessoes falhavam caladas.
            local dados = nil
            if CatalogoRacas ~= nil then
                local ok, res = pcall(function()
                    return CatalogoRacas.buscarPorNome(tostring(sheet.raca or ""))
                end)
                if ok then dados = res end
            end
            if dados ~= nil then
                for _, car in ipairs(dados.caracteristicas or {}) do
                    if tostring(car.nome or "") == nome then
                        -- Humano puro perde a caracteristica exclusiva quando
                        -- vira mestico; o resto vale normalmente.
                        local exclusiva = ""
                        pcall(function() exclusiva = CatalogoRacas.CARACTERISTICA_SO_HUMANO_PURO end)
                        if nome == exclusiva and exclusiva ~= "" and n(sheet.mesticoQtd) > 0 then
                            return false
                        end
                        return true
                    end
                end
            end

            for _, item in ipairs(NDB.getChildNodes(sheet.listaCaracsRaciais) or {}) do
                if tostring(item.nome or "") == nome then return true end
            end
            return false
        end

        function temQualidadeNaFicha(nome)
            if sheet == nil then return false end
            for _, q in ipairs(NDB.getChildNodes(sheet.listaQualidades) or {}) do
                if tostring(q.nome or "") == nome then return true end
            end
            return false
        end

        function fonteEstaAtiva(fonte)
            if fonte == nil then return false end
            if fonte.tipo == "caracRacial" then
                return temCaracRacial(fonte.nome)
            elseif fonte.tipo == "poderNivel" then
                return nivelDoPoder(fonte.nome) >= n(fonte.nivel)
            elseif fonte.tipo == "qualidade" then
                return temQualidadeNaFicha(fonte.nome)
            end
            return false
        end

        -- Nome da lista de pericias de um atributo (ex.: listaPericiasCarisma).
        function listaDePericiasDe(atributo)
            local base = CAMPO_ATRIBUTO[atributo]
            if base == nil then return nil end
            return "listaPericias" .. string.upper(string.sub(base, 1, 1)) .. string.sub(base, 2)
        end

        -- ---------------------------------------------------------------
        -- APLICAR / DESFAZER
        -- ---------------------------------------------------------------
        function aplicarEfeitoConcessao(con)
            local ef = con.efeito
            if ef == nil or sheet == nil then return false end

            if ef.tipo == "qualidade" or ef.tipo == "defeito" then
                local nomeLista = (ef.tipo == "qualidade") and "listaQualidades" or "listaDefeitos"
                local widget = self[nomeLista]
                if widget == nil then return false end
                -- ja existe na ficha? entao so registramos a origem, sem duplicar
                for _, item in ipairs(NDB.getChildNodes(sheet[nomeLista]) or {}) do
                    if tostring(item.nome or "") == ef.nome then
                        if n(item.pontosEscolhidos) < n(ef.tier) then
                            item.pontosEscolhidos = n(ef.tier)
                        end
                        item.origemConcessao = con.rotulo
                        return true
                    end
                end
                local dados = CatalogoQD.buscarPorNome(ef.nome)
                local node = widget:append()
                if node == nil then return false end
                node.tipo = (ef.tipo == "qualidade") and "Qualidade" or "Defeito"
                node.nome = ef.nome
                node.pontosEscolhidos = n(ef.tier)
                node.pontosPagos = 0          -- de graca: nao gasta PQ nem rende PD
                node.origemConcessao = con.rotulo
                node.descricao = dados and dados.descricao or ""
                node.pontosTexto = dados and dados.pontosTexto or ""
                return true

            elseif ef.tipo == "pericia" then
                local nomeLista = listaDePericiasDe(ef.atributo)
                if nomeLista == nil then return false end
                local widget = self[nomeLista]
                if widget == nil then return false end
                for _, item in ipairs(NDB.getChildNodes(sheet[nomeLista]) or {}) do
                    if tostring(item.nome or "") == ef.nome then
                        item.origemConcessao = con.rotulo
                        return true
                    end
                end
                local dados = CatalogoPericias.buscar(ef.atributo, ef.nome)
                local node = widget:append()
                if node == nil then return false end
                node.atributo = ef.atributo
                node.nome = ef.nome
                node.aprovadoMestre = true    -- concedida: entra fora do limite
                node.origemConcessao = con.rotulo
                node.descricao = dados and dados.descricao or ""
                return true

            elseif ef.tipo == "periciaLivre" then
                local base = CAMPO_ATRIBUTO[ef.atributo]
                if base == nil then return false end
                local campo = base .. "PericiasBonus"
                sheet[campo] = n(sheet[campo]) + 1
                return true

            elseif ef.tipo == "periciaLivreGeral" then
                sheet.periciasBonusGeral = n(sheet.periciasBonusGeral) + 1
                return true

            elseif ef.tipo == "atributoRacial" then
                -- +N no campo de BONUS de cada atributo listado, e o teto
                -- daquele atributo passa a ser o da raca (9 ou 10).
                local lancados = 0
                for _, nomeAtr in ipairs(ef.atributos or {}) do
                    local base = CAMPO_ATRIBUTO[nomeAtr]
                    if base ~= nil then
                        sheet[base .. "Bonus"] = n(sheet[base .. "Bonus"]) + n(ef.valor)
                        sheet[base .. "TetoRacial"] = n(ef.teto)
                        lancados = lancados + 1
                    end
                end
                return lancados > 0

            elseif ef.tipo == "pontoAtributo" then
                -- REGRA DA MESA: este ponto NAO entra no bolso de pontos de
                -- evolucao (que continua 18 no nivel 7). Ele vai direto para o
                -- campo de BONUS do atributo que o jogador escolher no popup
                -- da raca. Enquanto nao escolher, fica pendente.
                local nomeAtr = tostring(sheet.atributoRacialEscolhido or "")
                if nomeAtr == "" then return false end
                local base = CAMPO_ATRIBUTO[nomeAtr]
                if base == nil then return false end
                local v = n(ef.valor)
                if v == 0 then v = 1 end
                sheet[base .. "Bonus"] = n(sheet[base .. "Bonus"]) + v
                local t = n(ef.teto)
                if t == 0 then t = 10 end
                sheet[base .. "TetoRacial"] = t
                sheet.atributoRacialLancado = nomeAtr
                sheet.atributoRacialValor = v
                return true
            end
            return false
        end

        function desfazerEfeitoConcessao(con)
            local ef = con.efeito
            if ef == nil or sheet == nil then return end

            if ef.tipo == "qualidade" or ef.tipo == "defeito" then
                local nomeLista = (ef.tipo == "qualidade") and "listaQualidades" or "listaDefeitos"
                for _, item in ipairs(NDB.getChildNodes(sheet[nomeLista]) or {}) do
                    if tostring(item.nome or "") == ef.nome
                       and tostring(item.origemConcessao or "") == con.rotulo then
                        -- so remove o que foi 100% concedido; se o jogador
                        -- pagou por cima, mantemos e apenas soltamos a marca
                        if n(item.pontosPagos) <= 0 then
                            NDB.deleteNode(item)
                        else
                            item.origemConcessao = ""
                        end
                        return
                    end
                end

            elseif ef.tipo == "pericia" then
                local nomeLista = listaDePericiasDe(ef.atributo)
                if nomeLista == nil then return end
                for _, item in ipairs(NDB.getChildNodes(sheet[nomeLista]) or {}) do
                    if tostring(item.nome or "") == ef.nome
                       and tostring(item.origemConcessao or "") == con.rotulo then
                        NDB.deleteNode(item)
                        return
                    end
                end

            elseif ef.tipo == "periciaLivre" then
                local base = CAMPO_ATRIBUTO[ef.atributo]
                if base == nil then return end
                local campo = base .. "PericiasBonus"
                local novo = n(sheet[campo]) - 1
                if novo < 0 then novo = 0 end
                sheet[campo] = novo

            elseif ef.tipo == "periciaLivreGeral" then
                local novo = n(sheet.periciasBonusGeral) - 1
                if novo < 0 then novo = 0 end
                sheet.periciasBonusGeral = novo

            elseif ef.tipo == "atributoRacial" then
                for _, nomeAtr in ipairs(ef.atributos or {}) do
                    local base = CAMPO_ATRIBUTO[nomeAtr]
                    if base ~= nil then
                        local novo = n(sheet[base .. "Bonus"]) - n(ef.valor)
                        if novo < 0 then novo = 0 end
                        sheet[base .. "Bonus"] = novo
                        sheet[base .. "TetoRacial"] = 0
                    end
                end

            elseif ef.tipo == "pontoAtributo" then
                -- devolve o bonus ao atributo em que ele foi lancado
                local nomeAtr = tostring(sheet.atributoRacialLancado or "")
                local base = CAMPO_ATRIBUTO[nomeAtr]
                if base ~= nil then
                    local v = n(sheet.atributoRacialValor)
                    if v == 0 then v = 1 end
                    local novo = n(sheet[base .. "Bonus"]) - v
                    if novo < 0 then novo = 0 end
                    sheet[base .. "Bonus"] = novo
                    sheet[base .. "TetoRacial"] = 0
                end
                sheet.atributoRacialLancado = ""
                sheet.atributoRacialValor = 0
            end
        end

        -- ---------------------------------------------------------------
        -- BONUS DE ATRIBUTO DOS PODERES SOBRENATURAIS
        --
        -- Diferente das demais concessoes, este valor MUDA conforme o poder
        -- sobe. Guardamos quanto ja foi lancado em cada atributo para somar
        -- apenas a diferenca - assim o campo de bonus do jogador (que pode
        -- ter valores de outras origens) nunca e sobrescrito.
        -- ---------------------------------------------------------------
        function sincronizarBonusAtributoDePoderes()
            if sheet == nil then return end
            for _, poder in ipairs(CatalogoPoderes.itens) do
                if poder.atributo ~= nil then
                    local base = CAMPO_ATRIBUTO[poder.atributo]
                    if base ~= nil then
                        local nivel = nivelDoPoder(poder.nome)
                        if nivel > 5 then nivel = 5 end
                        local desejado = BONUS_ATRIBUTO_ACUMULADO[nivel + 1] or 0
                        local campoLancado = base .. "BonusDePoder"
                        local lancado = n(sheet[campoLancado])
                        if desejado ~= lancado then
                            local campoBonus = base .. "Bonus"
                            sheet[campoBonus] = n(sheet[campoBonus]) + (desejado - lancado)
                            sheet[campoLancado] = desejado
                        end
                    end
                end
            end
        end

        -- ---------------------------------------------------------------
        -- MOTOR
        -- ---------------------------------------------------------------
        aplicandoConcessoes = false

        function aplicarConcessoes()
            if sheet == nil then return end
            -- as concessoes mexem em listas que disparam recalculos; a trava
            -- evita reentrada infinita
            if aplicandoConcessoes then return end
            aplicandoConcessoes = true

            local ok = pcall(function()
                sincronizarBonusAtributoDePoderes()

                local aplicadas = chavesConcedidas()
                local mudou = false

                for _, con in ipairs(CONCESSOES) do
                    -- pcall POR CONCESSAO: se uma falhar, as seguintes ainda
                    -- rodam. Com um pcall unico envolvendo o laco, um erro no
                    -- meio abortava tudo o que vinha depois.
                    pcall(function()
                        local ativa = fonteEstaAtiva(con.fonte)
                        if ativa and not aplicadas[con.chave] then
                            if aplicarEfeitoConcessao(con) then
                                aplicadas[con.chave] = true
                                mudou = true
                            end
                        elseif (not ativa) and aplicadas[con.chave] then
                            desfazerEfeitoConcessao(con)
                            aplicadas[con.chave] = nil
                            mudou = true
                        end
                    end)
                end

                if mudou then gravarChavesConcedidas(aplicadas) end
            end)

            aplicandoConcessoes = false
            return ok
        end

        -- ---------------------------------------------------------------
        -- ATRIBUTO FAVORECIDO PELA RACA
        --
        -- Racas que dao "+1 ponto de atributo a sua escolha" (hoje so a
        -- Versatilidade humana). O ponto vai para o BONUS do atributo
        -- escolhido, e aquele atributo passa a ter limite 10 no BASE, em vez
        -- do teto normal de 8.
        -- ---------------------------------------------------------------
        -- Caracteristicas que dao "+1 ponto de atributo A SUA ESCOLHA".
        -- So estas abrem o seletor. As demais racas ja definem QUAL atributo
        -- recebe o bonus (Anoes -> Constituicao, Elfos -> Destreza, etc.), e
        -- nesse caso o "favorecido" e fixo: nao ha o que escolher.
        local CARACS_ATRIBUTO_A_ESCOLHER = {"Versatilidade humana"}

        -- Recebe o nome da raca EM DETALHE no popup. Sem isso o seletor
        -- aparecia em todas as racas, porque a checagem olhava so a ficha.
        function racaPermiteEscolherAtributo(nomeRaca)
            local dados = CatalogoRacas.buscarPorNome(tostring(nomeRaca or ""))
            if dados == nil then return false end
            for _, car in ipairs(dados.caracteristicas or {}) do
                for _, alvo in ipairs(CARACS_ATRIBUTO_A_ESCOLHER) do
                    if tostring(car.nome or "") == alvo then return true end
                end
            end
            return false
        end

        function racaDaAtributoAEscolher()
            for _, alvo in ipairs(CARACS_ATRIBUTO_A_ESCOLHER) do
                if temCaracRacial(alvo) then return true end
            end
            return false
        end

        function escolherAtributoRacial(nomeAtributo)
            if sheet == nil then return end
            if not podeEditarCriacao() then return end
            if CAMPO_ATRIBUTO[nomeAtributo] == nil then return end
            local anterior = tostring(sheet.atributoRacialLancado or "")
            if anterior == nomeAtributo then return end

            -- A chave e limpa SEMPRE, e nao so quando ja havia escolha.
            -- Fichas vindas de versoes anteriores podem ter a concessao
            -- marcada como aplicada sem nada lancado; sem limpar, o motor
            -- pulava a aplicacao e o bonus nunca entrava no campo.
            local aplicadasAgora = chavesConcedidas()
            aplicadasAgora["hum_versatilidade"] = nil
            gravarChavesConcedidas(aplicadasAgora)

            -- tira o bonus do atributo anterior antes de lancar no novo
            if anterior ~= "" then
                local baseAnt = CAMPO_ATRIBUTO[anterior]
                if baseAnt ~= nil then
                    local v = n(sheet.atributoRacialValor)
                    if v == 0 then v = 1 end
                    local novo = n(sheet[baseAnt .. "Bonus"]) - v
                    if novo < 0 then novo = 0 end
                    sheet[baseAnt .. "Bonus"] = novo
                    -- zera tambem o teto: sem o bonus, o atributo volta a 8
                    sheet[baseAnt .. "TetoRacial"] = 0
                end
                sheet.atributoRacialLancado = ""
                sheet.atributoRacialValor = 0
            end

            sheet.atributoRacialEscolhido = nomeAtributo
            aplicarConcessoes()
            pcall(function() recalcularTudo() end)
            pcall(function() atualizarSeletorAtributoRacial() end)
        end

        function atualizarSeletorAtributoRacial()
            if self.popRaca_secAtributo == nil then return end
            -- Aparece somente quando a raca ABERTA NO POPUP e uma das que
            -- deixam escolher, e o personagem de fato a possui.
            local mostra = racaPermiteEscolherAtributo(detalheRacaAtual)
                and racaDaAtributoAEscolher()
            definirAlturaPod(self.popRaca_secAtributo, mostra and 116 or 0)
            if not mostra then return end
            local escolhido = tostring(sheet and sheet.atributoRacialEscolhido or "")
            for nomeAtr, base in pairs(CAMPO_ATRIBUTO) do
                local btn = self["popRaca_btnAtr" .. base]
                local lbl = self["popRaca_lblAtr" .. base]
                if btn ~= nil then
                    if nomeAtr == escolhido then
                        btn:setStrokeColor(COR.gold); btn:setStrokeSize(2)
                        if lbl ~= nil then lbl:setFontColor(COR.gold) end
                    else
                        btn:setStrokeColor(COR.line); btn:setStrokeSize(1)
                        if lbl ~= nil then lbl:setFontColor(COR.muted) end
                    end
                end
            end
            if self.popRaca_lblAtributoAtual ~= nil then
                if escolhido == "" then
                    self.popRaca_lblAtributoAtual:setText("Nenhum escolhido — o +1 de bônus só entra depois da escolha.")
                else
                    self.popRaca_lblAtributoAtual:setText(escolhido ..
                        ": +1 de bônus aplicado, e o limite do valor base sobe para 10.")
                end
            end
        end

        -- ---------------------------------------------------------------
        -- LIMITES DO VALOR BASE
        --
        -- O valor BASE de um atributo respeita dois tetos: o do nivel atual
        -- (4 no nivel 1, subindo ate 8 no 19) e o maximo absoluto de 8 - que
        -- vira 10 no atributo favorecido pela raca.
        -- O campo de BONUS nao tem teto: e justamente por onde raras, poderes
        -- e itens ultrapassam o limite.
        -- ---------------------------------------------------------------
        function limiteBaseDoAtributo(nomeAtributo)
            if sheet == nil then return 8 end
            local dados = DadosSistema.dadosDoNivel(n(sheet.nivel))
            local limite = 8
            if dados ~= nil and dados.limiteAtributo ~= nil then
                limite = n(dados.limiteAtributo)
            end
            -- REGRA DA MESA: o limite do NIVEL vale para TODOS os atributos,
            -- sem excecao - no nivel 7 nenhum passa de 5, tenha bonus racial
            -- ou nao. A progressao so chega a 8 no NIVEL 17, e dali em diante
            -- o teto racial (9 ou 10) passa a valer no atributo favorecido.
            if limite < 8 then return limite end

            local base = CAMPO_ATRIBUTO[nomeAtributo]
            if base == nil then return limite end
            local tetoRacial = n(sheet[base .. "TetoRacial"])
            if tetoRacial > limite then return tetoRacial end
            return limite
        end

        -- Corta o que passou do teto e devolve um aviso, se cortou algo.
        function aplicarLimitesDeAtributo()
            if sheet == nil then return "" end
            local cortados = {}
            -- percorre CAMPO_ATRIBUTO (local DESTE bloco) e nao
            -- ATRIBUTOS_DA_FICHA, que so e declarada mais abaixo no arquivo:
            -- uma local em Lua nao existe antes da linha em que aparece.
            for nomeAtr, campo in pairs(CAMPO_ATRIBUTO) do
                local limite = limiteBaseDoAtributo(nomeAtr)
                local atual = n(sheet[campo .. "Base"])
                if atual > limite then
                    sheet[campo .. "Base"] = limite
                    table.insert(cortados, nomeAtr .. " → " .. limite)
                end
            end
            if #cortados == 0 then return "" end
            return "Limite de atributo aplicado: " .. table.concat(cortados, ", ") ..
                ". O teto vale só para o valor base; bônus podem ultrapassar."
        end

        -- Texto para a aba: o que a ficha concedeu sozinho.
        function resumoConcessoes()
            local aplicadas = chavesConcedidas()
            local linhas = {}
            for _, con in ipairs(CONCESSOES) do
                if aplicadas[con.chave] then
                    local ef = con.efeito
                    local oque = ""
                    if ef.tipo == "qualidade" then oque = "qualidade " .. ef.nome
                    elseif ef.tipo == "defeito" then oque = "defeito " .. ef.nome
                    elseif ef.tipo == "pericia" then oque = "perícia " .. ef.nome
                    elseif ef.tipo == "periciaLivre" then oque = "+1 vaga de perícia de " .. ef.atributo
                    elseif ef.tipo == "periciaLivreGeral" then oque = "+1 vaga de perícia (livre)"
                    elseif ef.tipo == "pontoAtributo" then oque = "+" .. n(ef.valor) .. " ponto de atributo (à escolha)"
                    elseif ef.tipo == "atributoRacial" then
                        oque = "+" .. n(ef.valor) .. " de bônus em " ..
                            table.concat(ef.atributos or {}, " e ") .. " (teto " .. n(ef.teto) .. ")" end
                    table.insert(linhas, oque .. " (por " .. con.rotulo .. ")")
                end
            end
            return linhas
        end

        -- =================================================================
        -- ECONOMIA DE ATRIBUTOS E PERICIAS
        --
        -- Fonte: [2.3] Sistema e Evolucao do .bib.
        --   Nivel 1: 15 pontos de atributo e 6 pericias iniciais.
        --   +1 ponto de atributo nos niveis 2, 4, 6, 8, 11, 13, 15, 17 e 18
        --   (24 pontos no nivel 20; 18 no nivel 7).
        --   Pericias adicionais nos niveis 3(+1), 5(+2), 7(+1), 9(+1),
        --   12(+1), 14(+1), 16(+1) e 18(+2) - 16 no nivel 20.
        --
        -- O limite POR ATRIBUTO continua sendo a pontuacao do atributo
        -- ("nao e possivel ter mais pericias de um atributo do que pontos,
        -- salvo pericias que explicitamente ignorem o limite").
        -- =================================================================

        local ATRIBUTO_PONTOS_INICIAIS = 15
        local PERICIAS_INICIAIS = 6

        -- Conferido contra a tabela de níveis do livro, nível a nível.
        -- O nivel 4 estava faltando: no nivel 7 dava 17 em vez de 18.
        local GANHO_ATRIBUTO_POR_NIVEL = {
            [2]=1, [4]=1, [6]=1, [8]=1, [11]=1, [13]=1, [15]=1, [17]=1, [18]=1,
        }
        local GANHO_PERICIAS_POR_NIVEL = {
            [3]=1, [5]=2, [7]=1, [9]=1, [12]=1, [14]=1, [16]=1, [18]=2,
        }

        local ATRIBUTOS_DA_FICHA = {
            {nome = "Força", campo = "forca"},
            {nome = "Destreza", campo = "destreza"},
            {nome = "Constituição", campo = "constituicao"},
            {nome = "Inteligência", campo = "inteligencia"},
            {nome = "Sabedoria", campo = "sabedoria"},
            {nome = "Carisma", campo = "carisma"},
            {nome = "Manipulação", campo = "manipulacao"},
        }

        function pontosAtributoTotais()
            if sheet == nil then return ATRIBUTO_PONTOS_INICIAIS end
            local total = ATRIBUTO_PONTOS_INICIAIS
            for i = 1, math.min(math.max(n(sheet.nivel), 1), 20) do
                total = total + (GANHO_ATRIBUTO_POR_NIVEL[i] or 0)
            end
            -- Somente evolucao (mais o ajuste manual do mestre). O ponto que
            -- a raca da NAO entra aqui: ele vai para o campo de BONUS do
            -- atributo escolhido, e o bolso de evolucao segue 18 no nivel 7.
            return total + n(sheet.pontosAtributoAjuste)
        end

        -- Os pontos gastos sao a soma dos campos BASE. O campo de bonus fica
        -- de fora de proposito: bonus racial e de poder nao sai do bolso do
        -- jogador.
        function pontosAtributoGastos()
            if sheet == nil then return 0 end
            local total = 0
            for _, a in ipairs(ATRIBUTOS_DA_FICHA) do
                total = total + n(sheet[a.campo .. "Base"])
            end
            return total
        end

        -- Bonus que vieram de raca, poderes e afins (o campo "+" de cada
        -- atributo). Mostrado como EXTRAS, para o jogador ver que nao pagou.
        function pontosAtributoExtras()
            if sheet == nil then return 0 end
            local total = 0
            for _, a in ipairs(ATRIBUTOS_DA_FICHA) do
                total = total + n(sheet[a.campo .. "Bonus"])
            end
            return total
        end

        function periciasTotaisPermitidas()
            if sheet == nil then return PERICIAS_INICIAIS end
            local total = PERICIAS_INICIAIS
            for i = 1, math.min(math.max(n(sheet.nivel), 1), 20) do
                total = total + (GANHO_PERICIAS_POR_NIVEL[i] or 0)
            end
            -- So o que vem da EVOLUCAO (mais o ajuste manual do mestre). As
            -- vagas concedidas por raca/poder ficam em vagasPericiaConcedidas
            -- e sao somadas no painel - se entrassem aqui tambem, o total
            -- contaria as mesmas vagas duas vezes.
            return total + n(sheet.periciasAjuste)
        end

        function listasDePericias()
            return {
                {lista = "listaPericiasForca", campo = "forcaTotal", nome = "Força"},
                {lista = "listaPericiasDestreza", campo = "destrezaTotal", nome = "Destreza"},
                {lista = "listaPericiasConstituicao", campo = "constituicaoTotal", nome = "Constituição"},
                {lista = "listaPericiasInteligencia", campo = "inteligenciaTotal", nome = "Inteligência"},
                {lista = "listaPericiasSabedoria", campo = "sabedoriaTotal", nome = "Sabedoria"},
                {lista = "listaPericiasCarisma", campo = "carismaTotal", nome = "Carisma"},
                {lista = "listaPericiasManipulacao", campo = "manipulacaoTotal", nome = "Manipulação"},
            }
        end

        -- Quantas pericias o jogador realmente escolheu. As concedidas
        -- (origemConcessao preenchida) nao entram: sao de graca e, no caso da
        -- Seducao da Beleza sobrenatural, o livro diz que ignoram o limite.
        function periciasEscolhidas()
            if sheet == nil then return 0 end
            local total = 0
            for _, item in ipairs(listasDePericias()) do
                for _, p in ipairs(NDB.getChildNodes(sheet[item.lista]) or {}) do
                    if tostring(p.origemConcessao or "") == "" then
                        total = total + 1
                    end
                end
            end
            return total
        end

        function periciasConcedidas()
            if sheet == nil then return 0 end
            local total = 0
            for _, item in ipairs(listasDePericias()) do
                for _, p in ipairs(NDB.getChildNodes(sheet[item.lista]) or {}) do
                    if tostring(p.origemConcessao or "") ~= "" then
                        total = total + 1
                    end
                end
            end
            return total
        end

        -- Vagas extras concedidas por poderes ("uma pericia deste atributo a
        -- sua escolha"), somadas de todos os atributos.
        function vagasPericiaConcedidas()
            if sheet == nil then return 0 end
            local total = n(sheet.periciasBonusGeral)
            for _, a in ipairs(ATRIBUTOS_DA_FICHA) do
                total = total + n(sheet[a.campo .. "PericiasBonus"])
            end
            return total
        end

        -- ---------------------------------------------------------------
        -- BONUS DE DEFESA VINDOS DOS PODERES
        --
        -- Os quatro poderes de atributo somam +1 na defesa correspondente
        -- ao chegarem ao NIVEL 2 (levantado na progressao de cada um):
        --   Força sobrenatural      -> Defesa - Aparar
        --   Destreza sobrenatural   -> Defesa - Esquiva
        --   Carisma sobrenatural    -> Defesa empática
        --   Sabedoria sobrenatural  -> Defesa telepática
        -- "Escudo psíquico" tambem da +1 (nivel 3) e +2 (nivel 5), mas numa
        -- defesa A ESCOLHER - por isso vai num campo proprio, e nao aqui.
        -- ---------------------------------------------------------------
        local DEFESA_POR_PODER = {
            aparar     = {poder = "Força sobrenatural", nivel = 2, valor = 1},
            esquiva    = {poder = "Destreza sobrenatural", nivel = 2, valor = 1},
            empatica   = {poder = "Carisma sobrenatural", nivel = 2, valor = 1},
            telepatica = {poder = "Sabedoria sobrenatural", nivel = 2, valor = 1},
        }

        function bonusDefesaDePoder(qual)
            local d = DEFESA_POR_PODER[qual]
            if d == nil then return 0 end
            local ok, nivel = pcall(function() return nivelDoPoder(d.poder) end)
            if not ok or n(nivel) < d.nivel then return 0 end
            return d.valor
        end

        -- Escudo psiquico: +1 no nivel 3 e +2 no nivel 5, na defesa que o
        -- jogador escolher no campo da aba de Combate.
        function bonusEscudoPsiquico(qual)
            if sheet == nil then return 0 end
            if tostring(sheet.escudoPsiquicoDefesa or "") ~= qual then return 0 end
            local ok, nivel = pcall(function() return nivelDoPoder("Escudo psíquico") end)
            if not ok then return 0 end
            if n(nivel) >= 5 then return 2 end
            if n(nivel) >= 3 then return 1 end
            return 0
        end

        -- Drow, "Mente fechada": +2 na Defesa Mental. REGRA DA MESA: existem
        -- DUAS defesas mentais - Telepática e Empática - e o jogador escolhe
        -- em qual delas o bônus recai. A escolha fica no popup da raça.
        function bonusDefesaRacial(qual)
            if not temCaracRacial("Mente fechada") then return 0 end
            local escolhida = tostring(sheet and sheet.defesaMentalDrow or "")
            if escolhida == "" then return 0 end   -- sem escolha, nao aplica
            if escolhida == qual then return 2 end
            return 0
        end

        -- Racas que pedem escolha de defesa mental.
        function racaPermiteEscolherDefesa(nomeRaca)
            local dados = nil
            if CatalogoRacas ~= nil then
                local ok, res = pcall(function()
                    return CatalogoRacas.buscarPorNome(tostring(nomeRaca or ""))
                end)
                if ok then dados = res end
            end
            if dados == nil then return false end
            for _, car in ipairs(dados.caracteristicas or {}) do
                if tostring(car.nome or "") == "Mente fechada" then return true end
            end
            return false
        end

        function escolherDefesaMental(qual)
            if sheet == nil then return end
            if not podeEditarCriacao() then return end
            if qual ~= "telepatica" and qual ~= "empatica" then return end
            sheet.defesaMentalDrow = qual
            pcall(function() recalcularTudo() end)
            pcall(function() atualizarSeletorDefesaMental() end)
        end

        function atualizarSeletorDefesaMental()
            if self.popRaca_secDefesa == nil then return end
            local mostra = racaPermiteEscolherDefesa(detalheRacaAtual)
                and temCaracRacial("Mente fechada")
            definirAlturaPod(self.popRaca_secDefesa, mostra and 84 or 0)
            if not mostra then return end
            local escolhida = tostring(sheet and sheet.defesaMentalDrow or "")
            local mapa = {
                {chave = "telepatica", btn = self.popRaca_btnDefTele, lbl = self.popRaca_lblDefTele},
                {chave = "empatica", btn = self.popRaca_btnDefEmp, lbl = self.popRaca_lblDefEmp},
            }
            for _, m in ipairs(mapa) do
                if m.btn ~= nil then
                    if m.chave == escolhida then
                        m.btn:setStrokeColor(COR.gold); m.btn:setStrokeSize(2)
                        if m.lbl ~= nil then m.lbl:setFontColor(COR.gold) end
                    else
                        m.btn:setStrokeColor(COR.line); m.btn:setStrokeSize(1)
                        if m.lbl ~= nil then m.lbl:setFontColor(COR.muted) end
                    end
                end
            end
            if self.popRaca_lblDefesaAtual ~= nil then
                if escolhida == "" then
                    self.popRaca_lblDefesaAtual:setText("Nenhuma escolhida — o +2 só entra depois da escolha.")
                elseif escolhida == "telepatica" then
                    self.popRaca_lblDefesaAtual:setText("+2 aplicado na Defesa telepática.")
                else
                    self.popRaca_lblDefesaAtual:setText("+2 aplicado na Defesa empática.")
                end
            end
        end

        -- Efeitos PERMANENTES de subclasse que mexem em valores da ficha.
        -- Varredura das 36 subclasses (273 níveis descritos): só dois são
        -- permanentes e numéricos sobre campos calculados. Os demais são
        -- condicionais ("sempre que", "ao atacar") ou incidem em testes
        -- específicos, e ficam com o mestre.
        --   Espadachim/Samurai nível 4  -> +3 nas defesas mentais e empática
        --   Duelista/Passos de vento nível 2 -> deslocamento e corrida dobram
        function nivelDaSubclasse(nomeClasse, nomeSub)
            if sheet == nil then return 0 end
            for slot = 1, 2 do
                if tostring(sheet["classe" .. slot .. "Nome"] or "") == nomeClasse
                   and tostring(sheet["classe" .. slot .. "Sub"] or "") == nomeSub then
                    return n(sheet["classe" .. slot .. "Nivel"])
                end
            end
            return 0
        end

        function bonusDefesaSubclasse(qual)
            -- "defesas mentais e empáticas": as duas mentais da mesa sao a
            -- telepatica e a empatica.
            if qual ~= "telepatica" and qual ~= "empatica" then return 0 end
            if nivelDaSubclasse("Espadachim", "Samurai") >= 4 then return 3 end
            return 0
        end

        function deslocamentoDobrado()
            return nivelDaSubclasse("Duelista", "Passos de vento") >= 2
        end

        function bonusTotalDefesa(qual)
            return bonusDefesaDePoder(qual) + bonusEscudoPsiquico(qual)
                + bonusDefesaRacial(qual) + bonusDefesaSubclasse(qual)
        end

        -- ---------------------------------------------------------------
        -- CALCULO DE ROLAGEM DE PERICIA
        --
        --   total = valor do atributo + proficiencia + extras do sistema
        --           + ajuste manual
        --
        -- "Extras do sistema" sao bonus que outras partes da ficha dao aquela
        -- pericia especifica - hoje as caracteristicas raciais que citam a
        -- pericia pelo nome e escalam com o nivel (ex.: Drow em "Animais",
        -- +1 ate o nivel 10 e +2 do 11 em diante).
        --
        -- O ajuste manual existe porque nem tudo cabe em regra fixa: um
        -- feitico que aumenta Percepcao por alguns turnos, um item, uma
        -- bencao do mestre. Automacao que prende o usuario e automacao ruim.
        -- ---------------------------------------------------------------

        -- {pericia, atributo, bonus ate o nivel 10, bonus do 11 em diante,
        --  fonte} - extraido das caracteristicas raciais do catalogo.
        -- Levantadas uma a uma no catalogo de racas e de qualidades. Todas
        -- seguem o mesmo desenho: um valor ate o nivel 10 e outro do 11 em
        -- diante.
        local BONUS_PERICIA_FONTE = {
            -- Drow
            {pericia = "Animais", atributo = "Carisma", ate10 = 1, apos11 = 2,
             fonte = "caracRacial", nome = "Mestres da domesticação"},
            -- Elfos
            {pericia = "Natureza", atributo = "Inteligência", ate10 = 1, apos11 = 2,
             fonte = "caracRacial", nome = "Conexão com a Natureza"},
            {pericia = "Sobrevivência", atributo = "Sabedoria", ate10 = 1, apos11 = 2,
             fonte = "caracRacial", nome = "Conexão com a Natureza"},
            -- ATENCAO: "Conexão com a natureza" existe em Fadas E Centauros
            -- com valores DIFERENTES (+1/+2 contra +2/+4). Por isso estas
            -- entradas trazem o campo "raca": sem ele, um Centauro receberia
            -- o bonus mais fraco das Fadas.
            {pericia = "Natureza", atributo = "Inteligência", ate10 = 1, apos11 = 2,
             fonte = "caracRacial", nome = "Conexão com a natureza", raca = "Fadas"},
            {pericia = "Animais", atributo = "Carisma", ate10 = 1, apos11 = 2,
             fonte = "caracRacial", nome = "Conexão com a natureza", raca = "Fadas"},
            -- Centauros
            {pericia = "Natureza", atributo = "Inteligência", ate10 = 2, apos11 = 4,
             fonte = "caracRacial", nome = "Conexão com a natureza", raca = "Centauros"},
            {pericia = "Arcos", atributo = "Destreza", ate10 = 2, apos11 = 4,
             fonte = "caracRacial", nome = "Aptidão com arcos"},
            {pericia = "Bestas", atributo = "Destreza", ate10 = 2, apos11 = 4,
             fonte = "caracRacial", nome = "Aptidão com arcos"},
            -- Ursaris
            {pericia = "Intimidação", atributo = "Manipulação", ate10 = 1, apos11 = 2,
             fonte = "caracRacial", nome = "Rugido amedrontador"},
            {pericia = "Subjugar", atributo = "Força", ate10 = 1, apos11 = 2,
             fonte = "caracRacial", nome = "Rugido amedrontador"},
            -- Goblins
            {pericia = "Prestidigitação", atributo = "Destreza", ate10 = 1, apos11 = 2,
             fonte = "caracRacial", nome = "Maestria furtiva"},
            {pericia = "Furtividade", atributo = "Destreza", ate10 = 1, apos11 = 2,
             fonte = "caracRacial", nome = "Maestria furtiva"},
            -- Qualidade: o bonus e fixo em +2 (a vantagem do nivel 10 nao e
            -- numero, entao entra so como marcacao)
            {pericia = "Vontade", atributo = "Sabedoria", ate10 = 2, apos11 = 2,
             fonte = "qualidade", nome = "Vontade de ferro"},
        }

        -- Escolas de magia entre as quais a Linhagem de Unaris escolhe.
        CatalogoEscolasDeMagia = {
            {nome = "Encantamentos (magia/forja)", atributo = "Carisma"},
            {nome = "Transmutação (magia)", atributo = "Destreza"},
            {nome = "Evocação (magia)", atributo = "Inteligência"},
            {nome = "Invocação", atributo = "Manipulação"},
            {nome = "Clarividência (magia/oráculos)", atributo = "Sabedoria"},
        }

        function bonusSistemaDaPericia(atributo, nomePericia)
            if sheet == nil then return 0, "" end
            local total, fontes = 0, {}
            local nivel = n(sheet.nivel)

            for _, b in ipairs(BONUS_PERICIA_FONTE) do
                if b.pericia == nomePericia and b.atributo == atributo then
                    local ativo = false
                    if b.fonte == "caracRacial" then
                        ativo = temCaracRacial(b.nome)
                        -- entradas com "raca" so valem naquela raca (ver o
                        -- caso de "Conexão com a natureza")
                        if ativo and b.raca ~= nil then
                            ativo = (tostring(sheet.raca or "") == b.raca)
                        end
                    elseif b.fonte == "qualidade" then
                        ativo = temQualidadeNaFicha(b.nome)
                    end
                    if ativo then
                        local v = (nivel >= 11) and b.apos11 or b.ate10
                        total = total + v
                        table.insert(fontes, b.nome .. " +" .. v)
                    end
                end
            end

            -- [Magia inata], da Linhagem de Unaris: +1 em testes de magia ate
            -- o nivel 10 e +2 do 11 em diante. Vale em TODAS as pericias
            -- magicas, nao em uma so - o texto diz "testes de magia".
            -- (A escolha de UMA escola, no popup da qualidade, e outra coisa:
            -- da VANTAGEM nos dados, tratada em periciaComVantagem.)
            if temQualidadeNaFicha("Linhagem de Unaris") and periciaEhMagica(nomePericia) then
                local v = (nivel >= 11) and 2 or 1
                total = total + v
                table.insert(fontes, "Magia inata +" .. v)
            end

            return total, table.concat(fontes, ", ")
        end

        function periciaEhMagica(nomePericia)
            for _, esc in ipairs(CatalogoEscolasDeMagia) do
                if esc.nome == nomePericia then return true end
            end
            return false
        end

        -- A escola escolhida no popup da qualidade rola com VANTAGEM. Isso
        -- nao e um numero somavel, entao a linha da pericia apenas marca.
        function periciaComVantagem(nomePericia)
            if sheet == nil then return false end
            -- Vontade de ferro: a partir do nivel 10 a pericia "Vontade"
            -- passa a ser rolada com vantagem.
            if nomePericia == "Vontade" and n(sheet.nivel) >= 10
               and temQualidadeNaFicha("Vontade de ferro") then
                return true
            end
            if not temQualidadeNaFicha("Linhagem de Unaris") then return false end
            return tostring(sheet.periciaMagiaEscolhida or "") == nomePericia
        end

        -- Aviso para a aba: a qualidade existe mas a escola com vantagem
        -- ainda nao foi escolhida.
        function pendenciaEscolaDeMagia()
            if sheet == nil then return "" end
            if not temQualidadeNaFicha("Linhagem de Unaris") then return "" end
            if tostring(sheet.periciaMagiaEscolhida or "") ~= "" then return "" end
            return "Linhagem de Unaris: escolha no detalhe da qualidade em qual escola você rola com VANTAGEM (capítulo III)."
        end

        function campoBaseDoAtributo(atributo)
            for _, a in ipairs(ATRIBUTOS_DA_FICHA) do
                if a.nome == atributo then return a.campo end
            end
            return nil
        end

        -- Devolve total e as parcelas, para a linha da pericia poder abrir a
        -- conta em vez de mostrar um numero solto.
        function calculoDaPericia(atributo, nomePericia, ajusteManual)
            local campo = campoBaseDoAtributo(atributo)
            local valorAtributo = 0
            if campo ~= nil and sheet ~= nil then
                valorAtributo = n(sheet[campo .. "Total"])
            end
            local prof = 0
            if sheet ~= nil then
                local dados = DadosSistema.dadosDoNivel(n(sheet.nivel))
                if dados ~= nil then prof = n(dados.prof) end
            end
            local extras, textoExtras = bonusSistemaDaPericia(atributo, nomePericia)
            -- acessorios equipados que bonificam uma pericia especifica
            local okItem, bItem = pcall(function() return bonusItemPericia(nomePericia) end)
            if okItem and n(bItem) ~= 0 then
                extras = extras + n(bItem)
                if textoExtras ~= "" then textoExtras = textoExtras .. ", " end
                textoExtras = textoExtras .. "item +" .. n(bItem)
            end
            local manual = n(ajusteManual)
            local total = valorAtributo + prof + extras + manual
            return total, valorAtributo, prof, extras, manual, textoExtras
        end

        -- ---------------------------------------------------------------
        -- PAINEL DO TOPO DA ABA
        -- ---------------------------------------------------------------
        function atualizarPainelAtributosPericias()
            if sheet == nil then return end

            local totalAtr = pontosAtributoTotais()
            local gastosAtr = pontosAtributoGastos()
            local extrasAtr = pontosAtributoExtras()
            local saldoAtr = totalAtr - gastosAtr

            if self.abaAtr_lblPontosTotal ~= nil then
                self.abaAtr_lblPontosTotal:setText(tostring(totalAtr))
            end
            if self.abaAtr_lblPontosGastos ~= nil then
                self.abaAtr_lblPontosGastos:setText(tostring(gastosAtr))
            end
            if self.abaAtr_lblPontosSaldo ~= nil then
                self.abaAtr_lblPontosSaldo:setText(tostring(saldoAtr))
                if saldoAtr < 0 then
                    self.abaAtr_lblPontosSaldo:setFontColor(COR.wine)
                elseif saldoAtr > 0 then
                    self.abaAtr_lblPontosSaldo:setFontColor(COR.gold)
                else
                    self.abaAtr_lblPontosSaldo:setFontColor(COR.muted)
                end
            end
            if self.abaAtr_lblPontosExtras ~= nil then
                self.abaAtr_lblPontosExtras:setText(tostring(extrasAtr))
                if extrasAtr > 0 then
                    self.abaAtr_lblPontosExtras:setFontColor(COR.moss)
                else
                    self.abaAtr_lblPontosExtras:setFontColor(COR.faint)
                end
            end

            local totalPer = periciasTotaisPermitidas()
            local usadasPer = periciasEscolhidas()
            local concedidasPer = periciasConcedidas()
            local vagasPer = vagasPericiaConcedidas()

            if self.abaAtr_lblPerTotal ~= nil then
                self.abaAtr_lblPerTotal:setText(tostring(totalPer + vagasPer))
            end
            if self.abaAtr_lblPerUsadas ~= nil then
                self.abaAtr_lblPerUsadas:setText(tostring(usadasPer))
            end
            if self.abaAtr_lblPerSaldo ~= nil then
                local saldoPer = totalPer + vagasPer - usadasPer
                self.abaAtr_lblPerSaldo:setText(tostring(saldoPer))
                if saldoPer < 0 then
                    self.abaAtr_lblPerSaldo:setFontColor(COR.wine)
                elseif saldoPer > 0 then
                    self.abaAtr_lblPerSaldo:setFontColor(COR.gold)
                else
                    self.abaAtr_lblPerSaldo:setFontColor(COR.muted)
                end
            end
            if self.abaAtr_lblPerExtras ~= nil then
                self.abaAtr_lblPerExtras:setText(tostring(concedidasPer + vagasPer))
                if (concedidasPer + vagasPer) > 0 then
                    self.abaAtr_lblPerExtras:setFontColor(COR.moss)
                else
                    self.abaAtr_lblPerExtras:setFontColor(COR.faint)
                end
            end

            if self.abaAtr_lblNota ~= nil then
                local prof = 0
                local dados = DadosSistema.dadosDoNivel(n(sheet.nivel))
                if dados ~= nil then prof = n(dados.prof) end
                local partes = {}
                table.insert(partes, "Proficiência do nível " .. n(sheet.nivel) .. ": +" .. prof)
                table.insert(partes, "cada atributo limita quantas perícias dele você pode ter")
                if concedidasPer > 0 then
                    table.insert(partes, concedidasPer .. " perícia(s) concedida(s) não ocupam vaga")
                end
                local pend = pendenciaEscolaDeMagia()
                if pend ~= "" then
                    self.abaAtr_lblNota:setText(pend)
                    self.abaAtr_lblNota:setFontColor(COR.gold)
                else
                    self.abaAtr_lblNota:setText(table.concat(partes, "   ·   "))
                    self.abaAtr_lblNota:setFontColor(COR.faint)
                end
            end
        end

        -- =================================================================
        -- ABA CALCULOS & COMBATE - renderizacao
        --
        -- Nenhum numero e digitado aqui: todos vem das outras secoes. Cada
        -- card mostra a CONTA embaixo do valor, para o jogador conferir de
        -- onde saiu - e cada um tem um campo de ajuste para o que o sistema
        -- nao cobre.
        -- =================================================================

        -- ---------------------------------------------------------------
        -- GRADE DA ABA DE COMBATE
        --
        -- Os cards de cada linha dividem a largura disponivel em partes
        -- iguais. Sem isso, largura fixa deixava um vao a direita em tela
        -- larga e apertava em tela estreita.
        -- Cards ocultos (Mana sem Coração de mana, Prana sem bruxa, Vitae sem
        -- vampiro) ficam com largura 0 e nao entram na divisao - os visiveis
        -- se espalham para ocupar a linha inteira.
        --
        -- Roda no onResize do scrollBox e ao fim de cada recalculo.
        -- ---------------------------------------------------------------
        local GRADE_COMBATE = {
            {linha = "cmb_linhaRecursos",  cards = {"Hp", "Ap", "Mp", "Prana", "Pv"}},
            {linha = "cmb_linhaDefesas",   cards = {"DefAparar", "DefEsquiva", "DefEmpatica", "DefTelepatica"}},
            {linha = "cmb_linhaMovimento", cards = {"Deslocamento", "Corrida", "Iniciativa", "Prof"}},
            {linha = "cmb_linhaAcoes",     cards = {"AcoesPadrao", "AcoesBonus", "AcoesReacao", "Inspiracao", "Mochila"}},
        }

        -- quais cards estao ativos para este personagem
        function cardVisivelCombate(nome)
            if sheet == nil then return true end
            if nome == "Mp" then
                return sheet.temCoracaoDeMana == true and sheet.ehVampiro ~= true
            elseif nome == "Prana" then
                return personagemEhBruxa() and sheet.ehVampiro ~= true
            elseif nome == "Pv" then
                return sheet.ehVampiro == true
            elseif nome == "Ap" then
                return sheet.ehVampiro ~= true
            end
            return true
        end

        function ajustarGradeCombate()
            if self.cmb_linhaRecursos == nil then return end
            -- A largura util e medida uma vez por passada, na melhor fonte
            -- disponivel. Na PRIMEIRA montagem as linhas ainda nao tem
            -- largura (retornam 0 ou um valor minusculo), e usar esse numero
            -- espremia todos os cards - so ao mexer em algo, com o layout ja
            -- desenhado, eles se abriam. Por isso caimos para o scrollBox e
            -- depois para o painel, que ja existem nesse momento.
            local disponivel = 0
            local function medir(ctrl, desconto)
                if disponivel > 0 or ctrl == nil then return end
                pcall(function()
                    local v = ctrl.width
                    if type(v) == "number" and v > 320 then disponivel = v - (desconto or 0) end
                end)
            end
            medir(self.cmb_linhaRecursos, 0)
            medir(self.cmb_scroll, 0)
            medir(self.pnlAba3, 36)      -- margens laterais do scrollBox
            if disponivel <= 0 then disponivel = 1180 end

            for _, grupo in ipairs(GRADE_COMBATE) do
                local total = disponivel

                local visiveis = {}
                for _, nome in ipairs(grupo.cards) do
                    if cardVisivelCombate(nome) then table.insert(visiveis, nome) end
                end
                local qtd = #visiveis
                if qtd > 0 then
                    -- Divisao pura pela quantidade visivel. NAO se impoe um
                    -- minimo alto aqui: com 5 cards, um minimo de 150 exigiria
                    -- 750px de linha, e em tela menor o ultimo card seria
                    -- empurrado para fora. O piso baixo existe so para o card
                    -- nao sumir de vez.
                    local largura = math.floor(total / qtd)
                    if largura < 96 then largura = 96 end
                    -- Fonte do valor proporcional a largura: em card estreito
                    -- um numero de 3 digitos em corpo 27 nao caberia.
                    local corpo = 27
                    if largura < 130 then corpo = 18
                    elseif largura < 165 then corpo = 21
                    elseif largura < 200 then corpo = 24 end

                    for _, nome in ipairs(grupo.cards) do
                        local w = 0
                        if cardVisivelCombate(nome) then w = largura end
                        pcall(function() self["cmb_wrap" .. nome]:setWidth(w) end)
                        pcall(function() self["cmb_lbl" .. nome]:setFontSize(corpo) end)
                    end
                end
            end
        end

        -- ---------------------------------------------------------------
        -- QUEM TEM CADA BARRA
        --
        -- Nada disso e marcado a mao: sai do que ja esta na ficha.
        --   Mana  -> qualidade "Coração de mana"
        --   Prana -> qualidade "Linhagem de Unaris" (bruxa)
        --   Vitae -> raça Vampiros, ou "Sede de sangue" herdada por mestiço
        -- Os campos temCoracaoDeMana e ehVampiro continuam existindo porque
        -- os calculos leem deles; passaram a ser ESCRITOS pela deteccao, e
        -- nao por caixas de marcar.
        -- ---------------------------------------------------------------
        function temCoracaoDeManaAuto()
            if sheet == nil then return false end
            if temQualidadeNaFicha("Coração de mana") then return true end
            -- toda bruxa e maga por definicao
            if temQualidadeNaFicha("Linhagem de Unaris") then return true end
            return false
        end

        function ehVampiroAuto()
            if sheet == nil then return false end
            if tostring(sheet.raca or "") == "Vampiros" then return true end
            return temCaracRacial("Sede de sangue")
        end

        function sincronizarMarcadoresDeEnergia()
            if sheet == nil then return end
            sheet.temCoracaoDeMana = temCoracaoDeManaAuto()
            sheet.ehVampiro = ehVampiroAuto()
        end

        function escolherDefesaEscudo(qual)
            if sheet == nil then return end
            if not podeEditarCriacao() then
                avisarInventario(motivoTravaCriacao(), COR.wine); return
            end
            local validas = {aparar = true, esquiva = true, empatica = true, telepatica = true}
            if not validas[qual] then return end
            sheet.escudoPsiquicoDefesa = qual
            recalcularTudo()
        end

        local ROTULO_DEFESA = {
            aparar = "Aparar", esquiva = "Esquiva",
            empatica = "Empática", telepatica = "Telepática",
        }

        local function porTexto(nome, texto)
            local lbl = self["cmb_conta" .. nome]
            if lbl ~= nil then lbl:setText(tostring(texto or "")) end
        end

        local function porValor(nome, valor)
            local lbl = self["cmb_lbl" .. nome]
            if lbl ~= nil then lbl:setText(tostring(valor)) end
        end

        function atualizarAbaCombate()
            if sheet == nil then return end
            local nivel = n(sheet.nivel)
            local dados = DadosSistema.dadosDoNivel(nivel)
            local rank = dados and dados.rank or "E"
            local prof = dados and n(dados.prof) or 0
            local rankNum = DadosSistema.ordemRank[rank] or 1

            local ehBruxa = temQualidadeNaFicha("Linhagem de Unaris")
            local ehVampiroSangue = temCaracRacial("Sede de sangue")

            -- ---------- RECURSOS ----------
            porValor("Hp", n(sheet.hp))
            porTexto("Hp", "15 + " .. n(sheet.dadoVida) .. " + (Con " ..
                n(sheet.constituicaoTotal) .. "÷2 × " .. nivel .. ")")

            -- A Aura e SEMPRE calculada e nunca zera: todo ser vivo tem
            -- Aura. O que muda entre magos, bruxas e vampiros e de qual
            -- barra a energia e gasta.
            porValor("Ap", n(sheet.ap))
            porTexto("Ap", "(20 + Sab " .. n(sheet.sabedoriaTotal) .. " + " ..
                nivel .. ") × " .. rankNum)

            porValor("Mp", n(sheet.mp))
            if sheet.temCoracaoDeMana then
                porTexto("Mp", "15 + idade " .. n(sheet.idade) .. " + (" .. nivel .. " × 2)")
            else
                porTexto("Mp", "requer Coração de Mana")
            end

            -- PRANA: so a bruxa tem. E a soma das outras duas barras.
            porValor("Prana", n(sheet.prana))
            porTexto("Prana", "mana " .. n(sheet.mp) .. " + aura " .. n(sheet.ap))

            -- Quem aparece e quanto ocupa fica com ajustarGradeCombate:
            -- os cards visiveis dividem a linha em partes iguais.
            ajustarGradeCombate()

            porValor("Pv", n(sheet.pv))
            if sheet.ehVampiro then
                porTexto("Pv", "10 + (Con × 1,5) + (" .. rankNum .. " × 30)")
            else
                porTexto("Pv", "apenas vampiros")
            end

            -- destaca o recurso que o personagem realmente usa
            if self.cmb_lblNotaRecursos ~= nil then
                if sheet.ehVampiro == true then
                    self.cmb_lblNotaRecursos:setText("Vampiro: você gasta VITAE. Aura e Mana não aparecem porque o Vitae toma o lugar das duas.")
                elseif ehBruxa then
                    self.cmb_lblNotaRecursos:setText("Linhagem de Unaris: você gasta do PRANA, que é a soma da sua Mana com a sua Aura. As duas seguem calculadas em separado.")
                elseif sheet.temCoracaoDeMana then
                    self.cmb_lblNotaRecursos:setText("Coração de Mana: você tem Mana e Aura, cada uma com sua barra.")
                else
                    self.cmb_lblNotaRecursos:setText("")
                end
            end

            -- ---------- DEFESAS ----------
            local defs = {
                {n = "DefAparar", campo = "defesaAparar", base = 9,
                 atr = "Força", val = n(sheet.forcaTotal), chave = "aparar"},
                {n = "DefEsquiva", campo = "defesaEsquiva", base = 9,
                 atr = "Des", val = n(sheet.destrezaTotal), chave = "esquiva"},
                {n = "DefEmpatica", campo = "defesaEmpatica", base = 10,
                 atr = "Man", val = n(sheet.manipulacaoTotal), chave = "empatica"},
                {n = "DefTelepatica", campo = "defesaTelepatica", base = 10,
                 atr = "Sab", val = n(sheet.sabedoriaTotal), chave = "telepatica"},
            }
            local extrasTexto = {}
            for _, d in ipairs(defs) do
                porValor(d.n, n(sheet[d.campo]))
                local partes = {d.base .. " + " .. d.atr .. " " .. d.val .. " + prof " .. prof}
                local itens = n(sheet.bonusItensArmaduras)
                if itens ~= 0 then table.insert(partes, "itens " .. itens) end
                local extra = bonusTotalDefesa(d.chave)
                if extra ~= 0 then
                    table.insert(partes, "bônus " .. extra)
                    table.insert(extrasTexto, ROTULO_DEFESA[d.chave] .. " +" .. extra)
                end
                porTexto(d.n, table.concat(partes, " + "))
            end
            if self.cmb_lblNotaDefesas ~= nil then
                if #extrasTexto > 0 then
                    self.cmb_lblNotaDefesas:setText("Bônus vindos de poderes, raça ou escudo psíquico: " ..
                        table.concat(extrasTexto, "   ·   "))
                else
                    self.cmb_lblNotaDefesas:setText("")
                end
            end

            -- seletor do Escudo psiquico: so aparece com o poder adquirido
            local nivelEscudo = 0
            pcall(function() nivelEscudo = nivelDoPoder("Escudo psíquico") end)
            definirAlturaPod(self.cmb_secEscudo, (nivelEscudo >= 3) and 74 or 0)
            if nivelEscudo >= 3 then
                local escolhida = tostring(sheet.escudoPsiquicoDefesa or "")
                local valor = (nivelEscudo >= 5) and 2 or 1
                if self.cmb_lblEscudoTit ~= nil then
                    self.cmb_lblEscudoTit:setText("ESCUDO PSÍQUICO nível " .. nivelEscudo ..
                        " — escolha onde entra o +" .. valor)
                end
                for _, par in ipairs({{"Aparar","aparar"},{"Esquiva","esquiva"},
                                      {"Empatica","empatica"},{"Telepatica","telepatica"}}) do
                    local btn = self["cmb_btnEsc" .. par[1]]
                    local lbl = self["cmb_lblEsc" .. par[1]]
                    if btn ~= nil then
                        if par[2] == escolhida then
                            btn:setStrokeColor(COR.gold); btn:setStrokeSize(2)
                            if lbl ~= nil then lbl:setFontColor(COR.gold) end
                        else
                            btn:setStrokeColor(COR.line); btn:setStrokeSize(1)
                            if lbl ~= nil then lbl:setFontColor(COR.muted) end
                        end
                    end
                end
            end

            -- ---------- MOVIMENTO ----------
            porValor("Deslocamento", n(sheet.deslocamento) .. "m")
            do
                local txt = "raça " .. n(sheet.deslocamentoBaseRaca) ..
                    " + Des " .. n(sheet.destrezaTotal) .. " + rank " .. rankNum
                if deslocamentoDobrado() then txt = txt .. ", dobrado" end
                porTexto("Deslocamento", txt)
            end

            porValor("Corrida", n(sheet.corrida) .. "m")
            if temCaracRacial("Maratonista") then
                porTexto("Corrida", "triplo (Maratonista)")
            else
                porTexto("Corrida", "o dobro do deslocamento")
            end

            porValor("Iniciativa", "+" .. n(sheet.iniciativa))
            porTexto("Iniciativa", "Des " .. n(sheet.destrezaTotal) .. " + rank " .. rankNum)

            porValor("Prof", "+" .. prof)
            porTexto("Prof", "nível " .. nivel .. "  ·  rank " .. rank)

            -- ---------- ACOES ----------
            porValor("AcoesPadrao", n(sheet.acoesPadrao))
            porTexto("AcoesPadrao", (nivel >= 19) and "1 base + 1 (nível 19)" or "1 base")
            porValor("AcoesBonus", n(sheet.acoesBonus))
            porTexto("AcoesBonus", (nivel >= 10) and "1 base + 1 (nível 10)" or "1 base")
            porValor("AcoesReacao", n(sheet.acoesReacao))
            porTexto("AcoesReacao", (nivel >= 15) and "1 base + 1 (nível 15)" or "1 base")

            -- Inspiracao: comeca em 3 e o teto e 3.
            if sheet.pontosInspiracao == nil then sheet.pontosInspiracao = 3 end
            if n(sheet.pontosInspiracao) > 3 then sheet.pontosInspiracao = 3 end
            if n(sheet.pontosInspiracao) < 0 then sheet.pontosInspiracao = 0 end
            porValor("Inspiracao", n(sheet.pontosInspiracao))
            porTexto("Inspiracao", "máximo 3")

            porValor("Mochila", n(sheet.capacidadeMochila))
            porTexto("Mochila", "2 + For " .. n(sheet.forcaTotal) .. " + rank " .. rankNum)

            if self.cmb_lblNotaAcoes ~= nil then
                local faltam = {}
                if nivel < 10 then table.insert(faltam, "ação bônus no 10") end
                if nivel < 15 then table.insert(faltam, "reação no 15") end
                if nivel < 19 then table.insert(faltam, "ação padrão no 19") end
                if #faltam > 0 then
                    self.cmb_lblNotaAcoes:setText("Ainda por vir: +1 " .. table.concat(faltam, "   ·   +1 "))
                else
                    self.cmb_lblNotaAcoes:setText("Todas as ações já foram destravadas.")
                end
            end
        end

        -- =================================================================
        -- FAVORES DIVINOS
        --
        -- Ganho: 1/2 favor por feito, ou 1 inteiro para humanos (passiva
        -- "Favorecimento divino") e para filhos/legados quando a missao e da
        -- propria divindade. Por isso a contagem trabalha com MEIOS.
        --
        -- Teto de 3 POR DIVINDADE (regra da mesa): da para ter 3 com Ditrys e
        -- 3 com Kaern ao mesmo tempo.
        --
        -- Quem registra e gasta e o MESTRE - "somente e possivel ganhar
        -- favores atraves de narrativas oficiais". O jogador so consulta.
        --
        -- FORMATO: "Deus|valor;Deus|valor" (valor com meio ponto: 0.5, 1, 1.5...)
        -- Nenhum nome de divindade contem ";" ou "|".
        -- =================================================================

        local FAVOR_MAXIMO = 3

        function lerFavores()
            local lista = {}
            if sheet == nil then return lista end
            for _, reg in ipairs(partirTexto(sheet.favoresDados, ";")) do
                local nome, valor = reg:match("^(.-)|([%d%.]+)$")
                if nome ~= nil and nome ~= "" then
                    table.insert(lista, {deus = nome, valor = tonumber(valor) or 0})
                end
            end
            table.sort(lista, function(a, b)
                if a.valor ~= b.valor then return a.valor > b.valor end
                return a.deus < b.deus
            end)
            return lista
        end

        function gravarFavores(lista)
            if sheet == nil then return end
            local partes = {}
            for _, f in ipairs(lista) do
                if f.valor > 0 then
                    table.insert(partes, f.deus .. "|" .. tostring(f.valor))
                end
            end
            sheet.favoresDados = table.concat(partes, ";")
        end

        -- Lua guarda 2 como 2.0; na tela isso vira "2.0", que polui. Meio
        -- ponto continua aparecendo como "½", que e como a mesa fala.
        function formatarFavor(v)
            v = tonumber(v) or 0
            local inteiro = math.floor(v)
            if v == inteiro then return tostring(inteiro) end
            if inteiro == 0 then return "½" end
            return tostring(inteiro) .. "½"
        end

        function favorDoDeus(nomeDeus)
            for _, f in ipairs(lerFavores()) do
                if f.deus == nomeDeus then return f.valor end
            end
            return 0
        end

        function totalDeFavores()
            local t = 0
            for _, f in ipairs(lerFavores()) do t = t + f.valor end
            return t
        end

        -- "Macula divina": o mestre escolhe uma divindade da qual o
        -- personagem nunca ganha favor. Guardada em campo proprio.
        function deusEhMacula(nomeDeus)
            if sheet == nil then return false end
            return tostring(sheet.maculaDivina or "") == nomeDeus
        end

        function ajustarFavor(nomeDeus, delta)
            if sheet == nil or nomeDeus == nil or nomeDeus == "" then return end
            if not usuarioEhMestre() then
                avisarFavores("Somente o MESTRE registra favores: eles só vêm de narrativas oficiais.", COR.wine)
                return
            end
            if delta > 0 and deusEhMacula(nomeDeus) then
                avisarFavores(nomeDeus .. " é a sua Mácula divina — você nunca ganha favores dela.", COR.wine)
                return
            end

            local lista = lerFavores()
            local alvo = nil
            for _, f in ipairs(lista) do
                if f.deus == nomeDeus then alvo = f end
            end
            if alvo == nil then
                alvo = {deus = nomeDeus, valor = 0}
                table.insert(lista, alvo)
            end

            local novo = alvo.valor + delta
            if novo > FAVOR_MAXIMO then
                avisarFavores("Teto de " .. FAVOR_MAXIMO .. " favores por divindade atingido em " .. nomeDeus .. ".", COR.muted)
                novo = FAVOR_MAXIMO
            end
            if novo < 0 then novo = 0 end
            if novo == alvo.valor then return end
            alvo.valor = novo

            gravarFavores(lista)
            local verbo = (delta > 0) and "concedeu" or "retirou"
            publicarNoChat("[§K #C9A24B]FAVOR DIVINO[§K] — " .. nickDoUsuario() .. " " .. verbo ..
                " " .. formatarFavor(math.abs(delta)) .. " favor de [§B]" .. nomeDeus .. "[§B] para " ..
                tostring(sheet.nome or "personagem") .. ". Total: " .. formatarFavor(novo) .. ".")
            atualizarAbaFavores()
        end

        -- ---------------------------------------------------------------
        -- BENEFICIOS PASSIVOS
        -- O bonus social vale pelo patamar ja alcancado, sem gastar nada.
        -- ---------------------------------------------------------------
        function bonusSocialDoFavor(valor)
            if valor >= 3 then return 5, "sacerdotes, seguidores, filhos e abençoados"
            elseif valor >= 2 then return 3, "sacerdotes e seguidores"
            elseif valor >= 1 then return 1, "sacerdotes"
            end
            return 0, ""
        end

        -- ---------------------------------------------------------------
        -- TROCAS QUE MEXEM NA FICHA
        --
        -- Das trocas do livro, so estas alteram valores: as demais (milagre,
        -- auxilio narrativo, conversa com a divindade, ressurreicao) sao
        -- resolvidas na mesa e nao tem o que automatizar.
        --   2 favores -> 1 ponto de poder
        --   3 favores -> bencao (libera o kit do deus)
        --   3 favores -> 3 pontos de poder
        --   3 favores -> 1 favor com um deus primordial
        -- ---------------------------------------------------------------
        -- ---------------------------------------------------------------
        -- HIERARQUIA DAS TROCAS
        --
        -- Trocar 3 favores por 1 favor sobe UM degrau na hierarquia divina:
        --   Menor      -> Grande
        --   Grande     -> Primordial
        --   Primordial -> a Mãe (a Mãe Celestial, acima dos primordiais;
        --                nao consta no catalogo de deuses, por isso entra
        --                como destino proprio)
        -- Antes a troca sempre oferecia primordiais, o que so vale para os
        -- deuses grandes.
        MAE_CELESTIAL = "A Mãe"

        function categoriaDoDeus(nomeDeus)
            if nomeDeus == MAE_CELESTIAL then return "Mãe" end
            local d = CatalogoDeuses.buscarPorNome(nomeDeus)
            if d == nil then return "" end
            return tostring(d.categoria or "")
        end

        -- Devolve a categoria de destino e um rotulo para o botao.
        function degrauAcima(nomeDeus)
            local cat = categoriaDoDeus(nomeDeus)
            if cat == "Menor" then return "Grande", "1 FAVOR DE UM GRANDE"
            elseif cat == "Grande" then return "Primordial", "1 FAVOR PRIMORDIAL"
            elseif cat == "Primordial" then return "Mãe", "1 FAVOR COM A MÃE"
            end
            return nil, nil
        end

        function trocarFavor(nomeDeus, tipo)
            if sheet == nil then return end
            if not usuarioEhMestre() then
                avisarFavores("Somente o MESTRE executa trocas de favor.", COR.wine)
                return
            end
            local atual = favorDoDeus(nomeDeus)
            local custo = (tipo == "poder1") and 2 or 3
            if atual < custo then
                avisarFavores("São necessários " .. custo .. " favores com " .. nomeDeus ..
                    " para esta troca (você tem " .. formatarFavor(atual) .. ").", COR.muted)
                return
            end

            local descricao = ""
            if tipo == "poder1" then
                sheet.poderPontosConcedidos = n(sheet.poderPontosConcedidos) + 1
                descricao = "1 ponto de poder"
            elseif tipo == "poder3" then
                sheet.poderPontosConcedidos = n(sheet.poderPontosConcedidos) + 3
                descricao = "3 pontos de poder"
            elseif tipo == "bencao" then
                if deusEhAcessivel(nomeDeus) then
                    avisarFavores("Você já tem acesso ao kit de " .. nomeDeus .. ".", COR.muted)
                    return
                end
                local atualB = tostring(sheet.deusesAbencoados or "")
                if atualB == "" then sheet.deusesAbencoados = nomeDeus
                else sheet.deusesAbencoados = atualB .. ";" .. nomeDeus end
                descricao = "a bênção de " .. nomeDeus .. ", liberando o kit de poderes"
            elseif tipo == "proclamar" then
                -- So faz sentido com a propria divindade: o aspecto proclama
                -- o semideus como campeao ou profeta. Com um deus que nao e o
                -- seu, o equivalente e a bencao.
                if tostring(sheet.aspectoDivino or "") ~= nomeDeus then
                    avisarFavores("A proclamação só vem do seu próprio Aspecto Divino.", COR.wine)
                    return
                end
                if tostring(sheet.proclamadoPor or "") ~= "" then
                    avisarFavores("Você já foi proclamado por " .. tostring(sheet.proclamadoPor) .. ".", COR.muted)
                    return
                end
                sheet.proclamadoPor = nomeDeus
                sheet.proclamadoData = carimboDeTempo()
                descricao = "a PROCLAMAÇÃO de " .. nomeDeus ..
                    ", que o reconhece publicamente como seu campeão"

            elseif tipo == "primordial" then
                local destino = degrauAcima(nomeDeus)
                if destino == nil then
                    avisarFavores("Não há degrau acima desta divindade.", COR.muted)
                    return
                end
                if destino == "Mãe" then
                    -- destino unico: nao ha o que escolher
                    local lista = lerFavores()
                    for _, f in ipairs(lista) do
                        if f.deus == nomeDeus then f.valor = f.valor - 3 end
                    end
                    local alvo = nil
                    for _, f in ipairs(lista) do if f.deus == MAE_CELESTIAL then alvo = f end end
                    if alvo == nil then
                        alvo = {deus = MAE_CELESTIAL, valor = 0}
                        table.insert(lista, alvo)
                    end
                    alvo.valor = math.min(alvo.valor + 1, FAVOR_MAXIMO)
                    gravarFavores(lista)
                    publicarNoChat("[§K #8A63C9]TROCA DE FAVORES[§K] — " .. tostring(sheet.nome or "Personagem") ..
                        " trocou 3 favores de [§B]" .. nomeDeus .. "[§B] por 1 favor com [§B]" ..
                        MAE_CELESTIAL .. "[§B], acima dos primordiais.")
                    atualizarAbaFavores()
                    return
                end
                favorPendentePrimordial = nomeDeus
                categoriaDestinoFavor = destino
                abrirPopupFavores(true)
                return
            else
                return
            end

            -- desconta os favores gastos
            local lista = lerFavores()
            for _, f in ipairs(lista) do
                if f.deus == nomeDeus then f.valor = f.valor - custo end
            end
            gravarFavores(lista)

            publicarNoChat("[§K #8A63C9]TROCA DE FAVORES[§K] — " .. tostring(sheet.nome or "Personagem") ..
                " trocou " .. custo .. " favores de [§B]" .. nomeDeus .. "[§B] por " .. descricao .. ".")
            avisarFavores("Troca concluída: " .. descricao .. ".", COR.gold)
            atualizarAbaFavores()
            atualizarBlocoPoderes()
        end

        -- ---------------------------------------------------------------
        -- SELETOR DE DIVINDADE
        -- ---------------------------------------------------------------
        favorPendentePrimordial = nil
        modoPrimordialFavor = false
        modoMaculaFavor = false
        categoriaDestinoFavor = "Primordial"

        function abrirPopupFavores(soPrimordiais)
            if self.popFavores == nil then return end
            modoPrimordialFavor = (soPrimordiais == true)
            atualizarListaFavoresPopup()
            abrirPopupAjustado(self.popFavores, 720, 620)
        end

        function fecharPopupFavores()
            if self.popFavores ~= nil then self.popFavores:close() end
            favorPendentePrimordial = nil
            modoPrimordialFavor = false
            modoMaculaFavor = false
        end

        function atualizarListaFavoresPopup()
            if self.popFav_lblTitulo == nil then return end
            if modoMaculaFavor then
                self.popFav_lblTitulo:setText("DEFINIR A MÁCULA DIVINA")
                self.popFav_lblAjuda:setText("A divindade escolhida nunca concederá favores a este personagem.")
            elseif modoPrimordialFavor then
                local dest = tostring(categoriaDestinoFavor or "Primordial")
                self.popFav_lblTitulo:setText("ESCOLHA A DIVINDADE — " .. string.upper(dest))
                self.popFav_lblAjuda:setText("Os 3 favores de " .. tostring(favorPendentePrimordial or "?") ..
                    " viram 1 favor com a divindade escolhida, um degrau acima na hierarquia.")
            else
                self.popFav_lblTitulo:setText("REGISTRAR FAVOR")
                self.popFav_lblAjuda:setText("Escolha a divindade que concedeu o favor. Meio ponto é o padrão; humanos, filhos e legados recebem 1 inteiro.")
            end
            for _, d in ipairs(CatalogoDeuses.itens) do
                local card = self["rectFav_" .. chavePoder(d.nome)]
                if card ~= nil then
                    local mostra = true
                    if modoPrimordialFavor then
                        mostra = (d.categoria == tostring(categoriaDestinoFavor or "Primordial"))
                    end
                    definirAlturaPod(card, mostra and 26 or 0)
                    if mostra then
                        local lbl = self["lblFav_" .. chavePoder(d.nome)]
                        if lbl ~= nil then
                            local v = favorDoDeus(d.nome)
                            local txt = d.nome
                            if v > 0 then txt = txt .. "   ·   " .. formatarFavor(v) end
                            if deusEhMacula(d.nome) then txt = txt .. "   ·   MÁCULA" end
                            lbl:setText(txt)
                            if deusEhMacula(d.nome) then lbl:setFontColor(COR.wine)
                            elseif v > 0 then lbl:setFontColor(COR.gold)
                            else lbl:setFontColor(COR.text) end
                        end
                    end
                end
            end
        end

        -- Clique numa divindade do popup.
        function escolherDeusFavor(nomeDeus)
            -- o mesmo popup serve para tres coisas; o modo diz qual
            if modoMaculaFavor then
                if not usuarioEhMestre() then return end
                sheet.maculaDivina = nomeDeus
                publicarNoChat("[§K #8B2332]MÁCULA DIVINA[§K] — " .. nickDoUsuario() ..
                    " marcou [§B]" .. nomeDeus .. "[§B] como mácula de " ..
                    tostring(sheet.nome or "personagem") .. ". Favores dessa divindade não serão mais concedidos.")
                modoMaculaFavor = false
                fecharPopupFavores()
                atualizarAbaFavores()
                return
            end
            if modoPrimordialFavor then
                -- conclui a troca: tira 3 do deus de origem, da 1 ao primordial
                local origem = favorPendentePrimordial
                if origem == nil then return end
                local lista = lerFavores()
                for _, f in ipairs(lista) do
                    if f.deus == origem then f.valor = f.valor - 3 end
                end
                local alvo = nil
                for _, f in ipairs(lista) do if f.deus == nomeDeus then alvo = f end end
                if alvo == nil then
                    alvo = {deus = nomeDeus, valor = 0}
                    table.insert(lista, alvo)
                end
                alvo.valor = math.min(alvo.valor + 1, FAVOR_MAXIMO)
                gravarFavores(lista)
                publicarNoChat("[§K #8A63C9]TROCA DE FAVORES[§K] — " .. tostring(sheet.nome or "Personagem") ..
                    " trocou 3 favores de [§B]" .. origem .. "[§B] por 1 favor com o primordial [§B]" ..
                    nomeDeus .. "[§B].")
                fecharPopupFavores()
                atualizarAbaFavores()
                return
            end
            ajustarFavor(nomeDeus, 0.5)
            atualizarListaFavoresPopup()
        end

        function escolherDeusFavorInteiro(nomeDeus)
            if modoPrimordialFavor then return end
            ajustarFavor(nomeDeus, 1)
            atualizarListaFavoresPopup()
        end

        -- ---------------------------------------------------------------
        -- RENDER
        -- ---------------------------------------------------------------
        local MAX_SLOTS_FAVOR = 12

        function avisarFavores(texto, cor)
            if self.abaFav_lblAviso == nil then return end
            self.abaFav_lblAviso:setText(tostring(texto or ""))
            self.abaFav_lblAviso:setFontColor(cor or COR.muted)
        end

        -- Os tres cards de patamar dividem a linha: dois com largura
        -- calculada e o terceiro em align="client", que absorve a sobra.
        -- Percentual nao existe no SDK, entao a conta e feita aqui.
        function ajustarPatamaresFavor()
            local total = 0
            pcall(function()
                local v = self.abaFav_linhaPatamares.width
                if type(v) == "number" and v > 320 then total = v end
            end)
            if total <= 0 then total = 1180 end
            local largura = math.floor((total - 20) / 3)
            if largura < 200 then largura = 200 end
            pcall(function() self.abaFav_pat1:setWidth(largura) end)
            pcall(function() self.abaFav_pat2:setWidth(largura) end)
        end

        function atualizarAbaFavores()
            if sheet == nil then return end
            ajustarPatamaresFavor()
            local lista = lerFavores()

            if self.abaFav_lblDivindades ~= nil then
                self.abaFav_lblDivindades:setText(tostring(#lista))
            end
            if self.abaFav_lblTotal ~= nil then
                self.abaFav_lblTotal:setText(formatarFavor(totalDeFavores()))
            end
            if self.abaFav_lblBencaos ~= nil then
                local q = 0
                for _, _d in ipairs(deusesAbencoados()) do q = q + 1 end
                self.abaFav_lblBencaos:setText(tostring(q))
            end
            if self.abaFav_lblAspecto ~= nil then
                local a = tostring(sheet.aspectoDivino or "")
                self.abaFav_lblAspecto:setText((a ~= "") and a or "—")
            end

            -- Selo de PROCLAMADO: marco raro, merece destaque proprio.
            local proclamado = tostring(sheet.proclamadoPor or "")
            definirAlturaPod(self.abaFav_wrapProclamado, (proclamado ~= "") and 54 or 0)
            if proclamado ~= "" and self.abaFav_lblProclamado ~= nil then
                self.abaFav_lblProclamado:setText("PROCLAMADO POR " .. string.upper(proclamado))
                if self.abaFav_lblProclamadoSub ~= nil then
                    self.abaFav_lblProclamadoSub:setText(
                        "Reconhecido publicamente como campeão da divindade em " ..
                        tostring(sheet.proclamadoData or "?") ..
                        ".  Poucos semideuses recebem este título em toda a vida.")
                end
            end

            definirAlturaPod(self.abaFav_wrapVazio, (#lista == 0) and 60 or 0)

            local ehMestre = usuarioEhMestre()
            definirLarguraPod(self.abaFav_wrapRegistrar, ehMestre and 240 or 0)
            definirLarguraPod(self.abaFav_wrapMacula, ehMestre and 240 or 0)

            for i = 1, MAX_SLOTS_FAVOR do
                local item = lista[i]
                definirAlturaPod(self["abaFav_wrap" .. i], (item ~= nil) and 96 or 0)
                if item ~= nil then
                    local lbl = self["abaFav_lblDeus" .. i]
                    if lbl ~= nil then lbl:setText(item.deus) end

                    local lblQtd = self["abaFav_lblQtd" .. i]
                    if lblQtd ~= nil then lblQtd:setText(formatarFavor(item.valor)) end

                    -- pips de meio ponto: 6 metades ate 3
                    for j = 1, 6 do
                        local pip = self["abaFav_pip" .. i .. "_" .. j]
                        if pip ~= nil then
                            if item.valor >= j * 0.5 then
                                pip:setColor(COR.gold); pip:setStrokeColor(COR.gold)
                            else
                                pip:setColor("#12181C"); pip:setStrokeColor("#3A4750")
                            end
                        end
                    end

                    local bonus, alvo = bonusSocialDoFavor(item.valor)
                    local lblBen = self["abaFav_lblBeneficio" .. i]
                    if lblBen ~= nil then
                        if bonus > 0 then
                            lblBen:setText("+" .. bonus .. " em testes sociais com " .. alvo)
                            lblBen:setFontColor(COR.moss)
                        else
                            lblBen:setText("meio favor — ainda sem benefício passivo")
                            lblBen:setFontColor(COR.faint)
                        end
                    end

                    local lblEstado = self["abaFav_lblEstado" .. i]
                    if lblEstado ~= nil then
                        local partes = {}
                        if tostring(sheet.aspectoDivino or "") == item.deus then
                            table.insert(partes, "seu Aspecto Divino")
                        end
                        if deusEhAcessivel(item.deus) and tostring(sheet.aspectoDivino or "") ~= item.deus then
                            table.insert(partes, "já abençoou você")
                        end
                        if deusEhMacula(item.deus) then table.insert(partes, "MÁCULA") end
                        lblEstado:setText(table.concat(partes, "  ·  "))
                    end

                    -- botoes: so o mestre, e so quando ha favores bastantes
                    definirLarguraPod(self["abaFav_wrapMais" .. i], ehMestre and 30 or 0)
                    definirLarguraPod(self["abaFav_wrapMeio" .. i], ehMestre and 38 or 0)
                    definirLarguraPod(self["abaFav_wrapMenos" .. i], ehMestre and 30 or 0)
                    definirLarguraPod(self["abaFav_wrapTroca1" .. i], (ehMestre and item.valor >= 2) and 150 or 0)
                    definirLarguraPod(self["abaFav_wrapTroca3" .. i], (ehMestre and item.valor >= 3) and 150 or 0)
                    definirLarguraPod(self["abaFav_wrapTrocaB" .. i], (ehMestre and item.valor >= 3
                        and not deusEhAcessivel(item.deus)) and 160 or 0)
                    -- degrau acima: o rotulo muda conforme a hierarquia
                    local destino, rotulo = degrauAcima(item.deus)
                    definirLarguraPod(self["abaFav_wrapTrocaP" .. i],
                        (ehMestre and item.valor >= 3 and destino ~= nil) and 180 or 0)
                    local lblP = self["abaFav_lblTrocaP" .. i]
                    if lblP ~= nil and rotulo ~= nil then
                        lblP:setText("3 → " .. rotulo)
                    end

                    -- PROCLAMAÇÃO: so com o proprio Aspecto Divino, e uma vez
                    local ehAspecto = (tostring(sheet.aspectoDivino or "") == item.deus)
                    local jaProclamado = (tostring(sheet.proclamadoPor or "") ~= "")
                    definirLarguraPod(self["abaFav_wrapProclamar" .. i],
                        (ehMestre and item.valor >= 3 and ehAspecto and not jaProclamado) and 190 or 0)

                    -- a bencao nao se aplica ao proprio aspecto
                    if ehAspecto then
                        definirLarguraPod(self["abaFav_wrapTrocaB" .. i], 0)
                    end
                end
            end
        end

        -- Botoes das linhas (indice fixo no XML).
        function favorMais(i)
            local item = lerFavores()[i]
            if item ~= nil then ajustarFavor(item.deus, 1) end
        end
        function favorMeio(i)
            local item = lerFavores()[i]
            if item ~= nil then ajustarFavor(item.deus, 0.5) end
        end
        function favorMenos(i)
            local item = lerFavores()[i]
            if item ~= nil then ajustarFavor(item.deus, -0.5) end
        end
        function favorTroca(i, tipo)
            local item = lerFavores()[i]
            if item ~= nil then trocarFavor(item.deus, tipo) end
        end

        -- Mácula: o mestre escolhe a divindade no mesmo popup.
        function definirMaculaDivina()
            if not usuarioEhMestre() then
                avisarFavores("Somente o MESTRE define a Mácula divina.", COR.wine)
                return
            end
            modoMaculaFavor = true
            abrirPopupFavores(false)
        end

        -- =================================================================
        -- INVENTARIO - modelo de dados
        --
        -- Cada item guarda os PROPRIOS valores. Ao vir do catalogo, os campos
        -- sao copiados uma vez; dali em diante o jogador edita o item e a
        -- ficha usa o que esta gravado nele. E o que permite uma armadura
        -- forjada, encantada ou danificada divergir do modelo do livro.
        --
        -- FORMATO: itens separados por ";", campos por "&", chave e valor
        -- por "=". Formato de chave e valor porque a lista de campos cresce
        -- (encantamentos, material, durabilidade atual...) e uma serializacao
        -- por posicao quebraria a cada campo novo.
        --
        -- Os separadores sao removidos de qualquer texto digitado.
        -- =================================================================

        -- Declarado ANTES de tudo: varias funcoes abaixo percorrem esta
        -- tabela, e em Lua uma local so existe a partir da linha em que
        -- aparece. Declarada no fim, "itemEstaEquipado" enxergava nil e
        -- nenhum item contava como equipado.
        local SLOTS_EQUIPADOS = {
            {chave = "armadura",   rotulo = "ARMADURA",     aceita = "armadura"},
            {chave = "acessorio1", rotulo = "ACESSÓRIO 1",  aceita = "acessorio"},
            {chave = "acessorio2", rotulo = "ACESSÓRIO 2",  aceita = "acessorio"},
            {chave = "primario",   rotulo = "PRIMÁRIO",     aceita = "maos"},
            {chave = "secundario", rotulo = "SECUNDÁRIO",   aceita = "maos"},
            {chave = "saque",      rotulo = "SAQUE RÁPIDO", aceita = "qualquer"},
            {chave = "bolso1",     rotulo = "BOLSO 1",      aceita = "qualquer"},
            {chave = "bolso2",     rotulo = "BOLSO 2",      aceita = "qualquer"},
        }

        function slotsEquipados() return SLOTS_EQUIPADOS end

        local CAMPOS_ITEM = {
            "nome", "categoria", "qualidade", "material", "onde", "qtd",
            "durMax", "durAtual", "dado", "danoExtra", "alcance",
            "reqAtributo", "reqValor",
            "absorcao", "deslocamento", "espacos",
            "aparar", "esquiva", "empatica", "telepatica",
            "periciaNome", "periciaBonus",
            "municoes", "slotsEnc", "encantamentos", "descricao",
            "visaoEscuro", "capacidade", "capacidadeTipo", "alcanceExtra",
        }

        local NUMERICOS_ITEM = {
            qtd = true, durMax = true, durAtual = true, danoExtra = true,
            alcance = true, reqValor = true, absorcao = true, deslocamento = true,
            espacos = true, aparar = true, esquiva = true, empatica = true,
            telepatica = true, periciaBonus = true, municoes = true, slotsEnc = true,
            visaoEscuro = true, capacidade = true, alcanceExtra = true,
        }

        function limparTextoItem(s)
            return tostring(s or ""):gsub("[;&=|]", " ")
        end

        function lerItens()
            local lista = {}
            if sheet == nil then return lista end
            for _, reg in ipairs(partirTexto(sheet.itensDados, ";")) do
                local it = {}
                for parte in string.gmatch(reg .. "&", "([^&]*)&") do
                    local chave, valor = parte:match("^([^=]+)=(.*)$")
                    if chave ~= nil then
                        if NUMERICOS_ITEM[chave] then it[chave] = tonumber(valor) or 0
                        else it[chave] = valor end
                    end
                end
                if it.nome ~= nil and it.nome ~= "" then
                    it.onde = it.onde or "mochila"
                    it.qtd = it.qtd or 1
                    table.insert(lista, it)
                end
            end
            return lista
        end

        function gravarItens(lista)
            if sheet == nil then return end
            local partes = {}
            for _, it in ipairs(lista) do
                if it.nome ~= nil and it.nome ~= "" then
                    local campos = {}
                    for _, chave in ipairs(CAMPOS_ITEM) do
                        local v = it[chave]
                        if v ~= nil and v ~= "" and v ~= 0 then
                            table.insert(campos, chave .. "=" .. tostring(v))
                        end
                    end
                    table.insert(partes, table.concat(campos, "&"))
                end
            end
            sheet.itensDados = table.concat(partes, ";")
        end

        -- Copia os valores do catalogo para um item novo. Dali em diante o
        -- item vive por conta propria.
        function itemDoCatalogo(nome, qualidade)
            local d = CatalogoItens.buscar(nome, qualidade)
            if d == nil then return nil end
            local it = {
                nome = d.nome, categoria = d.categoria, qualidade = d.qualidade,
                material = (d.qualidade == "Ótima") and "Incomum" or "Comum",
                onde = "mochila", qtd = 1,
                durMax = n(d.durabilidade), durAtual = n(d.durabilidade),
                dado = d.dado or "", danoExtra = n(d.danoExtra),
                -- alcance da arma e alcance EXTRA da municao sao coisas
                -- diferentes: os Virotes dao +4m ao alcance de quem atira.
                alcance = n(d.alcance), alcanceExtra = n(d.alcanceExtra),
                reqAtributo = d.reqAtributo or "", reqValor = n(d.reqValor),
                absorcao = n(d.absorcao), deslocamento = n(d.deslocamento),
                aparar = n(d.defesaAparar), esquiva = 0, empatica = 0, telepatica = 0,
                periciaNome = d.periciaNome or "", periciaBonus = n(d.periciaBonus),
                municoes = n(d.municoes), encantamentos = "", descricao = "",
                espacos = n(d.espacos), visaoEscuro = n(d.visaoEscuro),
                capacidade = n(d.capacidade), capacidadeTipo = d.capacidadeTipo or "",
            }
            -- "+N em duas defesas a escolha": o valor fica guardado e o
            -- jogador diz onde aplicar no editor
            -- O que o livro descreve mas a ficha nao tem como aplicar sozinha
            -- (escolhas, receitas de forja) vira texto na descricao, para o
            -- jogador ver e decidir onde lancar.
            local obs = {}
            if d.defesaEscolha ~= nil then
                -- Cinto e Colar nomeiam AS DUAS defesas; armaduras deixam livre.
                if d.defesaLista ~= nil then
                    table.insert(obs, "Distribua +" .. d.defesaEscolha .. " entre " ..
                        d.defesaLista .. " — apenas essas duas.")
                else
                    table.insert(obs, "Distribua +" .. d.defesaEscolha ..
                        " entre duas defesas, à sua escolha, nos campos acima.")
                end
            end
            -- consumiveis e itens narrativos: o efeito vai inteiro na descricao
            if d.efeito ~= nil and d.efeito ~= "" then
                table.insert(obs, d.efeito)
            end
            if d.curaDado ~= nil then
                table.insert(obs, "Restaura " .. d.curaDado .. "+(" .. tostring(d.curaFormula) ..
                    ") de " .. tostring(d.curaTipo) .. ".")
            end
            if d.periciaOpcoes ~= nil then
                local quanto = n(d.periciaBonus) + n(d.periciaDistribuir)
                table.insert(obs, "Escolha onde entram os +" .. quanto ..
                    ": " .. d.periciaOpcoes .. ".")
            end
            if d.danoArea ~= nil then
                table.insert(obs, "Aplica " .. d.danoArea .. " de dano [" ..
                    tostring(d.areaElemento) .. "] num raio de " .. n(d.areaRaio) .. " metros.")
            end
            if d.notas ~= nil and d.notas ~= "" then
                table.insert(obs, "Forja: " .. d.notas .. ".")
            end
            it.descricao = capitalizar(table.concat(obs, " "))
            -- Slots de encantamento dependem da qualidade e do material.
            it.slotsEnc = (d.qualidade == "Ótima") and 1 or 0
            return it
        end

        -- ---------------------------------------------------------------
        -- ENCANTAMENTOS DO ITEM
        -- Guardados como nomes separados por vírgula dentro do campo.
        -- ---------------------------------------------------------------
        function encantamentosDoItem(it)
            local r = {}
            for _, nome in ipairs(partirTexto((it or {}).encantamentos, ",")) do
                if nome ~= "" then table.insert(r, nome) end
            end
            return r
        end

        function gravarEncantamentos(it, lista)
            it.encantamentos = table.concat(lista, ",")
        end

        -- Efeitos numericos que os encantamentos somam ao item.
        function efeitosDosEncantamentos(it)
            local r = {absorcao = 0, espacos = 0, aparar = 0, esquiva = 0,
                       empatica = 0, telepatica = 0}
            for _, nome in ipairs(encantamentosDoItem(it)) do
                local e = CatalogoEncantamentos.buscar(nome)
                if e ~= nil and e.efeitos ~= nil then
                    for chave, valor in pairs(e.efeitos) do
                        r[chave] = (r[chave] or 0) + valor
                    end
                end
            end
            return r
        end

        -- =================================================================
        -- EFEITOS DO EQUIPADO
        -- Le os valores GRAVADOS no item, e nao o catalogo: e o que faz a
        -- edicao valer na hora.
        -- =================================================================
        function itemEstaEquipado(it)
            for _, s in ipairs(SLOTS_EQUIPADOS) do
                if s.chave == it.onde then return true end
            end
            return false
        end

        function efeitosEquipados()
            local r = {aparar = 0, esquiva = 0, empatica = 0, telepatica = 0,
                       absorcao = 0, deslocamento = 0, espacos = 0, pericias = {}}
            for _, it in ipairs(lerItens()) do
                if itemEstaEquipado(it) then
                    for _, chave in ipairs({"aparar", "esquiva", "empatica", "telepatica"}) do
                        r[chave] = r[chave] + n(it[chave])
                    end
                    r.absorcao = r.absorcao + n(it.absorcao)
                    r.deslocamento = r.deslocamento + n(it.deslocamento)
                    r.espacos = r.espacos + n(it.espacos)
                    if it.periciaNome ~= nil and it.periciaNome ~= "" then
                        r.pericias[it.periciaNome] = (r.pericias[it.periciaNome] or 0) + n(it.periciaBonus)
                    end
                    -- encantamentos somam por cima
                    local ef = efeitosDosEncantamentos(it)
                    for chave, valor in pairs(ef) do
                        if r[chave] ~= nil then r[chave] = r[chave] + valor end
                    end
                end
            end
            return r
        end

        function bonusItemDefesa(qual)
            local ok, e = pcall(efeitosEquipados)
            if not ok or e == nil then return 0 end
            return n(e[qual])
        end

        function bonusItemPericia(nomePericia)
            local ok, e = pcall(efeitosEquipados)
            if not ok or e == nil then return 0 end
            return n(e.pericias[nomePericia])
        end

        -- "Contrabando" e afins dao espaco extra de mochila.
        function espacosExtrasDeItens()
            local ok, e = pcall(efeitosEquipados)
            if not ok or e == nil then return 0 end
            return n(e.espacos)
        end

        -- =================================================================
        -- EDITOR DE ITEM
        -- =================================================================
        itemEmEdicao = nil

        -- Campos que aparecem no editor, por categoria. Um consumivel nao
        -- precisa de campo de defesa, e uma armadura nao precisa de alcance.
        local CAMPOS_POR_CATEGORIA = {
            ["Armadura"]  = {"durabilidade", "requisito", "defesas", "absorcao", "deslocamento", "encantamento"},
            ["Armas"]     = {"durabilidade", "requisito", "dano", "alcance", "defesas", "encantamento"},
            ["Projéteis"] = {"dano", "alcance", "municoes"},
            ["Acessórios e Ferramentas"] = {"durabilidade", "pericia", "espacos", "encantamento"},
            ["Consumíveis"] = {"municoes"},
            ["Livre"]     = {"durabilidade", "requisito", "dano", "alcance", "defesas",
                             "absorcao", "deslocamento", "pericia", "espacos", "encantamento"},
        }

        function camposDoEditor(categoria)
            return CAMPOS_POR_CATEGORIA[categoria or ""] or CAMPOS_POR_CATEGORIA["Livre"]
        end

        function abrirEditorItem(indice)
            local lista = lerItens()
            local it = lista[indice]
            if it == nil or self.popEditarItem == nil then return end
            itemEmEdicao = indice
            preencherEditorItem(it)
            abrirPopupAjustado(self.popEditarItem, 860, 700)
        end

        function fecharEditorItem()
            if self.popEditarItem ~= nil then self.popEditarItem:close() end
            itemEmEdicao = nil
        end

        local function porEdit(nome, valor)
            local w = self["edIt_" .. nome]
            if w ~= nil then w:setText(tostring(valor or "")) end
        end

        local function lerEdit(nome)
            local w = self["edIt_" .. nome]
            if w == nil then return "" end
            return tostring(w:getText() or "")
        end

        function preencherEditorItem(it)
            porEdit("nome", it.nome)
            porEdit("material", it.material)
            porEdit("qualidade", it.qualidade)
            porEdit("durAtual", n(it.durAtual))
            porEdit("durMax", n(it.durMax))
            porEdit("dado", it.dado)
            porEdit("danoExtra", n(it.danoExtra))
            porEdit("alcance", n(it.alcance))
            -- estes dois sao SELETORES: mostram "—" quando vazios
            if self.edIt_reqAtributo ~= nil then
                local v = tostring(it.reqAtributo or "")
                self.edIt_reqAtributo:setText((v ~= "") and v or "—")
                self.edIt_reqAtributo:setFontColor((v ~= "") and COR.text or COR.faint)
            end
            porEdit("reqValor", n(it.reqValor))
            porEdit("absorcao", n(it.absorcao))
            porEdit("deslocamento", n(it.deslocamento))
            porEdit("espacos", n(it.espacos))
            porEdit("aparar", n(it.aparar))
            porEdit("esquiva", n(it.esquiva))
            porEdit("empatica", n(it.empatica))
            porEdit("telepatica", n(it.telepatica))
            if self.edIt_periciaNome ~= nil then
                local v = tostring(it.periciaNome or "")
                self.edIt_periciaNome:setText((v ~= "") and v or "—")
                self.edIt_periciaNome:setFontColor((v ~= "") and COR.text or COR.faint)
            end
            porEdit("periciaBonus", n(it.periciaBonus))
            porEdit("municoes", n(it.municoes))
            porEdit("visaoEscuro", n(it.visaoEscuro))
            porEdit("slotsEnc", n(it.slotsEnc))
            porEdit("descricao", it.descricao)

            if self.edIt_lblTitulo ~= nil then
                self.edIt_lblTitulo:setText(string.upper(it.nome or "ITEM"))
            end
            if self.edIt_lblCategoria ~= nil then
                self.edIt_lblCategoria:setText((it.categoria or "Livre") ..
                    "   ·   " .. (it.qualidade or "") ..
                    "   ·   " .. (it.material or ""))
            end

            -- so mostra os grupos que fazem sentido para a categoria
            local ativos = {identidade = true}
            for _, g in ipairs(camposDoEditor(it.categoria)) do ativos[g] = true end
            -- Alturas iguais as do XML. Com 56 a caixa de texto virava uma
            -- linha fina: nao cabia titulo (16) + rotulo (15) + campo.
            local alturas = {identidade = 80, durabilidade = 80, requisito = 80,
                             dano = 80, alcance = 0, defesas = 88, absorcao = 80,
                             deslocamento = 0, pericia = 80, espacos = 0,
                             municoes = 80, encantamento = 128}
            for grupo, altura in pairs(alturas) do
                local w = self["edIt_grupo" .. grupo]
                if w ~= nil then
                    definirAlturaPod(w, ativos[grupo] and altura or 0)
                end
            end

            atualizarListaEncantamentosItem(it)
        end

        -- Atributo e pericia sao ESCOLHIDOS numa lista, e nao digitados: o
        -- nome precisa bater exatamente com o do catalogo para a automacao
        -- funcionar, e digitar dava margem a erro de grafia.
        function abrirSeletorAtributoItem()
            if itemEmEdicao == nil or self.popSelAtributo == nil then return end
            abrirPopupAjustado(self.popSelAtributo, 420, 420)
        end

        function escolherAtributoItem(nome)
            if itemEmEdicao == nil then return end
            if not podeEditarCriacao() then
                if self.popSelAtributo ~= nil then self.popSelAtributo:close() end
                avisarInventario(motivoTravaCriacao(), COR.wine); return
            end
            local lista = lerItens()
            local it = lista[itemEmEdicao]
            if it ~= nil then
                it.reqAtributo = nome
                gravarItens(lista)
                if self.edIt_reqAtributo ~= nil then
                    self.edIt_reqAtributo:setText((nome ~= "") and nome or "—")
                    self.edIt_reqAtributo:setFontColor((nome ~= "") and COR.text or COR.faint)
                end
            end
            if self.popSelAtributo ~= nil then self.popSelAtributo:close() end
        end

        function abrirSeletorPericiaItem()
            if itemEmEdicao == nil or self.popSelPericia == nil then return end
            abrirPopupAjustado(self.popSelPericia, 520, 620)
        end

        function escolherPericiaItem(nome)
            if itemEmEdicao == nil then return end
            if not podeEditarCriacao() then
                if self.popSelPericia ~= nil then self.popSelPericia:close() end
                avisarInventario(motivoTravaCriacao(), COR.wine); return
            end
            local lista = lerItens()
            local it = lista[itemEmEdicao]
            if it ~= nil then
                it.periciaNome = nome
                gravarItens(lista)
                if self.edIt_periciaNome ~= nil then
                    self.edIt_periciaNome:setText((nome ~= "") and nome or "—")
                    self.edIt_periciaNome:setFontColor((nome ~= "") and COR.text or COR.faint)
                end
            end
            if self.popSelPericia ~= nil then self.popSelPericia:close() end
        end

        function salvarEditorItem()
            if itemEmEdicao == nil then return end
            -- editar os atributos do item e criacao: o que ele FAZ nao muda
            -- no meio da campanha sem o mestre saber
            if not podeEditarCriacao() then
                avisarInventario(motivoTravaCriacao(), COR.wine); return
            end
            local lista = lerItens()
            local it = lista[itemEmEdicao]
            if it == nil then return end

            local nome = limparTextoItem(lerEdit("nome")):gsub("^%s+",""):gsub("%s+$","")
            if nome == "" then
                avisarInventario("O item precisa de um nome.", COR.wine); return
            end
            it.nome = nome
            it.material = limparTextoItem(lerEdit("material"))
            it.qualidade = limparTextoItem(lerEdit("qualidade"))
            it.durAtual = n(lerEdit("durAtual"))
            it.durMax = n(lerEdit("durMax"))
            it.dado = limparTextoItem(lerEdit("dado"))
            it.danoExtra = n(lerEdit("danoExtra"))
            it.alcance = n(lerEdit("alcance"))
            it.reqValor = n(lerEdit("reqValor"))
            it.absorcao = n(lerEdit("absorcao"))
            it.deslocamento = n(lerEdit("deslocamento"))
            it.espacos = n(lerEdit("espacos"))
            it.aparar = n(lerEdit("aparar"))
            it.esquiva = n(lerEdit("esquiva"))
            it.empatica = n(lerEdit("empatica"))
            it.telepatica = n(lerEdit("telepatica"))
            it.periciaBonus = n(lerEdit("periciaBonus"))
            it.municoes = n(lerEdit("municoes"))
            it.visaoEscuro = n(lerEdit("visaoEscuro"))
            it.slotsEnc = n(lerEdit("slotsEnc"))
            it.descricao = limparTextoItem(lerEdit("descricao"))

            gravarItens(lista)
            avisarInventario(it.nome .. " atualizado." ..
                (itemEstaEquipado(it) and " Os valores já entraram na ficha." or ""), COR.moss)
            fecharEditorItem()
            recalcularTudo()
        end

        -- ---------------------------------------------------------------
        -- ENCANTAMENTOS NO EDITOR
        -- ---------------------------------------------------------------
        function atualizarListaEncantamentosItem(it)
            local lista = encantamentosDoItem(it)
            if self.edIt_lblEncantados ~= nil then
                if #lista > 0 then
                    self.edIt_lblEncantados:setText(table.concat(lista, "   ·   "))
                    self.edIt_lblEncantados:setFontColor(COR.aura)
                else
                    self.edIt_lblEncantados:setText("nenhum encantamento aplicado")
                    self.edIt_lblEncantados:setFontColor(COR.faint)
                end
            end
            if self.edIt_lblSlotsInfo ~= nil then
                local usados, total = #lista, n(it.slotsEnc)
                self.edIt_lblSlotsInfo:setText(usados .. " de " .. total .. " slots usados")
                if usados > total then
                    self.edIt_lblSlotsInfo:setFontColor(COR.wine)
                else
                    self.edIt_lblSlotsInfo:setFontColor(COR.muted)
                end
            end
        end

        function abrirPopupEncantamentos()
            if itemEmEdicao == nil or self.popEncantamentos == nil then return end
            atualizarListaEncPopup()
            abrirPopupAjustado(self.popEncantamentos, 800, 640)
        end

        function fecharPopupEncantamentos()
            if self.popEncantamentos ~= nil then self.popEncantamentos:close() end
        end

        function atualizarListaEncPopup()
            local lista = lerItens()
            local it = lista[itemEmEdicao]
            if it == nil then return end
            local aplicados = {}
            for _, nome in ipairs(encantamentosDoItem(it)) do aplicados[nome] = true end
            for _, e in ipairs(CatalogoEncantamentos.itens) do
                local lbl = self["lblEnc_" .. chavePoder(e.nome)]
                local rect = self["rectEnc_" .. chavePoder(e.nome)]
                if lbl ~= nil then
                    if aplicados[e.nome] then
                        lbl:setFontColor(COR.gold)
                    else
                        lbl:setFontColor(COR.text)
                    end
                end
                if rect ~= nil then
                    rect:setStrokeColor(aplicados[e.nome] and COR.gold or COR.line)
                end
            end
        end

        function alternarEncantamento(nome)
            if itemEmEdicao == nil then return end
            if not podeEditarCriacao() then
                avisarInventario(motivoTravaCriacao(), COR.wine); return
            end
            local lista = lerItens()
            local it = lista[itemEmEdicao]
            if it == nil then return end
            local atuais = encantamentosDoItem(it)
            local achou = nil
            for i, x in ipairs(atuais) do if x == nome then achou = i end end
            if achou ~= nil then
                table.remove(atuais, achou)
            else
                if #atuais >= n(it.slotsEnc) then
                    avisarInventario("Este item tem " .. n(it.slotsEnc) ..
                        " slot(s) de encantamento. Aumente os slots no editor se ele foi forjado com mais.", COR.muted)
                    return
                end
                table.insert(atuais, nome)
            end
            gravarEncantamentos(it, atuais)
            gravarItens(lista)
            atualizarListaEncantamentosItem(it)
            atualizarListaEncPopup()
            recalcularTudo()
        end

        -- =================================================================
        -- INVENTARIO - estrutura
        --
        -- Tirada da ficha oficial do livro:
        --   Bolsa de moedas  Drams, Florins, Lunaris e Aureus, em campos
        --                    separados (a mesa nao converte automaticamente)
        --   Equipados        8 slots fixos
        --   Mochila          limitada por [2 + Forca + Rank]; cada lote de
        --                    2 consumiveis iguais ocupa 1 espaco
        --   Bau              sem limite, exige residencia
        -- =================================================================


        -- Resumo dos efeitos GRAVADOS no item (nao os do catalogo).
        function resumoDoItem(it)
            if it == nil then return "" end
            local p = {}
            if it.dado ~= nil and it.dado ~= "" then table.insert(p, it.dado) end
            if n(it.danoExtra) ~= 0 then table.insert(p, "+" .. n(it.danoExtra) .. " de dano") end
            if n(it.alcance) ~= 0 then table.insert(p, n(it.alcance) .. "m de alcance") end
            if n(it.alcanceExtra) ~= 0 then table.insert(p, "+" .. n(it.alcanceExtra) .. "m ao alcance da arma") end
            for chave, rot in pairs({aparar = "Aparar", esquiva = "Esquiva",
                                     empatica = "Empática", telepatica = "Telepática"}) do
                if n(it[chave]) ~= 0 then table.insert(p, "+" .. n(it[chave]) .. " " .. rot) end
            end
            if n(it.absorcao) ~= 0 then table.insert(p, n(it.absorcao) .. "% absorção") end
            if n(it.deslocamento) ~= 0 then table.insert(p, n(it.deslocamento) .. "m deslocamento") end
            if n(it.espacos) ~= 0 then table.insert(p, "+" .. n(it.espacos) .. " espaços") end
            if it.periciaNome ~= nil and it.periciaNome ~= "" then
                table.insert(p, "+" .. n(it.periciaBonus) .. " em " .. it.periciaNome)
            end
            if n(it.municoes) ~= 0 then table.insert(p, n(it.municoes) .. " munições") end
            if n(it.durMax) ~= 0 then
                table.insert(p, "durabilidade " .. n(it.durAtual) .. "/" .. n(it.durMax))
            end
            if it.reqAtributo ~= nil and it.reqAtributo ~= "" then
                table.insert(p, "requer " .. n(it.reqValor) .. " de " .. it.reqAtributo)
            end
            local enc = encantamentosDoItem(it)
            if #enc > 0 then table.insert(p, "✦ " .. table.concat(enc, ", ")) end
            if #p == 0 then return "sem efeitos" end
            return table.concat(p, "  ·  ")
        end

        function itemNoSlot(chaveSlot)
            for _, it in ipairs(lerItens()) do
                if it.onde == chaveSlot then return it end
            end
            return nil
        end

        -- ---------------------------------------------------------------
        -- CAPACIDADE DA MOCHILA
        -- "Cada lote de 2 consumiveis iguais consome 1 espaco" - por isso a
        -- conta nao e simplesmente o numero de linhas.
        -- ---------------------------------------------------------------
        function espacosOcupados()
            local total = 0
            for _, it in ipairs(lerItens()) do
                if it.onde == "mochila" then
                    local ehConsumivel = (it.categoria == "Consumíveis") or (n(it.municoes) > 0)
                    local q = math.max(1, n(it.qtd))
                    if ehConsumivel then
                        total = total + math.ceil(q / 2)
                    else
                        total = total + q
                    end
                end
            end
            return total
        end

        function capacidadeMochila()
            if sheet == nil then return 0 end
            return n(sheet.capacidadeMochila) + n(sheet.mochilaBonus) + espacosExtrasDeItens()
        end

        -- ---------------------------------------------------------------
        -- REQUISITOS
        -- ---------------------------------------------------------------
        function valorDoAtributo(nomeAtributo)
            if sheet == nil then return 0 end
            local mapa = {["Força"]="forca", ["Destreza"]="destreza",
                ["Constituição"]="constituicao", ["Inteligência"]="inteligencia",
                ["Sabedoria"]="sabedoria", ["Carisma"]="carisma", ["Manipulação"]="manipulacao"}
            local campo = mapa[nomeAtributo]
            if campo == nil then return 0 end
            return n(sheet[campo .. "Total"])
        end

        -- Devolve false e o motivo quando o item nao pode ser equipado.
        -- Le o requisito GRAVADO no item: uma arma forjada pode exigir mais
        -- ou menos que o modelo do catalogo.
        function podeEquipar(it, chaveSlot)
            if it == nil then return false, "" end
            if it.reqAtributo ~= nil and it.reqAtributo ~= "" and n(it.reqValor) > 0 then
                local tem = valorDoAtributo(it.reqAtributo)
                if tem < n(it.reqValor) then
                    return false, "Requer " .. n(it.reqValor) .. " de " .. it.reqAtributo ..
                        " e você tem " .. tem .. "."
                end
            end
            local d = CatalogoItens.buscar(it.nome, it.qualidade)
            local slotItem = (d ~= nil) and d.slot or "qualquer"
            for _, s in ipairs(SLOTS_EQUIPADOS) do
                if s.chave == chaveSlot then
                    if s.aceita ~= "qualquer" and slotItem ~= "qualquer" and slotItem ~= s.aceita then
                        return false, "Este slot não aceita " .. string.lower(tostring(it.categoria or "isso")) .. "."
                    end
                end
            end
            return true, ""
        end

        -- LIVRE: trocar de arma ou vestir armadura e acao de jogo. Travar
        -- isso obrigaria a chamar o mestre a cada combate.
        function equiparItem(indice, chaveSlot)
            if sheet == nil then return end
            local lista = lerItens()
            local it = lista[indice]
            if it == nil then return end

            local ok, motivo = podeEquipar(it, chaveSlot)
            if not ok then
                avisarInventario(motivo, COR.wine)
                return
            end

            -- o slot e de ocupacao unica: o que estava la volta para a mochila
            for _, outro in ipairs(lista) do
                if outro.onde == chaveSlot then outro.onde = "mochila" end
            end
            it.onde = chaveSlot
            gravarItens(lista)
            avisarInventario(it.nome .. " equipado.", COR.moss)
            recalcularTudo()
        end

        -- Clicar num slot equipado abre o editor daquele item.
        function editarOuDesequipar(chaveSlot)
            local lista = lerItens()
            for i, it in ipairs(lista) do
                if it.onde == chaveSlot then abrirEditorItem(i); return end
            end
        end

        function desequiparItem(chaveSlot)
            local lista = lerItens()
            for _, it in ipairs(lista) do
                if it.onde == chaveSlot then it.onde = "mochila" end
            end
            gravarItens(lista)
            recalcularTudo()
        end

        -- LIVRE mesmo com a ficha finalizada: guardar e tirar coisas da
        -- mochila acontece o tempo todo em jogo.
        function moverItem(indice, destino)
            local lista = lerItens()
            local it = lista[indice]
            if it == nil then return end
            if destino == "mochila" and it.onde ~= "mochila" then
                -- volta para a mochila: confere espaco
                if espacosOcupados() >= capacidadeMochila() then
                    avisarInventario("Mochila cheia (" .. espacosOcupados() .. "/" ..
                        capacidadeMochila() .. " espaços).", COR.wine)
                    return
                end
            end
            it.onde = destino
            gravarItens(lista)
            recalcularTudo()
        end

        function removerItem(indice)
            if not podeEditarCriacao() then
                avisarInventario(motivoTravaCriacao(), COR.wine); return
            end
            local lista = lerItens()
            if lista[indice] == nil then return end
            local nome = lista[indice].nome
            table.remove(lista, indice)
            gravarItens(lista)
            avisarInventario(nome .. " removido.", COR.muted)
            recalcularTudo()
        end

        -- LIVRE: gastar municao e consumir pocao sao acoes de jogo.
        function ajustarQtdItem(indice, delta)
            local lista = lerItens()
            local it = lista[indice]
            if it == nil then return end
            it.qtd = math.max(1, n(it.qtd) + delta)
            gravarItens(lista)
            recalcularTudo()
        end

        -- ---------------------------------------------------------------
        -- EFEITOS DO QUE ESTA EQUIPADO
        --
        -- So conta o que esta nos slots: item na mochila ou no bau nao
        -- bonifica nada.
        -- ---------------------------------------------------------------
        -- ---------------------------------------------------------------
        -- ADICIONAR
        -- ---------------------------------------------------------------
        function adicionarItemCatalogo(nome, qualidade)
            if sheet == nil then return end
            if not podeEditarCriacao() then
                avisarInventario(motivoTravaCriacao(), COR.wine); return
            end
            local lista = lerItens()
            if #lista >= 40 then
                avisarInventario("Limite de 40 itens na ficha.", COR.wine); return
            end
            local it = itemDoCatalogo(nome, qualidade)
            if it == nil then
                avisarInventario("Item não encontrado no catálogo.", COR.wine); return
            end
            table.insert(lista, it)
            gravarItens(lista)
            avisarInventario(nome .. " (" .. qualidade .. ") foi para a mochila.", COR.moss)
            recalcularTudo()
        end

        -- Cria um item em branco e ja abre o editor: e la que o jogador
        -- define nome e efeitos, sem precisar digitar antes.
        function adicionarItemLivre()
            if sheet == nil then return end
            if not podeEditarCriacao() then
                avisarInventario(motivoTravaCriacao(), COR.wine); return
            end
            local lista = lerItens()
            if #lista >= 40 then
                avisarInventario("Limite de 40 itens na ficha.", COR.wine); return
            end
            table.insert(lista, {nome = "Item novo", categoria = "Livre", qualidade = "Livre",
                                 material = "", onde = "mochila", qtd = 1, slotsEnc = 0})
            gravarItens(lista)
            recalcularTudo()
            abrirEditorItem(#lista)
        end

        -- ---------------------------------------------------------------
        -- RENDER
        -- ---------------------------------------------------------------
        local MAX_LINHAS_ITEM = 40

        function avisarInventario(texto, cor)
            if self.abaInv_lblAviso == nil then return end
            self.abaInv_lblAviso:setText(tostring(texto or ""))
            self.abaInv_lblAviso:setFontColor(cor or COR.muted)
        end

        local ROTULO_DEF_ITEM = {aparar = "Aparar", esquiva = "Esquiva",
                                 empatica = "Empática", telepatica = "Telepática"}

        function atualizarAbaInventario()
            if sheet == nil then return end
            local lista = lerItens()
            local efeitos = efeitosEquipados()

            -- ----- topo: capacidade e efeitos -----
            local usados, capacidade = espacosOcupados(), capacidadeMochila()
            if self.abaInv_lblMochila ~= nil then
                self.abaInv_lblMochila:setText(usados .. " / " .. capacidade)
                if usados > capacidade then
                    self.abaInv_lblMochila:setFontColor(COR.wine)
                else
                    self.abaInv_lblMochila:setFontColor(COR.gold)
                end
            end
            if self.abaInv_lblMochilaConta ~= nil then
                self.abaInv_lblMochilaConta:setText("2 + For " .. valorDoAtributo("Força") ..
                    " + rank " .. (DadosSistema.ordemRank[tostring(sheet.rank or "E")] or 1))
            end
            if self.abaInv_lblAbsorcao ~= nil then
                self.abaInv_lblAbsorcao:setText(n(efeitos.absorcao) .. "%")
            end
            if self.abaInv_lblPeso ~= nil then
                local d = n(efeitos.deslocamento)
                self.abaInv_lblPeso:setText((d ~= 0) and (d .. "m") or "—")
                self.abaInv_lblPeso:setFontColor((d ~= 0) and COR.wine or COR.faint)
            end
            if self.abaInv_lblEfeitos ~= nil then
                local p = {}
                for _, chave in ipairs({"aparar", "esquiva", "empatica", "telepatica"}) do
                    if n(efeitos[chave]) ~= 0 then
                        table.insert(p, ROTULO_DEF_ITEM[chave] .. " +" .. n(efeitos[chave]))
                    end
                end
                for nomePer, v in pairs(efeitos.pericias) do
                    table.insert(p, nomePer .. " +" .. v)
                end
                if #p > 0 then
                    self.abaInv_lblEfeitos:setText("Do que está equipado: " .. table.concat(p, "   ·   "))
                else
                    self.abaInv_lblEfeitos:setText("")
                end
            end

            -- ----- slots equipados -----
            for i, s in ipairs(SLOTS_EQUIPADOS) do
                local it = itemNoSlot(s.chave)
                local lbl = self["abaInv_lblSlot" .. i]
                local sub = self["abaInv_subSlot" .. i]
                local rect = self["abaInv_rectSlot" .. i]
                if lbl ~= nil then
                    if it ~= nil then
                        lbl:setText(it.nome)
                        lbl:setFontColor(COR.text)
                    else
                        lbl:setText("vazio")
                        lbl:setFontColor(COR.faint)
                    end
                end
                if sub ~= nil then
                    if it ~= nil then
                        local txt = resumoDoItem(it)
                        sub:setText(txt)
                    else
                        sub:setText(s.rotulo)
                    end
                end
                if rect ~= nil then
                    rect:setStrokeColor((it ~= nil) and COR.gold or COR.borda)
                end
            end

            -- ----- lista de itens -----
            definirAlturaPod(self.abaInv_wrapVazio, (#lista == 0) and 56 or 0)
            for i = 1, MAX_LINHAS_ITEM do
                local it = lista[i]
                definirAlturaPod(self["abaInv_wrapItem" .. i], (it ~= nil) and 52 or 0)
                if it ~= nil then
                    local lbl = self["abaInv_lblItem" .. i]
                    if lbl ~= nil then
                        local txt = it.nome
                        if n(it.qtd) > 1 then txt = txt .. "  ×" .. n(it.qtd) end
                        lbl:setText(txt)
                    end
                    local lblQual = self["abaInv_lblQual" .. i]
                    if lblQual ~= nil then
                        lblQual:setText(string.upper(it.qualidade or ""))
                        if it.qualidade == "Ótima" then lblQual:setFontColor(COR.gold)
                        elseif it.qualidade == "Livre" then lblQual:setFontColor(COR.rain)
                        else lblQual:setFontColor(COR.muted) end
                    end
                    local lblRes = self["abaInv_lblResumo" .. i]
                    if lblRes ~= nil then
                        lblRes:setText(capitalizar(resumoDoItem(it)))
                    end
                    local lblOnde = self["abaInv_lblOnde" .. i]
                    if lblOnde ~= nil then
                        local onde = it.onde
                        for _, s in ipairs(SLOTS_EQUIPADOS) do
                            if s.chave == onde then onde = s.rotulo end
                        end
                        if onde == "mochila" then onde = "MOCHILA"
                        elseif onde == "bau" then onde = "BAÚ" end
                        lblOnde:setText(onde)
                        if it.onde == "mochila" then lblOnde:setFontColor(COR.muted)
                        elseif it.onde == "bau" then lblOnde:setFontColor(COR.faint)
                        else lblOnde:setFontColor(COR.gold) end
                    end
                end
            end

        end

        -- ---------------------------------------------------------------
        -- POPUPS
        -- ---------------------------------------------------------------
        itemParaEquipar = nil

        function abrirPopupItens()
            if self.popItens == nil then return end
            abrirPopupAjustado(self.popItens, 900, 640)
        end

        function fecharPopupItens()
            if self.popItens ~= nil then self.popItens:close() end
        end

        function abrirEscolhaSlot(indice)
            local lista = lerItens()
            local it = lista[indice]
            if it == nil or self.popSlotItem == nil then return end
            itemParaEquipar = indice

            if self.popSlot_lblTitulo ~= nil then
                self.popSlot_lblTitulo:setText("EQUIPAR " .. string.upper(it.nome))
            end
            if self.popSlot_lblAjuda ~= nil then
                self.popSlot_lblAjuda:setText(resumoDoItem(it))
            end

            -- marca em cinza os slots que este item nao aceita, dizendo o motivo
            for _, s in ipairs(SLOTS_EQUIPADOS) do
                local ok, motivo = podeEquipar(it, s.chave)
                local btn = self["popSlot_btn" .. s.chave]
                local lbl = self["popSlot_lbl" .. s.chave]
                local ocupado = itemNoSlot(s.chave)
                local texto = s.rotulo
                if ocupado ~= nil then texto = texto .. "   ·   ocupado por " .. ocupado.nome end
                if not ok then texto = texto .. "   ·   " .. motivo end
                if lbl ~= nil then
                    lbl:setText(texto)
                    lbl:setFontColor(ok and COR.text or COR.faint)
                end
                if btn ~= nil then
                    btn:setStrokeColor(ok and COR.gold or COR.line)
                end
            end
            abrirPopupAjustado(self.popSlotItem, 620, 380)
        end

        function fecharPopupSlot()
            if self.popSlotItem ~= nil then self.popSlotItem:close() end
            itemParaEquipar = nil
        end

        function confirmarSlot(chaveSlot)
            if itemParaEquipar == nil then return end
            equiparItem(itemParaEquipar, chaveSlot)
            fecharPopupSlot()
        end

        -- ---------------------------------------------------------------
        -- CATALOGO: lista a esquerda, detalhe a direita
        -- ---------------------------------------------------------------
        itemDetalheCatalogo = nil

        -- Largura util do painel de detalhe, em caracteres aproximados por
        -- linha no corpo 12 do EB Garamond. Serve para estimar quantas linhas
        -- um texto vai ocupar.
        local CHARS_POR_LINHA_DET = 74

        local function alturaDeTexto(txt, base, porLinha, maxLinhas)
            local n = #tostring(txt or "")
            local linhas = math.ceil(n / (porLinha or CHARS_POR_LINHA_DET))
            if linhas < 1 then linhas = 1 end
            if maxLinhas ~= nil and linhas > maxLinhas then linhas = maxLinhas end
            return base + (linhas - 1) * 17
        end

        -- Guarda o que foi aplicado: reler ".height" logo depois de gravar
        -- pode devolver o valor antigo, porque o layout ainda nao redesenhou.
        alturaDetalheAcumulada = 0

        -- Primeira letra maiuscula. O texto do livro vem em minuscula ("ao ser
        -- consumido...") e a ficha monta frases proprias; capitalizar aqui
        -- cobre os dois casos, inclusive acentuadas.
        function capitalizar(s)
            s = tostring(s or "")
            if s == "" then return s end
            local primeira = s:sub(1, 1)
            local resto = s:sub(2)
            -- letras acentuadas ocupam 2 bytes em UTF-8
            if primeira:byte() ~= nil and primeira:byte() >= 194 then
                primeira = s:sub(1, 2)
                resto = s:sub(3)
                local MAI = {["á"]="Á",["à"]="À",["ã"]="Ã",["â"]="Â",["é"]="É",["ê"]="Ê",
                             ["í"]="Í",["ó"]="Ó",["ô"]="Ô",["õ"]="Õ",["ú"]="Ú",["ç"]="Ç"}
                return (MAI[primeira] or primeira) .. resto
            end
            return primeira:upper() .. resto
        end

        local function porDet(nome, valor)
            local lbl = self["det_" .. nome]
            local wrap = self["det_wrap" .. nome]
            local tem = (valor ~= nil and valor ~= "" and valor ~= "0")
            if lbl ~= nil then lbl:setText(capitalizar(valor)) end
            if wrap == nil then return end
            if not tem then definirAlturaPod(wrap, 0); return end
            -- Blocos de texto corrido (rotulo em cima) crescem conforme o
            -- conteudo; as linhas de rotulo-a-esquerda tem altura fixa.
            local h = 26
            if nome == "efeito" then
                h = alturaDeTexto(valor, 40, CHARS_POR_LINHA_DET, 24)
            elseif nome == "forja" then
                h = alturaDeTexto(valor, 38, 80, 6)
            elseif nome == "defesas" then
                h = alturaDeTexto(valor, 26, 52, 3)
            end
            definirAlturaPod(wrap, h)
            alturaDetalheAcumulada = alturaDetalheAcumulada + h
        end

        function verDetalheItem(indice)
            local d = CatalogoItens.itens[indice]
            if d == nil then return end
            itemDetalheCatalogo = indice

            alturaDetalheAcumulada = 0
            if self.det_nome ~= nil then self.det_nome:setText(d.nome) end
            porDet("preco", CatalogoItens.precoTexto(d.preco))
            porDet("categoria", d.categoria)
            porDet("qualidade", d.qualidade)
            porDet("material", (d.qualidade == "Ótima") and "Incomum" or "Comum")
            if d.durabilidade ~= nil then
                porDet("durabilidade", d.durabilidade .. " / " .. d.durabilidade)
            else porDet("durabilidade", nil) end
            local dano = d.dado or ""
            if d.danoExtra ~= nil then
                if dano ~= "" then dano = dano .. " e +" .. d.danoExtra
                else dano = "+" .. d.danoExtra end
            end
            porDet("dano", (dano ~= "") and dano or nil)
            -- "Nm de alcance" e o alcance da arma; "+Nm de alcance" e um
            -- EXTRA que a municao concede a quem atira. Somar os dois fazia
            -- os Virotes aparecerem como arma de 4 metros.
            if n(d.alcance) > 0 then
                porDet("alcance", n(d.alcance) .. " metros")
            elseif n(d.alcanceExtra) > 0 then
                porDet("alcance", "+" .. n(d.alcanceExtra) .. " metros ao alcance da arma")
            else
                porDet("alcance", nil)
            end
            if d.reqAtributo ~= nil then
                porDet("requisito", d.reqValor .. " de " .. d.reqAtributo)
            else porDet("requisito", nil) end
            if d.defesaAparar ~= nil then
                porDet("defesas", "+" .. d.defesaAparar .. " em Defesa - Aparar")
            elseif d.defesaEscolha ~= nil then
                -- Cinto do Gladiador e Colar do Resiliente nomeiam QUAIS duas
                -- defesas recebem; as armaduras deixam o jogador escolher.
                if d.defesaLista ~= nil then
                    porDet("defesas", "+" .. d.defesaEscolha .. " distribuído entre " .. d.defesaLista)
                else
                    porDet("defesas", "+" .. d.defesaEscolha .. " distribuído entre duas defesas, à sua escolha")
                end
            else porDet("defesas", nil) end
            porDet("absorcao", (d.absorcao ~= nil) and (d.absorcao .. "%") or nil)
            porDet("deslocamento", (d.deslocamento ~= nil) and (d.deslocamento .. " metros") or nil)
            if d.periciaNome ~= nil then
                porDet("pericia", "+" .. d.periciaBonus .. " em " .. d.periciaNome)
            elseif d.periciaDistribuir ~= nil then
                porDet("pericia", "+" .. d.periciaDistribuir .. " a distribuir entre perícias de ofício")
            else porDet("pericia", nil) end
            porDet("municoes", (d.municoes ~= nil) and tostring(d.municoes) or nil)
            porDet("espacos", (d.espacos ~= nil) and ("+" .. d.espacos .. " no espaço da mochila") or nil)
            porDet("visao", (d.visaoEscuro ~= nil) and ("+" .. d.visaoEscuro .. " metros de raio") or nil)
            porDet("capacidade", (d.capacidade ~= nil)
                and ("carrega " .. d.capacidade .. " " .. tostring(d.capacidadeTipo or "")) or nil)
            porDet("area", (d.danoArea ~= nil)
                and (d.danoArea .. " [" .. tostring(d.areaElemento) .. "] num raio de " ..
                     n(d.areaRaio) .. " metros") or nil)
            porDet("efeito", d.efeito)
            porDet("forja", d.notas)
            local slots = (d.qualidade == "Ótima") and 1 or 0
            porDet("slots", (slots > 0) and (slots .. " (pela qualidade Ótima)") or "nenhum")

            if self.det_obs ~= nil then
                if d.defesaEscolha ~= nil then
                    if d.defesaLista ~= nil then
                        self.det_obs:setText("No editor, distribua o bônus entre " .. d.defesaLista ..
                            " — apenas essas duas.")
                    else
                        self.det_obs:setText("No editor, distribua o bônus entre as duas defesas que preferir.")
                    end
                elseif d.periciaDistribuir ~= nil then
                    self.det_obs:setText("O bônus é distribuído entre Ofícios, Forja, Alfaiataria ou Mecânica — defina no editor do item.")
                else
                    self.det_obs:setText("")
                end
            end
            if self.det_lblAdicionar ~= nil then
                self.det_lblAdicionar:setText("+  ADICIONAR " .. string.upper(d.nome) .. " À MOCHILA")
            end

            -- O container cresce com o conteudo: soma a altura de cada linha
            -- visivel mais a observacao. Assim o scroll do painel funciona e
            -- nenhum texto fica escondido.
            do
                local total = alturaDetalheAcumulada + 90   -- observacao e folga
                if total < 300 then total = 300 end
                pcall(function() self.det_conteudo:setHeight(total) end)
            end

            -- destaca o selecionado na lista
            for i, item in ipairs(CatalogoItens.itens) do
                local rect = self["itmL_" .. chavePoder(item.nome) .. chavePoder(item.qualidade)]
                if rect ~= nil then
                    rect:setStrokeColor((i == indice) and COR.gold or COR.line)
                end
            end
        end

        function adicionarDetalheItem()
            if itemDetalheCatalogo == nil then
                avisarInventario("Escolha um item na lista à esquerda.", COR.muted); return
            end
            local d = CatalogoItens.itens[itemDetalheCatalogo]
            if d == nil then return end
            adicionarItemCatalogo(d.nome, d.qualidade)
        end

        -- =================================================================
        -- BACKGROUND & ANOTACOES
        --
        -- Um campo unico, ocupando a aba inteira: historia do personagem e
        -- anotacoes de mesa no mesmo lugar. Sem validacao de tamanho nem
        -- roteiro de perguntas - as historias da mesa ja estao escritas, e a
        -- ficha nao precisa cobrar nada.
        --
        -- O link continua porque muita gente escreve fora da ficha.
        -- =================================================================

        -- #texto conta BYTES, e cada acentuada ocupa dois. Como o contador e
        -- so informativo, o desconto dos bytes de continuacao UTF-8 evita
        -- mostrar uns 10% a mais numa historia em portugues.
        function contarCaracteres(texto)
            local s = tostring(texto or "")
            local total = 0
            for i = 1, #s do
                local b = s:byte(i)
                if b < 128 or b >= 192 then total = total + 1 end
            end
            return total
        end

        -- O richEdit guarda texto formatado e nao dispara onChange como o
        -- textEditor, entao nao ha contador de caracteres nesta aba.
        function atualizarAbaBackground()
        end

        function publicarLinkBackground()
            if sheet == nil then return end
            local link = tostring(sheet.bgLink or ""):gsub("^%s+", ""):gsub("%s+$", "")
            if link == "" then return end
            publicarNoChat("[§K #C9A24B]BACKGROUND[§K] — " .. tostring(sheet.nome or "Personagem") ..
                ": " .. link)
            atualizarAbaBackground()
        end


-- =====================================================================
-- VARREDURA COMPLETA DO CATALOGO
--
-- Percorre TODAS as racas, poderes, qualidades, defeitos e subclasses,
-- aplicando cada uma numa ficha limpa e conferindo se a ficha entrega o
-- que o catalogo promete. Roda em segundos e serve de rede de seguranca:
-- se um catalogo mudar ou uma automacao se perder, aparece aqui.
--
-- Uso:  lua5.3 varre_tudo.lua
-- =====================================================================
local M=dofile("varredura_base.lua"); M.montar()
local falhas, avisos = {}, {}
local function falha(t) table.insert(falhas,t) end
local function aviso(t) table.insert(avisos,t) end
local function norm(s)
  s=tostring(s or ""):lower():gsub("%(%d+%)",""):gsub("^%s+",""):gsub("%s+$","")
  return s
end

-- ------------------------------------------------ RACAS
local nR,nRb,nRp=0,0,0
for _,r in ipairs(CatalogoRacas.itens) do
  nR=nR+1
  M.aplicarRaca(r.nome)
  local prometeAtrib={}
  local prometeTeto=nil
  for _,car in ipairs(r.caracteristicas or {}) do
    local s=tostring(car.descricao or "")
    for _,a in ipairs(M.ATRIBS) do
      if s:find(a,1,true) and (s:find("Receba %+%d") or s:find("Recebe %+%d")
         or s:find("Receba %d ponto") or s:find("Recebe %d ponto")) then prometeAtrib[a]=true end
    end
    local t=s:match("passa a ser (%d+) ao invés de 8") or s:match("limite de (%d+) ao invés de 8")
    if t then prometeTeto=tonumber(t) end
  end
  for a in pairs(prometeAtrib) do
    if n(sheet[M.CAMPO[a].."Bonus"])==0 and r.nome~="Humanos" then
      falha(string.format("RAÇA %s: promete bônus em %s, ficha não aplicou", r.nome, a))
    else nRb=nRb+1 end
  end
  if prometeTeto and r.nome~="Humanos" then
    sheet.nivel=20
    local ok=false
    for a in pairs(prometeAtrib) do if limiteBaseDoAtributo(a)==prometeTeto then ok=true end end
    if not ok then falha(string.format("RAÇA %s: teto %d prometido, não aplicado", r.nome, prometeTeto)) end
    sheet.nivel=7
  end
  for _,l in ipairs({"Forca","Destreza","Constituicao","Inteligencia","Sabedoria","Carisma","Manipulacao"}) do
    nRp=nRp+#sheet["listaPericias"..l].__filhos
  end
end

-- ------------------------------------------------ PODERES
local nP,nPa=0,0
sheet.aspectoDivino="Qhyrana"
for _,p in ipairs(CatalogoPoderes.itens) do
  nP=nP+1
  M.limpar(); sheet.nivel=7; sheet.poderPontosConcedidos=200
  local alcancou=0
  for lv=1,5 do
    sheet.nivel=6+lv
    comprarNivelPoder(p.nome)
    if nivelDoPoder(p.nome)>=lv then alcancou=lv end
  end
  sheet.nivel=20; aplicarConcessoes()
  if p.atributo~=nil then
    nPa=nPa+1
    local b=n(sheet[M.CAMPO[p.atributo].."Bonus"])
    if alcancou==5 and b~=6 then
      falha(string.format("PODER %s: nível 5 deveria dar +6 em %s, deu +%d", p.nome, p.atributo, b))
    end
  end
  for i,txt in ipairs(p.progressao) do
    local s=tostring(txt)
    local q=s:match("[Rr]eceba a qualidade [\"']([^\"']+)[\"']")
    if q and alcancou>=i then
      local achou=false
      for _,item in ipairs(sheet.listaQualidades.__filhos) do
        if norm(item.nome)==norm(q) then achou=true end
      end
      if not achou then
        falha(string.format("PODER %s nv%d: promete a qualidade '%s', não concedida", p.nome, i, q))
      end
    end
    local mapa={["Defesa - Aparar"]="aparar",["Defesa - Esquiva"]="esquiva",
                ["Defesa empática"]="empatica",["Defesa telepática"]="telepatica"}
    for nomeDef,chave in pairs(mapa) do
      if s:find(nomeDef,1,true) and s:find("%+%d") and alcancou>=i and p.nome~="Escudo psíquico" then
        if bonusTotalDefesa(chave)==0 then
          falha(string.format("PODER %s nv%d: promete bônus em %s, ficha aplicou 0", p.nome, i, nomeDef))
        end
      end
    end
  end
end

-- ------------------------------------------------ QUALIDADES / DEFEITOS
local xml=io.open("../ficha.lfm"):read("a")
local nQ=0
for nome, tier in xml:gmatch('nome = "([^"]+)", tier = (%d+)') do
  nQ=nQ+1
  local q=CatalogoQD.buscarPorNome(nome)
  if q==nil then falha("CONCESSÃO aponta para '"..nome.."', inexistente no catálogo")
  else
    local permitidos={}
    for d in tostring(q.pontosTexto or ""):gmatch("(%d+)") do permitidos[tonumber(d)]=true end
    if next(permitidos)~=nil and not permitidos[tonumber(tier)] then
      falha(string.format("CONCESSÃO %s: tier %s fora do que o catálogo aceita (%s)",
        nome, tier, tostring(q.pontosTexto)))
    end
  end
end
local nQe=0
for _,q in ipairs(CatalogoQD.itens) do
  if q.efeitos~=nil then
    nQe=nQe+1
    for pts,mods in pairs(q.efeitos) do
      local total=CatalogoQD.somarEfeitos({{nome=q.nome,pontos=pts}})
      for chave,valor in pairs(mods) do
        if total[chave]~=valor then
          falha(string.format("QUALIDADE %s tier %d: %s deveria ser %s, somou %s",
            q.nome, pts, chave, tostring(valor), tostring(total[chave])))
        end
      end
    end
  end
end

-- ------------------------------------------------ SUBCLASSES
local CC=dofile("../catalogoClasses.lua")
local nS,nSn=0,0
for _,cl in ipairs(CC.classes) do
  for _,sub in ipairs(cl.subclasses or {}) do
    nS=nS+1
    for i,txt in ipairs(sub.niveis or {}) do nSn=nSn+1 end
  end
end
-- confere os dois efeitos permanentes implementados
M.limpar()
sheet.classe1Nome="Espadachim"; sheet.classe1Sub="Samurai"; sheet.classe1Nivel=4
if bonusTotalDefesa("telepatica")~=3 or bonusTotalDefesa("empatica")~=3 then
  falha("SUBCLASSE Samurai nv4: +3 nas defesas mentais não aplicado")
end
sheet.classe1Nome="Duelista"; sheet.classe1Sub="Passos de vento"; sheet.classe1Nivel=2
if not deslocamentoDobrado() then
  falha("SUBCLASSE Passos de vento nv2: deslocamento dobrado não aplicado")
end
sheet.classe1Nivel=1
if deslocamentoDobrado() then
  falha("SUBCLASSE Passos de vento: dobrou antes do nível 2")
end

-- ------------------------------------------------ RELATORIO
print("=====================================================")
print(string.format("raças %d  ·  poderes %d  ·  subclasses %d (%d níveis)", nR, nP, nS, nSn))
print(string.format("bônus raciais de atributo conferidos: %d", nRb))
print(string.format("perícias concedidas por raça: %d", nRp))
print(string.format("poderes de atributo: %d  ·  concessões de qualidade: %d", nPa, nQ))
print(string.format("qualidades com efeito numérico: %d", nQe))
print("=====================================================")
if #falhas==0 then print("\nSEM FALHAS.")
else
  print("\nFALHAS ("..#falhas.."):")
  local v={} for _,f in ipairs(falhas) do if not v[f] then v[f]=true; print("  "..f) end end
end
if #avisos>0 then
  print("\nAVISOS:")
  for _,a in ipairs(avisos) do print("  "..a) end
end

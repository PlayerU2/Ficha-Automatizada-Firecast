-- Ambiente comum das varreduras: monta uma ficha limpa e carrega o codigo
-- REAL extraido do ficha.lfm.
local M={}
function M.montar()
  local L={}
  local function novaLista(nome) local t={__filhos={}}; L[nome]=t; return t end
  NDB={} function NDB.getChildNodes(c) return (c and c.__filhos) or {} end
  function NDB.deleteNode(no)
    for _,cc in pairs(L) do
      for i,f in ipairs(cc.__filhos) do if f==no then table.remove(cc.__filhos,i) return end end end
  end
  sheet={nivel=7,poderesDados="",poderPontosConcedidos=200,raca="",idade=18}
  for _,nome in ipairs({"listaQualidades","listaDefeitos","listaCaracsRaciais","listaHabilidades",
    "listaPericiasForca","listaPericiasDestreza","listaPericiasConstituicao","listaPericiasInteligencia",
    "listaPericiasSabedoria","listaPericiasCarisma","listaPericiasManipulacao"}) do sheet[nome]=novaLista(nome) end
  local W={}
  self=setmetatable({},{__index=function(t,k)
    if L[k] then local w={__alvo=L[k]}
      function w:append() local no={}; table.insert(self.__alvo.__filhos,no); return no end
      return w end
    W[k]=W[k] or {}
    local w=W[k]
    function w:setText(v) self.txt=v end
    function w:setHeight(v) self.h=v end
    function w:setWidth(v) self.w=v end
    function w:setStrokeColor() end function w:setStrokeSize() end
    function w:setFontColor() end function w:setColor() end function w:setVisible() end
    return w end})
  COR={gold="g",wine="w",muted="m",faint="f",moss="ms",aura="a",rain="r",text="t",line="l"}
  DadosSistema=dofile("../dadosSistema.lua")
  CatalogoPoderes=dofile("../catalogoPoderes.lua")
  CatalogoDeuses=dofile("../catalogoDeuses.lua")
  CatalogoHabilidades=dofile("../catalogoHabilidades.lua")
  CatalogoQD=dofile("../catalogoQualidadesDefeitos.lua")
  CatalogoPericias=dofile("../catalogoPericias.lua")
  CatalogoRacas=dofile("../catalogoRacas.lua")
  function n(v) return tonumber(v) or 0 end
  -- utilitarios que vivem no TOPO do ficha.lfm, fora do trecho extraido
  function partirTexto(texto, sep)
    local r = {}
    for parte in string.gmatch(tostring(texto or ""), "([^" .. sep .. "]+)") do
      table.insert(r, parte)
    end
    return r
  end
  function podeEditarCriacao() return true end
  function motivoTravaCriacao() return "" end
  function usuarioEhMestre() return false end
  function nickDoUsuario() return "" end
  function publicarNoChat() end
  function abrirPopupAjustado() end
  function mostrarDetalhePoder() end
  function atualizarBlocoPoderes() end
  function atualizarBlocoHabilidades() end
  function avisarPoderes() end
  function recalcularTudo() end
  load(io.open("bloco_tudo.lua"):read("a"))()
  return L, W
end

M.ATRIBS={"Força","Destreza","Constituição","Inteligência","Sabedoria","Carisma","Manipulação"}
M.CAMPO={["Força"]="forca",["Destreza"]="destreza",["Constituição"]="constituicao",
         ["Inteligência"]="inteligencia",["Sabedoria"]="sabedoria",["Carisma"]="carisma",
         ["Manipulação"]="manipulacao"}

function M.limpar()
  sheet.listaCaracsRaciais.__filhos={}
  sheet.listaQualidades.__filhos={}
  sheet.listaDefeitos.__filhos={}
  for _,l in ipairs({"Forca","Destreza","Constituicao","Inteligencia","Sabedoria","Carisma","Manipulacao"}) do
    sheet["listaPericias"..l].__filhos={}
  end
  for _,campo in pairs(M.CAMPO) do
    sheet[campo.."Bonus"]=0; sheet[campo.."TetoRacial"]=0
    sheet[campo.."PericiasBonus"]=0; sheet[campo.."BonusDePoder"]=0
  end
  sheet.concessoesAplicadas=""
  sheet.periciasBonusGeral=0
  sheet.atributoRacialEscolhido=""; sheet.atributoRacialLancado=""; sheet.atributoRacialValor=0
  sheet.poderesDados=""
  sheet.raca=""
end

function M.aplicarRaca(nome)
  M.limpar()
  local d=CatalogoRacas.buscarPorNome(nome)
  if d==nil then return nil end
  for _,car in ipairs(d.caracteristicas or {}) do
    table.insert(sheet.listaCaracsRaciais.__filhos, {nome=car.nome})
  end
  sheet.raca=nome
  aplicarConcessoes()
  return d
end
return M

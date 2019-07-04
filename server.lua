
--[[----------------------------------------------------------------------]]--
--[[  Licença: c69aae396d9d2102a43a839d97775907							  ]]--
--[[  Discord: AZTËC™#0001                                                ]]--
--[[  Discord: discord.me/aztecde                                         ]]--
--[[  Youtube: https://www.youtube.com/channel/UC8jGkFhiXnbWWBbr90z596Q   ]]--
--[[----------------------------------------------------------------------]]--

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

MySQL = module("vrp_mysql", "MySQL")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP")
vRPmask = Tunnel.getInterface("vRP","azt_mask")

MySQL.createCommand("vRP/insertMask", "INSERT INTO vrp_srv_data (dkey, dvalue) VALUES (@key, @value)")
MySQL.createCommand("vRP/getMask", "SELECT * FROM vrp_srv_data WHERE dkey = @dkey")	-- # Utilizamos o vrp_srv_data com dkey: 'ped:u0mask', dvalue: '[142,0]'

local commandHelp = "ajuda"		-- # Mostra todas mascaras no prompt
local commandMask = "mascara"   -- # Comando da mascara
local serverMasks = true        -- # true: Permite o uso das mascara do servidor "free", false: desabilita o uso das mascaras do serve
local serverItemMask = true     -- # true: Precisa do item "mascara" para usar o comando e as mascaras do servidor, false: não e necessario o item
local playerItemMask = true     -- # true: Precisa do item "mascara" para usar o comando, false: não e necessario o item
local itemName = "mascara" 		-- # Caso não tenha o item o adicione! vrp/cfg/items.lua >> dentro do cfg.items adicione >> ["mascara"] = {"Mascara", "", nil, 0.1},
local showNotification = true	-- # true: Ativa as notificações do script, false: Desativa as notificações!

local animations = {
	["put"] = {true, {{"misscommon@van_put_on_masks","put_on_mask_ps",1}}, false},
	["take"] = {true, {{"veh@common@fp_helmet@", "take_off_helmet_stand", 1}}, false}
	--[[
	# Animação capacete
		["put"] = {true, {{"veh@common@fp_helmet@", "put_on_helmet", 1}}, false},
		["take"] = {true, {{"veh@common@fp_helmet@", "take_off_helmet_stand", 1}}, false}
	# Animação mascara
		["put"] = {true, {{"misscommon@van_put_on_masks","put_on_mask_ps",1}}, false},
		["take"] = {true, {{"misscommon@std_take_off_masks","take_off_mask_ds",1}}, false}
	]]--
}

local masks = {					-- # Lista de mascaras, total: 145 - Obs: caso queiram alterar o nome da mascara so alterar a chave dentro do array!
  ["porco"] = 1, ["caveira"] = 2, ["macaco"] = 3, ["raio"] = 4, ["macaco2"] = 5, ["caveira2"] = 6, ["capeta"] = 7, ["noel"] = 8, ["alci"] = 9, ["neve"] = 10, ["carnaval"] = 11,
  ["carnaval2"] = 12, ["kid"] = 13, ["jason"] = 14, ["jason2"] = 15, ["jason3"] = 16, ["gato"] = 17, ["raposa"] = 18, ["coruja"] = 19, ["gamba"] = 20, ["urso"] = 21, ["bufalo"] = 22,
  ["touro"] = 23, ["aguia"] = 24, ["peru"] = 25, ["lobo"] = 26, ["aviador"] = 27, ["cyborg"] = 28, ["caveira3"] = 29, ["jason4"] = 30, ["pinguim"] = 31, ["panover"] = 32,
  ["biscoito"] = 33, ["velhoc"] = 34, ["capuzpreto"] = 35, ["gasboca"] = 36, ["panopret"] = 37, ["gas"] = 38, ["monstro"] = 39, ["monstro2"] = 40, ["monstro3"] = 41,
  ["monstro4"] = 42, ["heroi"] = 43, ["meninarosa"] = 44, ["queixomen"] = 45, ["gas2"] = 46, ["fitacross"] = 47, ["fita"] = 48, ["saco"] = 49, ["jason5"] = 50, ["bandana"] = 51,
  ["balaclava"] = 52, ["balaclavacapuz"] = 53, ["camiseta"] = 54, ["balaclava2"] = 55, ["balaclava3"] = 56, ["balaclava4"] = 57, ["balaclava5"] = 58, ["bixao"] = 59, ["abobora"] = 60,
  ["monstro5"] = 61, ["monstro6"] = 62, ["monstro7"] = 63, ["monstro8"] = 64, ["monstro9"] = 65, ["monstro10"] = 66, ["monstro11"] = 67, ["diabo"] = 68, ["costurado"] = 69,
  ["monstro12"] = 70, ["monstro13"] = 71, ["diabo2"] = 72, ["biscoitomal"] = 74, ["biscoitomal2"] = 75, ["velhonatal"] = 76, ["natal"] = 77, ["natal2"] = 78,
  ["bixao2"] = 79, ["bixao3"] = 80, ["bixao4"] = 81, ["bixao5"] = 82, ["bixao6"] = 83, ["bixao7"] = 84, ["frango"] = 85, ["velha"] = 86, ["velhoc2"] = 87, ["velha2"] = 88,
  ["cyborg2"] = 89, ["cyborg3"] = 90, ["guerreiro"] = 91, ["monstro14"] = 92, ["dino"] = 93, ["diabo3"] = 94, ["palhaço"] = 95, ["gorilla"] = 96, ["cavalo"] = 97, ["unicornio"] = 98,
  ["cmexicana"] = 99, ["pug"] = 100, ["bigness"] = 101, ["bigodeneon"] = 102, ["monstro15"] = 103, ["balaclava6"] = 104, ["cmexicana2"] = 105, ["cyborg4"] = 106, ["cyborg5"] = 107,
  ["caveirab"] = 108, ["aviador2"] = 109, ["cyborg6"] = 110, ["bandana2"] = 111, ["cyborg7"] = 112, ["balaclava7"] = 113, ["arabia"] = 114, ["arabia2"] = 115, ["arabia3"] = 116,
  ["balaclava8"] = 117, ["balaclava9"] = 118, ["balaclava10"] = 119, ["ponto"] = 121, ["balaclava11"] = 122, ["balaclavaneon"] = 123, ["jasonneon"] = 124,
  ["cyborg8"] = 125, ["balaclava12"] = 126, ["jasonbiscoito"] = 127, ["boquinha"] = 128, ["cyborg9"] = 129, ["cyborg10"] = 130, ["diabovelho"] = 131, ["cyborg11"] = 132,
  ["jasonbigness"] = 133, ["balaclavafuturo"] = 134, ["cyborg12"] = 135, ["corvo"] = 136, ["monstro16"] = 137, ["monstro17"] = 138, ["monstro18"] = 139, ["monstro19"] = 140,
  ["monstro20"] = 141, ["monstro21"] = 142, ["taco"] = 143, ["xburg"] = 144, ["frango"] = 145, ["cyborg"] = 146, ["macacao"] = 147
}

--[[ C O M A N D O ]]--
RegisterCommand(commandMask, function(source, args)
	local user_id = vRP.getUserId({source})
	if #args > 0 then	
		if args[1] == commandHelp then
			local maskList = ""
			for name in pairs(masks) do
				if maskList == "" then maskList = name else maskList = maskList.."\n"..name end
			end
			vRP.prompt({source, "Lista de mascaras: ", maskList}, function(source, tab) end)
			return
		end
		if not masks[args[1]] then
			if showNotification then TriggerClientEvent("azt:notifyPicture", source, "Algo deu errado!", "~y~Mascara: ~w~"..args[1].."~n~~r~Erro: ~w~Não encontrada!") end
			return
		end
		if serverMasks then
			if serverItemMask then
				if vRP.getInventoryItemAmount({user_id, "mascara"}) >=1 then
					TriggerClientEvent("azt:mask", source, "server", masks[args[1]])
					if showNotification then TriggerClientEvent("azt:notifyPicture", source, "Otimo!", "~y~Mascara: ~w~"..args[1].."~n~~g~Sucesso: ~w~Vestindo mascara...") end
				else
					TriggerClientEvent("azt:noItemMask", source)
					if showNotification then TriggerClientEvent("azt:notifyPicture", source, "Algo deu errado!", "~y~Mascara: ~w~compre uma.~n~~r~Erro: ~w~Você não posssui mascara!") end
				end
			else
				TriggerClientEvent("azt:mask", source, "server", masks[args[1]])
				if showNotification then TriggerClientEvent("azt:notifyPicture", source, "Otimo!", "~y~Mascara: ~w~"..args[1].."~n~~g~Sucesso: ~w~Vestindo mascara...") end
			end
		else
			if showNotification then TriggerClientEvent("azt:notifyPicture", source, "Algo deu errado!", "~r~Erro: ~w~Mascaras do servidor desativada!") end
		end
	else
		key = 'ped:u'..user_id..'mask'
		if playerItemMask then		
			if vRP.getInventoryItemAmount({user_id, "mascara"}) >=1 then
				MySQL.query("vRP/getMask", {dkey = key}, function(rows)			
					if #rows > 0 then
						TriggerClientEvent("azt:mask", source, "player", json.decode(rows[1]['dvalue']))
					end
				end)
			else
				TriggerClientEvent("azt:noItemMask", source)
				if showNotification then TriggerClientEvent("azt:notifyPicture", source, "Algo deu errado!", "~y~Mascara: ~w~compre uma.~n~~r~Erro: ~w~Você não posssui mascara!") end
			end
		else
			MySQL.query("vRP/getMask", {dkey = key}, function(rows)			
				if #rows > 0 then
					TriggerClientEvent("azt:mask", source, "player", json.decode(rows[1]['dvalue']))
				end
			end)
		end
	end
end, false)

--[[ E V E N T O ]]--
RegisterNetEvent('azt:joined')
AddEventHandler('azt:joined', function()
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		key = 'ped:u'..user_id..'mask'
		MySQL.query("vRP/getMask", {dkey = key}, function(rows)			
			if #rows > 0 then
				TriggerClientEvent("azt:current", source, json.decode(rows[1]['dvalue']))	
			else
				key = 'ped:u'..user_id..'mask'
				MySQL.execute("vRP/insertMask", {key = key, value = json.encode({0, 0})})
			end
		end)
	end
end, false)

RegisterNetEvent('azt:defaultData')
AddEventHandler('azt:defaultData', function()
	local user_id = vRP.getUserId({source})
	vRP.setSData("ped:u"..user_id.."mask", json.encode({0, 0}))
end, false)

RegisterNetEvent('azt:animation')
AddEventHandler('azt:animation', function(animation)
	vRPclient.playAnim(source,{animations[animation][1],animations[animation][2],animations[animation][3]})
end, false)
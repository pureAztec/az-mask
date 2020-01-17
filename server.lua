
--[[----------------------------------------------------------------------]]--
--[[  Licença: c69aae396d9d2102a43a839d97775907							  ]]--
--[[  Discord: AZTËC™#0001                                                ]]--
--[[  Youtube: https://www.youtube.com/channel/UC8jGkFhiXnbWWBbr90z596Q   ]]--
--[[----------------------------------------------------------------------]]--

local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface("vRP", "vRP")
AZT = {}
AZTclient = Tunnel.getInterface('azt_mask', 'azt_mask')
Tunnel.bindInterface('azt_mask', AZT)

local serverMasks 	= true		-- # Se true permite o uso das mascara do servidor, ex: /mascara lobo ou /mascara 26 1 (ID DA MASCARA E COR)
local personalMask 	= false		-- # Se true o player so vai usar a mascara comprada
local needItem 		= true		-- # Se true vai precisar do item 'mascara' para usar o comando

local masks = {					-- # Lista de mascaras, total: 145 - Obs: caso queiram alterar o nome da mascara so alterar a chave dentro do array!
  ['porco'] = 1, ['caveira'] = 2, ['macaco'] = 3, ['raio'] = 4, ['macaco2'] = 5, ['caveira2'] = 6, ['capeta'] = 7, ['noel'] = 8, ['alci'] = 9, ['neve'] = 10, ['carnaval'] = 11,
  ['carnaval2'] = 12, ['kid'] = 13, ['jason'] = 14, ['jason2'] = 15, ['jason3'] = 16, ['gato'] = 17, ['raposa'] = 18, ['coruja'] = 19, ['gamba'] = 20, ['urso'] = 21, ['bufalo'] = 22,
  ['touro'] = 23, ['aguia'] = 24, ['peru'] = 25, ['lobo'] = 26, ['aviador'] = 27, ['cyborg'] = 28, ['caveira3'] = 29, ['jason4'] = 30, ['pinguim'] = 31, ['panover'] = 32,
  ['biscoito'] = 33, ['velhoc'] = 34, ['capuzpreto'] = 35, ['gasboca'] = 36, ['panopret'] = 37, ['gas'] = 38, ['monstro'] = 39, ['monstro2'] = 40, ['monstro3'] = 41,
  ['monstro4'] = 42, ['heroi'] = 43, ['meninarosa'] = 44, ['queixomen'] = 45, ['gas2'] = 46, ['fitacross'] = 47, ['fita'] = 48, ['saco'] = 49, ['jason5'] = 50, ['bandana'] = 51,
  ['balaclava'] = 52, ['balaclavacapuz'] = 53, ['camiseta'] = 54, ['balaclava2'] = 55, ['balaclava3'] = 56, ['balaclava4'] = 57, ['balaclava5'] = 58, ['bixao'] = 59, ['abobora'] = 60,
  ['monstro5'] = 61, ['monstro6'] = 62, ['monstro7'] = 63, ['monstro8'] = 64, ['monstro9'] = 65, ['monstro10'] = 66, ['monstro11'] = 67, ['diabo'] = 68, ['costurado'] = 69,
  ['monstro12'] = 70, ['monstro13'] = 71, ['diabo2'] = 72, ['biscoitomal'] = 74, ['biscoitomal2'] = 75, ['velhonatal'] = 76, ['natal'] = 77, ['natal2'] = 78,
  ['bixao2'] = 79, ['bixao3'] = 80, ['bixao4'] = 81, ['bixao5'] = 82, ['bixao6'] = 83, ['bixao7'] = 84, ['frango'] = 85, ['velha'] = 86, ['velhoc2'] = 87, ['velha2'] = 88,
  ['cyborg2'] = 89, ['cyborg3'] = 90, ['guerreiro'] = 91, ['monstro14'] = 92, ['dino'] = 93, ['diabo3'] = 94, ['palhaço'] = 95, ['gorilla'] = 96, ['cavalo'] = 97, ['unicornio'] = 98,
  ['cmexicana'] = 99, ['pug'] = 100, ['bigness'] = 101, ['bigodeneon'] = 102, ['monstro15'] = 103, ['balaclava6'] = 104, ['cmexicana2'] = 105, ['cyborg4'] = 106, ['cyborg5'] = 107,
  ['caveirab'] = 108, ['aviador2'] = 109, ['cyborg6'] = 110, ['bandana2'] = 111, ['cyborg7'] = 112, ['balaclava7'] = 113, ['arabia'] = 114, ['arabia2'] = 115, ['arabia3'] = 116,
  ['balaclava8'] = 117, ['balaclava9'] = 118, ['balaclava10'] = 119, ['ponto'] = 121, ['balaclava11'] = 122, ['balaclavaneon'] = 123, ['jasonneon'] = 124,
  ['cyborg8'] = 125, ['balaclava12'] = 126, ['jasonbiscoito'] = 127, ['boquinha'] = 128, ['cyborg9'] = 129, ['cyborg10'] = 130, ['diabovelho'] = 131, ['cyborg11'] = 132,
  ['jasonbigness'] = 133, ['balaclavafuturo'] = 134, ['cyborg12'] = 135, ['corvo'] = 136, ['monstro16'] = 137, ['monstro17'] = 138, ['monstro18'] = 139, ['monstro19'] = 140,
  ['monstro20'] = 141, ['monstro21'] = 142, ['taco'] = 143, ['xburg'] = 144, ['frango'] = 145, ['cyborg'] = 146, ['macacao'] = 147
}

RegisterCommand('mascara', function(source, args)
	local source = source
	local user_id = vRP.getUserId({source})
	AZTclient.getMask(source, {}, function(mDrawable)
		if mDrawable > 0 and personalMask or #args <= 0 then
			AZTclient.removeMask(source, {})
		end
	end)
	if #args > 0 and not personalMask then
		if args[1] == 'ajuda' then
			local maskList = ''
			for name,id in pairs(masks) do
				if maskList == '' then maskList = name..': '..id else maskList = maskList..'\n'..name..': '..id end
			end
			vRP.prompt({source, 'Lista de mascaras: ', maskList}, function(source, tab) end)
			return
		else
			if serverMasks then
				if needItem and vRP.getInventoryItemAmount({user_id, 'mascara'}) <= 0 then
					AZTclient.notify(source, {'Algo deu errado!', '~y~Mascara: ~w~compre uma.~n~~r~Erro: ~w~Você não posssui mascara!'})
					return
				end
				if type(tonumber(args[1])) == 'nil' then
					if not masks[args[1]] then
						AZTclient.notify(source, {'Algo deu errado!', '~y~Mascara: ~w~'..args[1]..'~n~~r~Erro: ~w~Não encontrada!'})
					elseif masks[args[1]] then
						AZTclient.getMask(source, {}, function(mDrawable, mTexture, mTextureMax)
							if type(tonumber(args[2])) ~= 'nil' and args[2] ~= nil then texture = tonumber(args[2]) else texture = 0 end
							if mTextureMax == 0 then texture = 0 end
							if mDrawable == 0 or texture <= mTextureMax then
								if masks[args[1]] ~= mDrawable or texture ~= mTexture then
									AZTclient.putMask(source, {masks[args[1]], texture})
								end
							end
						end)
					end
				elseif type(tonumber(args[1])) ~= 'nil' then
					AZTclient.getMask(source, {}, function(mDrawable, mTexture, mTextureMax)
						drawable = tonumber(args[1])
						if type(tonumber(args[2])) ~= 'nil' and args[2] ~= nil then texture = tonumber(args[2]) else texture = 0 end
						if mTextureMax == 0 then texture = 0 end
						if mDrawable == 0 or texture <= mTextureMax or texture == mTextureMax then
							if drawable ~= mDrawable or texture ~= mTexture then
								AZTclient.putMask(source, {drawable, texture})
							end
						end
					end)
				end
			else
				AZTclient.notify(source, {'Algo deu errado!', '~r~Erro: ~w~Mascaras do servidor desativada!'})
			end
		end
	elseif #args == 0 and personalMask then
		if needItem and vRP.getInventoryItemAmount({user_id, 'mascara'}) <= 0 then
			AZTclient.notify(source, {'Algo deu errado!', '~y~Mascara: ~w~compre uma.~n~~r~Erro: ~w~Você não posssui mascara!'})
			return
		end
		vRP.getSData({'ped:u'..user_id..'mask', function(data)	
			if data == nil or data == '' then
				AZTclient.notify(source, {'Algo deu errado!', '~y~Mascara: ~w~compre uma.~n~~r~Erro: ~w~Você não posssui mascara!'})
			else
				local myMask = json.decode(data)
				if type(myMask) == 'table' then
					AZTclient.getMask(source, {}, function(mDrawable, mTexture)
						if myMask[1] ~= mDrawable then AZTclient.putMask(source, {myMask[1], myMask[2]}) end
					end)
				end
			end
		end})
	end
end, false)

RegisterCommand('rmascara', function(source, args)
	AZTclient.getMask(source, {}, function(mDrawable, mTexture)
		if mDrawable > 0 then AZTclient.removeMask(source, {}) end
	end)
end, false)
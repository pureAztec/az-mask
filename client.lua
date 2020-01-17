
--[[----------------------------------------------------------------------]]--
--[[  Licença: c69aae396d9d2102a43a839d97775907							              ]]--
--[[  Discord: AZTËC™#0001                                                ]]--
--[[  Youtube: https://www.youtube.com/channel/UC8jGkFhiXnbWWBbr90z596Q   ]]--
--[[----------------------------------------------------------------------]]--

AZT = {}
Tunnel.bindInterface('azt_mask',  AZT)
AZTserver = Tunnel.getInterface('azt_mask', 'azt_mask')
vRP = Proxy.getInterface('vRP')

local animations = {
	['put'] = {true, {{'misscommon@van_put_on_masks','put_on_mask_ps',1}}, false},
	['take'] = {true, {{'veh@common@fp_helmet@', 'take_off_helmet_stand', 1}}, false}
}

AZT.putMask = function(drawable, texture)
  vRP.playAnim({animations['put'][1], animations['put'][2], animations['put'][3]})
  Citizen.SetTimeout(2000, function()
    SetPedComponentVariation(GetPlayerPed(-1), 1, tonumber(drawable), tonumber(texture), 2)
  end)
end

AZT.getMask = function()
	return GetPedDrawableVariation(GetPlayerPed(-1), 1), GetPedTextureVariation(GetPlayerPed(-1), 1), GetNumberOfPedTextureVariations(GetPlayerPed(-1), 1, GetPedDrawableVariation(GetPlayerPed(-1), 1))-1
end

AZT.removeMask = function()
  if GetPedDrawableVariation(GetPlayerPed(-1), 1) ~= 0 then
    vRP.playAnim({animations['take'][1], animations['take'][2], animations['take'][3]})
    Citizen.SetTimeout(1700, function()
      SetPedComponentVariation(GetPlayerPed(-1), 1, 0, 0, 2)
    end)
  end
end

AZT.notify = function(title, subtitle)
  SetNotificationTextEntry('STRING')
  AddTextComponentString(subtitle)  
  SetNotificationMessage('CHAR_AZTEC', 'CHAR_AZTEC', false, 0, 'AZT: '..title, 'github.com/pureAztec      ')
  DrawNotification(false, true)
end
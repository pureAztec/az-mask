
--[[----------------------------------------------------------------------]]--
--[[  Licença: c69aae396d9d2102a43a839d97775907							              ]]--
--[[  Discord: AZTËC™#0001                                                ]]--
--[[  Discord: discord.me/aztecde                                         ]]--
--[[  Youtube: https://www.youtube.com/channel/UC8jGkFhiXnbWWBbr90z596Q   ]]--
--[[----------------------------------------------------------------------]]--

local showNotification = true
local timeAnim = 2000           -- # Tempo de delay pra fazera animação

local currentMask = GetPedDrawableVariation(GetPlayerPed(-1), 1)
if currentMask > 0 then dressedMask = true else dressedMask = false end

TriggerServerEvent("azt:joined")

RegisterNetEvent("azt:current")
AddEventHandler("azt:current", function(current)
  if current ~= 0 or current ~= "[]" or current[1] ~= 0  or current[2] ~= 0 then
    if current[1] == 0 then
      if current[2] ~= 0 then
        TriggerServerEvent("azt:defaultData")
      end
    end
  end
end, false)

RegisterNetEvent("azt:noItemMask")
AddEventHandler("azt:noItemMask", function()
  if GetPedDrawableVariation(GetPlayerPed(-1), 1) ~= 0 then
    TriggerServerEvent("azt:animation", "take")
    Citizen.SetTimeout(timeAnim-300, function()
      SetPedComponentVariation(GetPlayerPed(-1), 1)    
      dressedMask = false
    end)
  end
end, false)

RegisterNetEvent("azt:notifyPicture")
AddEventHandler("azt:notifyPicture", function(title, subtitle)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(subtitle)  
  SetNotificationMessage("CHAR_AZTEC", "CHAR_AZTEC", false, 0, "AZT: "..title, "github.com/pureAztec      ")
  DrawNotification(false, true)
end, false)

RegisterNetEvent("azt:mask")
AddEventHandler("azt:mask", function(model, current)
  currentMask = GetPedDrawableVariation(GetPlayerPed(-1), 1)
  if currentMask > 0 then dressedMask = true else dressedMask = false end  
  if model == "server" then
    if currentMask == current then return end
    if dressedMask == false then
      if current or current ~= "" then 
        if showNotification then TriggerEvent("azt:notifyPicture", "Otimo!", "~y~Colocando a mascara aguarde...") end        
        TriggerServerEvent("azt:animation", "put")
        Citizen.SetTimeout(timeAnim, function()
          SetPedComponentVariation(GetPlayerPed(-1), 1, current, 0, 2)
          dressedMask = true
        end) 
      end
    else
      if showNotification then TriggerEvent("azt:notifyPicture", "Otimo!", "~y~Trocando de mascara, aguarde um momento...") end
      TriggerServerEvent("azt:animation", "take")
      Citizen.SetTimeout(timeAnim-300, function()
        SetPedComponentVariation(GetPlayerPed(-1), 1)  
        if current then
          TriggerServerEvent("azt:animation", "put")
          Citizen.SetTimeout(timeAnim, function()
            SetPedComponentVariation(GetPlayerPed(-1), 1, current, 0, 2)
            dressedMask = true
          end)
        end
        dressedMask = false
      end)      
    end   
  end
  if model == "player" then
    if current == 0 or current == "[]" or current[1] == 0 then
        if showNotification then TriggerEvent("azt:notifyPicture", "Ops!", "~y~Você não posssui ~r~mascara~y~, compre uma!") end
    else      
      if dressedMask == false then
        if showNotification then TriggerEvent("azt:notifyPicture", "Otimo!", "~y~Colocando a mascara aguarde...") end
        TriggerServerEvent("azt:animation", "put")
        Citizen.SetTimeout(timeAnim, function()
          SetPedComponentVariation(GetPlayerPed(-1), 1, tonumber(current[1]), tonumber(current[2]), 2)
          dressedMask = true
        end)
      else
        if showNotification then TriggerEvent("azt:notifyPicture", "Otimo!", "~y~Tirando a mascara aguarde...") end
        TriggerServerEvent("azt:animation", "take")
        Citizen.SetTimeout(timeAnim-300, function()
          SetPedComponentVariation(GetPlayerPed(-1), 1)    
          dressedMask = false
        end)        
      end
    end
  end
end, false)

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end
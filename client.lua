ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

Citizen.CreateThread(function()
	local sleep = 0

	while true do
		Citizen.Wait(sleep)

		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)
		local distance = #(vector3(Config.Coords.x, Config.Coords.y, Config.Coords.z) - vector3(pedCoords.x, pedCoords.y, pedCoords.z))

		if distance <= Config.DrawDistance then
			DrawMarker(Config.Marker.type, Config.Coords.x, Config.Coords.y, Config.Coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, Config.Marker.color.r, Config.Marker.color.g, Config.Marker.color.b, 100, false, true, 2, true, false, false, false)
		
			if distance <= 2.0 then
				if IsControlJustPressed(0, Config.OpenMenuKey) then
					-- OPEN UI
				end
			end
		else
			sleep = 1000
		end
	end
end)
ESX = nil
local PlayerData = {}
local isMenuOpen = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('tac:playerLoaded')
AddEventHandler('tac:playerLoaded', function(xPlayer)
    PlayerData = xPlayer   
end)

RegisterNetEvent('tac:setJob')
AddEventHandler('tac:setJob', function(job)
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
			sleep = 0
			if Config.Marker.Type ~= -1 then
				DrawMarker(Config.Marker.Type, Config.Coords.x, Config.Coords.y, Config.Coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, Config.Marker.color.r, Config.Marker.color.g, Config.Marker.color.b, 100, false, true, 2, true, false, false, false)
			end

			if distance <= 2.0 then
				if not isMenuOpen then
					ESX.ShowHelpNotification3("Presiona ~p~E~w~ para comprar/vender fichas", vector3(pedCoords.x, pedCoords.y, pedCoords.z + 1.0))
				end

				if IsControlJustPressed(0, Config.OpenMenuKey) then
					openNui()
				end
			end
		else
			sleep = 1000
		end
	end
end)

RegisterNUICallback("closeNui", function()
	closeNui()
end)

RegisterNUICallback("executeAction", function(data)
	TriggerServerEvent('en_chips:giveOrPay', data.type, tonumber(data.qtty))
end)

RegisterNUICallback("notify", function(data)
	exports.en_notify:SendNotification({
        text = data.text,
        type = 'info',
        timeout = 3000,
        layout = "centerRight",
        queue = "left"
    })
end)

function closeNui()
	SendNUIMessage({type = "container", show = false})
	SetNuiFocus(false, false)
	isMenuOpen = false
end

function openNui()
	SendNUIMessage({type = "container", show = true})
	SetNuiFocus(true, true)
	isMenuOpen = true
end

Citizen.CreateThread(function()
	Citizen.Wait(10000)
	modelHash = GetHashKey("ig_paper")
	RequestModel(modelHash)
	while not HasModelLoaded(modelHash) do
		 Wait(1)
	end
	createNPCA() 
end)

local created_ped

function createNPCA()
	created_ped = CreatePed(5, GetHashKey("ig_paper"), Config.Coords.x, Config.Coords.y, Config.Coords.z-1.15, Config.Coords.h, false, true)
    FreezeEntityPosition(created_ped, true)
    SetEntityInvincible(created_ped, true)
    SetBlockingOfNonTemporaryEvents(created_ped, true)
    TaskStartScenarioInPlace(created_ped, "WORLD_HUMAN_DRINKING", 0, true)
end
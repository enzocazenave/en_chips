ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if GetCurrentResourceName() != "en_chips" then
    print("Script turning off...")
    StopResource()
end
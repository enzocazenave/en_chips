ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if GetCurrentResourceName() ~= "en_chips" then
    print("Script turning off...")
    StopResource()
end

RegisterServerEvent("en_chips:giveOrPay")
AddEventHandler("en_chips:giveOrPay", function(type, qtty)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = Config.ItemName

    if type == "sell" then
        local chipsQtty = xPlayer.getInventoryItem(item).count

        if qtty >= chipsQtty then
            local moneyToPay = qtty * Config.SalePrice

            xPlayer.removeInventoryItem(item, qtty)
            xPlayer.addMoney(moneyToPay)
        else
            -- GONNA NOTIFY NOT ENOUGH CHIPS
        end

        CancelEvent()
    end
    
    local xPlayerMoney = xPlayer.getMoney()
    local money = qtty * Config.PurchasePrice
    
    if xPlayerMoney >= money then
        xPlayer.removeMoney(money)
        xPlayer.addInventoryItem(item, qtty)
    else
        -- GONNA NOTIFY NOT ENOUGH MONEY
    end
end)
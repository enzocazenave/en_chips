ESX = nil

TriggerEvent('tac:getSharedObject', function(obj) ESX = obj end)

if GetCurrentResourceName() ~= "en_chips" then
    print("Script turning off...")
    StopResource()
end

RegisterServerEvent("en_chips:giveOrPay")
AddEventHandler("en_chips:giveOrPay", function(type, qtty)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = Config.ItemName
    
    if type == "sale" then
        local chipsQtty = xPlayer.getInventoryItem(item).count

        if qtty <= chipsQtty then
            local moneyToPay = qtty * Config.SalePrice

            print(moneyToPay, qtty)
            xPlayer.removeInventoryItem(item, qtty)
            xPlayer.addMoney(moneyToPay)

            TriggerClientEvent("en_notify:SendNotification", xPlayer.source, {
                text = '+ $'..moneyToPay,
                type = "money",
                queue = "left",
                timeout = 3000,
                layout = "centerRight"
            })
        else
            -- GONNA NOTIFY NOT ENOUGH CHIPS
            TriggerClientEvent("en_notify:SendNotification", xPlayer.source, {
                text = 'No tienes esa cantidad de fichas',
                type = "info",
                queue = "left",
                timeout = 3000,
                layout = "centerRight"
            })
        end

        return
    end
    
    local xPlayerMoney = xPlayer.getMoney()
    local money = qtty * Config.PurchasePrice
    
    if xPlayerMoney >= money then
        xPlayer.removeMoney(money)
        xPlayer.addInventoryItem(item, qtty)

        TriggerClientEvent("en_notify:SendNotification", xPlayer.source, {
            text = '- $'..money,
            type = "money",
            queue = "left",
            timeout = 3000,
            layout = "centerRight"
        })
    else
        TriggerClientEvent("en_notify:SendNotification", xPlayer.source, {
            text = 'No tienes dinero suficiente',
            type = "money",
            queue = "left",
            timeout = 3000,
            layout = "centerRight"
        })
    end
end)
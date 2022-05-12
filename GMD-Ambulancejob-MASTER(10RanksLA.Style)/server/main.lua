local playersHealing, deadPlayers = {}, {}

TriggerEvent('esx_phone:registerNumber', 'ambulance', _U('alert_ambulance'), true, true)

TriggerEvent('esx_society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})

RegisterNetEvent('GMD-Ambulancejob:revive')
AddEventHandler('GMD-Ambulancejob:revive', function(playerId)
	playerId = tonumber(playerId)
	if source == '' and GetInvokingResource() == 'monitor' then -- txAdmin support
        local xTarget = ESX.GetPlayerFromId(playerId)
        if xTarget then
            if deadPlayers[playerId] then
                print(_U('revive_complete', xTarget.name))
                xTarget.triggerEvent('GMD-Ambulancejob:revive')
            else
                print(_U('player_not_unconscious'))
            end
        else
            print(_U('revive_fail_offline'))
        end
	else
		local xPlayer = source and ESX.GetPlayerFromId(source)

		if xPlayer and xPlayer.job.name == 'ambulance' then
			local xTarget = ESX.GetPlayerFromId(playerId)

			if xTarget then
				if deadPlayers[playerId] then
					if Config.ReviveReward > 0 then
						xPlayer.showNotification(_U('revive_complete_award', xTarget.name, Config.ReviveReward))
						xPlayer.addMoney(Config.ReviveReward)
						xTarget.triggerEvent('GMD-Ambulancejob:revive')
					else
						-- xPlayer.showNotification(_U('revive_complete', xTarget.name))
						TriggerClientEvent('t-notify:client:Custom', xPlayers, {
							style  =  'success',
							duration  =  1500,
							title  =  'EMS',
							message  =  'Die Wiederbelebungsmaßnahme war erfolgreich bei Herr '..xTarget.name..'.',
							sound  =  true
						})
						xTarget.triggerEvent('GMD-Ambulancejob:revive')
					end
				else
					-- xPlayer.showNotification(_U('player_not_unconscious'))
					TriggerClientEvent('t-notify:client:Custom', xPlayers, {
						style  =  'error',
						duration  =  1500,
						title  =  'EMS',
						message  =  'Dieser Bürger ist nicht Bewusstlos, simuliert er etwa?.',
						sound  =  true
					})
				end
			else
				-- xPlayer.showNotification(_U('revive_fail_offline'))
				TriggerClientEvent('t-notify:client:Custom', xPlayers, {
					style  =  'error',
					duration  =  1500,
					title  =  'EMS',
					message  =  'Dieser Bürger ist nicht mehr da, Was ist hier passiert?.',
					sound  =  true
				})
			end
		end
	end
end)

RegisterServerEvent('AnnounceEMSOuvert')
AddEventHandler('AnnounceEMSOuvert', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		-- TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'EMS', '~b~EMS announcement', 'An EMS is in service! Your health first, Please Call EMS if you die!', 'CHAR_CALL911', 8)
		TriggerClientEvent('t-notify:client:Custom', xPlayers[i], {
			style  =  'success',
			duration  =  10500,
			title  =  'EMS',
			message  =  'Das EMS ist nun im Dienst, benötigt ihr Behandlungen kommt ins MD.',
			sound  =  true
		})
	end
end)

RegisterServerEvent('AnnounceEMSFerme')
AddEventHandler('AnnounceEMSFerme', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		-- TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'EMS', '~b~EMS announcement', 'There are no more EMS in service! Please keep your heath on first position', 'CHAR_CALL911', 8)
		TriggerClientEvent('t-notify:client:Custom', xPlayers[i], {
			style  =  'error',
			duration  =  10500,
			title  =  'EMS',
			message  =  'Das EMS ist nun ausser Dienst, passt auf euch auf eine Behandlung ist absofort nicht mehr möglich.',
			sound  =  true
		})
	end
end)

RegisterServerEvent('esx_ambulance:NotificationBlipsX')
AddEventHandler('esx_ambulance:NotificationBlipsX', function(x, y, z, name)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'ambulance' then
			TriggerClientEvent('GMD-Ambulancejob:NotificationBlipsX2', xPlayers[i], _source, x, y, z)
		end
	end
end)

ESX.RegisterServerCallback('EMS:GetID', function(source, cb)
	local idJoueur = source
	cb(idJoueur)
end)

RegisterServerEvent("Server:emsAppel")
AddEventHandler("Server:emsAppel", function(coords, id)
	--local xPlayer = ESX.GetPlayerFromId(source)
	local _coords = coords
	local xPlayers	= ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
          if xPlayer.job.name == 'ambulance' then
               TriggerClientEvent("AppelemsTropBien", xPlayers[i], _coords, id)
		end
	end
end)

RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	deadPlayers[source] = 'dead'
	TriggerClientEvent('GMD-Ambulancejob:setDeadPlayers', -1, deadPlayers)
end)

RegisterServerEvent('GMD-Ambulancejob:svsearch')
AddEventHandler('GMD-Ambulancejob:svsearch', function()
  TriggerClientEvent('GMD-Ambulancejob:clsearch', -1, source)
end)

RegisterNetEvent('GMD-Ambulancejob:onPlayerDistress')
AddEventHandler('GMD-Ambulancejob:onPlayerDistress', function()
	if deadPlayers[source] then
		deadPlayers[source] = 'distress'
		TriggerClientEvent('GMD-Ambulancejob:setDeadPlayers', -1, deadPlayers)
	end
end)

RegisterNetEvent('esx:onPlayerSpawn')
AddEventHandler('esx:onPlayerSpawn', function()
	if deadPlayers[source] then
		deadPlayers[source] = nil
		TriggerClientEvent('GMD-Ambulancejob:setDeadPlayers', -1, deadPlayers)
	end
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
	if deadPlayers[playerId] then
		deadPlayers[playerId] = nil
		TriggerClientEvent('GMD-Ambulancejob:setDeadPlayers', -1, deadPlayers)
	end
end)

RegisterNetEvent('GMD-Ambulancejob:heal')
AddEventHandler('GMD-Ambulancejob:heal', function(target, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('GMD-Ambulancejob:heal', target, type)
	end
end)

RegisterNetEvent('GMD-Ambulancejob:putInVehicle')
AddEventHandler('GMD-Ambulancejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('GMD-Ambulancejob:putInVehicle', target)
	end
end)

ESX.RegisterServerCallback('GMD-Ambulancejob:removeItemsAfterRPDeath', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.RemoveCashAfterRPDeath then
		if xPlayer.getMoney() > 0 then
			xPlayer.removeMoney(xPlayer.getMoney())
		end

		if xPlayer.getAccount('black_money').money > 0 then
			xPlayer.setAccountMoney('black_money', 0)
		end
	end

	if Config.RemoveItemsAfterRPDeath then
		for i=1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].count > 0 then
				xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
			end
		end
	end

	local playerLoadout = {}
	if Config.RemoveWeaponsAfterRPDeath then
		for i=1, #xPlayer.loadout, 1 do
			xPlayer.removeWeapon(xPlayer.loadout[i].name)
		end
	else -- save weapons & restore em' since spawnmanager removes them
		for i=1, #xPlayer.loadout, 1 do
			table.insert(playerLoadout, xPlayer.loadout[i])
		end

		-- give back wepaons after a couple of seconds
		Citizen.CreateThread(function()
			Citizen.Wait(5000)
			for i=1, #playerLoadout, 1 do
				if playerLoadout[i].label ~= nil then
					xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
				end
			end
		end)
	end

	cb()
end)

if Config.EarlyRespawnFine then
	ESX.RegisterServerCallback('GMD-Ambulancejob:checkBalance', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local bankBalance = xPlayer.getAccount('bank').money

		cb(bankBalance >= Config.EarlyRespawnFineAmount)
	end)

	RegisterNetEvent('GMD-Ambulancejob:payFine')
	AddEventHandler('GMD-Ambulancejob:payFine', function()
		local xPlayer = ESX.GetPlayerFromId(source)
		local fineAmount = Config.EarlyRespawnFineAmount

		-- xPlayer.showNotification(_U('respawn_bleedout_fine_msg', ESX.Math.GroupDigits(fineAmount)))
		TriggerClientEvent('t-notify:client:Custom', xPlayers, {
			style  =  'success',
			duration  =  1500,
			title  =  'EMS',
			message  =  'Du wurdest von Notfallmediziner behandelt, dafür wird nun eine Rechnung in höhe von '..fineAmount..' ~g~$~g~ fällig.',
			sound  =  true
		})
		xPlayer.removeAccountMoney('bank', fineAmount)
	end)
end

ESX.RegisterServerCallback('GMD-Ambulancejob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

ESX.RegisterServerCallback('GMD-Ambulancejob:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		cb(false)
	else
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price)

			MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (@owner, @vehicle, @plate, @type, @job, @stored)', {
				['@owner'] = xPlayer.identifier,
				['@vehicle'] = json.encode(vehicleProps),
				['@plate'] = vehicleProps.plate,
				['@type'] = type,
				['@job'] = xPlayer.job.name,
				['@stored'] = true
			}, function (rowsChanged)
				cb(true)
			end)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('GMD-Ambulancejob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundPlate, foundNum

	for k,v in ipairs(nearbyVehicles) do
		local result = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = v.plate,
			['@job'] = xPlayer.job.name
		})

		if result[1] then
			foundPlate, foundNum = result[1].plate, k
			break
		end
	end

	if not foundPlate then
		cb(false)
	else
		MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = foundPlate,
			['@job'] = xPlayer.job.name
		}, function (rowsChanged)
			if rowsChanged == 0 then
				cb(false)
			else
				cb(true, foundNum)
			end
		end)
	end
end)

function getPriceFromHash(vehicleHash, jobGrade, type)
	local vehicles = Config.AuthorizedVehicles[type][jobGrade]

	for k,v in ipairs(vehicles) do
		if GetHashKey(v.model) == vehicleHash then
			return v.price
		end
	end

	return 0
end

RegisterNetEvent('GMD-Ambulancejob:removeItem')
AddEventHandler('GMD-Ambulancejob:removeItem', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item, 1)

	if item == 'bandage' then
		-- xPlayer.showNotification(_U('used_bandage'))
		TriggerClientEvent('t-notify:client:Custom', xPlayers, {
			style  =  'success',
			duration  =  1500,
			title  =  'EMS',
			message  =  'Du hast eine Bandage benutzt.',
			sound  =  true
		})
	elseif item == 'medikit' then
		-- xPlayer.showNotification(_U('used_medikit'))
		TriggerClientEvent('t-notify:client:Custom', xPlayers, {
			style  =  'success',
			duration  =  1500,
			title  =  'EMS',
			message  =  'Du hast einen Erstehilfekasten benutzt.',
			sound  =  true
		})
	end
end)

RegisterNetEvent('GMD-Ambulancejob:giveItem')
AddEventHandler('GMD-Ambulancejob:giveItem', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'ambulance' then
		print(('[GMD-Ambulancejob] [^2INFO^7] "%s" attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	elseif (itemName ~= 'medikit' and itemName ~= 'bandage' and itemName ~= 'marijuana2' and itemName ~= 'ibuprofen' and itemName~= 'aspirin' and itemName~= 'mexalen') then
		print(('[GMD-Ambulancejob] [^2INFO^7] "%s" attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	end

	if xPlayer.canCarryItem(itemName, amount) then
		xPlayer.addInventoryItem(itemName, amount)
	else
		-- xPlayer.showNotification(_U('max_item'))
		TriggerClientEvent('t-notify:client:Custom', xPlayers, {
			style  =  'success',
			duration  =  1500,
			title  =  'EMS',
			message  =  'Du hast davon zuviel dabei.',
			sound  =  true
		})
	end
end)

ESX.RegisterCommand('revive', 'admin', function(xPlayer, args, showError)
	args.playerId.triggerEvent('GMD-Ambulancejob:revive')
end, true, {help = _U('revive_help'), validate = true, arguments = {
	{name = 'playerId', help = 'The player id', type = 'player'}
}})

ESX.RegisterUsableItem('medikit', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('medikit', 1)

		playersHealing[source] = true
		TriggerClientEvent('GMD-Ambulancejob:useItem', source, 'medikit')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('bandage', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('bandage', 1)

		playersHealing[source] = true
		TriggerClientEvent('GMD-Ambulancejob:useItem', source, 'bandage')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('marijuana2', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('marijuana2', 1)
	
		playersHealing[source] = true
		TriggerClientEvent('GMD-Ambulancejob:useItem', source, 'marijuana2')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('ibuprofen', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('ibuprofen', 1)
	
		playersHealing[source] = true
		TriggerClientEvent('GMD-Ambulancejob:useItem', source, 'ibuprofen')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('aspirin', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('aspirin', 1)
	
		playersHealing[source] = true
		TriggerClientEvent('GMD-Ambulancejob:useItem', source, 'aspirin')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('mexalen', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('mexalen', 1)
	
		playersHealing[source] = true
		TriggerClientEvent('GMD-Ambulancejob:useItem', source, 'mexalen')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterServerCallback('GMD-Ambulancejob:getDeathStatus', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchScalar('SELECT is_dead FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(isDead)
				
		if isDead then
			print(('[GMD-Ambulancejob] [^2INFO^7] "%s" attempted combat logging'):format(xPlayer.identifier))
		end

		cb(isDead)
	end)
end)

RegisterNetEvent('GMD-Ambulancejob:setDeathStatus')
AddEventHandler('GMD-Ambulancejob:setDeathStatus', function(isDead)
	local xPlayer = ESX.GetPlayerFromId(source)

	if type(isDead) == 'boolean' then
		MySQL.Sync.execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier,
			['@isDead'] = isDead
		})
	end
end)

local AppelTotal = 0
RegisterServerEvent('EMS:AjoutAppelTotalServeur')
AddEventHandler('EMS:AjoutAppelTotalServeur', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local name = xPlayer.getName(source)
	local xPlayers = ESX.GetPlayers()
	AppelTotal = AppelTotal + 1

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'ambulance' then
			TriggerClientEvent('EMS:AjoutUnAppel', xPlayers[i], AppelTotal)
		end
	end

end)

RegisterServerEvent('EMS:PriseAppelServeur')
AddEventHandler('EMS:PriseAppelServeur', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local name = xPlayer.getName(source)
	local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'ambulance' then
			TriggerClientEvent('EMS:AppelDejaPris', xPlayers[i], name)
		end
	end
end)

RegisterServerEvent('GMD-Ambulancejob:RetirerBlipServer')
AddEventHandler('GMD-Ambulancejob:RetirerBlipServer', function(blipsRenfort)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'ambulance' then
			TriggerClientEvent('GMD-Ambulancejob:BlipRetirer', xPlayers[i], blipsRenfort)
		end
	end
end)


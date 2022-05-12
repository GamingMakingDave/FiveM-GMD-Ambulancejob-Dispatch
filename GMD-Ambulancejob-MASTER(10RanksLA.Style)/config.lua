Config                            = {}

Config.DrawDistance               = 20.0 -- How close do you need to be in order for the markers to be drawn (in GTA units).

Config.Marker                     = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}

Config.ReviveReward               = 700  -- Revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- Enable anti-combat logging? (Removes Items when a player logs back after intentionally logging out while dead.)
Config.LoadIpl                    = true -- Disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'en'

Config.EarlyRespawnTimer          = 60000 * 1  -- time til respawn is available
Config.BleedoutTimer              = 60000 * 10 -- time til the player bleeds out

Config.EnablePlayerManagement     = false -- Enable society managing (If you are using esx_society).

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 5000

Config.RespawnPoint = {coords = vector3(352.39, -599.21, 43.28), heading = 68.88}

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(352.39, -599.21, 43.28),
			sprite = 61,
			scale  = 1.2,
			color  = 2
		},

		AmbulanceActions = {
			vector3(270.5, -1363.0, 23.5)
		},

		Pharmacies = {
			vector3(306.77, -601.81, 42.28)
		},

		Vehicles = {
			{
				Spawner = vector3(342.19, -564.45, -208.8),
				InsideShop = vector3(328.11, -581.68, 28.8),
				Marker = {type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(322.79, -565.76, 28.8), heading = 250.14, radius = 4.0},
					{coords = vector3(319.17, -574.16, 28.8), heading = 250.00, radius = 4.0},
					{coords = vector3(318.09, -578.55, 28.8), heading = 250.00, radius = 6.0}
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(342.19, -579.81, 74.16),
				InsideShop = vector3(351.36, -587.65, 74.16),
				Marker = {type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(351.36, -587.65, 74.16), heading = 142.7, radius = 10.0}
				}
			}
		},

		FastTravels = {
			{
				From = vector3(332.33, -595.73, -42.28),
				To = {coords = vector3(340.09, -584.67, -28.8), heading = 68.04},
				Marker = {type = 1, x = 2.0, y = 2.0, z = 0.5, r = 0, g = 0, b = 0, a = 0, rotate = false}
			}
		},

		FastTravelsPrompt = {
			{
				From = vector3(237.4, -1373.8, 26.0),
				To = {coords = vector3(251.9, -1363.3, 38.5), heading = 0.0},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false},
				Prompt = _U('fast_travel')
			},

			{
				From = vector3(256.5, -1357.7, 36.0),
				To = {coords = vector3(235.4, -1372.8, 26.3), heading = 0.0},
				Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false},
				Prompt = _U('fast_travel')
			}
		}

	}
}

Config.AuthorizedVehicles = {
	car = {
		ambulance = {
			{model = 'ambulance', price = 5000}
		},

		doctor = {
			{model = 'ambulance', price = 4500}
		},

		chief_doctor = {
			{model = 'ambulance', price = 3000}
		},

		boss = {
			{model = 'ambulance', price = 2000}
		}
	},

	helicopter = {
		ambulance = {},

		intern = {
			{model = 'ec135med', price = 1}
		},

		emt_b = {
			{model = 'aw139', price = 1},
			{model = 'ec135med', price = 1}
		},

		emt_i = {
			{model = 'aw139', price = 1},
			{model = 'ec135med', price = 1}
		},

		emt_p = {
			{model = 'aw139', price = 1},
			{model = 'ec135med', price = 1}
		},

		ambulance_officer = {
			{model = 'aw139', price = 1},
			{model = 'ec135med', price = 1}
		},

		captain = {
			{model = 'aw139', price = 1},
			{model = 'ec135med', price = 1}
		},

		medical_resident = {
			{model = 'aw139', price = 1},
			{model = 'ec135med', price = 1}
		},

		medical_doctor = {
			{model = 'aw139', price = 1},
			{model = 'ec135med', price = 1}
		},

		chief_resident = {
			{model = 'aw139', price = 1},
			{model = 'ec135med', price = 1}
		},

		head_of_department = {
			{model = 'aw139', price = 1},
			{model = 'ec135med', price = 1}
		},

		chief_of_rescue_operation = {
			{model = 'aw139', price = 1},
			{model = 'ec135med', price = 1}
		},

		chief_of_medicine = {
			{model = 'aw139', price = 1},
			{model = 'ec135med', price = 1}
		}
	}
}

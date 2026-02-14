-- ServerScriptService Script
local Players = game:GetService("Players")
local PolicyService = game:GetService("PolicyService")
local bubbles = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remoteEvent = ReplicatedStorage:WaitForChild("UChatUpdate")
local TextService = game:GetService("TextService")
local ServerStorage = game:GetService("ServerStorage")
local RunService = game:GetService("RunService")
local function getFilterResult(text, fromUserId)

	local filterResult

	local success, errorMessage = pcall(function()

		filterResult = TextService:FilterStringAsync(text, fromUserId)

	end)


	if success then

		return filterResult

	else

		warn("Error generating TextFilterResult:", errorMessage)

	end

end

-- Global heartbeat loop 
RunService.Heartbeat:Connect(function() 
	local now = os.clock() 
	for player, bubble in pairs(bubbles) do 
		if bubble.Gui.Enabled and (now - bubble.LastUpdate) > 5 then 
			bubble.Gui.Enabled = false 
		end 
	end 
end)

Players.PlayerAdded:Connect(function(player)
	local success, policyInfo = pcall(function()
		return PolicyService:GetPolicyInfoForPlayerAsync(player)
	end)

	if success and policyInfo then
		-- policyInfo is a dictionary of flags, e.g. {IsContentSharingAllowed = true/false, ...}
		if not policyInfo.IsContentSharingAllowed then
			player:Kick("Your account is not permitted to send or receive user-provided text in this experience.")
		end
	else
		warn(" [UChat Server] PolicyService check failed:", policyInfo)
	end
	player.CharacterAdded:Connect(function(char)
		print(" [UChat Server] Character added for", player.Name)
		local head = char:FindFirstChild("Head") or char:WaitForChild("Head", 5)
		local f = ServerStorage:WaitForChild("UChatGui"):Clone()
		f.Parent = player.Character:WaitForChild("Head")
		f.Adornee = player.Character:WaitForChild("Head")
		bubbles[player] = {Gui = f, Label = f:FindFirstChild("TextLabel"), LastUpdate = 0}
		print(" [UChat Server] Finished adding UChatGui...")
	end)

end)

local function showText(player, msg) 
	print(" [UChat Server] Showing text!")
	local bubble = bubbles[player]
	if not bubble then 
		return 
	end
	bubble.Label.Text = msg 
	local ts = TextService:GetTextSize(bubble.Label.Text, bubble.Label.TextSize, bubble.Label.Font, Vector2.new(1000, 1000))
	bubble.Gui.Enabled = true
	local scaleX = (ts.X + 20) / 50 
	local scaleY = (ts.Y + 20) / 50 
	bubble.Gui.Size = UDim2.new(scaleX, 0, scaleY, 0)
	bubble.LastUpdate = os.clock() 
end

local function onServerEvent(player, filterstring, data)
	print(" [UChat Server] Received data from " .. player.Name .. ": " .. data .. "")
	local filteredObject = getFilterResult(filterstring, player.UserId)
	local filteredMessage = filteredObject:GetNonChatStringForBroadcastAsync()
	print(" [UChat Server] DEBUG filteredstring: " .. filteredMessage)
	remoteEvent:FireAllClients(data .. filteredMessage)
	
	-- Perform secure server-side actions here
	showText(player, filteredMessage)
end
remoteEvent.OnServerEvent:Connect(onServerEvent)




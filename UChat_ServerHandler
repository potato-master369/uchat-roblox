print(" [UChat Sever Handler] Started!")
print(" [UChat Server Handler] Waiting for _G.UChatBuffer...")
repeat task.wait() until _G.UChatBuffer ~= nil
repeat task.wait() until _G.UChatBufferSize ~= nil
-- init server or whatever
print(" [UChat Server Handler] Probing PlayerGUI and elements...")
local PlayerGUI = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local UChatGUI = PlayerGUI:WaitForChild("UChatGUI")
local UChatOutputText = UChatGUI:WaitForChild("Frame"):WaitForChild("ScrollingFrame"):WaitForChild("OutputText")
local ThisPlayerHead = game.Players.LocalPlayer.Character:WaitForChild("Head")
print(" [UChat Server Handler] Declaring helpers...")
function BufferToOut()
	UChatOutputText.Text = ""
	for i = 1, _G.UChatBufferSize do
		if _G.UChatBuffer[i] ~= nil then
			UChatOutputText.Text = UChatOutputText.Text .. _G.UChatBuffer[i] .. "\n"
		end
	end
end
local HelperCount
function AddToBuffer(text)
	if _G.UChatBuffer[_G.UChatBufferSie] ~= "" then
		for i = 2, _G.UChatBufferSize do
			_G.UChatBuffer[i] = _G.UChatBuffer[i+1]
		end
	end
	HelperCount = 1
	while _G.UChatBuffer[HelperCount] ~= nil do
		HelperCount += 1
	end
	_G.UChatBuffer[HelperCount] = text
end
print(" [UChat Server Handler] Preparing server...")
local UChatServerEvent = game:GetService("ReplicatedStorage"):WaitForChild("UChatUpdate")
print(" [UChat Server Handler] Validating OK token...")
_G.UChatServerOK = true
UChatServerEvent.OnClientEvent:Connect(function(data)
	print(" [UChat Server Handler] Recieved message")
	-- display anim
	AddToBuffer(data)
	BufferToOut()
end)

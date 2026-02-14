-- configuration
_G.UChatBufferSize = 10











-- code: DO NOT TOUCH if not dev
print(" [UChat] Started User chat handler!")
print("===========================")
print(" [UChat] Initialising buffer...")
_G.UChatBuffer = {}
for i = 1, _G.UChatBufferSize do
	table.insert(_G.UChatBuffer, "")
end
print(" [UChat] Probing PlayerGUI and elements...")
local PlayerGUI = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local UChatGUI = PlayerGUI:WaitForChild("UChatGUI")
local UChatInput = UChatGUI:WaitForChild("Frame"):WaitForChild("InputField")
local UChatOutputText = UChatGUI:WaitForChild("Frame"):WaitForChild("ScrollingFrame"):WaitForChild("OutputText")
local DisplayName = game.Players.LocalPlayer.DisplayName
local ThisPlayerColor = Color3.fromRGB(math.random(100, 255), math.random(100, 255), math.random(100, 255))

print(" [UChat] Declaring helpers...")
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


repeat task.wait() until _G.UChatServerOK ~= nil
print(" [UChat] Preparing server...")
local UChatServerEvent = game:GetService("ReplicatedStorage"):WaitForChild("UChatUpdate")
local UChatFilterEvent = game:GetService("ReplicatedStorage"):WaitForChild("UChatFilter")
print(" [UChat] Finished object init!")
AddToBuffer("<b>[SYSTEM]:</b> <i>Roblox Default chat sucks so use this instead!</i>")
BufferToOut()
print(" [UChat] Starting Input Loop...")
UChatInput.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		if UChatInput.Text ~= "" then
			-- show text bubble thing is in ServerHandler
			UChatServerEvent:FireServer(UChatInput.Text, [[<font color="#]] .. ThisPlayerColor:ToHex() .. "\"><b>[" .. DisplayName .. "]</b></font>: ")
			UChatInput.Text = ""
		end
	end
end)

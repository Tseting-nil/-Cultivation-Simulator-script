-- 本地變數定義
local localPlayer = game.Players.LocalPlayer
local Players = game.Players
local isDetectionEnabled = false
local playerInRange = false

-- 檢查玩家是否在範圍內
local function checkPlayersInRange()
	local character = localPlayer.Character
	if not character or not character:FindFirstChild("HumanoidRootPart") then return end
	
	local boxPosition = character.HumanoidRootPart.Position
	local boxSize = Vector3.new(500, 500, 500) / 2
	playerInRange = false
	
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local playerPosition = player.Character.HumanoidRootPart.Position
			if (math.abs(playerPosition.X - boxPosition.X) <= boxSize.X) and 
			   (math.abs(playerPosition.Y - boxPosition.Y) <= boxSize.Y) and 
			   (math.abs(playerPosition.Z - boxPosition.Z) <= boxSize.Z) then
				playerInRange = true
				break
			end
		end
	end
end

-- 設置範圍檢測循環
local function setupRangeDetection()
	while true do
		if isDetectionEnabled then checkPlayersInRange() end
		wait(0.1)
	end
end

-- 開關檢測功能
function toggleDetection()
	isDetectionEnabled = not isDetectionEnabled
	print("檢測已" .. (isDetectionEnabled and "啟用" or "關閉"))
end

-- 啟動範圍檢測
spawn(setupRangeDetection)

return playerInRange

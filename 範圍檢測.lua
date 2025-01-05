-- 取得本地玩家和服務
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local savemodetime = 3
-- 全局開關
local isDetectionEnabled = false -- 默認關閉檢測
local timescheck = 0 -- 計時器變數
local inRange = false
local playerInRange = false
local hasPrintedNoPlayer = false -- 控制「範圍內無玩家」輸出一次

-- 檢查是否有玩家在範圍內
local function checkPlayersInRange()
    local character = localPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        return
    end

    local boxPosition = character.HumanoidRootPart.Position
    local boxSize = Vector3.new(500, 500, 500) / 2 -- 範圍大小

    playerInRange = false -- 每次檢查時重置玩家範圍內狀態

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local playerPosition = player.Character.HumanoidRootPart.Position
            local inRange =
                math.abs(playerPosition.X - boxPosition.X) <= boxSize.X and
                math.abs(playerPosition.Y - boxPosition.Y) <= boxSize.Y and
                math.abs(playerPosition.Z - boxPosition.Z) <= boxSize.Z

            if inRange then
                playerInRange = true
                break -- 只需確認是否有任一玩家在範圍內即可
            end
        end
    end

    -- 輸出檢測結果
    if playerInRange then
        if timescheck == 0 then
            print("有玩家在範圍內")
			savemodetime = 8
            timescheck = 1 -- 設置計時器，避免重複輸出訊息
            hasPrintedNoPlayer = true -- 重置「範圍內無玩家」的輸出狀態
        end
    elseif timescheck == 1 then
        print("範圍內玩家已離開")
        timescheck = 0 -- 玩家離開範圍，重置計時器
		hasPrintedNoPlayer = false  -- 重置「範圍內無玩家」的輸出狀態
    end
	 -- 如果範圍內沒有玩家且尚未輸出「範圍內無玩家」，則輸出一次
	 if not playerInRange and not hasPrintedNoPlayer then
        print("範圍內無玩家")
		savemodetime = 3
        hasPrintedNoPlayer = true -- 確保只輸出一次
    end
end

-- 啟用或禁用檢測
local function setupRangeDetection()
    while true do
        if isDetectionEnabled then
            checkPlayersInRange() -- 執行檢測邏輯
        end
        wait(0.1) -- 每 0.1 秒檢測一次
    end
end

-- 開啟或關閉檢測的函數
local function toggleDetection()
    isDetectionEnabled = not isDetectionEnabled
    print("檢測已" .. (isDetectionEnabled and "啟用" or "關閉"))
	if not isDetectionEnabled then
		savemodetime = 3
	end
end

-- 啟動檢測邏輯
spawn(setupRangeDetection)


-- 重置狀態
inRange = false
playerInRange = false
timescheck = 0
hasPrintedNoPlayer = false -- 重置範圍內無玩家的輸出狀態
toggleDetection() -- 啟用/關閉檢測

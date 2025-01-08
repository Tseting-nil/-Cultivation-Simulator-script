-- 全域變數
local Players = game:GetService("Players")
local ALLRespawn_Point = {}
local localPlayer = Players.LocalPlayer -- 本地玩家
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- 玩家位置
local playerPosition = humanoidRootPart.Position

-- 資料夾變數
local workspace = game:GetService("Workspace")
local mainscene = workspace:FindFirstChild("主场景") -- 主場景
if mainscene then
    mainscene.Name = "主场景1"
else
    print("已更改名稱")
end

-- 記錄所有重生點位置
for i = 1, 9 do
    local scene = workspace:FindFirstChild("主场景"..i)
    if scene then
        local respawnPoint = scene:FindFirstChild("重生点")
        ALLRespawn_Point[i] = {
            Position = respawnPoint.Position,
            SceneName = scene.Name
        }
    end
end

-- 找到最近的出生點
local closestDistance = math.huge -- 初始設為無限大
local closestSceneName = nil

for _, respawnInfo in ipairs(ALLRespawn_Point) do
    local distance = (playerPosition - respawnInfo.Position).Magnitude
    if distance < closestDistance then
        closestDistance = distance
        closestSceneName = respawnInfo.SceneName
    end
end

return closestSceneName
local localPlayer = game.Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait() -- 獲取玩家角色
local rootPart = character:WaitForChild("HumanoidRootPart") -- 獲取角色的根部件

local closestScene = nil
local closestPosition = nil
local closestDistance = math.huge -- 初始化為無窮大

for i = 1, 9 do
    local sceneName = "主场景" .. (i > 1 and tostring(i) or "") -- 動態生成主場景名稱
    local scene = workspace:WaitForChild(sceneName, 5) -- 等待主場景加載

    if scene then
        local respawnPoint = scene:WaitForChild("重生点", 5) -- 在主場景中等待出生點加載
        if respawnPoint then
            local distance = (respawnPoint.CFrame.Position - rootPart.CFrame.Position).Magnitude -- 計算距離
            if distance < closestDistance then
                closestDistance = distance
                closestScene = scene
                closestPosition = respawnPoint.Position + Vector3.new(0, 4.9, 0)
            end
        else
            print("主場景:", scene.Name, "中未找到重生點")
        end
    else
        print("未找到主場景:", sceneName)
    end
end

if closestScene and closestPosition then
    print("初始場景為:", closestScene.Name)
    print("重生點座標 (x, y, z):", closestPosition.X, closestPosition.Y, closestPosition.Z)
    
    
else
    print("未找到任何有效的出生點")
end

-- 傳送玩家到重生點
    rootPart.CFrame = CFrame.new(closestPosition)

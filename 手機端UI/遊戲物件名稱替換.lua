local player = game:GetService("Players").LocalPlayer;
local playerGui = player.PlayerGui;
-- ========================================================================== --
-- 任務資料夾初始化名稱
local gamepassmissionnamelist = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("商店"):WaitForChild("通行证任务"):WaitForChild("背景"):WaitForChild("任务列表")
local gamepassnamecheck = false
local function gamepassmissionnamechange()
	-- 檢查最終對象是否存在
	if gamepassmissionnamelist then
        spawn(function()
            for i = 1, 12 do
                local gamepassmissionlist = gamepassmissionnamelist:FindFirstChild("任务项预制体")
                if gamepassmissionlist then
                    gamepassmissionlist.Name = tostring(i)
                else
                    if not gamepassnamecheck then
                        game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\230\156\136\233\128\154\232\161\140\232\175\129"):FindFirstChild("\232\142\183\229\143\150\230\149\176\230\141\174"):FireServer()
                        print("通行證任務--名稱--已全部更改")
                        gamepassnamecheck = true
                    end
                end
            end
        end)
    end
end
gamepassmissionnamechange()
-- ========================================================================== --
-- 通行證獎勵資料夾初始化名稱
local player = game:GetService("Players").LocalPlayer;
local playerGui = player.PlayerGui;
local gamepassgiftnnamelist = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("商店"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("月通行证"):WaitForChild("背景"):WaitForChild("奖励区"):WaitForChild("奖励列表")
local gamepassgiftnamecheck = false
local function gamepassgiftnnamechange()
    if gamepassgiftnnamelist then
        spawn(function()
            local index = 1
            while true do
                local gamepassgiftnlist = gamepassgiftnnamelist:GetChildren()  -- 獲取所有子物件
                local found = false

                for _, item in ipairs(gamepassgiftnlist) do
                    if item.Name == "月通行证奖励预制体" then
                        item.Name = "gamepassgift" .. tostring(index)  -- 設定名稱
                        index = index + 1
                        found = true
                    end
                end

                if not found then
                    if not gamepassgiftnamecheck then
                        print("通行證獎勵--名稱--已全部更改")
                        gamepassgiftnamecheck = true
                    end
                    break
                end
            end
        end)
    end
end
gamepassgiftnnamechange()
-- ========================================================================== --
-- 每日任務資料夾初始化名稱
local everydaymissionnamelist = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("每日任务"):WaitForChild("背景"):WaitForChild("任务列表")
local everydaynamecheck = false
local function everydatmissionnamechange()
	if everydaymissionnamelist then
        spawn(function()
            for i = 1, 7 do
                local everydaymissionlist = everydaymissionnamelist:FindFirstChild("任务项预制体")
                if everydaymissionlist then
                    everydaymissionlist.Name = tostring(i)
                else
                    if not everydaynamecheck then
                        print("每日任務--名稱--已全部更改")
                        everydaynamecheck = true
                    end
                end
            end
        end)
	else
		--print("每日任務--名稱--已全部更改")
	end
end
everydatmissionnamechange()

-- ========================================================================== --
-- 世界關卡資料夾初始化名稱
local schedule = player:WaitForChild("值"):WaitForChild("主线进度")
local worldname = schedule:FindFirstChild("世界")
local worldlevelsname = schedule:FindFirstChild("关卡")
if worldname and worldlevelsname then
    worldname.Name = "world"
    worldlevelsname.Name = "levels"
end

-- ========================================================================== --
-- 地下城資料夾初始化名稱
local Dungeonslist = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("关卡选择"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("副本"):WaitForChild("列表")
local function Dungeonnamechange()
    local namecheck = false
    if Dungeonslist then
        spawn(function()
            while true do
                local dungeonlist = Dungeonslist:FindFirstChild("副本预制体")
                if dungeonlist then
                    local dungeonsname = dungeonlist:FindFirstChild("名称").Text
                    dungeonsname = string.gsub(dungeonsname, "%s+", "")
                    dungeonlist.Name = dungeonsname
                else
                    if not namecheck then
                        print("地下城--名稱--已全部更改")
                        namecheck = true
                        break
                    end
                end
            end
            namecheck = false
        end)
    else
        --print("地下城--名稱--已全部更改")
    end
end

Dungeonnamechange()
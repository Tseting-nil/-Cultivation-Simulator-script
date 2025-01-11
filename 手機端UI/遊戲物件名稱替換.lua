local player = game:GetService("Players").LocalPlayer;
local playerGui = player.PlayerGui;
local gamepassmissionnamelist = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("商店"):WaitForChild("通行证任务"):WaitForChild("背景"):WaitForChild("任务列表")
-- ========================================================================== --
-- 任務資料夾初始化名稱
local function gamepassmissionnamechange()
    local namecheck = false
	-- 檢查最終對象是否存在
	if gamepassmissionnamelist then
	spawn(function()
        for i = 1, 12 do
            local gamepassmissionlist = gamepassmissionnamelist:FindFirstChild("任务项预制体")
            if gamepassmissionlist then
            	gamepassmissionlist.Name = tostring(i)
            else
                game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\230\156\136\233\128\154\232\161\140\232\175\129"):FindFirstChild("\232\142\183\229\143\150\230\149\176\230\141\174"):FireServer()
                if not namecheck then
                    print("通行證任務--名稱--已全部更改")
                    namecheck = true
                end
            end
        end
        namecheck = false
	end)
	else
		--print("通行證任務--名稱--已全部更改")
    end
end
gamepassmissionnamechange()
-- ========================================================================== --
-- 每日任务資料夾初始化名稱

local everydaymissionnamelist = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("每日任务"):WaitForChild("背景"):WaitForChild("任务列表")
local function everydatmissionnamechange()
    local namecheck = false
	if everydaymissionnamelist then
	spawn(function()
		for i = 1, 7 do
			local everydaymissionlist = everydaymissionnamelist:FindFirstChild("任务项预制体")
			if everydaymissionlist then
				everydaymissionlist.Name = tostring(i)
			else
                if not namecheck then
                    print("每日任務--名稱--已全部更改")
                    namecheck = true
                end
			end
		end
        namecheck = false
	end)
	else
		--print("每日任務--名稱--已全部更改")
	end
end
everydatmissionnamechange()


-- ========================================================================== --
-- 世界關卡資料夾初始化名稱&添加模塊

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
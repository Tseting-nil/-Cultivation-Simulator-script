local player = game:GetService("Players").LocalPlayer;
local playerGui = player.PlayerGui;
local gamepassmissionnamelist = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("商店"):WaitForChild("通行证任务"):WaitForChild("背景"):WaitForChild("任务列表")
-- ========================================================================== --
-- 任務資料夾初始化名稱
local function gamepassmissionnamechange()
	-- 檢查最終對象是否存在
	if gamepassmissionnamelist then
	spawn(function()
        for i = 1, 12 do
            local gamepassmissionlist = gamepassmissionnamelist:FindFirstChild("任务项预制体")
            if gamepassmissionlist then
            	gamepassmissionlist.Name = tostring(i)
            else
                game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\230\156\136\233\128\154\232\161\140\232\175\129"):FindFirstChild("\232\142\183\229\143\150\230\149\176\230\141\174"):FireServer()
                print("通行證任務--名稱--已全部更改")
            end
        end
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
	if everydaymissionnamelist then
	spawn(function()
		for i = 1, 7 do
			local everydaymissionlist = everydaymissionnamelist:FindFirstChild("任务项预制体")
			if everydaymissionlist then
				everydaymissionlist.Name = tostring(i)
			else
				print("每日任務--名稱--已全部更改")
			end
		end
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

-- 獲取目標資料夾（例如 schedule）
local targetFolder = schedule
-- 定義 IntValue 的名稱
local intValueName = "statistics"
-- 檢查是否已存在同名的 IntValue
local existingIntValue = targetFolder:FindFirstChild(intValueName)
-- 正確的條件檢查
if not existingIntValue then
    -- 如果不存在，創建新的 IntValue
    local newIntValue = Instance.new("IntValue")
    newIntValue.Name = intValueName -- 設置名稱
    newIntValue.Value = 0 -- 設置初始值
    newIntValue.Parent = targetFolder -- 添加到目標資料夾
--[[
    print("成功創建 IntValue，名稱：" .. intValueName .. "，值：" .. newIntValue.Value)
elseif not existingIntValue:IsA("IntValue") then
    -- 如果名稱相同但類型不同，打印警告
    warn("目標名稱已被其他類型物件佔用：" .. existingIntValue.ClassName)
else
    -- 如果已存在並且類型正確，打印提示
    print("IntValue 已存在，名稱：" .. intValueName .. "，值：" .. existingIntValue.Value)
]]
end

-- ========================================================================== --
-- 00:00(UTC+8) 時執行更新

-- 定時檢查當時間為 UTC+8 的 00:00(遊戲更新時間)
local function checkTimeAndRun()
    spawn(function()
        while true do
            local currentTime = os.time() -- 獲取當前時間戳
            local utcTime = os.date("!*t", currentTime) -- UTC 時間表
            local utcPlus8Time = os.date("*t", currentTime + (8 * 3600)) -- UTC+8 時間表

            if utcPlus8Time.hour == 0 and utcPlus8Time.min == 0 then
                print("UTC+8 時間為 00:00，開始執行更新數據...")
                gamepassmissionnamechange()
				everydatmissionnamechange()
                wait(60) -- 等待 60 秒，避免重複執行
            end

            wait(1) -- 每秒檢查一次
        end
    end)
end

-- 開始定時檢查
checkTimeAndRun()
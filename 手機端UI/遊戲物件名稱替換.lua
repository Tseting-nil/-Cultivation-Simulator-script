local player = game:GetService("Players").LocalPlayer;
local playerGui = player.PlayerGui;
local missionnamelist = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("商店"):WaitForChild("通行证任务"):WaitForChild("背景"):WaitForChild("任务列表")
--任務資料夾初始化名稱
local function gamepassmissionnamechange()
	-- 檢查最終對象是否存在
	if missionnamelist then
	spawn(function()
        for i = 1, 12 do
            local gamepassmissionlist = missionnamelist:FindFirstChild("任务项预制体")
            if gamepassmissionlist then
            	gamepassmissionlist.Name = tostring(i)
            else
                --更新數據
                game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\230\156\136\233\128\154\232\161\140\232\175\129"):FindFirstChild("\232\142\183\229\143\150\230\149\176\230\141\174"):FireServer()
                print("任務--名稱--已全部更改")
            end
        end
	end)
	else
		print("任務--名稱--已重複更改")
    end
end

gamepassmissionnamechange()

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
                wait(60) -- 等待 60 秒，避免重複執行
            end

            wait(1) -- 每秒檢查一次
        end
    end)
end

-- 開始定時檢查
checkTimeAndRun()
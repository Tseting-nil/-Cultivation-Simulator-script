local library = loadstring(game:HttpGet("https://pastebin.com/raw/d40xPN0c", true))()
--獲取重生點
local RespawPoint = loadstring(game:HttpGet('https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/%E9%85%8D%E7%BD%AE%E4%B8%BB%E5%A0%B4%E6%99%AF.lua'))()
--遊戲內部資料夾名稱更改(優先度最高)
--loadstring(game:HttpGet('https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/%E9%81%8A%E6%88%B2%E7%89%A9%E4%BB%B6%E5%90%8D%E7%A8%B1%E6%9B%BF%E6%8F%9B.lua'))()
--任務自動領取--內部包含(遊戲內部資料夾名稱更改)
loadstring(game:HttpGet('https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E4%BB%BB%E5%8B%99%E8%87%AA%E5%8B%95%E9%A0%98%E5%8F%96.lua'))()
--JSON模組
local JsonHandler = loadstring(game:HttpGet('https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/JSON%E6%A8%A1%E7%B5%84.lua'))()

--AFKscript
local AntiAFK = game:GetService("VirtualUser");
game.Players.LocalPlayer.Idled:Connect(function()
	AntiAFK:CaptureController();
	AntiAFK:ClickButton2(Vector2.new());
	wait(2);
	--print("AFK：AFK Bypass");
end);
-- ========================================================================== --
-- 標題
local window = library:AddWindow("Cultivation-Simulator  養成模擬器 -- 手機板UI", {main_color=Color3.fromRGB(41, 74, 122),min_size=Vector2.new(356, 310),can_resize=false});
-- ========================================================================== --
-- 標籤
local features = window:AddTab("自述");
local features1 = window:AddTab("Main");
local features2 = window:AddTab("副本");
local features3 = window:AddTab("地下城");
local features4 = window:AddTab("抽取");
local features5 = window:AddTab("開啟UI");
local features6 = window:AddTab("設定");



-- ========================================================================== --
-- 定義全域函數
local workspace = game:GetService("Workspace")
local player = game:GetService("Players").LocalPlayer
local Players = game.Players
local localPlayer = game.Players.LocalPlayer;
local playerGui = player.PlayerGui;
local RespawPointnum = RespawPoint:match("%d+")
print("重生點編號：".. RespawPointnum)
local reworld = workspace:waitForChild("主場景"..RespawPointnum):waitForChild("重生点")
local TPX ,TPY ,TPZ = reworld.Position.X, reworld.Position.Y + 5, reworld.Position.Z
--(傳送相關)
local Restart = false
local finishworldnum
--遊戲UI
local values = player:WaitForChild("值");
local privileges = values:WaitForChild("特权");


--全域數值定義
local gowordlevels = 1

--特殊定義(安全模式)
local isDetectionEnabled = true
local playerInRange = false
local timescheck = 0
local hasPrintedNoPlayer = false
local savemodetime = 3
local savemodetime2 = 0
local savemodebutton

-- 檢查玩家是否在範圍內
local function checkPlayersInRange()
	local character = localPlayer.Character;
	if (not character or not character:FindFirstChild("HumanoidRootPart")) then
		return;
	end
	local boxPosition = character.HumanoidRootPart.Position;
	local boxSize = Vector3.new(500, 500, 500) / 2;
	playerInRange = false;
	for _, player in pairs(Players:GetPlayers()) do
		if ((player ~= localPlayer) and player.Character and player.Character:FindFirstChild("HumanoidRootPart")) then
			local playerPosition = player.Character.HumanoidRootPart.Position;
			local inRange = (math.abs(playerPosition.X - boxPosition.X) <= boxSize.X) and (math.abs(playerPosition.Y - boxPosition.Y) <= boxSize.Y) and (math.abs(playerPosition.Z - boxPosition.Z) <= boxSize.Z);
			if inRange then
				playerInRange = true;
				break;
			end
		end
	end
	
	if playerInRange then
		if (timescheck == 0) then
			print("有玩家在範圍內");
            savemodetime2 = 2
			savemodetime = 5;
			timescheck = 1;
			hasPrintedNoPlayer = true;
		end
	elseif (timescheck == 1) then
		print("範圍內玩家已離開");
		timescheck = 0;
        savemodetime2 = 0
		hasPrintedNoPlayer = false;
	end
	if (not playerInRange and not hasPrintedNoPlayer) then
		print("範圍內無玩家");
		savemodetime = 3;
        savemodetime2 = 0
		hasPrintedNoPlayer = true;
	end
end
local function setupRangeDetection()
	while true do
		if isDetectionEnabled then
			checkPlayersInRange();
		end
		wait(0.1);
	end
end
local function toggleDetection()
	isDetectionEnabled = not isDetectionEnabled;
	print("檢測已" .. ((isDetectionEnabled and "啟用") or "關閉"));
	if not isDetectionEnabled then
		savemodetime = 3;
        savemodetime2 = 0
	end
end
-- ========================================================================== --
-- -- 特殊定義(任務自動領取)
local function getGiftCountdown(index)
    local gift = Online_Gift:FindFirstChild("Online_Gift" .. index)
    if not gift then return nil end
    local countdownText = gift:FindFirstChild("按钮"):FindFirstChild("倒计时").Text
    if countdownText == "CLAIMED!" then
        return 0
    elseif countdownText == "DONE" then
        -- 執行遠程代碼以領取獎勵
        local args = {
            [1] = index -- 傳遞當前獎勵的索引
        }
        game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\232\138\130\230\151\165\230\180\187\229\138\168"):FindFirstChild("\233\162\134\229\143\150\229\165\150\229\138\177"):FireServer(unpack(args))
        return 0 -- 回傳 0 表示該獎勵已完成
    else
        local minutes, seconds = countdownText:match("^(%d+):(%d+)$")
        if minutes and seconds then
            return tonumber(minutes) * 60 + tonumber(seconds)
        end
    end
    return nil
end

-- 檢查所有禮物倒數計時
local function checkOnlineGiftcountdown()
    -- 初始化變數
    local minCountdown = math.huge
    local Countdown = {}

    -- 獲取每個禮物的倒數計時
    for i = 1, 6 do
        local totalSeconds = getGiftCountdown(i)
        if totalSeconds then
            Countdown[i] = totalSeconds
            OnlineGift_data[i] = totalSeconds
            if totalSeconds < minCountdown and totalSeconds > 0 then
                minCountdown = totalSeconds
            end
        else
            Countdown[i] = nil
        end
    end

    -- 處理本地倒數計時
    if minCountdown ~= math.huge then
        if localCountdownActive then
            for i = 1, 6 do
                if Countdown[i] and Countdown[i] > 0 then
                    Countdown[i] = Countdown[i] - 1
                    local minutes = math.floor(Countdown[i] / 60)
                    local seconds = Countdown[i] % 60
                    local formattedTime = string.format("%02d:%02d", minutes, seconds)
                    Online_Gift:FindFirstChild("Online_Gift" .. i):FindFirstChild("按钮"):FindFirstChild("倒计时").Text = formattedTime
                end
            end
            minCountdown = minCountdown - 1
            --print("使用本地倒數計時，距離下次領取還有：" .. minCountdown .. "秒")
        else
            --print("距離下次領取還有：" .. minCountdown .. "秒")
        end
    end
end
local function chaangeonlinegiftname()
	-- 初始化並更改在線獎勵名稱
	for i = 1, 6 do
		local giftName = "在线奖励0" .. i
		local gift = Online_Gift:FindFirstChild(giftName)
		if gift then
			gift.Name = "Online_Gift" .. tostring(gift.LayoutOrder + 1)
			print("名稱已更改為：" .. gift.Name)
		else
			allGiftsExist = false
			break
		end
	end

	if allGiftsExist then
		print("在線獎勵--名稱--已全部更改")
	else
		print("名稱已重複或部分名稱不存在")
	end
end


local function checkTimeAndRun()
    spawn(function()
        while true do
            local currentTime = os.time() -- 獲取當前時間戳
            local utcTime = os.date("!*t", currentTime) -- UTC 時間表
            local utcPlus8Time = os.date("*t", currentTime + (8 * 3600)) -- UTC+8 時間表

            if utcPlus8Time.hour == 0 and utcPlus8Time.min == 0 then
                print("UTC+8 時間為 00:00，開始執行更新數據...")
				--在線獎勵
				spawn(function()
					allGiftsExist = true
					chaangeonlinegiftname()
					wait(1)
					checkOnlineGiftcountdown()
				end)

				
                wait(60) -- 等待 60 秒，避免重複執行
            end
            wait(1) -- 每秒檢查一次
        end
    end)
end

-- 開始定時檢查
checkTimeAndRun()


-- ========================================================================== --
-- 自述頁
features:Show();
features:AddLabel("作者：澤澤   介面：Elerium v2    版本：手機板");
features:AddLabel("AntiAFK：start");
features:AddLabel("製作時間：2024/09/27");
features:AddLabel("最後更新時間：2025/01/12");
local timeLabel = features:AddLabel("當前時間：00/00/00 00:00:00");
local timezoneLabel = features:AddLabel("時區：UTC+00:00");
local function getFormattedTime()
	return os.date("%Y/%m/%d %H:%M:%S");
end
local function getLocalTimezone()
	local offset = os.date("%z");
	return string.format("UTC%s", offset:sub(1, 3) .. ":" .. offset:sub(4, 5));
end
local function updateLabel()
	timeLabel.Text = "當前時間：" .. getFormattedTime();
	timezoneLabel.Text = "時區：" .. getLocalTimezone();
end
spawn(function()
	while true do
		updateLabel();
		wait(1);
	end
end);
-- 重生點按鈕
local AddLabelfeatures = features:AddLabel("重生點：重生點");
AddLabelfeatures.Text = ("重生點：" .. RespawPoint .." -- 傳送錯誤請回家後使用底下按鈕")
local function Respawn_Point()
    RespawPoint = loadstring(game:HttpGet('https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/%E9%85%8D%E7%BD%AE%E4%B8%BB%E5%A0%B4%E6%99%AF.lua'))()
    AddLabelfeatures.Text = ("重生點：" .. RespawPoint .." -- 傳送錯誤請回家後使用底下按鈕")
    print("最近的出生點：".. RespawPoint)
    RespawPointnum = RespawPoint:match("%d+")
    print("重生點編號：".. RespawPointnum)
    reworld = workspace:waitForChild("主場景"..RespawPointnum):waitForChild("重生点")
    TPX ,TPY ,TPZ = reworld.Position.X, reworld.Position.Y + 5, reworld.Position.Z
    print("傳送座標：".. TPX .." ".. TPY .." ".. TPZ)
    player.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TPX, TPY, TPZ)
end
features:AddButton("重生點更改",function()
	Respawn_Point()
end)

-- 安全模式按鈕
local function updateButtonText()
	if isDetectionEnabled then
		savemodebutton.Text = " 狀態：已啟用安全模式";
	else
		savemodebutton.Text = " 狀態：以關閉安全模式";
	end
end
savemodebutton = features:AddButton(" 狀態：啟用安全模式 ", function()
	inRange = false;
	playerInRange = false;
	timescheck = 0;
	hasPrintedNoPlayer = false;
	toggleDetection();
	updateButtonText();
end);
updateButtonText();
spawn(setupRangeDetection);
-- 創建界面
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- 創建黑色塊
local blackBlock = Instance.new("Frame")
blackBlock.Size = UDim2.new(200, 0, 200, 0)  -- 確保大小是全螢幕
blackBlock.Position = UDim2.new(0, 0, 0, 0)  -- 位置在螢幕的起始點
blackBlock.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
blackBlock.Visible = false  -- 初始時隱藏
blackBlock.Parent = screenGui
features:AddButton("黑幕開/關閉", function()
	blackBlock.Visible = not blackBlock.Visible
end);

-- ========================================================================== --
-- --特殊定義(在線獎勵領取)
local timeLabel = features1:AddLabel("距離下自動獲取還有 0 秒")
local playerGui = game.Players.LocalPlayer.PlayerGui
local Online_Gift = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("节日活动商店"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("在线奖励"):WaitForChild("列表")

local Gife_check = false
local countdownList = {}
local hasExecutedToday = false
local lastExecutedDay = os.date("%d")

-- 將時間格式 (MM:SS) 轉為總秒數
local function convertToSeconds(timeText)
    local minutes, seconds = string.match(timeText, "(%d+):(%d+)")
    if minutes and seconds then
        return (tonumber(minutes) * 60) + tonumber(seconds)
    end
    return nil
end

-- 獲取在線獎勳的最短倒計時
local function GetOnlineGiftCountdown()
    hasExecutedToday = true
    local minTime = math.huge

    for i = 1, 6 do
        local rewardName = string.format("在线奖励%02d", i)
        local rewardFolder = Online_Gift:FindFirstChild(rewardName)
        if rewardFolder then
            local button = rewardFolder:FindFirstChild("按钮")
            local countdown = button and button:FindFirstChild("倒计时")
            if countdown then
                local countdownText = countdown.Text
                countdownList[rewardName] = countdownText

                if string.match(countdownText, "CLAIMED!") then
                    -- 已領取，跳過
                elseif string.match(countdownText, "DONE") then
                    minTime = math.min(minTime, 0)
                elseif string.match(countdownText, "%d+:%d+") then
                    local totalSeconds = convertToSeconds(countdownText)
                    if totalSeconds then
                        minTime = math.min(minTime, totalSeconds)
                    end
                end
            end
        end
    end

    return ((minTime < math.huge) and minTime) or nil
end

local minCountdown = GetOnlineGiftCountdown()
local nowminCountdown = minCountdown

-- 處理在線獎勳的邏輯
local function Online_Gift_start()
    local newMinCountdown = GetOnlineGiftCountdown()
    if newMinCountdown and (newMinCountdown == minCountdown) then
        nowminCountdown = nowminCountdown - 1
    else
        minCountdown = newMinCountdown
        nowminCountdown = minCountdown
    end

    if nowminCountdown and nowminCountdown > 0 then
        timeLabel.Text = string.format("距離下自動獲取還有 %d 秒", nowminCountdown)
    elseif nowminCountdown and nowminCountdown <= 0 then
        timeLabel.Text = "倒計時結束，準備獲取獎勳"
        for i = 1, 6 do
            local args = { [1] = i }
            game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\232\138\130\230\151\165\230\180\187\229\138\168"):FindFirstChild("\233\162\134\229\143\150\229\165\150\229\138\177"):FireServer(unpack(args))
        end
    else
        timeLabel.Text = "已全部領取"
        Gife_check = false
    end
end

-- 不斷檢查獎勳狀態
local function Online_Gift_check()
    while Gife_check do
        Online_Gift_start()
        wait(1)
    end
end

features1:AddButton("自動領取在線獎勳", function()
    Gife_check = true
    spawn(Online_Gift_check)
end)

-- 檢查是否所有獎勳已完成
local function CheckAllRewardsCompleted()
    local allCompleted = true
    GetOnlineGiftCountdown()

    for i = 1, 6 do
        local rewardName = string.format("在线奖励%02d", i)
        local status = countdownList[rewardName]
        if not status or not string.match(status, "DONE") then
            allCompleted = false
            break
        end
    end

    if allCompleted then
        print("所有在線獎勳已完成！")
        Gife_check = false
    end
end

-- 每分鐘檢查一次所有獎勳
spawn(function()
    while Gife_check and not hasExecutedToday do
        CheckAllRewardsCompleted()
        wait(60)
    end
end)

-- 每天凌晨 1 點自動執行一次
spawn(function()
    while true do
        -- 取得當前UTC時間的時數和日期
        local currentUTCHour = tonumber(os.date("!*t").hour)
        local currentUTCDate = os.date("!*t").day
        
        -- 取得當前UTC+8的時數（加上8小時）並判斷是否是當天的00:00
        local currentLocalHour = currentUTCHour + 8
        if currentLocalHour >= 24 then
            currentLocalHour = currentLocalHour - 24  -- 防止時數超過24小時
        end
        
        -- 取得當前本地日期
        local currentLocalDate = currentUTCDate
        if currentLocalHour == 0 then
            -- 如果是UTC+8的00:00，進行重置操作
            if lastExecutedDay ~= currentLocalDate then
                hasExecutedToday = false
                print("UTC+8 00:00，自動領取在線獎勳")
                Gife_check = true
                lastExecutedDay = currentLocalDate
            end
        end
        wait(60)  -- 每60秒檢查一次
    end
end)
-- ========================================================================== --
-- Main頁
local Autocollmission = features1:AddSwitch("自動任務領取(包括GamePass任務)", function(bool)
	Autocollmission = bool;
	if Autocollmission then
		while Autocollmission do
			mainmissionchack()
			everydaymission()
			gamepassmission()
			wait(1)
		end
	end
end);
Autocollmission:Set(false);

local invest = features1:AddSwitch("自動執行投資", function(bool)
	invest = bool;
	if invest then
		while invest do
			for i = 1, 3 do
				local args = {i};
				game:GetService("ReplicatedStorage")["\228\186\139\228\187\182"]["\229\133\172\231\148\168"]["\229\149\134\229\186\151"]["\233\147\182\232\161\140"]["\233\162\134\229\143\150\231\144\134\232\180\162"]:FireServer(unpack(args));
				--print("領取", i);
			end
			wait(5);
			for i = 1, 3 do
				local args = {i};
				game:GetService("ReplicatedStorage")["\228\186\139\228\187\182"]["\229\133\172\231\148\168"]["\229\149\134\229\186\151"]["\233\147\182\232\161\140"]["\232\180\173\228\185\176\231\144\134\232\180\162"]:FireServer(unpack(args));
				--print("投資", i);
			end
			wait(600);
		end
	end
end);
invest:Set(false);

local AutoCollectherbs = features1:AddSwitch("自動採草藥", function(bool)
	AutoCollectherbs = bool;
	if AutoCollectherbs then
		while AutoCollectherbs do
			for i = 1, 6 do
				local args = {[1]=i,[2]=nil};
				game:GetService("ReplicatedStorage")["\228\186\139\228\187\182"]["\229\133\172\231\148\168"]["\229\134\156\231\148\176"]["\233\135\135\233\155\134"]:FireServer(unpack(args));
				wait(0.1)
			end
			wait(60);
		end
	end
end);
AutoCollectherbs:Set(false);

features1:AddLabel(" - - 統計");
features1:AddButton("每秒擊殺/金幣數", function()
	loadstring(game:HttpGet("https://pastebin.com/raw/0NqSi46N"))()
	loadstring(game:HttpGet("https://pastebin.com/raw/HGQXdAiz"))()
end);

features1:AddLabel(" - - 通行證解鎖");
features1:AddButton("解鎖自動煉製", function()
	local superRefining = privileges:WaitForChild("超级炼制");
	superRefining.Value = false;
	local automaticRefining = privileges:WaitForChild("自动炼制");
	automaticRefining.Value = true;
end);
features1:AddButton("背包擴充", function()
	local backpack = privileges:WaitForChild("扩充背包");
	backpack.Value = true;
end);

-- ========================================================================== --
-- 副本頁
-- ========================================================================== --
-- --特殊定義(關卡難易度選擇)
local worldnum = player:WaitForChild("值"):WaitForChild("主线进度"):WaitForChild("world").Value
local newworldnum = worldnum
local function statisticsupdata()
    worldnum = player:WaitForChild("值"):WaitForChild("主线进度"):WaitForChild("world").Value
    --print("當前最高關卡：".. worldnum)
end
spawn(function()
    while true do
        statisticsupdata()
        wait(1)
    end
end)
-- ========================================================================== --
-- --特殊定義傳送(重啟世界)

-- ========================================================================== --
-- 副本頁UI

local Difficulty_choose = features2:AddLabel("  當前選擇： 01");
local Difficulty_selection = features2:AddDropdown("                關卡難易度選擇                ", function(text)
    if text == "      世界關卡簡單： 01       " then
        print("當前選擇：簡單")
        gowordlevels = 1
        Difficulty_choose.Text = "  當前選擇： 01"
    elseif text == "      世界關卡普通： 21       " then
        print("當前選擇：普通")
        gowordlevels = 21
        if gowordlevels > worldnum then
            if gowordlevels < 10 then
                Difficulty_choose.Text = "  關卡未解鎖 關卡： 0"..gowordlevels;
            else
                Difficulty_choose.Text = "  關卡未解鎖 關卡： "..gowordlevels;
            end
        else
            if gowordlevels < 10 then
                Difficulty_choose.Text = "  當前選擇： 0"..gowordlevels;
            else
                Difficulty_choose.Text = "  當前選擇： "..gowordlevels;
            end

        end
    elseif text == "      世界關卡困難： 41       " then
        print("當前選擇：困難")
        gowordlevels = 41
        if gowordlevels > worldnum then
            if gowordlevels < 10 then
                Difficulty_choose.Text = "  關卡未解鎖 關卡： 0"..gowordlevels;
            else
                Difficulty_choose.Text = "  關卡未解鎖 關卡： "..gowordlevels;
            end
        else
            if gowordlevels < 10 then
                Difficulty_choose.Text = "  當前選擇： 0"..gowordlevels;
            else
                Difficulty_choose.Text = "  當前選擇： "..gowordlevels;
            end

        end
    elseif text == "      世界關卡專家： 61       " then
        print("當前選擇：專家")
        gowordlevels = 61
        if gowordlevels > worldnum then
            if gowordlevels < 10 then
                Difficulty_choose.Text = "  關卡未解鎖 關卡： 0"..gowordlevels;
            else
                Difficulty_choose.Text = "  關卡未解鎖 關卡： "..gowordlevels;
            end
        else
            if gowordlevels < 10 then
                Difficulty_choose.Text = "  當前選擇： 0"..gowordlevels;
            else
                Difficulty_choose.Text = "  當前選擇： "..gowordlevels;
            end

        end
    elseif text == "      自動最高關卡        " then
        print("當前選擇：自動最高關卡")
        if worldnum < 10 then
            Difficulty_choose.Text = "  當前選擇最高關卡： 0"..worldnum;
        else
            Difficulty_choose.Text = "  當前選擇最高關卡： "..worldnum;
        end
        gowordlevels = worldnum
        while text == "      自動最高關卡        "  do
            if newworldnum ~= worldnum then
                gowordlevels = worldnum
                newworldnum = worldnum
                finishworldnum = tonumber(gowordlevels)
                if worldnum < 10 then
                    Difficulty_choose.Text = "  當前選擇最高關卡： 0"..gowordlevels;
                    wait(savemodetime2)
                    wait(savemodetime + 1)
                    local args = {[1]=finishworldnum}
                    game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\229\133\179\229\141\161"):FindFirstChild("\232\191\155\229\133\165\228\184\150\231\149\140\229\133\179\229\141\161"):FireServer(unpack(args))     
        
                else
                    Difficulty_choose.Text = "  當前選擇最高關卡： "..gowordlevels;
                    wait(savemodetime2)
                    wait(savemodetime + 1)
                    local args = {[1]=finishworldnum}
                    game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\229\133\179\229\141\161"):FindFirstChild("\232\191\155\229\133\165\228\184\150\231\149\140\229\133\179\229\141\161"):FireServer(unpack(args))        
                end
            end
            wait(1)
        end
    end
end);
local Levels1 = Difficulty_selection:Add("      世界關卡簡單： 01       ")
local Levels2 = Difficulty_selection:Add("      世界關卡普通： 21       ")
local Levels3 = Difficulty_selection:Add("      世界關卡困難： 41       ")
local Levels4 = Difficulty_selection:Add("      世界關卡專家： 61       ")
local Levels5 = Difficulty_selection:Add("      自動最高關卡        ")
local Levels6 = Difficulty_selection:Add("空白")
features2:AddButton("選擇關卡+1", function()
	gowordlevels = gowordlevels + 1
    if gowordlevels < 10 then
        Difficulty_choose.Text = "  當前選擇： 0"..gowordlevels;
    else
        Difficulty_choose.Text = "  當前選擇： "..gowordlevels;
    end
    if gowordlevels > worldnum then
        if gowordlevels < 10 then
            Difficulty_choose.Text = "  關卡未解鎖 關卡： 0"..gowordlevels;
        else
            Difficulty_choose.Text = "  關卡未解鎖 關卡： "..gowordlevels;
        end
    end
end);

features2:AddButton("選擇關卡-1", function()
    gowordlevels = gowordlevels - 1
    if gowordlevels < 1 then
        gowordlevels = 1
        Difficulty_choose.Text = "  自動修正： 關卡 0" .. gowordlevels
    else
        if gowordlevels > worldnum then
            if gowordlevels < 10 then
                Difficulty_choose.Text = "  關卡未解鎖 關卡： 0"..gowordlevels;
            else
                Difficulty_choose.Text = "  關卡未解鎖 關卡： "..gowordlevels;
            end
        else
            if gowordlevels < 10 then
                Difficulty_choose.Text = "  當前選擇： 0"..gowordlevels;
            else
                Difficulty_choose.Text = "  當前選擇： "..gowordlevels;
            end
        end
    end
end);

-- ========================================================================== --
-- --特殊定義(傳送相關)
local combatUI = playerGui.GUI:WaitForChild("主界面"):WaitForChild("战斗"):waitForChild("关卡信息"):waitForChild("文本")
local function teleporttworld1()
    local args = {[1]=gowordlevels};
	game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\229\133\179\229\141\161"):FindFirstChild("\232\191\155\229\133\165\228\184\150\231\149\140\229\133\179\229\141\161"):FireServer(unpack(args));
    print("傳送世界關卡：".. gowordlevels)
end
local function teleporttworld2()
    finishworldnum = tonumber(gowordlevels)
    local args = {[1]=finishworldnum};
	game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\229\133\179\229\141\161"):FindFirstChild("\232\191\155\229\133\165\228\184\150\231\149\140\229\133\179\229\141\161"):FireServer(unpack(args));
    print("重啟世界關卡：".. finishworldnum)
end
local combattext = playerGui.GUI:WaitForChild("主界面"):WaitForChild("战斗"):waitForChild("关卡信息"):waitForChild("文本").Text
local function CheckRestart() --玩家完成關卡後觸發自動傳送
    combattext = playerGui.GUI:WaitForChild("主界面"):WaitForChild("战斗"):waitForChild("关卡信息"):waitForChild("文本").Text
    local worldstring = string.match(combattext, "World")
    finishworldnum = string.match(combattext, "World (%d+)-")-- 關卡數字 1
    local fraction = string.match(combattext, "-(%d+/%d+)")-- 提取關卡完成度
    -- 將分數轉換為小數
    local numerator, denominator = string.match(fraction, "(%d+)/(%d+)")
    local decimal = tonumber(numerator) / tonumber(denominator)
    if decimal == 1 and worldstring then
        --print("完成戰鬥 世界"..finishworldnum)
        Restart = true
    end
end

local function teleporthome()
    wait(savemodetime2)
    --print("傳送座標：".. TPX .." ".. TPY .." ".. TPZ)
    player.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TPX, TPY, TPZ)
end


--[[
local function teleport2()
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local event = replicatedStorage:FindFirstChild("回城", true) -- 遞歸搜尋
    if event and event:IsA("BindableEvent") then
        event:Fire("回城")
    end
end
]]

-- 添加按鈕功能
features2:AddButton("傳送", function()
    game:GetService("Players").LocalPlayer:WaitForChild("值"):WaitForChild("设置"):WaitForChild("自动战斗").Value = true
    teleporttworld1()
end)
features2:AddLabel("⚠️自動開始需能夠完成波次100⚠️")
local Autostart = false;
local Autostart = features2:AddSwitch("戰鬥結束後自動開始(世界戰鬥)", function(bool)
	Autostart = bool;
	if Autostart then
		while Autostart do
            CheckRestart()
            if Restart then
                wait(savemodetime2)
                teleporthome()
                wait(0.5)
                wait(savemodetime)
                teleporttworld2()
                Restart = false
            end
			wait(1)
		end
    end
end);
Autostart:Set(false);

features2:AddButton("掛機模式", function()
	local AFKmod = game:GetService("Players").LocalPlayer:WaitForChild("值"):WaitForChild("设置"):WaitForChild("自动战斗");
	if ( AFKmod.Value == true ) then
		AFKmod.Value = false;
	else
		AFKmod.Value = true;
	end
end)
-- ========================================================================== --
-- 地下城頁

-- ========================================================================== --
-- --特殊定義(地下城相關)
-- JSON本地存取
local httpService = game:GetService("HttpService")
local player = game.Players.LocalPlayer
local filePath = "DungeonsMaxLevel.json"  -- JSON 文件路徑

-- 提取 LocalPlayer 的資料

local function extractLocalPlayerData()
    -- 確保 JSON 文件存在
    if not isfile(filePath) then
        error("JSON 文件不存在：" .. filePath)
    end

    -- 讀取 JSON 文件內容
    local fileContent = readfile(filePath)
    local success, data = pcall(httpService.JSONDecode, httpService, fileContent)
    if not success then
        error("無法解析 JSON 文件：" .. filePath)
    end

    -- 提取 LocalPlayer 的資料
    local localPlayerName = player.Name
    local localPlayerData = data[localPlayerName]
    if not localPlayerData then
        error("LocalPlayer 的資料不存在於 JSON 文件中：" .. localPlayerName)
    end

    return localPlayerData
end

-- 保存為單獨函數
local dungeonFunctions = {}

local function saveDungeonFunctions(playerData)
    for dungeonName, maxLevel in pairs(playerData) do
        local functionName = dungeonName:gsub("MaxLevel", "")  -- 移除 "MaxLevel" 後綴
        dungeonFunctions[functionName] = function()
            return maxLevel
        end
        --print("函數已創建：" .. functionName)
    end
end

-- 更新副本資料並重新設置 dungeonFunctions
local function updateDungeonFunctions()
    -- 重新獲取玩家資料
    local playerData = JsonHandler.getPlayerData(filePath, player.Name)

    -- 清空原來的 dungeonFunctions
    dungeonFunctions = {}

    -- 創建新的 dungeonFunctions
    for dungeonName, maxLevel in pairs(playerData) do
        local functionName = dungeonName:gsub("MaxLevel", "")  -- 移除 "MaxLevel" 後綴
        dungeonFunctions[functionName] = function()
            return maxLevel
        end
        --print("函數已創建：" .. functionName)
    end
end

-- 主程式執行
local success, playerData = pcall(extractLocalPlayerData)
if success then
    saveDungeonFunctions(playerData)
else
    warn("提取資料失敗：" .. tostring(playerData))
end

--[[測試函數
for funcName, func in pairs(dungeonFunctions) do
    print(funcName, "Max Level:", func())  -- 呼叫函數並打印返回值
end
]]--
-- 每秒更新副本最高等級
spawn(function()
    while true do
        local dungeonChoice = playerGui:WaitForChild("GUI"):WaitForChild("二级界面"):WaitForChild("关卡选择"):WaitForChild("副本选择弹出框"):WaitForChild("背景"):WaitForChild("标题"):WaitForChild("名称").Text
        local dungeonMaxLevel = tonumber(playerGui:WaitForChild("GUI"):WaitForChild("二级界面"):WaitForChild("关卡选择"):WaitForChild("副本选择弹出框"):WaitForChild("背景"):WaitForChild("难度"):WaitForChild("难度等级"):WaitForChild("值").Text)
        -- 檢查副本資料是否有更新
        JsonHandler.updateDungeonMaxLevel(filePath, player.Name, dungeonChoice, dungeonMaxLevel)    
        -- 更新 dungeonFunctions 和標籤
        updateDungeonFunctions()
        wait(1)
    end
end)
-- 打印玩家初始資料
local playerData = JsonHandler.getPlayerData(filePath, player.Name)
print("玩家初始資料:")
for key, value in pairs(playerData) do
    print(key, value)
end
local dungeonNum
local Dungeonslist = playerGui:WaitForChild("GUI"):WaitForChild("二级界面"):WaitForChild("关卡选择"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("副本"):WaitForChild("列表")
--獲取副本鑰匙值
local function checkDungeonkey()
-- 获取副本钥匙值并确保小于 10 的数字前加上 0
Ore_Dungeonkey = string.match(Dungeonslist.OreDungeon:WaitForChild("钥匙"):WaitForChild("值").Text, "^%d+")
Gem_Dungeonkey = string.match(Dungeonslist.GemDungeon:WaitForChild("钥匙"):WaitForChild("值").Text, "^%d+")
Gold_Dungeonkey = string.match(Dungeonslist.GoldDungeon:WaitForChild("钥匙"):WaitForChild("值").Text, "^%d+")
Relic_Dungeonkey = string.match(Dungeonslist.RelicDungeon:WaitForChild("钥匙"):WaitForChild("值").Text, "^%d+")
Rune_Dungeonkey = string.match(Dungeonslist.RuneDungeon:WaitForChild("钥匙"):WaitForChild("值").Text, "^%d+")
Hover_Dungeonkey = string.match(Dungeonslist.HoverDungeon:WaitForChild("钥匙"):WaitForChild("值").Text, "^%d+")

-- 确保数字小于 10 的值前加上 0
Ore_Dungeonkey = tonumber(Ore_Dungeonkey) < 10 and string.format("0%d", tonumber(Ore_Dungeonkey)) or Ore_Dungeonkey
Gem_Dungeonkey = tonumber(Gem_Dungeonkey) < 10 and string.format("0%d", tonumber(Gem_Dungeonkey)) or Gem_Dungeonkey
Gold_Dungeonkey = tonumber(Gold_Dungeonkey) < 10 and string.format("0%d", tonumber(Gold_Dungeonkey)) or Gold_Dungeonkey
Relic_Dungeonkey = tonumber(Relic_Dungeonkey) < 10 and string.format("0%d", tonumber(Relic_Dungeonkey)) or Relic_Dungeonkey
Rune_Dungeonkey = tonumber(Rune_Dungeonkey) < 10 and string.format("0%d", tonumber(Rune_Dungeonkey)) or Rune_Dungeonkey
Hover_Dungeonkey = tonumber(Hover_Dungeonkey) < 10 and string.format("0%d", tonumber(Hover_Dungeonkey)) or Hover_Dungeonkey

end
checkDungeonkey()
wait(0.5)
local dropdownchoose
local dropdownchoose2
local dropdown = features3:AddDropdown("選擇地下城", function(text)
	if text == "        礦石地下城      " then
        dropdownchoose = 1
        dropdownchoose2 =  tonumber(dungeonFunctions["OreDungeon"] and dungeonFunctions["OreDungeon"]() or "0")
	elseif text == "        金幣地下城      " then
        dropdownchoose = 2
        dropdownchoose2 =  tonumber(dungeonFunctions["GoldDungeon"] and dungeonFunctions["GoldDungeon"]() or "0")
	elseif text == "        靈石地下城      " then
        dropdownchoose = 3
        dropdownchoose2 =  tonumber(dungeonFunctions["GemDungeon"] and dungeonFunctions["GemDungeon"]() or "0")
    elseif text == "        符石地下城      " then
        dropdownchoose = 4
        dropdownchoose2 =  tonumber(dungeonFunctions["RelicDungeon"] and dungeonFunctions["RelicDungeon"]() or "0")
    elseif text == "        遺物地下城      " then
        dropdownchoose = 5
        dropdownchoose2 =  tonumber(dungeonFunctions["RuneDungeon"] and dungeonFunctions["RuneDungeon"]() or "0")
    elseif text == "        懸浮地下城      " then
        dropdownchoose = 6
        dropdownchoose2 =  tonumber(dungeonFunctions["HoverDungeon"] and dungeonFunctions["HoverDungeon"]() or "0")
	end
end)
local Dungeons1 = dropdown:Add("        礦石地下城      ")
local Dungeons2 = dropdown:Add("        金幣地下城      ")
local Dungeons3 = dropdown:Add("        靈石地下城      ")
local Dungeons4 = dropdown:Add("        符石地下城      ")
local Dungeons5 = dropdown:Add("        遺物地下城      ")
local Dungeons6 = dropdown:Add("        懸浮地下城      ")
local Dungeons7 = dropdown:Add("        活動地下城 -- 未開啟      ")
local Dungeons7 = dropdown:Add("空白")
-- 副本鑰匙標籤
local textLabel1 = features3:AddLabel("礦石副本鑰匙： "..(Ore_Dungeonkey or "0").." 當前選擇難度： "..(dungeonFunctions["OreDungeon"] and dungeonFunctions["OreDungeon"]() or "未知"))
local textLabel2 = features3:AddLabel("金幣副本鑰匙： "..(Gem_Dungeonkey or "0").." 當前選擇難度： "..(dungeonFunctions["GemDungeon"] and dungeonFunctions["GemDungeon"]() or "未知"))
local textLabel3 = features3:AddLabel("靈石副本鑰匙： "..(Gold_Dungeonkey or "0").." 當前選擇難度：  "..(dungeonFunctions["GoldDungeon"] and dungeonFunctions["GoldDungeon"]() or "未知"))
local textLabel4 = features3:AddLabel("符石副本鑰匙： "..(Relic_Dungeonkey or "0").." 當前選擇難度：  "..(dungeonFunctions["RelicDungeon"] and dungeonFunctions["RelicDungeon"]() or "未知"))
local textLabel5 = features3:AddLabel("遺物副本鑰匙： "..(Rune_Dungeonkey or "0").." 當前選擇難度：  "..(dungeonFunctions["RuneDungeon"] and dungeonFunctions["RuneDungeon"]() or "未知"))
local textLabel6 = features3:AddLabel("懸浮地牢鑰匙： "..(Hover_Dungeonkey or "0").." 當前選擇難度：  "..(dungeonFunctions["HoverDungeon"] and dungeonFunctions["HoverDungeon"]() or "未知"))

local function DungeonKeyUpd()
checkDungeonkey()
-- 更新内容
textLabel1.Text = "礦石副本鑰匙：" .. (Ore_Dungeonkey or "0") .. "    當前選擇難度：  " .. (dungeonFunctions["OreDungeon"] and dungeonFunctions["OreDungeon"]() or "未知")
textLabel2.Text = "金幣副本鑰匙：" .. (Gold_Dungeonkey or "0") .. "    當前選擇難度：  " .. (dungeonFunctions["GoldDungeon"] and dungeonFunctions["GoldDungeon"]() or "未知")
textLabel3.Text = "靈石副本鑰匙：" .. (Gem_Dungeonkey or "0") .. "    當前選擇難度：  " .. (dungeonFunctions["GemDungeon"] and dungeonFunctions["GemDungeon"]() or "未知")
textLabel4.Text = "符石副本鑰匙：" .. (Rune_Dungeonkey or "0") .. "    當前選擇難度：  " .. (dungeonFunctions["RuneDungeon"] and dungeonFunctions["RuneDungeon"]() or "未知")
textLabel5.Text = "遺物副本鑰匙：" .. (Relic_Dungeonkey or "0") .. "    當前選擇難度：  " .. (dungeonFunctions["RelicDungeon"] and dungeonFunctions["RelicDungeon"]() or "未知")
textLabel6.Text = "懸浮地牢鑰匙：" .. (Hover_Dungeonkey or "0") .. "    當前選擇難度：  " .. (dungeonFunctions["HoverDungeon"] and dungeonFunctions["HoverDungeon"]() or "未知")
end
local function dungeonNumcheck()
    combattext = playerGui.GUI:WaitForChild("主界面"):WaitForChild("战斗"):WaitForChild("关卡信息"):WaitForChild("文本").Text
    local dungeonName = string.match(combattext, "([%w%s]+)%s%d+-%d+/%d+") 
    if dungeonName == "Ore Dungeon" then
        dungeonNum = string.match(combattext, dungeonName.." (%d+)-")
        dungeonNum = tonumber(dungeonNum)
        dungeonFunctions["OreDungeon"] = dungeonNum + 1
    elseif dungeonName == "Gold Dungeon" then 
        dungeonNum = string.match(combattext, dungeonName.." (%d+)-")
        dungeonNum = tonumber(dungeonNum)
        dungeonFunctions["GoldDungeon"] = dungeonNum + 1
    elseif dungeonName == "Gem Dungeon" then
        dungeonNum = string.match(combattext, dungeonName.." (%d+)-")
        dungeonNum = tonumber(dungeonNum)
        dungeonFunctions["GemDungeon"] = dungeonNum + 1
    elseif dungeonName == "Relic Dungeon" then
        dungeonNum = string.match(combattext, dungeonName.." (%d+)-")
        dungeonNum = tonumber(dungeonNum)
        dungeonFunctions["RelicDungeon"] = dungeonNum + 1
    elseif dungeonName == "Rune Dungeon" then
        dungeonNum = string.match(combattext, dungeonName.." (%d+)-")
        dungeonNum = tonumber(dungeonNum)
        dungeonFunctions["RuneDungeon"] = dungeonNum + 1
    elseif dungeonName == "Hover Dungeon" then
        dungeonNum = string.match(combattext, dungeonName.." (%d+)-")
        dungeonNum = tonumber(dungeonNum)
        dungeonFunctions["HoverDungeon"] = dungeonNum + 1 
    end    
end


spawn(function()
    while true do
        DungeonKeyUpd()
        --dungeonNumcheck()
        wait(1)
    end
end)

local function teleport3()
    local args = {
        [1] = dropdownchoose,
        [2] = dropdownchoose2
    }

    game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\229\137\175\230\156\172"):FindFirstChild("\232\191\155\229\133\165\229\137\175\230\156\172"):FireServer(unpack(args))
end
--[[
features3:AddButton("傳送",function()
	teleport3()
end)

features3:AddButton("選擇難度+1",function()
	dungeonNum = dungeonNum + 1
end)

features3:AddButton("選擇難度-1",function()
	dungeonNum = dungeonNum - 1
end)

]]--


-- ========================================================================== --
-- 抽取頁
-- ========================================================================== --
-- --特殊定義(煉製裝備相關)
local CopyObject = workspace:waitForChild("主場景"..RespawPointnum):waitForChild("建造物"):waitForChild("035炼器台")

local AutoelixirSwitch = features4:AddSwitch("自動煉丹藥", function(bool)
	Autoelixir = bool
	if Autoelixir then
		while Autoelixir do
            game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\231\130\188\228\184\185"):FindFirstChild("\229\136\182\228\189\156"):FireServer()
            wait(0.5)
        end
	end
end)

AutoelixirSwitch:Set(false)

local AutoelixirabsorbSwitch = features4:AddSwitch("自動吸收丹藥（⚠️背包裡面所有的丹藥⚠️）", function(bool)
	Autoelixirabsorb = bool
	if Autoelixirabsorb then
		while Autoelixirabsorb do
            game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\228\184\185\232\141\175"):FindFirstChild("\229\144\184\230\148\182\229\133\168\233\131\168"):FireServer()
            wait(0.7)
        end
	end
end)

AutoelixirabsorbSwitch:Set(false)

-- ========================================================================== --
-- --特殊定義(抽獎相關)
--抽獎相關
local lottery =playerGui.GUI:WaitForChild("二级界面"):WaitForChild("商店"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("召唤")
local currency = player:WaitForChild("值"):WaitForChild("货币")
local diamonds = currency:WaitForChild("钻石")
--法寶UI
local sword = lottery:WaitForChild("法宝"):WaitForChild("等级区域")
local sword_level = sword:WaitForChild("值").text
local sword_value = sword:WaitForChild("进度条"):WaitForChild("值"):WaitForChild("值").text
--技能UI
local skill = lottery:WaitForChild("技能"):WaitForChild("等级区域")
local skill_level = skill:WaitForChild("值").text
local skill_value = skill:WaitForChild("进度条"):WaitForChild("值"):WaitForChild("值").text
--抽獎卷UI
local sword_tickets = currency:WaitForChild("法宝抽奖券").value
local skill_tickets = currency:WaitForChild("技能抽奖券").value
--單一向定義
local extract_sword_level  --抽獎相關
local extract_sword_value  --抽獎相關
local extract_skill_level  --抽獎相關
local extract_skill_value  --抽獎相關
local useDiamonds = false --抽獎相關
local Autolotteryspeed = 0.2

local function usesword_ticket()
    print("抽獎：法寶")
    local args = {
        [1] = "\230\179\149\229\174\157",
        [2] = false
    }

    game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild(
        "\229\133\172\231\148\168"
    ):FindFirstChild("\229\149\134\229\186\151"):FindFirstChild("\229\143\172\229\148\164"):FindFirstChild(
        "\230\138\189\229\165\150"
    ):FireServer(unpack(args))
end
local function useskill_ticket()
    print("抽獎：技能")
    local args = {
        [1] = "\230\138\128\232\131\189",
        [2] = false
    }
    game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild(
        "\229\133\172\231\148\168"
    ):FindFirstChild("\229\149\134\229\186\151"):FindFirstChild("\229\143\172\229\148\164"):FindFirstChild(
        "\230\138\189\229\165\150"
    ):FireServer(unpack(args))
end

-- 配置參數
local MIN_TICKETS = 8 -- 最低抽獎券需求
local DIAMONDS_PER_TICKET = 50 -- 每張抽獎券需要的鑽石數量

-- 判斷是否可以使用抽獎券或鑽石補充
local function checkTicketsAndDiamonds(tickets, diamonds, itemType, useDiamonds)
    if tickets >= MIN_TICKETS then
        --print(itemType .. "抽獎券足夠")
        return true
    end

    -- 計算缺少的抽獎券
    local missingTickets = MIN_TICKETS - tickets
    --print(itemType .. "抽獎券不足，需要補充 " .. missingTickets .. " 張")

    if not useDiamonds then
        --print(itemType .. "未啟用鑽石補充")
        return false
    end

    -- 計算補充所需的鑽石數量
    local requiredDiamonds = missingTickets * DIAMONDS_PER_TICKET
    if diamonds >= requiredDiamonds then
        --print("鑽石足夠，將使用 " .. requiredDiamonds .. " 鑽石補充 " .. missingTickets .. " 張抽獎券")
        return true
    else
        --print("鑽石不足，無法補充")
        return false
    end
end

-- 自動抽獎邏輯
local function processLottery(type, tickets, diamonds, useDiamonds)
    local canProceed = checkTicketsAndDiamonds(tickets, diamonds, type, useDiamonds)
    if canProceed then
        --print("執行抽獎：" .. type)
        if type == "法寶" then
            usesword_ticket()
        elseif type == "技能" then
            useskill_ticket()
        end
    else
        --print(type .. "條件未滿足，抽獎失敗")
    end
    return canProceed
end

-- 比較抽獎邏輯
local function compare_ticket_type(sword_tickets,skill_tickets,sword_level,skill_level,sword_value,skill_value,diamonds,useDiamonds)
    if sword_level == skill_level then
        if sword_value > skill_value then
            --print("法寶進度 > 技能進度，優先使用技能抽獎券")
            processLottery("技能", skill_tickets, diamonds, useDiamonds)
        elseif sword_value < skill_value then
            --print("法寶進度 < 技能進度，優先使用法寶抽獎券")
            processLottery("法寶", sword_tickets, diamonds, useDiamonds)
        else
            --print("法寶進度 = 技能進度，同時使用")
            local canSword = processLottery("法寶", sword_tickets, diamonds, useDiamonds)
            local canSkill = processLottery("技能", skill_tickets, diamonds, useDiamonds)
            if not canSword and not canSkill then
            --print("兩種抽獎券均不足，無法使用抽獎券")
            end
        end
    elseif sword_level > skill_level then
        --print("法寶等級 > 技能等級，優先使用技能抽獎券")
        processLottery("技能", skill_tickets, diamonds, useDiamonds)
    else
        --print("法寶等級 < 技能等級，優先使用法寶抽獎券")
        processLottery("法寶", sword_tickets, diamonds, useDiamonds)
    end
end




-- 數據提取函數
local function fetchData()
    sword_level = sword:WaitForChild("值").Text
    sword_value = sword:WaitForChild("进度条"):WaitForChild("值"):WaitForChild("值").Text
    skill_level = skill:WaitForChild("值").Text
    skill_value = skill:WaitForChild("进度条"):WaitForChild("值"):WaitForChild("值").Text
    sword_tickets = currency:WaitForChild("法宝抽奖券").Value
    skill_tickets = currency:WaitForChild("技能抽奖券").Value
    diamonds = currency:WaitForChild("钻石").Value
end
fetchData()

features4:AddLabel("⚠️同步抽取，抽獎券不足就會停止，請開啟鑽石抽取")
local lotterynum =  features4:AddLabel("法寶抽獎券： " .. sword_tickets .. "    技能抽獎券： " .. skill_tickets)


local function updateExtractedValues()
    fetchData()
    extract_sword_level = tonumber(string.match(sword_level, "%d+"))
    extract_sword_value = tonumber(string.match(sword_value, "^(%d+)/"))
    extract_skill_level = tonumber(string.match(skill_level, "%d+"))
    extract_skill_value = tonumber(string.match(skill_value, "^(%d+)/"))
    lotterynum.Text = "法寶抽獎券： " .. sword_tickets .. "    技能抽獎券： " .. skill_tickets
end

spawn(function()
    while true do
        updateExtractedValues()
        wait(1)
    end
end)

local AutolotterySwitch = features4:AddSwitch("自動抽法寶/技能", function(bool)
	Autolottery = bool
	if Autolottery then
		while Autolottery do
            updateExtractedValues()
            wait(Autolotteryspeed)
            compare_ticket_type(sword_tickets,skill_tickets,extract_sword_level,extract_skill_level,extract_sword_value,extract_skill_value,diamonds,useDiamonds)
        end
	end
end)

AutolotterySwitch:Set(false)

-- 啟用鑽石補充功能
local USEDiamondSwitch = features4:AddSwitch("啟用鑽石抽取", function(bool)
	useDiamonds = bool
end)

USEDiamondSwitch:Set(false)
features4:AddButton("抽取速度快",function()
	Autolotteryspeed = 0
end)
features4:AddButton("抽取速度慢",function()
	Autolotteryspeed = 0.5
end)


-- ========================================================================== --
-- UI頁
local replicatedStorage = game:GetService("ReplicatedStorage")
features5:AddButton("開啟每日任務",function()
    local event = replicatedStorage:FindFirstChild("打开每日任务", true) -- 遞歸搜尋
    if event and event:IsA("BindableEvent") then
        event:Fire("打開每日任務")
    end
end)
features5:AddButton("開啟郵件",function()
    local event = replicatedStorage:FindFirstChild("打开邮件", true) -- 遞歸搜尋
    if event and event:IsA("BindableEvent") then
        event:Fire("打开郵件")
    end
end)
features5:AddButton("開啟轉盤",function()
    local event = replicatedStorage:FindFirstChild("打开转盘", true) -- 遞歸搜尋
    if event and event:IsA("BindableEvent") then
        event:Fire("打開轉盤")
    end
end)
features5:AddButton("開啟陣法",function()
    local event = replicatedStorage:FindFirstChild("打开阵法", true) -- 遞歸搜尋
    if event and event:IsA("BindableEvent") then
        event:Fire("打开陣法")
    end
end)
features5:AddButton("開啟世界樹",function()
    local event = replicatedStorage:FindFirstChild("打开世界树", true) -- 遞歸搜尋
    if event and event:IsA("BindableEvent") then
        event:Fire("打開世界樹")
    end
end)
features5:AddButton("開啟練器台",function()
    local event = replicatedStorage:FindFirstChild("打开炼器台", true) -- 遞歸搜尋
    if event and event:IsA("BindableEvent") then
        event:Fire("打開練器台")
    end
end)
features5:AddButton("開啟煉丹爐",function()
    local event = replicatedStorage:FindFirstChild("打开炼丹炉", true) -- 遞歸搜尋
    if event and event:IsA("BindableEvent") then
        event:Fire("打開煉丹爐")
    end
end)

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/imgui_en%E9%9D%A2%E6%9D%BF.lua", true))()
--獲取重生點
local RespawPoint = loadstring(game:HttpGet('https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/%E9%85%8D%E7%BD%AE%E4%B8%BB%E5%A0%B4%E6%99%AF.lua'))()
--遊戲內部資料夾名稱更改(優先度最高)
--loadstring(game:HttpGet('https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/%E9%81%8A%E6%88%B2%E7%89%A9%E4%BB%B6%E5%90%8D%E7%A8%B1%E6%9B%BF%E6%8F%9B.lua'))()
--任務自動領取--內部包含(遊戲內部資料夾名稱更改)
loadstring(game:HttpGet('https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/%E4%BB%BB%E5%8B%99%E8%87%AA%E5%8B%95%E9%A0%98%E5%8F%96.lua'))()
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
local window = library:AddWindow("Cultivation-Simulator script ", {main_color=Color3.fromRGB(41, 74, 122),min_size=Vector2.new(408, 335),can_resize=false});
-- ========================================================================== --
-- 標籤
local features = window:AddTab("Rdme");
local features1 = window:AddTab("Main");
local features2 = window:AddTab("World");
local features3 = window:AddTab("Dungeons");
local features4 = window:AddTab("Pull");
local features5 = window:AddTab("Misc");
local features6 = window:AddTab("UI");
local features7 = window:AddTab("Set");

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
            showNotification("somepeople in range");
            savemodetime2 = 2
			savemodetime = 5;
			timescheck = 1;
			hasPrintedNoPlayer = true;
		end
	elseif (timescheck == 1) then
		print("範圍內玩家已離開");
        showNotification("player out of range");
		timescheck = 0;
        savemodetime2 = 0
		hasPrintedNoPlayer = false;
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
features:AddLabel("Author： Tseting-nil  |  Version：V4.4.2");
features:AddLabel("AntiAFK：Start");
features:AddLabel("Created on： 2024/09/27");
features:AddLabel("Last Updated： 2025/03/29");
local timeLabel = features:AddLabel("Current Time： 00/00/00 00:00:00");
local timezoneLabel = features:AddLabel("Time Zone： UTC+00:00");
local function getFormattedTime()
	return os.date("%Y/%m/%d %H:%M:%S");
end
local function getLocalTimezone()
	local offset = os.date("%z");
	return string.format("UTC%s", offset:sub(1, 3) .. ":" .. offset:sub(4, 5));
end
local function updateLabel()
	timeLabel.Text = "Current Time：" .. getFormattedTime();
	timezoneLabel.Text = "Time Zone：" .. getLocalTimezone();
end
spawn(function()
	while true do
		updateLabel();
		wait(1);
	end
end);
-- 重生點按鈕
local AddLabelfeatures = features:AddLabel("重生點：重生點");
AddLabelfeatures.Text = ("重生點：" .. RespawPoint .." -- If TP Error.Return home and Use TP FIX button")
local function Respawn_Point()
    RespawPoint = loadstring(game:HttpGet('https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/%E9%85%8D%E7%BD%AE%E4%B8%BB%E5%A0%B4%E6%99%AF.lua'))()
    AddLabelfeatures.Text = ("重生點：" .. RespawPoint .." -- If TP Error.Return home and Use TP FIX button")
    print("最近的出生點：".. RespawPoint)
    RespawPointnum = RespawPoint:match("%d+")
    print("重生點編號：".. RespawPointnum)
    reworld = workspace:waitForChild("主場景"..RespawPointnum):waitForChild("重生点")
    TPX ,TPY ,TPZ = reworld.Position.X, reworld.Position.Y + 5, reworld.Position.Z
    print("傳送座標：".. TPX .." ".. TPY .." ".. TPZ)
    player.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(TPX, TPY, TPZ)
end
features:AddButton("TP FIX",function()
	Respawn_Point()
end)

-- 安全模式按鈕
local function updateButtonText()
	if isDetectionEnabled then
		savemodebutton.Text = "Status：Safe Mode Enabled";
        showNotification("Safe Mode Enabled");
	else
		savemodebutton.Text = "Status：Safe Mode Disabled";
        showNotification("Safe Mode Disabled");
	end
end
savemodebutton = features:AddButton("Status：Safe Mode Enabled ", function()
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
features:AddButton("Black Screen: On/Off", function()
	blackBlock.Visible = not blackBlock.Visible
end);

-- ========================================================================== --
-- --特殊定義(在線獎勵領取)
local timeLabel = features1:AddLabel("Time until auto-fetch: 0 seconds")
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
        timeLabel.Text = string.format("Time until auto-fetch: %d seconds", nowminCountdown)
    elseif nowminCountdown and nowminCountdown <= 0 then
        timeLabel.Text = "Countdown complete, preparing to receive rewards"
        for i = 1, 6 do
            local args = { [1] = i }
            game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\232\138\130\230\151\165\230\180\187\229\138\168"):FindFirstChild("\233\162\134\229\143\150\229\165\150\229\138\177"):FireServer(unpack(args))
        end
    else
        timeLabel.Text = "All rewards collected"
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

features1:AddButton("Auto-collect online rewards", function()
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
        print("All online rewards have been collected！")
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
local Autocollmission = features1:AddSwitch("Auto-collect tasks (GamePass tasks and Gift)", function(bool)
	Autocollmissionbool = bool;
	if Autocollmissionbool then
        spawn(function()
            while Autocollmissionbool do
                mainmissionchack()
                everydaymission()
                gamepassmission()
                gamepassgiftget()
                wait(1)
            end
        end)
	end
end);
Autocollmission:Set(false);

local invest = features1:AddSwitch("Auto-execute investments", function(bool)
	investbool = bool;
	if investbool then
        spawn(function()
		while investbool do
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
    end)
	end
end);
invest:Set(false);

local AutoCollectherbs = features1:AddSwitch("Auto-harvest herbs", function(bool)
	AutoCollectherbsbool = bool;
	if AutoCollectherbsbool then
        spawn(function()
            while AutoCollectherbsbool do
                for i = 1, 6 do
                    local args = {[1]=i,[2]=nil};
                    game:GetService("ReplicatedStorage")["\228\186\139\228\187\182"]["\229\133\172\231\148\168"]["\229\134\156\231\148\176"]["\233\135\135\233\155\134"]:FireServer(unpack(args));
                    wait(0.1)
                end
                wait(60);
            end
        end)
	end
end);
AutoCollectherbs:Set(false);

features1:AddLabel("- - GamePass Unlock");
local Refining = features1:AddSwitch("Unlock Auto-Crafting", function(bool)
	local Refiningbool = bool;
    privileges:WaitForChild("超级炼制").Value = false;
    privileges:WaitForChild("自动炼制").Value = Refiningbool;
end);
Refining:Set(true);

local showAll = features1:AddSwitch("Show all Currencies", function(bool)
	ShowAllbool = bool;
	if ShowAllbool then
        while ShowAllbool do
            --活動物品
            game:GetService("Players").LocalPlayer.PlayerGui.GUI["\228\184\187\231\149\140\233\157\162"]["\228\184\187\229\159\142"]["\232\180\167\229\184\129\229\140\186\229\159\159"]["\230\180\187\229\138\168\231\137\169\229\147\129"].Visible = true
            --礦石
            game:GetService("Players").LocalPlayer.PlayerGui.GUI["\228\184\187\231\149\140\233\157\162"]["\228\184\187\229\159\142"]["\232\180\167\229\184\129\229\140\186\229\159\159"]["\231\159\191\231\159\179"].Visible = false
            --符文粉末
            game:GetService("Players").LocalPlayer.PlayerGui.GUI["\228\184\187\231\149\140\233\157\162"]["\228\184\187\229\159\142"]["\232\180\167\229\184\129\229\140\186\229\159\159"]["\231\172\166\231\159\179\231\178\137\230\156\171"].Visible = true
            --等級
            game:GetService("Players").LocalPlayer.PlayerGui.GUI["\228\184\187\231\149\140\233\157\162"]["\228\184\187\229\159\142"]["\232\180\167\229\184\129\229\140\186\229\159\159"]["\231\173\137\231\186\167"].Visible = true
            --紫色鑽石
            game:GetService("Players").LocalPlayer.PlayerGui.GUI["\228\184\187\231\149\140\233\157\162"]["\228\184\187\229\159\142"]["\232\180\167\229\184\129\229\140\186\229\159\159"]["\231\180\171\233\146\187"].Visible = true
            --草藥
            game:GetService("Players").LocalPlayer.PlayerGui.GUI["\228\184\187\231\149\140\233\157\162"]["\228\184\187\229\159\142"]["\232\180\167\229\184\129\229\140\186\229\159\159"]["\232\141\137\232\141\175"].Visible = false
            --金幣
            game:GetService("Players").LocalPlayer.PlayerGui.GUI["\228\184\187\231\149\140\233\157\162"]["\228\184\187\229\159\142"]["\232\180\167\229\184\129\229\140\186\229\159\159"]["\233\135\145\229\184\129"].Visible = true
            --鑽石
            game:GetService("Players").LocalPlayer.PlayerGui.GUI["\228\184\187\231\149\140\233\157\162"]["\228\184\187\229\159\142"]["\232\180\167\229\184\129\229\140\186\229\159\159"]["\233\146\187\231\159\179"].Visible = true
            wait(0.3)
        end
	end
end);
showAll:Set(false);

features1:AddButton("Remove the display of the reward",function()
    local target1 = playerGui.GUI:WaitForChild("二级界面"):FindFirstChild("展示奖励界面")
    if target1 then
        target1:Destroy()
        print("成功刪除 UI 元件")
    else
        print("已刪除過")
    end
end)
features1:AddButton("Redeem Game Code",function()
    local gamecode = {"ilovethisgame", "welcome", "30klikes", "40klikes", "halloween", "artistkapouki", "45klikes", "60klikes"}
    for i = 1, #gamecode do
        print(gamecode[i])
        local args = {
            [1] = gamecode[i]
        }
        game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\230\191\128\230\180\187\231\160\129"):FindFirstChild("\231\142\169\229\174\182\229\133\145\230\141\162\230\191\128\230\180\187\231\160\129"):FireServer(unpack(args))     
    end
end)
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

local Difficulty_choose = features2:AddLabel("Current Selection： 01");
local function gowordlevelscheak(gowordlevels)
    if gowordlevels > worldnum then
        if gowordlevels < 10 then
            Difficulty_choose.Text = "Level Not Unlocked： 0"..gowordlevels;
        else
            Difficulty_choose.Text = "Level Not Unlocked： "..gowordlevels;
        end
    else
        if gowordlevels < 10 then
            Difficulty_choose.Text = "Current Selection： 0"..gowordlevels;
        else
            Difficulty_choose.Text = "Current Selection： "..gowordlevels;
        end
    end
end
local Difficulty_selection = features2:AddDropdown("                Difficulty Level Selection                ", function(text)
    if text == "  World ： 01 .. Easy" then
        print("World ： 01")
        gowordlevels = 1
        Difficulty_choose.Text = "Current Selection： 01"
    elseif text == "  World ： 21 .. Normal" then
        print("World ： 21")
        gowordlevels = 21
        gowordlevelscheak(gowordlevels)
    elseif text == "  World ： 41 .. Hard" then
        print("World ： 41")
        gowordlevels = 41
        gowordlevelscheak(gowordlevels)
    elseif text == "  World ： 61 .. Expert" then
        print("World ： 61")
        gowordlevels = 61
        gowordlevelscheak(gowordlevels)
    elseif text == "  World ： 81 .. Master" then
        print("World ： 81")
        gowordlevels = 81
        gowordlevelscheak(gowordlevels)
    elseif text == "  World ： 101" then
        print("World ： 101")
        gowordlevels = 101
        gowordlevelscheak(gowordlevels)
    elseif text == "  Auto Max Choose" then
        local showone = false;
        print("Current Selection: Auto Max Level");
    
        if (worldnum < 10) then
            Difficulty_choose.Text = "Current Selection Max Level: 0"..worldnum;
        else
            Difficulty_choose.Text = "Current Selection Max Level: "..worldnum;
        end
        gowordlevels = worldnum;
    
        while true do
            local Difficulty_choose_Text = string.match(Difficulty_choose.Text, "Current Selection Max Level");
    
            if (Difficulty_choose_Text ~= "Current Selection Max Level") then
                showone = false;
                print("Auto Max Level has stopped");
                break;
            elseif not showone then
                print("Auto Max Level has started");
                showone = true;
            end
    
            if (newworldnum ~= worldnum) then
                gowordlevels = worldnum;
                newworldnum = worldnum;
                finishworldnum = tonumber(gowordlevels);
                if (worldnum < 10) then
                    Difficulty_choose.Text = "  Current Selection Max Level: 0" .. gowordlevels;
                else
                    Difficulty_choose.Text = "  Current Selection Max Level: " .. gowordlevels;
                end
                wait(savemodetime2);
                wait(savemodetime + 1);
                local args = {[1]=finishworldnum};
                game:GetService("ReplicatedStorage"):FindFirstChild("LevelData"):FindFirstChild("MaxLevel"):FireServer(unpack(args));
            end
            wait(1);
        end
    end    
end);
local Levels1 = Difficulty_selection:Add("  World ： 01 .. Easy")
local Levels2 = Difficulty_selection:Add("  World ： 21 .. Normal")
local Levels3 = Difficulty_selection:Add("  World ： 41 .. Hard")
local Levels4 = Difficulty_selection:Add("  World ： 61 .. Expert")
local Levels5 = Difficulty_selection:Add("  World ： 81 .. Master")
--local Levels6 = Difficulty_selection:Add("  World ： 101")
local Levels99 = Difficulty_selection:Add("  Auto Max Choose")
local Levels999 = Difficulty_selection:Add(" ... ")
features2:AddButton("Select level +1", function()
	gowordlevels = gowordlevels + 1
    gowordlevelscheak(gowordlevels)
end);

features2:AddButton("Select level -1", function()
    gowordlevels = gowordlevels - 1
    gowordlevelscheak(gowordlevels)
end);

-- ========================================================================== --
-- --特殊定義(傳送相關)
local decimal = 0
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
local function CheckRestart() --玩家完成關卡後觸發自動傳送
    local combattext = playerGui.GUI:WaitForChild("主界面"):WaitForChild("战斗"):waitForChild("关卡信息"):waitForChild("文本").Text
    local worldstring = string.match(combattext, "World")
    finishworldnum = string.match(combattext, "World (%d+)-")-- 關卡數字 1
    local fraction = string.match(combattext, "-(%d+/%d+)")-- 提取關卡完成度
    -- 將分數轉換為小數
    if fraction then
        local numerator, denominator = string.match(fraction, "(%d+)/(%d+)")
        decimal = tonumber(numerator) / tonumber(denominator)
        if decimal == 1 and worldstring and Autostartwarld then
            --print("完成戰鬥 世界"..finishworldnum)
            Restart = true
        end
        if decimal >= 0.7 and worldstring and Autostar2twarld  then
            Restart = true
        end
        --print(worldstring ..",".. numerator.."," .. denominator.."," .. decimal )
        if Autostartwarld and Autostar2twarld then
            showNotification("Both modes turned on will only execute Endless Battle")
        end
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
features2:AddButton("TP", function()
    teleporttworld1()
end)
features2:AddLabel("!! Auto-start requires the ability to complete wave 100")
local Autostart = features2:AddSwitch("Auto-start After Battle (World Battle)", function(bool)
    Autostartwarld = bool
    if Autostartwarld then
        while Autostartwarld do
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
end)
Autostart:Set(false);

local Autostart2 = features2:AddSwitch("Endless Battle(Wave > 70)", function(bool)
    Autostar2twarld = bool
    if Autostar2twarld then
        while Autostar2twarld do
            CheckRestart()
            if Restart and not hasPrintedNoPlayer then
                print("Endless battle begins, no players nearby")
                teleporttworld2()
                Restart = false
            elseif Restart and hasPrintedNoPlayer and decimal == 1 then
                print("Endless battle begins, there are players nearby, execute normal mode")
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
end)

Autostart2:Set(false);

features2:AddButton("AFK Mode", function()
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
local updDungeonui = false
local AutoDungeonplus1 = false
local Notexecuted = true
local AutoDungeonplusonly = false
local Autofinishdungeon = false
local dungeonFunctions = {} -- 用於存放動態生成的副本函數

-- 提取 LocalPlayer 的資料
local function extractLocalPlayerData()
    -- 確保 JSON 文件存在並讀取內容
    if not isfile(filePath) then
        error("JSON 文件不存在：" .. filePath)
    end

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

-- 創建 Dungeon 函數
local function saveDungeonFunctions(playerData)
    for dungeonName, maxLevel in pairs(playerData) do
        -- 將 "MaxLevel" 後綴移除，作為函數名稱
        local functionName = dungeonName:gsub("MaxLevel", "")
        dungeonFunctions[functionName] = function()
            return maxLevel
        end
    end
end

-- 更新副本資料並重新設置 Dungeon 函數
local function updateDungeonFunctions()
    -- 重新獲取玩家資料
    local playerData = JsonHandler.getPlayerData(filePath, player.Name)

    -- 清空原來的 Dungeon 函數
    dungeonFunctions = {}

    -- 創建新的 Dungeon 函數
    saveDungeonFunctions(playerData)
end

-- 主程式執行
local function main()
    local success, playerData = pcall(extractLocalPlayerData)
    if success then
        saveDungeonFunctions(playerData)
        print("Dungeon 函數已成功創建")
    else
        warn("提取資料失敗：" .. tostring(playerData))
    end
end

-- 初始化執行
main()

-- 測試 Dungeon 函數
--[[
for functionName, dungeonFunc in pairs(dungeonFunctions) do
    print("副本名稱:", functionName, "等級:", dungeonFunc())
end
]]--

-- JSON每秒更新副本UI選擇的值等級
spawn(function()
    while true do
        if updDungeonui then
            local dungeonChoice = playerGui:WaitForChild("GUI"):WaitForChild("二级界面"):WaitForChild("关卡选择"):WaitForChild("副本选择弹出框"):WaitForChild("背景"):WaitForChild("标题"):WaitForChild("名称").Text
            local dungeonMaxLevel = tonumber(playerGui:WaitForChild("GUI"):WaitForChild("二级界面"):WaitForChild("关卡选择"):WaitForChild("副本选择弹出框"):WaitForChild("背景"):WaitForChild("难度"):WaitForChild("难度等级"):WaitForChild("值").Text)
            -- 檢查副本資料是否有更新
            JsonHandler.updateDungeonMaxLevel(filePath, player.Name, dungeonChoice, dungeonMaxLevel)    
            -- 更新 dungeonFunctions 和標籤
            updateDungeonFunctions()
        end
    wait(1)
    end
end)
-- 打印玩家初始資料
local playerData = JsonHandler.getPlayerData(filePath, player.Name)
print("玩家初始資料:")
for key, value in pairs(playerData) do
    print(key, value)
end

local Dungeonslist = playerGui:WaitForChild("GUI"):WaitForChild("二级界面"):WaitForChild("关卡选择"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("副本"):WaitForChild("列表")
local dropdownchoose = 0
local dropdownchoose2 = "1"
local dropdownchoose3 = 0
-- 獲取副本鑰匙值的通用函數
local function getDungeonKey(dungeonName)
    local dungeon = Dungeonslist:FindFirstChild(dungeonName)
    if dungeon then
        local keyText = dungeon:WaitForChild("钥匙"):WaitForChild("值").Text
        local key = tonumber(string.match(keyText, "^%d+"))
        if key then
            return key < 10 and string.format("0%d", key) or tostring(key)
        end
    end
    return nil
end

-- 獲取所有副本鑰匙值
local function checkDungeonkey()
    Ore_Dungeonkey = getDungeonKey("OreDungeon")
    Gem_Dungeonkey = getDungeonKey("GemDungeon")
    Gold_Dungeonkey = getDungeonKey("GoldDungeon")
    Relic_Dungeonkey = getDungeonKey("RelicDungeon")
    Rune_Dungeonkey = getDungeonKey("RuneDungeon")
    Hover_Dungeonkey = getDungeonKey("HoverDungeon")
end
checkDungeonkey()

local chooselevels = features3:AddLabel("Dungeon Selection ...")


-- 初始化下拉選單
local dropdown1 = features3:AddDropdown("Dungeon Selection ...", function(text)
    if     text == ("    OreDungeon    ") then
        dropdownchoose = 1
        dropdownchoose2 = tostring(dungeonFunctions["OreDungeon"] and dungeonFunctions["OreDungeon"]() or "0")
        chooselevels.Text = " OreDungeon,  Key："..Ore_Dungeonkey.. "  ,Level："..dropdownchoose2
    elseif text == ("    GemDungeon    ") then
        dropdownchoose = 2
        dropdownchoose2 = tostring(dungeonFunctions["GemDungeon"] and dungeonFunctions["GemDungeon"]() or "0")
        chooselevels.Text = " GemDungeon,  Key："..Gem_Dungeonkey.. "  ,Level："..dropdownchoose2
    elseif text == ("    RuneDungeon    ") then
        dropdownchoose = 3
        dropdownchoose2 = tostring(dungeonFunctions["RuneDungeon"] and dungeonFunctions["RuneDungeon"]() or "0")        
        chooselevels.Text = " RuneDungeon,  Key："..Rune_Dungeonkey.. "  ,Level："..dropdownchoose2
    elseif text == ("    RelicDungeon    ") then        
        dropdownchoose = 4  
        dropdownchoose2 = tostring(dungeonFunctions["RelicDungeon"] and dungeonFunctions["RelicDungeon"]() or "0")
        chooselevels.Text = " RelicDungeon,  Key："..Relic_Dungeonkey.. "  ,Level："..dropdownchoose2
    elseif text == ("    HoverDungeon    ") then
        dropdownchoose = 7
        dropdownchoose2 = tostring(dungeonFunctions["HoverDungeon"] and dungeonFunctions["HoverDungeon"]() or "0")
        chooselevels.Text = " HoverDungeon,  Key："..Hover_Dungeonkey.. "  ,Level："..dropdownchoose2
    elseif text == ("    GoldDungeon    ") then
        dropdownchoose = 6
        dropdownchoose2 = tostring(dungeonFunctions["GoldDungeon"] and dungeonFunctions["GoldDungeon"]() or "0")
        chooselevels.Text = " GoldDungeon,  Key："..Gold_Dungeonkey.. "  ,Level："..dropdownchoose2
    elseif text == ("    Event Dungeon...Not open    ") then
        dropdownchoose = 5
        dropdownchoose2 = "未開啟"
        chooselevels.Text = "當前選擇：活動地下城  未開啟"
    end
end)

local Dungeon1 = dropdown1:Add("    OreDungeon    ")
local Dungeon2 = dropdown1:Add("    GemDungeon    ")
local Dungeon3 = dropdown1:Add("    RuneDungeon    ")
local Dungeon4 = dropdown1:Add("    RelicDungeon    ")
local Dungeon5 = dropdown1:Add("    HoverDungeon    ")
local Dungeon6 = dropdown1:Add("    GoldDungeon    ")
local Dungeon7 = dropdown1:Add("    Event Dungeon...Not open    ")
local Dungeon8 = dropdown1:Add("    ...    ")

local function UDPDungeontext()
    if dropdownchoose == 0 then
        chooselevels.Text = "Dungeon Selection ..."
    elseif dropdownchoose == 1 then
        dropdownchoose2 = tostring(dungeonFunctions["OreDungeon"] and dungeonFunctions["OreDungeon"]() or "0")
        chooselevels.Text = " OreDungeon,  Key："..Ore_Dungeonkey.. "  ,Level："..dropdownchoose2
    elseif dropdownchoose == 2 then
        dropdownchoose2 = tostring(dungeonFunctions["GemDungeon"] and dungeonFunctions["GemDungeon"]() or "0")
        chooselevels.Text = " GemDungeon,  Key："..Gem_Dungeonkey.. "  ,Level："..dropdownchoose2
    elseif dropdownchoose == 3 then
        dropdownchoose2 = tostring(dungeonFunctions["RuneDungeon"] and dungeonFunctions["RuneDungeon"]() or "0")
        chooselevels.Text = " RuneDungeon,  Key："..Rune_Dungeonkey.. "  ,Level："..dropdownchoose2
    elseif dropdownchoose == 4 then
        dropdownchoose2 = tostring(dungeonFunctions["RelicDungeon"] and dungeonFunctions["RelicDungeon"]() or "0")
        chooselevels.Text = " RelicDungeon,  Key："..Relic_Dungeonkey.. "  ,Level："..dropdownchoose2
    elseif dropdownchoose == 7 then
        dropdownchoose2 = tostring(dungeonFunctions["HoverDungeon"] and dungeonFunctions["HoverDungeon"]() or "0")
        chooselevels.Text = " HoverDungeon,  Key："..Hover_Dungeonkey.. "  ,Level："..dropdownchoose2
    elseif dropdownchoose == 6 then
        dropdownchoose2 = tostring(dungeonFunctions["GoldDungeon"] and dungeonFunctions["GoldDungeon"]() or "0")
        chooselevels.Text = " GoldDungeon,  Key："..Gold_Dungeonkey.. "  ,Level："..dropdownchoose2        
    elseif dropdownchoose == 5 then  
        chooselevels.Text = " EventDungeon  Not OPEN"
    end
end

local function UDPDungeonchoose()
    checkDungeonkey()
    Dungeon1.Text = ("  OreDungeon          Key："..Ore_Dungeonkey.."  ")
    Dungeon2.Text = ("  GemDungeon        Key："..Gem_Dungeonkey.."  ")
    Dungeon3.Text = ("  RuneDungeon       Key："..Rune_Dungeonkey.."  ")
    Dungeon4.Text = ("  RelicDungeon        Key："..Relic_Dungeonkey.."  ")
    Dungeon5.Text = ("  HoverDungeon      Key："..Hover_Dungeonkey.."  ")
    Dungeon6.Text = ("  GoldDungeon         Key："..Gold_Dungeonkey.."  ")
    Dungeon7.Text = ("  Event Dungeon...Not open")
end

spawn(function()
    while true do
        UDPDungeonchoose()
        UDPDungeontext()
        wait(0.5)
    end
end)
local updDungeonuiSwitch = features3:AddSwitch("Sync dungeon entry interface difficulty", function(bool)
	updDungeonui = bool
end)

updDungeonuiSwitch:Set(false)

-- ========================================================================== --
-- 特殊定義地下城自動開始
local function updateDungeonLevel(dungeonName, dataField, newLevel)
    -- 測試更新後的函數
    JsonHandler.updatePlayerData(filePath, player.Name, { [dataField] = newLevel })
    updateDungeonFunctions()
    print("更新後的 " .. dungeonName .. " 等級:", dungeonFunctions[dungeonName]())
    
end
local function adjustDungeonLevel(adjustment)
    local newLevel = dropdownchoose2 + adjustment
    local dungeonMapping = {
        [1] = { name = "OreDungeon", field = "OreDungeonMaxLevel" },
        [2] = { name = "GemDungeon", field = "GemDungeonMaxLevel" },
        [3] = { name = "RuneDungeon", field = "RuneDungeonMaxLevel" },
        [4] = { name = "RelicDungeon", field = "RelicDungeonMaxLevel" },
        [7] = { name = "HoverDungeon", field = "HoverDungeonMaxLevel" },
        [6] = { name = "GoldDungeon", field = "GoldDungeonMaxLevel" },
    }
    local dungeon = dungeonMapping[dropdownchoose]
    if dungeon then
        updateDungeonLevel(dungeon.name, dungeon.field, newLevel)
    else
        print("未選擇地下城")
    end
end

local function DungeonTP()
    local dropdownTP = tonumber(dropdownchoose2)
    local args = {
        [1] = dropdownchoose,
        [2] = dropdownTP
    }

    game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\229\137\175\230\156\172"):FindFirstChild("\232\191\155\229\133\165\229\137\175\230\156\172"):FireServer(unpack(args))
end
local dungeonList = {
    "Ore Dungeon", "Gem Dungeon", "Rune Dungeon",
    "Relic Dungeon", "Hover Dungeon", "Gold Dungeon"
}

local dungeonKeys = {
    ["Ore Dungeon"] = "OreDungeon",
    ["Gem Dungeon"] = "GemDungeon",
    ["Rune Dungeon"] = "RuneDungeon",
    ["Relic Dungeon"] = "RelicDungeon",
    ["Hover Dungeon"] = "HoverDungeon",
    ["Gold Dungeon"] = "GoldDungeon"
}
local changeDungeon = false
-- 找到擁有最多鑰匙的地下城
local function getDungeonWithMostKeys()
    changeDungeon = true
    local maxKeys = 0
    local bestDungeon = nil
    local bestDropdownIndex = 1

	local dropdownMapping = {1, 2, 3, 4, 7, 6}
    for i, name in ipairs(dungeonList) do
        local keyCount = tonumber(getDungeonKey(dungeonKeys[name])) or 0
        if keyCount > maxKeys then
            maxKeys = keyCount
            bestDungeon = name
            bestDropdownIndex = dropdownMapping[i] or 0
        end
    end

    return bestDungeon, bestDropdownIndex
end
local function selectDungeonWithMostKeys()
    local bestDungeon, bestDropdownIndex = getDungeonWithMostKeys()
    dropdownchoose = bestDropdownIndex
    local dungeonName = bestDungeon
    local dungeonLevel = tostring(dungeonFunctions[dungeonKeys[dungeonName]]() or "0")
    --chooselevels.Text = "當前選擇："..dungeonName..", 鑰匙："..getDungeonKey(dungeonKeys[dungeonName]).." ,關卡選擇："..dungeonLevel
    print("已選擇最多鑰匙的地下城：" .. dungeonName)
    showNotification("ChangeDungeon:"..dungeonName);
    wait(0.5)
    wait(savemodetime2)
    DungeonTP()
end
local function AutostartDungeonf()
    local Dungeonuilevel = playerGui.GUI:WaitForChild("主界面"):WaitForChild("战斗"):WaitForChild("关卡信息"):WaitForChild("文本").Text
    local dungeonNametext = string.match(Dungeonuilevel, "^(.-)%s%d")
    if dungeonNametext == "Ore Dungeon" then
        local lastKeysCount = getDungeonKey("OreDungeon")
        local lastKeysCount1 = tonumber(lastKeysCount)
        local currentKeysCount = tonumber(string.match(Dungeonuilevel, "Keys:%s*(%d+)"))
        if lastKeysCount1 ~= currentKeysCount and lastKeysCount1 > 0 then
            if AutoDungeonplus1  and not changeDungeon then
                adjustDungeonLevel(1)
            end
            changeDungeon = false
            wait(savemodetime2)
            teleporthome()
            wait(0.5)
            wait(savemodetime)
            DungeonTP()
        elseif lastKeysCount1 == 0 and Autofinishdungeon then
            if lastKeysCount1 ~= currentKeysCount then
                if AutoDungeonplus1 and not AutoDungeonplusonly then
                    adjustDungeonLevel(1)
                    AutoDungeonplusonly = true
                    wait(3)
                    AutoDungeonplusonly = false
                end
            end
            print("已啟用自動完成地下城")
            selectDungeonWithMostKeys()
        end
    elseif dungeonNametext == "Gem Dungeon" then
        local lastKeysCount = getDungeonKey("GemDungeon")
        local lastKeysCount1 = tonumber(lastKeysCount)
        local currentKeysCount = tonumber(string.match(Dungeonuilevel, "Keys:%s*(%d+)"))
        if lastKeysCount1 ~= currentKeysCount and lastKeysCount1 > 0 then
            if AutoDungeonplus1  and not changeDungeon then
                adjustDungeonLevel(1)
            end
            changeDungeon = false
            wait(savemodetime2)
            teleporthome()
            wait(0.5)
            wait(savemodetime)
            DungeonTP()
        elseif lastKeysCount1 == 0 and Autofinishdungeon then
            if lastKeysCount1 ~= currentKeysCount then
                if AutoDungeonplus1 and not AutoDungeonplusonly then
                    adjustDungeonLevel(1)
                    AutoDungeonplusonly = true
                    wait(3)
                    AutoDungeonplusonly = false
                end
            end
            print("已啟用自動完成地下城")
            selectDungeonWithMostKeys()
        end
    elseif dungeonNametext == "Rune Dungeon" then
        local lastKeysCount = getDungeonKey("RuneDungeon")
        local lastKeysCount1 = tonumber(lastKeysCount)
        local currentKeysCount = tonumber(string.match(Dungeonuilevel, "Keys:%s*(%d+)"))
        if lastKeysCount1 ~= currentKeysCount and lastKeysCount1 > 0 then
            if AutoDungeonplus1  and not changeDungeon then
                adjustDungeonLevel(1)
            end
            changeDungeon = false
            wait(savemodetime2)
            teleporthome()
            wait(0.5)
            wait(savemodetime)
            DungeonTP()
        elseif lastKeysCount1 == 0 and Autofinishdungeon then
            if lastKeysCount1 ~= currentKeysCount then
                if AutoDungeonplus1 and not AutoDungeonplusonly then
                    adjustDungeonLevel(1)
                    AutoDungeonplusonly = true
                    wait(3)
                    AutoDungeonplusonly = false
                end
            end
            print("已啟用自動完成地下城")
            selectDungeonWithMostKeys()
        end
    elseif dungeonNametext == "Relic Dungeon" then
        local lastKeysCount = getDungeonKey("RelicDungeon")
        local lastKeysCount1 = tonumber(lastKeysCount)
        local currentKeysCount = tonumber(string.match(Dungeonuilevel, "Keys:%s*(%d+)"))
        if lastKeysCount1 ~= currentKeysCount and lastKeysCount1 > 0 then
            if AutoDungeonplus1  and not changeDungeon then
                adjustDungeonLevel(1)
            end
            changeDungeon = false
            wait(savemodetime2)
            teleporthome()
            wait(0.5)
            wait(savemodetime)
            DungeonTP()
        elseif lastKeysCount1 == 0 and Autofinishdungeon then
            if lastKeysCount1 ~= currentKeysCount then
                if AutoDungeonplus1 and not AutoDungeonplusonly then
                    adjustDungeonLevel(1)
                    AutoDungeonplusonly = true
                    wait(3)
                    AutoDungeonplusonly = false
                end
            end
            print("已啟用自動完成地下城")
            selectDungeonWithMostKeys()
        end
    elseif dungeonNametext == "Hover Dungeon" then
        local lastKeysCount = getDungeonKey("HoverDungeon")
        local lastKeysCount1 = tonumber(lastKeysCount)
        local currentKeysCount = tonumber(string.match(Dungeonuilevel, "Keys:%s*(%d+)"))
        if lastKeysCount1 ~= currentKeysCount and lastKeysCount1 > 0 then
            if AutoDungeonplus1  and not changeDungeon then
                adjustDungeonLevel(1)
            end
            changeDungeon = false
            wait(savemodetime2)
            teleporthome()
            wait(0.5)
            wait(savemodetime)
            DungeonTP()
        elseif lastKeysCount1 == 0 and Autofinishdungeon then
            if lastKeysCount1 ~= currentKeysCount then
                if AutoDungeonplus1 and not AutoDungeonplusonly then
                    adjustDungeonLevel(1)
                    AutoDungeonplusonly = true
                    wait(3)
                    AutoDungeonplusonly = false
                end
            end
            print("已啟用自動完成地下城")
            selectDungeonWithMostKeys()
        end
    elseif dungeonNametext == "Gold Dungeon" then
        local lastKeysCount = getDungeonKey("GoldDungeon")
        local lastKeysCount1 = tonumber(lastKeysCount)
        local currentKeysCount = tonumber(string.match(Dungeonuilevel, "Keys:%s*(%d+)"))
        if lastKeysCount1 ~= currentKeysCount and lastKeysCount1 > 0 then
            if AutoDungeonplus1  and not changeDungeon then
                adjustDungeonLevel(1)
            end
            changeDungeon = false
            wait(savemodetime2)
            teleporthome()
            wait(0.5)
            wait(savemodetime)
            DungeonTP()
        elseif lastKeysCount1 == 0 and Autofinishdungeon then
            if lastKeysCount1 ~= currentKeysCount then
                if AutoDungeonplus1 and not AutoDungeonplusonly then
                    adjustDungeonLevel(1)
                    AutoDungeonplusonly = true
                    wait(3)
                    AutoDungeonplusonly = false
                end
            end
            print("已啟用自動完成地下城")
            selectDungeonWithMostKeys()
        end
    end
end

local AutostartDungeonSwitch = features3:AddSwitch("Auto-start After Battle (Dungeon) -- Victory Required", function(bool)
    AutostartDungeon = bool
    if AutostartDungeon then
        while AutostartDungeon do
            AutostartDungeonf()
            wait(0.5)
        end
    end
end)
AutostartDungeonSwitch:Set(false)

local AutoDungeonplus1Switch = features3:AddSwitch("Automatically Increase Level by +1 After Battle", function(bool)
    AutoDungeonplus1 = bool
end)

AutoDungeonplus1Switch:Set(false)
features3:AddLabel("If open ,When no keys, it will change to other dungeon")
local AutofinishdungeonSwitch = features3:AddSwitch("Complete All Dungeons ", function(bool)
    Autofinishdungeon = bool
end)

AutofinishdungeonSwitch:Set(false)

features3:AddTextBox("You can also manually input the level", function(text)
    local dropdownchoose0 = string.gsub(text, "[^%d]", "")
    local dropdownchoose3 = tonumber(dropdownchoose0)
    if not dropdownchoose3 then
        dropdownchoose3 = 1
    end
    if dropdownchoose == 1 then
        local field = "OreDungeonMaxLevel"
        JsonHandler.updateField(filePath, player.Name, field, dropdownchoose3)
        updateDungeonFunctions()
    elseif dropdownchoose == 2 then
        local field = "GemDungeonMaxLevel"
        JsonHandler.updateField(filePath, player.Name, field, dropdownchoose3)
        updateDungeonFunctions()
    elseif dropdownchoose == 3 then
        local field = "RuneDungeonMaxLevel"
        JsonHandler.updateField(filePath, player.Name, field, dropdownchoose3)
        updateDungeonFunctions()
    elseif dropdownchoose == 4 then
        local field = "RelicDungeonMaxLevel"
        JsonHandler.updateField(filePath, player.Name, field, dropdownchoose3)
        updateDungeonFunctions()
    elseif dropdownchoose == 5 then
        local field = "HoverDungeonMaxLevel"
        JsonHandler.updateField(filePath, player.Name, field, dropdownchoose3)
        updateDungeonFunctions()
    elseif dropdownchoose == 6 then
        local field = "GoldDungeonMaxLevel"
        JsonHandler.updateField(filePath, player.Name, field, dropdownchoose3)
        updateDungeonFunctions()
    else
        print("未選擇地下城")
    end
end)

features3:AddButton("Level Selection +1", function()
    adjustDungeonLevel(1)
end)

features3:AddButton("Level Selection -1", function()
    adjustDungeonLevel(-1)
end)

features3:AddButton("TP", function()
    DungeonTP()
end)
-- ========================================================================== --
-- 抽取頁
-- ========================================================================== --
-- --特殊定義(煉製裝備相關)
local AutoelixirSwitch = features4:AddSwitch("Auto Elixir ", function(bool)
	Autoelixir = bool
	if Autoelixir then
		while Autoelixir do
            game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\231\130\188\228\184\185"):FindFirstChild("\229\136\182\228\189\156"):FireServer()
            wait(0.5)
        end
	end
end)

AutoelixirSwitch:Set(false)

local AutoelixirabsorbSwitch = features4:AddSwitch("Auto Absorb Elixir⚠️All Elixir in the backpack⚠️）", function(bool)
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
local player = game:GetService("Players").LocalPlayer
local playerGui = game.Players.LocalPlayer.PlayerGui
--定義技能區
local lotteryskill = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("商店"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("召唤"):WaitForChild("技能")
local skilllevel = lotteryskill:WaitForChild("等级区域"):WaitForChild("值").text
skilllevel = string.gsub(skilllevel, "%D", "")
local skilllevel2 = lotteryskill:WaitForChild("等级区域"):WaitForChild("进度条"):WaitForChild("值"):WaitForChild("值").text
skilllevel2 = string.match(skilllevel2, "(%d+)/")
--定義法寶區
local lotteryweapon = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("商店"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("召唤"):WaitForChild("法宝")
local weaponlevel = lotteryweapon:WaitForChild("等级区域"):WaitForChild("值").text
weaponlevel = string.gsub(weaponlevel, "%D", "")
local weaponlevel2 = lotteryweapon:WaitForChild("等级区域"):WaitForChild("进度条"):WaitForChild("值"):WaitForChild("值").text
weaponlevel2 = string.match(weaponlevel2, "(%d+)/")
--定義貨幣區
local currency = player:WaitForChild("值"):WaitForChild("货币")
local diamonds = currency:WaitForChild("钻石")
local sword_tickets = currency:WaitForChild("法宝抽奖券").value
local skill_tickets = currency:WaitForChild("技能抽奖券").value
--定義抽獎相關參數
local useDiamonds = false
local Autolotteryspeed = 0.3 --不宜太快，遊戲抽獎為延遲抽獎
local canstartticket = true
local canstartticket2 = true
--更新/獲取數據
local function updData()
    skilllevel = lotteryskill:WaitForChild("等级区域"):WaitForChild("值").text
    skilllevel = string.gsub(skilllevel, "%D", "") or 0
    skilllevel2 = lotteryskill:WaitForChild("等级区域"):WaitForChild("进度条"):WaitForChild("值"):WaitForChild("值").text
    skilllevel2 = string.match(skilllevel2, "(%d+)/") or 0
    weaponlevel = lotteryweapon:WaitForChild("等级区域"):WaitForChild("值").text
    weaponlevel = string.gsub(weaponlevel, "%D", "") or 0
    weaponlevel2 = lotteryweapon:WaitForChild("等级区域"):WaitForChild("进度条"):WaitForChild("值"):WaitForChild("值").text
    weaponlevel2 = string.match(weaponlevel2, "(%d+)/") or 0
    diamonds = currency:WaitForChild("钻石").value
    sword_tickets = currency:WaitForChild("法宝抽奖券").value
    skill_tickets = currency:WaitForChild("技能抽奖券").value
    print("技能等級："..skilllevel.."技能進度："..skilllevel2)
    print("法寶等級："..weaponlevel.."法寶進度："..weaponlevel2)
    print("鑽石："..diamonds.."法寶抽獎券："..sword_tickets.."技能抽獎券："..skill_tickets)
end

local function useskill_ticket()
    print("抽獎：技能")
    if canstartticket then
        local args = {
            [1] = "\230\138\128\232\131\189",
        }
        game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\229\149\134\229\186\151"):FindFirstChild("\229\143\172\229\148\164"):FindFirstChild("\230\138\189\229\165\150"):FireServer(unpack(args))    
    end
end
local function usesword_ticket()
    print("抽獎：法寶")
    if canstartticket2 then
        local args = {
            [1] = "\230\179\149\229\174\157",
        }
        game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\229\149\134\229\186\151"):FindFirstChild("\229\143\172\229\148\164"):FindFirstChild("\230\138\189\229\165\150"):FireServer(unpack(args))
    end
end

--判斷區(判斷：抽獎券是否足夠)
local function Compareskilltickets()
    if skill_tickets <= 8 and useDiamonds then
        if diamonds >= 400 then
            local compare = 8 - tonumber(skill_tickets)
            print("技能抽獎券不足，使用鑽石補足："..compare.."張")
            print("鑽石消耗："..compare*50)
            useskill_ticket()
        else
            print("鑽石不足")
        end
    elseif skill_tickets >= 8  then
        print("技能抽獎券足夠")
        useskill_ticket()
    else
        print("技能抽獎券不足且沒開啟鑽石補足")
    end
end
local function Compareweapentickets()
    if sword_tickets <= 8 and useDiamonds then
        if diamonds > 400 then
            local compare = 8 - tonumber(sword_tickets)
            print("法寶抽獎券不足，使用鑽石補足："..compare.."張")
            print("鑽石消耗："..compare*50)
            usesword_ticket()
        else
            print("鑽石不足")
        end
    elseif sword_tickets >= 8  then
        print("法寶抽獎券足夠")
        usesword_ticket()
    else
        print("法寶抽獎券不足且沒開啟鑽石補足")
    end
end
--判斷區(判斷：進度)
local function Compareprogress()
    if skilllevel2 > weaponlevel2 then
        print("法寶進度小於技能進度")
        Compareweapentickets()
    elseif skilllevel2 < weaponlevel2 then
        print("技能進度小於法寶進度")
        Compareskilltickets()
    else
        print("技能進度等於法寶進度")
        spawn(function()
            Compareskilltickets()
        end)
        Compareweapentickets()
    end
end

--判斷區(判斷：等級)
local function Comparelevel()
    updData()
    if skilllevel > weaponlevel then
        usesword_ticket()
        print("法寶等級小於技能等級")
    elseif skilllevel < weaponlevel then
        useskill_ticket()
        print("技能等級小於法寶等級")
    else
        print("技能等級等於法寶等級")
        Compareprogress()
    end
end

features4:AddLabel("⚠️If lottery tickets are insufficient, it will stop");

local lotterynum = features4:AddLabel("Weapon Tickets： " .. sword_tickets .. "  Skill Tickets： " .. skill_tickets)
local function updateExtractedValues()
    local sword_ticketslable = currency:WaitForChild("法宝抽奖券").value
    local skill_ticketslable = currency:WaitForChild("技能抽奖券").value
    lotterynum.Text = "Weapon Tickets： " .. sword_ticketslable .. "  Skill Tickets： " .. skill_ticketslable
end

spawn(function()
    while true do
        updateExtractedValues()
        wait(1)
    end
end)

local AutolotterySwitch = features4:AddSwitch("Auto Draw Weapons/Skills -- Need Fix", function(bool)
    Autolottery = bool
    if Autolottery then
        canstartticket = true
        canstartticket2 = true
        while Autolottery do
            Comparelevel()
            wait(Autolotteryspeed)
            wait(0.4)
        end
    else
        canstartticket = false
        canstartticket2 = false
    end
end)
AutolotterySwitch:Set(false)
-- 啟用鑽石補充功能
local USEDiamondSwitch = features4:AddSwitch("Enable Diamond Draw", function(bool)
	useDiamonds = bool
end)
USEDiamondSwitch:Set(false)
-- ========================================================================== --
-- 雜項頁

local AutoupdFlyingSwordSwitch = features5:AddSwitch("Upd Flying Sword", function(bool)
    AutoupdFlyingSword = bool
    if AutoupdFlyingSword then
        while AutoupdFlyingSword do
            game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\233\163\158\229\137\145"):FindFirstChild("\229\141\135\231\186\167"):FireServer()
            wait(0.2)
        end
    end
end)
AutoupdFlyingSwordSwitch:Set(false)
local AutoupdskillSwordSwitch = features5:AddSwitch("Upd weapon/skill", function(bool)
    AutoupdskillSword = bool
    if AutoupdskillSword then
        while AutoupdskillSword do
            game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\230\179\149\229\174\157"):FindFirstChild("\229\141\135\231\186\167\229\133\168\233\131\168\230\179\149\229\174\157"):FireServer()
            game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\230\138\128\232\131\189"):FindFirstChild("\229\141\135\231\186\167\229\133\168\233\131\168\230\138\128\232\131\189"):FireServer()
            wait(1.5)
        end
    end
end)
AutoupdskillSwordSwitch:Set(false)
local AutoupdRuneSwordSwitch = features5:AddSwitch("Upd Rune", function(bool)
    AutoupdRuneSwordSwitch = bool
    if AutoupdRuneSwordSwitch then
        while AutoupdRuneSwordSwitch do
            game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\233\152\181\230\179\149"):FindFirstChild("\229\141\135\231\186\167"):FireServer()
            wait(0.2)
        end
    end
end)
AutoupdRuneSwordSwitch:Set(false)

local Guidename = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("公会"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("主页"):WaitForChild("介绍"):waitForChild("名称"):waitForChild("文本"):waitForChild("文本").Text
local Donatetimes = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("公会"):WaitForChild("捐献"):WaitForChild("背景"):WaitForChild("按钮"):WaitForChild("确定按钮"):WaitForChild("次数").Text
local Donatetimesnumber = tonumber(string.match(Donatetimes, "%d+"))
local Guildname = features5:AddLabel("Guide Name：Need chack Upd Guide" .. " || Contribute times： " .. Donatetimesnumber)
features5:AddButton("Upd Guide",function()
	local replicatedStorage = game:GetService("ReplicatedStorage")
    local event = replicatedStorage:FindFirstChild("打开公会", true) -- 遞歸搜尋
    event:Fire("打开公会")
    wait(0.5)
    Donatetimes = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("公会"):WaitForChild("捐献"):WaitForChild("背景"):WaitForChild("按钮"):WaitForChild("确定按钮"):WaitForChild("次数").Text
    Donatetimesnumber = tonumber(string.match(Donatetimes, "%d+"))
    Guildname.Text = "Guide Name：" .. Guidename .. " || Contribute times： " .. Donatetimesnumber
end)
local AutoDonateSwitch = features5:AddSwitch("Auto Contribute", function(bool)
    AutoDonate = bool
    if AutoDonate then
        while AutoDonate do
            Donatetimes = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("公会"):WaitForChild("捐献"):WaitForChild("背景"):WaitForChild("按钮"):WaitForChild("确定按钮"):WaitForChild("次数").Text
            Donatetimesnumber = tonumber(string.match(Donatetimes, "%d+"))
            Guildname.Text = "Guide Name：" .. Guidename .. " || Contribute times： " .. Donatetimesnumber
            if Donatetimesnumber > 0 then
                game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\229\133\172\228\188\154"):FindFirstChild("\230\141\144\231\140\174"):FireServer()
            end
            wait(0.5)
        end
    end
end)
AutoDonateSwitch:Set(false)

-- ========================================================================== --
-- UI頁
local replicatedStorage = game:GetService("ReplicatedStorage")
features6:AddButton("Daily Tasks",function()
    local event = replicatedStorage:FindFirstChild("打开每日任务", true) -- 遞歸搜尋
    if event and event:IsA("BindableEvent") then
        event:Fire("打開每日任務")
    end
end)
features6:AddButton("Mail",function()
    local event = replicatedStorage:FindFirstChild("打开邮件", true) -- 遞歸搜尋
    if event and event:IsA("BindableEvent") then
        event:Fire("打开郵件")
    end
end)
features6:AddButton("Wheel",function()
    local event = replicatedStorage:FindFirstChild("打开转盘", true) -- 遞歸搜尋
    if event and event:IsA("BindableEvent") then
        event:Fire("打開轉盤")
    end
end)
features6:AddButton("Formation",function()
    local event = replicatedStorage:FindFirstChild("打开阵法", true) -- 遞歸搜尋
    if event and event:IsA("BindableEvent") then
        event:Fire("打开陣法")
    end
end)
features6:AddButton("World Tree",function()
    local event = replicatedStorage:FindFirstChild("打开世界树", true) -- 遞歸搜尋
    if event and event:IsA("BindableEvent") then
        event:Fire("打開世界樹")
    end
end)
features6:AddButton("Training Bench",function()
    local event = replicatedStorage:FindFirstChild("打开炼器台", true) -- 遞歸搜尋
    if event and event:IsA("BindableEvent") then
        event:Fire("打開練器台")
    end
end)
features6:AddButton("Alchemy Furnace",function()
    local event = replicatedStorage:FindFirstChild("打开炼丹炉", true) -- 遞歸搜尋
    if event and event:IsA("BindableEvent") then
        event:Fire("打開煉丹爐")
    end
end)
features7:AddLabel(" -- 語言配置/language config")
features7:AddButton("刪除語言配置/language config delete",function()
    local HttpService = game:GetService("HttpService")
    -- 刪除 Cultivation_languageSet.json 配置文件
    function deleteConfigFile()
        if isfile("Cultivation_languageSet.json") then
            -- 使用 delfile 刪除文件
            delfile("Cultivation_languageSet.json")
            print("配置文件 Cultivation_languageSet.json 已刪除。")
        else
            print("配置文件 Cultivation_languageSet.json 不存在，無法刪除。")
        end
    end
    deleteConfigFile()
end)
features7:AddLabel("- - Statistics");
features7:AddButton("每秒擊殺/金幣數", function()
	loadstring(game:HttpGet("https://pastebin.com/raw/0NqSi46N"))()
	loadstring(game:HttpGet("https://pastebin.com/raw/HGQXdAiz"))()
end);
features7:AddLabel(" If you have any questions or ideas, leave a comment on GitHub.");
features7:AddButton("Github Link", function()
    local urlToCopy = "https://github.com/Tseting-nil";
    if setclipboard then
        setclipboard(urlToCopy);
        showNotification("Link Copied:) ！！");
    else
        showNotification("error！Link：github.com/Tseting-nil");
    end
end);

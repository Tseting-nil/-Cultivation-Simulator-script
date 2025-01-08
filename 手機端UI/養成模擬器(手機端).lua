local library = loadstring(game:HttpGet("https://pastebin.com/raw/d40xPN0c", true))()
local AntiAFK = game:GetService("VirtualUser");
game.Players.LocalPlayer.Idled:Connect(function()
	AntiAFK:CaptureController();
	AntiAFK:ClickButton2(Vector2.new());
	wait(2);
	--print("AFK：AFK Bypass");
end);
local window = library:AddWindow("Cultivation-Simulator 養成模擬器-手機板UI", {main_color=Color3.fromRGB(41, 74, 122),min_size=Vector2.new(275, 265),can_resize=false});
-- ========================================================================== --
-- 自述

local features = window:AddTab("自述");
features:Show();
features:AddLabel("作者：澤澤   介面：Elerium v2");
features:AddLabel("AntiAFK：start");
features:AddLabel("製作時間：2024/09/27");
features:AddLabel("最後更新時間：2024/12/18");
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
local player = game:GetService("Players").LocalPlayer;
local playerGui = player.PlayerGui;
local guiPath = playerGui.GUI:WaitForChild("主界面"):WaitForChild("战斗");
local levelInfoUI = guiPath:WaitForChild("关卡信息"):WaitForChild("文本");
local victoryResult = guiPath:WaitForChild("胜利结果");
local values = player:WaitForChild("值");
local playersetting = values:WaitForChild("设置");
local privileges = values:WaitForChild("特权");
-- 定義玩家與貨幣相關物件
local player = game:GetService("Players").LocalPlayer
local playerGui = player.PlayerGui
local lottery = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("商店"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("召唤")
local currency = player:WaitForChild("值"):WaitForChild("货币")
local diamonds = currency:WaitForChild("钻石")
--任務UI
local mainmission = playerGui.GUI:WaitForChild("主界面"):WaitForChild("主城"):WaitForChild("主线任务"):WaitForChild("按钮"):WaitForChild("提示").Visible
--任務UI--gamepass
local namechangechick = false
local missionnamelist = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("商店"):WaitForChild("通行证任务"):WaitForChild("背景"):WaitForChild("任务列表")
--抽獎卷UI
local sword_tickets = currency:WaitForChild("法宝抽奖券").value
local skill_tickets = currency:WaitForChild("技能抽奖券").value
--法寶UI
local sword = lottery:WaitForChild("法宝"):WaitForChild("等级区域")
local sword_level = sword:WaitForChild("值").text
local sword_value = sword:WaitForChild("进度条"):WaitForChild("值"):WaitForChild("值").text
--技能UI
local skill = lottery:WaitForChild("技能"):WaitForChild("等级区域")
local skill_level = skill:WaitForChild("值").text
local skill_value = skill:WaitForChild("进度条"):WaitForChild("值"):WaitForChild("值").text
--數值
local extract_sword_level
local extract_sword_value
local extract_skill_level
local extract_skill_value
--狀態/設置
local useDiamonds = false
local savemodetime = 9;
--地下城相關
local Dungeonslist = playerGui:WaitForChild("GUI"):WaitForChild("二级界面"):WaitForChild("关卡选择"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("副本"):WaitForChild("列表")
local DungeonDungeon = Dungeonslist:FindFirstChild("副本预制体")
local Dungeonnamechangechick = false
local Ore_Dungeonkey, Gem_Dungeonkey, Gold_Dungeonkey, Relic_Dungeonkey, Rune_Dungeonkey, Hover_Dungeonkey
--其他(轉盤)
local turntable = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("抽奖转盘"):WaitForChild("抽奖按钮"):WaitForChild("按钮"):WaitForChild("名称").Text
turntable = string.match(turntable, "%d+")  -- 提取数字
turntable = tonumber(turntable) or 0  -- 将提取的文本转换为数字，如果没有数字则为0
--其他(公會捐獻)
local Guilddonation = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("公会"):WaitForChild("捐献"):WaitForChild("背景"):WaitForChild("按钮"):WaitForChild("确定按钮"):WaitForChild("次数").Text
Guilddonation = string.match(Guilddonation, "%d+")  -- 提取数字
Guilddonation = tonumber(Guilddonation) or 0  -- 将提取的文本转换为数字，如果没有数字则为0
--其他(郵件)
local mailList = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("邮件"):WaitForChild("背景"):WaitForChild("邮件列表")
local mailCheckCompleted = false
--start
local Players = game:GetService("Players");
local isDetectionEnabled = true;
local timescheck = 0;
local inRange = false;
local playerInRange = false;
local hasPrintedNoPlayer = false;
local localPlayer = game.Players.LocalPlayer;
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait();
local rootPart = character:WaitForChild("HumanoidRootPart");
local closestScene = nil;
local closestPosition = nil;
local closestDistance = math.huge;
for i = 1, 9 do
	local sceneName = "主场景" .. (((i > 1) and tostring(i)) or "");
	local scene = workspace:WaitForChild(sceneName, 5);
	if scene then
		local respawnPoint = scene:WaitForChild("重生点", 5);
		if respawnPoint then
			local distance = (respawnPoint.CFrame.Position - rootPart.CFrame.Position).Magnitude;
			if (distance < closestDistance) then
				closestDistance = distance;
				closestScene = scene;
				closestPosition = respawnPoint.Position + Vector3.new(0, 4.9, 0);
			end
		else
			print("主場景:", scene.Name, "中未找到重生點");
		end
	else
		print("未找到主場景:", sceneName);
	end
end
if (closestScene and closestPosition) then
	print("初始場景為:", closestScene.Name);
	print("重生點座標 (x, y, z):", closestPosition.X, closestPosition.Y, closestPosition.Z);
end
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
			savemodetime = 9;
			timescheck = 1;
			hasPrintedNoPlayer = true;
		end
	elseif (timescheck == 1) then
		print("範圍內玩家已離開");
		timescheck = 0;
		hasPrintedNoPlayer = false;
	end
	if (not playerInRange and not hasPrintedNoPlayer) then
		print("範圍內無玩家");
		savemodetime = 3;
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
	end
end
spawn(setupRangeDetection);
local button;
local function updateButtonText()
	if isDetectionEnabled then
		button.Text = "關閉安全模式";
	else
		button.Text = "啟用安全模式";
	end
end
button = features:AddButton("啟用安全模式", function()
	inRange = false;
	playerInRange = false;
	timescheck = 0;
	hasPrintedNoPlayer = false;
	toggleDetection();
	updateButtonText();
end);
updateButtonText();

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
features:AddButton("開黑幕/關閉", function()
	blackBlock.Visible = not blackBlock.Visible
end);
-- ========================================================================== --
-- Main

local features = window:AddTab("Main");
features:AddButton("掛機模式", function()
	local AFKmod = playersetting:WaitForChild("自动战斗");
	if ( AFKmod.Value == true ) then
		AFKmod.Value = false;
	else
		AFKmod.Value = true;
	end
end);
--任務資料夾初始化名稱
local function gamepassmissionnamechange()
	-- 檢查最終對象是否存在
	if missionnamelist then
		local gamepassmissionlist = missionnamelist:FindFirstChild("任务项预制体")
		if gamepassmissionlist then
			-- 獲取 LayoutOrder 的值
			local gamepassmissionLayoutOrder = gamepassmissionlist.LayoutOrder
			-- 將 LayoutOrder 值轉為字符串後設置為 Name
			gamepassmissionlist.Name = tostring(gamepassmissionLayoutOrder)
		else
			--更新數據
			game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\230\156\136\233\128\154\232\161\140\232\175\129"):FindFirstChild("\232\142\183\229\143\150\230\149\176\230\141\174"):FireServer()
			print("任務--名稱--已全部更改")
			namechangechick = true
		end
	end
end
while not namechangechick do
	gamepassmissionnamechange()
end
--主介面任務
local function mainmissionchack ()
	mainmission = playerGui.GUI:WaitForChild("主界面"):WaitForChild("主城"):WaitForChild("主线任务"):WaitForChild("按钮"):WaitForChild("提示").Visible 
	if mainmission == true then
		print("任務完成，可領取")
		game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\228\184\187\231\186\191\228\187\187\229\138\161"):FindFirstChild("\233\162\134\229\143\150\229\165\150\229\138\177"):FireServer()
	end
end
--gamepass任務
local function gamepassmission()
	if missionnamelist then
		for _, child in ipairs(missionnamelist:GetChildren()) do
			if child:IsA("Frame") and child.Visible == true then
				--print("找到目的物件:", child.Name)
				local missionname = child.Name
				missionname = tonumber(missionname)
				-- 確保 child 中有名稱這個子物件
				local nameLabel = child:WaitForChild("名称")
				if nameLabel then
					-- 提取任務進度 "0/100"
					local taskProgress = nameLabel.Text:match("%((%d+/%d+)%)")
					if taskProgress then
						-- 分割數字並轉換為數字類型
						local A_num, B_num = taskProgress:match("(%d+)%/(%d+)")
						A_num = tonumber(A_num)
						B_num = tonumber(B_num)
						-- 判斷比例是否大於等於 1
						if A_num and B_num and A_num / B_num >= 1 then
							print("可領取")
							local args = {
								[1] = missionname
							}
							game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\230\156\136\233\128\154\232\161\140\232\175\129"):FindFirstChild("\229\174\140\230\136\144\228\187\187\229\138\161"):FireServer(unpack(args))
							--更新數據
							game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\230\156\136\233\128\154\232\161\140\232\175\129"):FindFirstChild("\232\142\183\229\143\150\230\149\176\230\141\174"):FireServer()
						end
					end
				end
			end
		end
	end
end

local rewardstasks = false;
local rewardstasks = features:AddSwitch("任務自動領取(包括Gamepass)", function(bool)
	rewardstasks = bool;
	if rewardstasks then
		while rewardstasks do
			mainmissionchack ()
			gamepassmission()
			wait(1)
		end
	end
end);
rewardstasks:Set(false);



local invest = false;
local invest = features:AddSwitch("投資", function(bool)
	invest = bool;
	if invest then
		while invest do
			for i = 1, 3 do
				local args = {i};
				game:GetService("ReplicatedStorage")["\228\186\139\228\187\182"]["\229\133\172\231\148\168"]["\229\149\134\229\186\151"]["\233\147\182\232\161\140"]["\233\162\134\229\143\150\231\144\134\232\180\162"]:FireServer(unpack(args));
				print("領取", i);
			end
			wait(5);
			for i = 1, 3 do
				local args = {i};
				game:GetService("ReplicatedStorage")["\228\186\139\228\187\182"]["\229\133\172\231\148\168"]["\229\149\134\229\186\151"]["\233\147\182\232\161\140"]["\232\180\173\228\185\176\231\144\134\232\180\162"]:FireServer(unpack(args));
				print("投資", i);
			end
			wait(600);
		end
	end
end);
invest:Set(false);
local AutoCollectherbs = false;
local AutoCollectherbs = features:AddSwitch("自動採草藥", function(bool)
	AutoCollectherbs = bool;
	if AutoCollectherbs then
		while AutoCollectherbs do
			local args = {[1]=1,[2]=nil};
			game:GetService("ReplicatedStorage")["\228\186\139\228\187\182"]["\229\133\172\231\148\168"]["\229\134\156\231\148\176"]["\233\135\135\233\155\134"]:FireServer(unpack(args));
			local args = {[1]=2,[2]=nil};
			game:GetService("ReplicatedStorage")["\228\186\139\228\187\182"]["\229\133\172\231\148\168"]["\229\134\156\231\148\176"]["\233\135\135\233\155\134"]:FireServer(unpack(args));
			local args = {[1]=3,[2]=nil};
			game:GetService("ReplicatedStorage")["\228\186\139\228\187\182"]["\229\133\172\231\148\168"]["\229\134\156\231\148\176"]["\233\135\135\233\155\134"]:FireServer(unpack(args));
			local args = {[1]=4,[2]=nil};
			game:GetService("ReplicatedStorage")["\228\186\139\228\187\182"]["\229\133\172\231\148\168"]["\229\134\156\231\148\176"]["\233\135\135\233\155\134"]:FireServer(unpack(args));
			local args = {[1]=5,[2]=nil};
			game:GetService("ReplicatedStorage")["\228\186\139\228\187\182"]["\229\133\172\231\148\168"]["\229\134\156\231\148\176"]["\233\135\135\233\155\134"]:FireServer(unpack(args));
			local args = {[1]=6,[2]=nil};
			game:GetService("ReplicatedStorage")["\228\186\139\228\187\182"]["\229\133\172\231\148\168"]["\229\134\156\231\148\176"]["\233\135\135\233\155\134"]:FireServer(unpack(args));
			wait(60);
		end
	end
end);
AutoCollectherbs:Set(false);
local previousLevelText = levelInfoUI.Text or "";
local previousVictoryText = victoryResult.Text or "";
local levelNumber = 0;
local restart = false;
local function isEmpty(text)
	return (text == nil) or (text:gsub("%s+", "") == "");
end
local function updateLevelText()
	local currentLevelText = levelInfoUI.Text;
	if (not isEmpty(currentLevelText) and (currentLevelText ~= previousLevelText)) then
		previousLevelText = currentLevelText;
		levelNumber = previousLevelText:match("World (%d+)") or 0;
	end
end
local function updateVictoryText()
	local currentVictoryText = victoryResult.Text;
	if (currentVictoryText ~= previousVictoryText) then
		previousVictoryText = currentVictoryText;
		local losewave = previousVictoryText
		local victoryWaveNumber = previousVictoryText:match("Wave (%d+)") or 100;
		local victoryText = previousVictoryText:match("Wave %d+ (.+)") or "結束";
		if (victoryWaveNumber == 100) then
			restart = true;
		end
		if (losewave == 100) then
			restart = true;
		end
	end
end
local function checkAndUpdate()
	updateLevelText();
	updateVictoryText();
end
local function restart_level()
	local number = tonumber(levelNumber:match("%d+"));
	print("重啟世界", number);
	local args = {[1]=number};
	game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\229\133\179\229\141\161"):FindFirstChild("\232\191\155\229\133\165\228\184\150\231\149\140\229\133\179\229\141\161"):FireServer(unpack(args));
end


-- 抽獎功能
local function usesword_ticket()
	print("抽獎：法寶")
	local args = {
		[1] = "\230\179\149\229\174\157",
		[2] = false
	}

	game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\229\149\134\229\186\151"):FindFirstChild("\229\143\172\229\148\164"):FindFirstChild("\230\138\189\229\165\150"):FireServer(unpack(args))
end
local function useskill_ticket()
	print("抽獎：技能")
	local args = {
		[1] = "\230\138\128\232\131\189",
		[2] = false
	}
	game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\229\149\134\229\186\151"):FindFirstChild("\229\143\172\229\148\164"):FindFirstChild("\230\138\189\229\165\150"):FireServer(unpack(args))

end

-- 配置參數
local MIN_TICKETS = 8         -- 最低抽獎券需求
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
local function compare_ticket_type(sword_tickets, skill_tickets, sword_level, skill_level, sword_value, skill_value, diamonds, useDiamonds)
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

local function updateExtractedValues()
	fetchData()
	extract_sword_level = tonumber(string.match(sword_level, "%d+"))
	extract_sword_value = tonumber(string.match(sword_value, "^(%d+)/"))
	extract_skill_level = tonumber(string.match(skill_level, "%d+"))
	extract_skill_value = tonumber(string.match(skill_value, "^(%d+)/"))
end

-- 自動抽獎功能
local Autolottery = false
local AutolotterySwitch = features:AddSwitch("自動抽法寶/技能", function(bool)
	Autolottery = bool
	if Autolottery then
		while Autolottery do
			updateExtractedValues()
			wait(0.2)
			compare_ticket_type(sword_tickets, skill_tickets, extract_sword_level, extract_skill_level, extract_sword_value, extract_skill_value, diamonds, useDiamonds)
			wait(0.2) -- 防止過度觸發
		end
	end
end)

AutolotterySwitch:Set(false)


-- 啟用鑽石補充功能
local USEDiamondSwitch = features:AddSwitch("啟用鑽石抽取", function(bool)
	useDiamonds = bool
end)

USEDiamondSwitch:Set(false)

features:AddLabel(" ∇ --需要成功完成波次100 ");
local Autostart = false;
local Autostart = features:AddSwitch("戰鬥結束後自動開始(只支援世界戰鬥)", function(bool)
	Autostart = bool;
	if Autostart then
		while Autostart do
			checkAndUpdate();
			if (restart == true) then
				rootPart.CFrame = CFrame.new(closestPosition);
				wait(0.5);
				wait(savemodetime);
				restart_level();
				wait(0.5);
				restart = false;
			end
			wait(0.3);
		end
	end
end);
Autostart:Set(false);

--獲取副本鑰匙值
local function checkDungeonkey()
    Ore_Dungeonkey = string.match(Dungeonslist.OreDungeon:WaitForChild("钥匙"):WaitForChild("值").Text, "^%d+")
    Gem_Dungeonkey = string.match(Dungeonslist.GemDungeon:WaitForChild("钥匙"):WaitForChild("值").Text, "^%d+")
    Gold_Dungeonkey = string.match(Dungeonslist.GoldDungeon:WaitForChild("钥匙"):WaitForChild("值").Text, "^%d+")
    Relic_Dungeonkey = string.match(Dungeonslist.RelicDungeon:WaitForChild("钥匙"):WaitForChild("值").Text, "^%d+")
    Rune_Dungeonkey = string.match(Dungeonslist.RuneDungeon:WaitForChild("钥匙"):WaitForChild("值").Text, "^%d+")
    Hover_Dungeonkey  = string.match(Dungeonslist.HoverDungeon:WaitForChild("钥匙"):WaitForChild("值").Text, "^%d+")
end

--更改副本文件名稱
local function Dungeonnamechange()
    if DungeonDungeon then
        local dungeonFolder = Dungeonslist:FindFirstChild("副本预制体")
        if dungeonFolder then
            local dungeonsname = dungeonFolder:FindFirstChild("名称")
            dungeonsname = dungeonsname.Text
            dungeonsname = string.gsub(dungeonsname, "%s+", "")
            dungeonFolder.Name = dungeonsname
        else
            Dungeonnamechangechick = true
            print("地下城--名稱--已全部更改")
            checkDungeonkey()
        end
	else
		print("地下城--名稱--已全部更改")
		Dungeonnamechangechick = true
    end
end

while not Dungeonnamechangechick do
    Dungeonnamechange()
end

local features = window:AddTab("副本");
features:AddButton("快速副本傳送", function()
	local ohInstance1 = game:GetService("Players").LocalPlayer

	game:GetService("ReplicatedStorage")[utf8.char(20107, 20214)][utf8.char(20844, 29992)][utf8.char(22330, 26223)][utf8.char(35775, 38382)]:FireServer(ohInstance1)
end);
local textLabel = features:AddLabel("礦石地下城鑰匙：")
local textLabel2 = features:AddLabel("金幣地下城鑰匙：")
local textLabel3 = features:AddLabel("靈石地下城鑰匙：")
local textLabel4 = features:AddLabel("符石地下城鑰匙：")
local textLabel5 = features:AddLabel("遺物地下城鑰匙：")
local textLabel6 = features:AddLabel("懸浮地下城鑰匙：")


local function DungeonKeyUpd()
	checkDungeonkey()
	-- 更新标签内容
	textLabel.Text = "礦石地下城鑰匙：" .. (Ore_Dungeonkey or "0")
	textLabel2.Text = "金幣地下城鑰匙：" .. (Gold_Dungeonkey or "0")
	textLabel3.Text = "靈石地下城鑰匙：" .. (Gem_Dungeonkey or "0")
	textLabel4.Text = "符石地下城鑰匙：" .. (Rune_Dungeonkey or "0")
	textLabel5.Text = "遺物地下城鑰匙：" .. (Relic_Dungeonkey or "0")
	textLabel6.Text = "懸浮地下城鑰匙：" .. (Hover_Dungeonkey or "0")
end
spawn(function()
	while true do
		DungeonKeyUpd()
		wait(1);
	end
end);
local features = window:AddTab("其他");
local timeLabel = features:AddLabel("距離下自動獲取還有 0 秒");
local playerGui = game.Players.LocalPlayer.PlayerGui;
local Online_Gift = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("节日活动商店"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("在线奖励"):WaitForChild("列表");
local Gife_check = false;
local countdownList = {};
local hasExecutedToday = false;
local lastExecutedDay = os.date("%d");
local function convertToSeconds(timeText)
	local minutes, seconds = string.match(timeText, "(%d+):(%d+)");
	if (minutes and seconds) then
		return (tonumber(minutes) * 60) + tonumber(seconds);
	end
	return nil;
end
local function GetOnlineGiftCountdown()
	hasExecutedToday = true
	local minTime = math.huge;
	for i = 1, 6 do
		local rewardName = string.format("在线奖励%02d", i);
		local rewardFolder = Online_Gift:FindFirstChild(rewardName);
		if rewardFolder then
			local button = rewardFolder:FindFirstChild("按钮");
			local countdown = button and button:FindFirstChild("倒计时");
			if countdown then
				local countdownText = countdown.Text;
				countdownList[rewardName] = countdownText;
				if string.match(countdownText, "CLAIMED!") then
				elseif string.match(countdownText, "DONE") then
					minTime = math.min(minTime, 0);
				elseif string.match(countdownText, "%d+:%d+") then
					local totalSeconds = convertToSeconds(countdownText);
					if totalSeconds then
						--print(rewardName .. " 狀態：倒計時 - " .. countdownText .. " (" .. totalSeconds .. " 秒)");
						minTime = math.min(minTime, totalSeconds);
					end
				else
					--print(rewardName .. " 錯誤或未知狀態");
				end
			else
				--print(rewardName .. " 找不到倒計時元素，請檢查");
			end
		else
			--print(rewardName .. " 未找到，請檢查是否存在");
		end
	end
	return ((minTime < math.huge) and minTime) or nil;
end
local minCountdown = GetOnlineGiftCountdown();
local nowminCountdown = minCountdown;
local check_timers = false;
local function Online_Gift_start()
	local newMinCountdown = GetOnlineGiftCountdown();
	if (newMinCountdown and (newMinCountdown == minCountdown)) then
		check_timers = true;
	else
		check_timers = false;
	end
	if check_timers then
		nowminCountdown = nowminCountdown - 1;
	else
		minCountdown = newMinCountdown;
		nowminCountdown = minCountdown;
	end
	if (nowminCountdown and (nowminCountdown > 0)) then
		timeLabel.Text = string.format("距離下自動獲取還有 %d 秒", nowminCountdown);
	elseif (nowminCountdown and (nowminCountdown <= 0)) then
		timeLabel.Text = "倒計時結束，準備獲取獎勳";
		for i = 1, 6 do
			local args = {[1]=i};
			game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\232\138\130\230\151\165\230\180\187\229\138\168"):FindFirstChild("\233\162\134\229\143\150\229\165\150\229\138\177"):FireServer(unpack(args));
		end
	else
		timeLabel.Text = "已全部領取";
		Gife_check = false;
	end
end
local function Online_Gift_check()
	while Gife_check do
		Online_Gift_start();
		wait(1);
	end
end
features:AddButton("自動領取在線獎勳", function()
	Gife_check = true;
	spawn(Online_Gift_check);
end);
local function CheckAllRewardsCompleted()
	
	local allCompleted = true;
	GetOnlineGiftCountdown();
	for i = 1, 6 do
		local rewardName = string.format("在线奖励%02d", i);
		local status = countdownList[rewardName];
		if (not status or not string.match(status, "DONE")) then
			allCompleted = false;
			break;
		end
	end
	if allCompleted then
		print("所有在線獎勳已完成！");
		Gife_check = false;
	end
end
spawn(function()
	while Gife_check and not hasExecutedToday do
		CheckAllRewardsCompleted();
		wait(60);
	end
end);
spawn(function()
	while true do
		local currentHour = tonumber(os.date("%H"));
		local currentDay = os.date("%d");
		if ((currentHour == 1) and (lastExecutedDay ~= currentDay)) then
			hasExecutedToday = false;
			print("一點、自動領取在線獎勳");
			wait(0.1)
			Gife_check = true;
			lastExecutedDay = currentDay;
		end
		wait(60);
	end
end);

features:AddLabel(" - - 解鎖通行證");
features:AddButton("解鎖自動煉製", function()
	local superRefining = privileges:WaitForChild("超级炼制");
	superRefining.Value = false;
	local automaticRefining = privileges:WaitForChild("自动炼制");
	automaticRefining.Value = true;
end);
features:AddButton("背包擴充", function()
	local backpack = privileges:WaitForChild("扩充背包");
	backpack.Value = true;
end);


features:AddLabel(" - - 統計");
features:AddButton("每秒擊殺/金幣數", function()
	loadstring(game:HttpGet("https://pastebin.com/raw/0NqSi46N"))()
	loadstring(game:HttpGet("https://pastebin.com/raw/HGQXdAiz"))()
end);


features = window:AddTab("每日任務")
local turntabtimmer = false
local turntabletext = features:AddLabel("抽獎轉盤剩餘次數：")
local Guilddonationtext = features:AddLabel("公會捐贈剩餘次數：")
local mail_text = features:AddLabel("郵箱有郵件待領取！！")
-- 更新抽獎轉盤的次數
local function turntabletextupd()
	local turntable = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("抽奖转盘"):WaitForChild("抽奖按钮"):WaitForChild("按钮"):WaitForChild("名称").Text
    turntable = string.match(turntable, "%d+")
    turntable = tonumber(turntable) or 0

    if turntable == 0 then
        turntabletext.Text = "抽獎轉盤已完成✅"
    elseif turntabtimmer then
        local waitTime = 5  -- 設定等待的次數
        for i = waitTime, 1, -1 do
            turntabletext.Text = "請等待... " .. tostring(i)
            wait(1)
        end
		wait(0.5)
        turntabletext.Text = "領取獎勳"
        turntabtimmer = false
    else
        turntabletext.Text = "抽獎轉盤剩餘次數： " .. tostring(turntable)
    end
end
-- 檢查郵件內容
local function checkMail()
    local newMail = mailList:FindFirstChild("FallingGemsfromtheSky")
    local gamePassMail = mailList:FindFirstChild("MysteriousLetter")

    if newMail or gamePassMail then
        local newMailText = ""
        if newMail then
            newMailText = newMail:WaitForChild("领取按钮"):WaitForChild("按钮"):WaitForChild("名称").Text
        end
        local gamePassMailText = ""
        if gamePassMail then
            gamePassMailText = gamePassMail:WaitForChild("领取按钮"):WaitForChild("按钮"):WaitForChild("名称").Text
        end
        if newMailText == "Claim" or gamePassMailText ~= "Unlock" then
            --print("發現郵件未領取")
            mail_text.Text = "郵箱有郵件待領取！！"
        else
            --print("郵件已全部領取")
            mail_text.Text = "郵箱無郵件可領取。"
        end
    end
end
--12點重製郵箱子檢查
local function updateStatus()
    mailCheckCompleted = false
	--更新公會數據test
	game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\229\133\172\228\188\154"):FindFirstChild("\232\142\183\229\143\150\229\133\172\228\188\154\230\149\176\230\141\174"):FireServer(unpack(args))
end
local function checkTime()
    while true do
        local currentTime = os.date("*t")
        if currentTime.hour == 0 and currentTime.min == 0 then
            updateStatus()
            wait(60)
        else
            wait(1)
        end
    end
end
spawn(function()
    checkTime()
end)
-- 更改郵件文本
local function changeMailName()
    local mailFolder = mailList:FindFirstChild("邮件")
    if mailFolder then
        local mailNameObject = mailFolder:FindFirstChild("名称")
        if mailNameObject then
            local mailName = string.gsub(mailNameObject.Text, "%s+", "")
            mailFolder.Name = mailName
        end
    else
        mailCheckCompleted = true
        print("郵件--名稱--已全部更改")
    end
end

-- 主逻辑循环
while not mailCheckCompleted do
    changeMailName()
end


-- 更新公會捐贈的次數
local function Guilddonationudp()
    local Guilddonation = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("公会"):WaitForChild("捐献"):WaitForChild("背景"):WaitForChild("按钮"):WaitForChild("确定按钮"):WaitForChild("次数").Text
    Guilddonation = string.match(Guilddonation, "%d+")
    Guilddonation = tonumber(Guilddonation) or 0 

    if Guilddonation == 0 then
        Guilddonationtext.Text = "公會捐贈已完成✅"
    else
        Guilddonationtext.Text = "公會捐贈剩餘次數： " .. tostring(Guilddonation)
    end
end

-- 循環更新任務資訊
spawn(function()
    while true do
        turntabletextupd()
        Guilddonationudp()
		checkMail()
        wait(1)
    end
end)

-- 點擊抽獎轉盤按鈕
features:AddButton("抽獎轉盤", function()
    local remainingTurntableAttempts = tonumber(turntabletext.Text:match("%d+")) or 0
    if remainingTurntableAttempts > 0 then
        if not turntabtimmer then
            game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\232\189\172\231\155\152"):FindFirstChild("\230\138\189\229\165\150"):FireServer()
            turntabtimmer = true
        else
            print("請等待...")
        end
    else
        print("已完成轉盤")
    end
end)

-- 點擊公會捐贈按鈕
features:AddButton("公會捐贈", function()
    local Guilddonation = tonumber(Guilddonationtext.Text:match("%d+")) or 0
    if Guilddonation > 0 then
        game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\229\133\172\228\188\154"):FindFirstChild("\230\141\144\231\140\174"):FireServer()
        wait(1)
    else
        print("已完成捐贈")
    end
end)

local player = game:GetService("Players").LocalPlayer
local playerGui = player.PlayerGui
local secondscreen = playerGui.GUI:WaitForChild("二级界面")

-- ========================================================================== --
-- (父物件：任務列表容器,目標名稱：要找的物件名稱,新名稱前綴,最大數量,完成訊息)
local function initializationNameChange(parent, targetName, newNamePrefix, maxCount, completedMessage)
	if not parent then
		return
	end

	local RunService = game:GetService("RunService")
	spawn(function()
		local items = {}
		local processed = 0

		for _, child in ipairs(parent:GetChildren()) do
			if child.Name == targetName then
				table.insert(items, child)
			end
		end

		for i, item in ipairs(items) do
			if newNamePrefix then
				item.Name = newNamePrefix .. tostring(i)
			else
				item.Name = tostring(i)
			end
			processed = processed + 1
		end

		if maxCount and processed < maxCount then
			local attempts = 0
			local maxAttempts = 50 -- 最多50次
			while processed < maxCount and attempts < maxAttempts do
				local item = parent:FindFirstChild(targetName)
				if item then
					processed = processed + 1
					if newNamePrefix then
						item.Name = newNamePrefix .. tostring(processed)
					else
						item.Name = tostring(processed)
					end
				else
					attempts = attempts + 1
					RunService.Heartbeat:Wait() -- 等待一幀
				end
			end
		end
		print(completedMessage .. " (處理了 " .. processed .. " 個物件)")
	end)
end

-- 地下城專用的名稱處理函數
local function initializationDungeonNameChange(parent, targetName, completedMessage)
	if not parent then
		return
	end
	spawn(function()
		local items = {}
		local processed = 0

		for _, child in ipairs(parent:GetChildren()) do
			if child.Name == targetName then
				table.insert(items, child)
			end
		end

		for _, item in ipairs(items) do
			local nameText = item:FindFirstChild("名称")
			if nameText then
				local cleanName = string.gsub(nameText.Text, "%s+", "")
				item.Name = cleanName
				processed = processed + 1
			end
		end

		if processed == 0 then
			local RunService = game:GetService("RunService")
			local attempts = 0
			local maxAttempts = 100
			while attempts < maxAttempts do
				local item = parent:FindFirstChild(targetName)
				if item then
					local nameText = item:FindFirstChild("名称")
					if nameText then
						local cleanName = string.gsub(nameText.Text, "%s+", "")
						item.Name = cleanName
						processed = processed + 1
					end
				else
					attempts = attempts + 1
					RunService.Heartbeat:Wait()
				end
			end
		end
		print(completedMessage .. " (處理了 " .. processed .. " 個物件)")
	end)
end

-- 處理固定數量的物件
local function initializePhaseOne()

    -- 通行證任務 (固定12個)
	local gamepassmissionnamelist = secondscreen:WaitForChild("商店"):WaitForChild("通行证任务"):WaitForChild("背景"):WaitForChild("任务列表")
	initializationNameChange(gamepassmissionnamelist, "任务项预制体", nil, 12, "通行證任務--名稱--已全部更改")

    -- 每日任務 (固定7個)
	local everydaymissionnamelist = secondscreen:WaitForChild("每日任务"):WaitForChild("背景"):WaitForChild("任务列表")
	initializationNameChange(everydaymissionnamelist, "任务项预制体", nil, 7, "每日任務--名稱--已全部更改")

    -- 世界關卡 (立即處理)
	local schedule = player:WaitForChild("值"):WaitForChild("主线进度")
	local worldname = schedule:FindFirstChild("世界")
	local worldlevelsname = schedule:FindFirstChild("关卡")
	if worldname and worldlevelsname then
		worldname.Name = "world"
		worldlevelsname.Name = "levels"
		print("世界關卡--名稱--已全部更改")
	end
end

-- 處理動態數量的物件
local function initializePhaseTwo()
    -- 通行證獎勵 (動態數量)
	local gamepassgiftnnamelist = secondscreen:WaitForChild("商店"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("月通行证"):WaitForChild("背景"):WaitForChild("奖励区"):WaitForChild("奖励列表")
	initializationNameChange(gamepassgiftnnamelist, "月通行证奖励预制体", "gamepassgift", nil, "通行證獎勵--名稱--已全部更改")

    -- 郵件 (動態數量)
	local mailList = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("邮件"):WaitForChild("背景"):WaitForChild("邮件列表")
	initializationNameChange(mailList, "邮件", "mail", nil, "郵件--名稱--已全部更改")

    -- 活動商品 (動態數量)
	local eventcommodity = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("节日活动商店"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("兑换"):WaitForChild("列表")
	initializationNameChange(eventcommodity, "活动商品预制体", "eventcommodity", nil, "活動商品--名稱--已全部更改")

    -- 公會商店 (動態數量)
	local Guildshoplist = secondscreen:WaitForChild("公会"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("商店"):WaitForChild("列表")
	initializationNameChange(Guildshoplist, "活动商品预制体", "Guildshopitem", nil, "公會商店--名稱--已全部更改")

    -- 世界BOSS (動態數量)
	local Worldbosslist = secondscreen:WaitForChild("关卡选择"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("世界boss"):WaitForChild("列表")
	initializationNameChange(Worldbosslist, "世界boss关卡预制体", "worldboss", nil, "世界BOSS--名稱--已全部更改")

	-- 祝福 (動態數量)
	local Blessinglist = game:GetService("Players").LocalPlayer.PlayerGui.GUI:WaitForChild("二级界面"):WaitForChild("主角"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("小绿瓶"):WaitForChild("祝福"):waitForChild("列表")
	initializationNameChange(Blessinglist, "祝福预制体", "Blessing", nil, "祝福--名稱--已全部更改")
end

-- 處理需要文本處理的物件
local function initializePhaseThree()

    -- 地下城 (需要文本處理)
	local Dungeonslist = secondscreen:WaitForChild("关卡选择"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("副本"):WaitForChild("列表")
	initializationDungeonNameChange(Dungeonslist, "副本预制体", "地下城--名稱--已全部更改")

    -- 活動地下城 (需要文本處理)
	local Dungeonseventlist = secondscreen:WaitForChild("关卡选择"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("活动副本"):WaitForChild("列表")
	initializationDungeonNameChange(Dungeonseventlist, "活动副本预制体", "活動地下城--名稱--已全部更改")
end

local function runInitialization()
	print("=== 開始遊戲初始化命名程序 ===")

	initializePhaseOne()

	wait(0.5)
	initializePhaseTwo()

	wait(0.5)
	initializePhaseThree()
	print("=== 初始化完成 ===")
end

-- 啟動
runInitialization()
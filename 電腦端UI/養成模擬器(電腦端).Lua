local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://pastebin.com/raw/s0xZkAWA"))()
local InterfaceManager = loadstring(game:HttpGet("https://pastebin.com/raw/RDHPC0AZ"))()
--Anti afk
local AntiAFK = game:GetService("VirtualUser")
game.Players.LocalPlayer.Idled:Connect(
function()
    AntiAFK:CaptureController()
    AntiAFK:ClickButton2(Vector2.new())
    wait(2)
    --print("AFK：AFK Bypass");
end
)
--start_視窗
local Window =
    Fluent:CreateWindow(
    {
        Title = "Cultivation-Simulator 養成模擬器-電腦板UI",
        SubTitle = "作者：澤澤",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460), --(寬/高)
        Acrylic = true,
        Theme = "Dark",
        MinimizeKey = Enum.KeyCode.LeftControl
    }
)
--定義視窗子項目
--圖示：https://lucide.dev/icons/
-- ========================================================================== --
-- 標籤代碼

local Tabs = {
    PAGE = Window:AddTab({Title = "自述", Icon = "hammer"}),
    Main = Window:AddTab({Title = "Main", Icon = "play"}),
    PAGE1 = Window:AddTab({Title = "世界副本", Icon = "axe"}),
    PAGE2 = Window:AddTab({Title = "地下城", Icon = "swords"}),
    PAGE3 = Window:AddTab({Title = "抽取", Icon = "egg"}),
    PAGE4 = Window:AddTab({Title = "快速開啟", Icon = "arrow-right"}),
    Settings = Window:AddTab({Title = "設定", Icon = "settings"}),
    PAGE5 = Window:AddTab({Title = "更新日誌", Icon = "bone"})
}
--start_通知
do
    Fluent:Notify(
        {
            Title = "通知",
            Content = "腳本已載入",
            Duration = 5 -- 設為 nil 讓通知不會消失
        }
    )

    Fluent:Notify(
        {
            Title = "通知",
            Content = "Anti-AFK：Start",
            Duration = 5 -- 設為 nil 讓通知不會消失
        }
    )
end
--定義全域函數
local Options = Fluent.Options
local player = game:GetService("Players").LocalPlayer

--查找遊戲資料夾
local values = player:WaitForChild("值")
local playersetting = values:WaitForChild("设置")
local privileges = values:WaitForChild("特权")

--遊戲內部UI定義
local playerGui = player.PlayerGui
local mainmission = playerGui.GUI:WaitForChild("主界面"):WaitForChild("主城"):WaitForChild("主线任务"):WaitForChild("按钮"):WaitForChild("提示").Visible --任務UI
local missionnamelist = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("商店"):WaitForChild("通行证任务"):WaitForChild("背景"):WaitForChild("任务列表") --任務UI--gamepass
--TP重啟世界
local guiPath = playerGui.GUI:WaitForChild("主界面"):WaitForChild("战斗")
local levelInfoUI = guiPath:WaitForChild("关卡信息"):WaitForChild("文本")
local victoryResult = guiPath:WaitForChild("胜利结果")
--副本頁
local Level_settings_Value -- 關卡設置
--抽獎相關
local lottery =
    playerGui.GUI:WaitForChild("二级界面"):WaitForChild("商店"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("召唤")
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
local savemodecheck2 = false --安全模式第二次確認
local Autolotteryspeed = 0.2
-- 創建界面
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
-- 創建黑色塊
local blackBlock = Instance.new("Frame")
blackBlock.Size = UDim2.new(200, 0, 200, 0) -- 確保大小是全螢幕
blackBlock.Position = UDim2.new(0, 0, 0, 0) -- 位置在螢幕的起始點
blackBlock.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
blackBlock.Visible = false -- 初始時隱藏
blackBlock.Parent = screenGui
--特殊定義(更換遊戲內部名稱)
--任務資料夾初始化名稱
local function gamepassmissionnamechange()
    -- 檢查最終對象是否存在
    if missionnamelist then
        for i = 1, 12 do
            local gamepassmissionlist = missionnamelist:FindFirstChild("任务项预制体")
            if gamepassmissionlist then
                -- 將 LayoutOrder 值轉為字符串後設置為 Name
            gamepassmissionlist.Name = tostring(i)
            else
                --更新數據
                game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild(
                    "\229\133\172\231\148\168"
                ):FindFirstChild("\230\156\136\233\128\154\232\161\140\232\175\129"):FindFirstChild(
                    "\232\142\183\229\143\150\230\149\176\230\141\174"
                ):FireServer()
                print("任務--名稱--已全部更改")
            end
        end
    end
end
gamepassmissionnamechange()

--特殊定義(重生點設置)
local closestScene = nil
local closestPosition = nil
local closestDistance = math.huge
local localPlayer = game.Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")
for i = 1, 9 do
    local sceneName = "主场景" .. (((i > 1) and tostring(i)) or "")
    local scene = workspace:WaitForChild(sceneName, 5)
    if scene then
        local respawnPoint = scene:WaitForChild("重生点", 5)
        if respawnPoint then
            local distance = (respawnPoint.CFrame.Position - rootPart.CFrame.Position).Magnitude
            if (distance < closestDistance) then
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
if (closestScene and closestPosition) then
    print("初始場景為:", closestScene.Name)
    print("重生點座標 (x, y, z):", closestPosition.X, closestPosition.Y, closestPosition.Z)
end
--特殊定義(玩家-玩家範圍檢測)
local Players = game:GetService("Players")
local playerInRange = false
local hasPrintedNoPlayer = false
local inRange = false
local isDetectionEnabled = false
local timescheck = 0
local savemodetime = 9

local function checkPlayersInRange()
    local character = localPlayer.Character
    if (not character or not character:FindFirstChild("HumanoidRootPart")) then
        return
    end
    local boxPosition = character.HumanoidRootPart.Position
    local boxSize = Vector3.new(500, 500, 500) / 2
    playerInRange = false
    for _, player in pairs(Players:GetPlayers()) do
        if ((player ~= localPlayer) and player.Character and player.Character:FindFirstChild("HumanoidRootPart")) then
            local playerPosition = player.Character.HumanoidRootPart.Position
            local inRange =
                (math.abs(playerPosition.X - boxPosition.X) <= boxSize.X) and
                (math.abs(playerPosition.Y - boxPosition.Y) <= boxSize.Y) and
                (math.abs(playerPosition.Z - boxPosition.Z) <= boxSize.Z)
            if inRange then
                playerInRange = true
                break
            end
        end
    end
    if playerInRange then
        if (timescheck == 0) then
            print("有玩家在範圍內")
            savemodetime = 9
            timescheck = 1
            hasPrintedNoPlayer = true
        end
    elseif (timescheck == 1) then
        print("範圍內玩家已離開")
        timescheck = 0
        hasPrintedNoPlayer = false
    end
    if (not playerInRange and not hasPrintedNoPlayer) then
        print("範圍內無玩家")
        savemodetime = 3
        hasPrintedNoPlayer = true
    end
end
local function setupRangeDetection()
    while true do
        if isDetectionEnabled then
            checkPlayersInRange()
        end
        wait(0.1)
    end
end
local function toggleDetection()
    if not savemodecheck2 then
        isDetectionEnabled = true
        print("檢測已啟用")
    else
        isDetectionEnabled = false
        savemodetime = 3
        print("檢測已關閉")
    end
end
spawn(setupRangeDetection)
--特殊定義傳送(重啟世界)
local previousLevelText = levelInfoUI.Text or ""
local previousVictoryText = victoryResult.Text or ""
local levelNumber = 0
local restart = false
--處理特殊字元
local function isEmpty(text)
    return (text == nil) or (text:gsub("%s+", "") == "")
end
local function updateLevelText()
    local currentLevelText = levelInfoUI.Text
    if (not isEmpty(currentLevelText) and (currentLevelText ~= previousLevelText)) then
        previousLevelText = currentLevelText
        levelNumber = previousLevelText:match("World (%d+)") or 0
    end
end
local function updateVictoryText()
    local currentVictoryText = victoryResult.Text
    if (currentVictoryText ~= previousVictoryText) then
        previousVictoryText = currentVictoryText
        local losewave = previousVictoryText
        local victoryWaveNumber = previousVictoryText:match("Wave (%d+)") or 100
        local victoryText = previousVictoryText:match("Wave %d+ (.+)") or "結束"
        if (victoryWaveNumber == 100) then
            restart = true
        end
        if (losewave == 100) then
            restart = true
        end
    end
end
local function checkAndUpdate()
    updateLevelText()
    updateVictoryText()
end
local function restart_level()
    local number = tonumber(levelNumber:match("%d+"))
    print("重啟世界", number)
    local args = {[1] = number}
    game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild(
        "\229\133\172\231\148\168"
    ):FindFirstChild("\229\133\179\229\141\161"):FindFirstChild(
        "\232\191\155\229\133\165\228\184\150\231\149\140\229\133\179\229\141\161"
    ):FireServer(unpack(args))
end
--特殊定義(在線獎勵領取)
local Online_Gift = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("节日活动商店"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("在线奖励"):WaitForChild("列表")
local allGiftsExist = true
local localCountdownActive = false

local OnlineGift_data = {}

-- 獲取單個禮物倒數計時
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
        game:GetService("ReplicatedStorage")
            :FindFirstChild("\228\186\139\228\187\182")
            :FindFirstChild("\229\133\172\231\148\168")
            :FindFirstChild("\232\138\130\230\151\165\230\180\187\229\138\168")
            :FindFirstChild("\233\162\134\229\143\150\229\165\150\229\138\177")
            :FireServer(unpack(args))
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
--特殊定義(任務自動領取)
--主介面任務
local function mainmissionchack()
    mainmission =
        playerGui.GUI:WaitForChild("主界面"):WaitForChild("主城"):WaitForChild("主线任务"):WaitForChild("按钮"):WaitForChild("提示").Visible
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
                            game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild( "\229\133\172\231\148\168"):FindFirstChild("\230\156\136\233\128\154\232\161\140\232\175\129"):FindFirstChild("\229\174\140\230\136\144\228\187\187\229\138\161"):FireServer(unpack(args))
                            --更新數據
                            game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\230\156\136\233\128\154\232\161\140\232\175\129"):FindFirstChild("\232\142\183\229\143\150\230\149\176\230\141\174" ):FireServer()
                        end
                    end
                end
            end
        end
    end
end

--特殊定義(抽獎相關)
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
local function compare_ticket_type(
    sword_tickets,
    skill_tickets,
    sword_level,
    skill_level,
    sword_value,
    skill_value,
    diamonds,
    useDiamonds)
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

-- ========================================================================== --
-- PAGE頁 自述

--自述(PAGE)頁
Tabs.PAGE:AddParagraph(
    {
        Title = "這個UI庫不能調整字體大小,如看不到請使用手機板UI",
    }
)
Tabs.PAGE:AddParagraph(
    {
        Title = "最後更新時間：2025/01/07",
        Content = "製作時間：2024/12/20"
    }
)

Tabs.PAGE:AddButton(
    {
        Title = "手機板UI",
        Description = "包含基本功能",
        Callback = function()
            loadstring(game:HttpGet("https://pastebin.com/raw/thwJrecP"))()
        end
    }
)

Tabs.PAGE:AddButton(
    {
        Title = "開黑幕/關閉",
        Callback = function()
            print("開黑幕/關閉")
            blackBlock.Visible = not blackBlock.Visible
        end
    }
)

Tabs.PAGE:AddButton(
    {
        Title = "統計 -- 每秒擊殺/金幣數",
        Callback = function()
            loadstring(game:HttpGet("https://pastebin.com/raw/0NqSi46N"))()
            loadstring(game:HttpGet("https://pastebin.com/raw/HGQXdAiz"))()
        end
    }
)
local Toggle = Tabs.PAGE:AddToggle("SaveMode", {Title = "安全模式 -- 附近有人時不會執行快速自動開始", Default = false})
Toggle:OnChanged(
    function()
        if Toggle.Value then
            --print("安全模式", Options.SaveMode.Value)
            inRange = false
            playerInRange = false
            timescheck = 0
            hasPrintedNoPlayer = false
            savemodecheck2 = false
            toggleDetection()
        else
            savemodecheck2 = true
            toggleDetection()
        end
    end
)
Options.SaveMode:SetValue(true)
-- ========================================================================== --
-- Main頁

Tabs.Main:AddButton(
    {
        Title = "掛機模式開關",
        Callback = function()
            local AFKmod = playersetting:WaitForChild("自动战斗")
            if (AFKmod.Value == true) then
                AFKmod.Value = false
            else
                AFKmod.Value = true
            end
        end
    }
)
local Toggle = Tabs.Main:AddToggle("Autocoll", {Title = "自動領取在線獎勵", Default = false})

Toggle:OnChanged(
    function()
        -- 透過 Toggle.Value 控制是否啟動或停止
        if Toggle.Value then
            spawn(
                function()
                    while Toggle.Value do
                        checkOnlineGiftcountdown()
                        if OnlineGift_data[6] == 0 then
                            print("所有獎勵已完成，停止計時")
                            break
                        end
                        wait(1)
                    end
                end
            )
        end
    end
)
Options.Autocoll:SetValue(false)

local Toggle = Tabs.Main:AddToggle("AutoCollectherbs", {Title = "自動採草藥", Default = false})

Toggle:OnChanged(
    function()
        -- 透過 Toggle.Value 控制是否啟動或停止
        if Toggle.Value then
            spawn(
                function()
                    while Toggle.Value do
                        local args = {[1] = 1, [2] = nil}
                        game:GetService("ReplicatedStorage")["\228\186\139\228\187\182"]["\229\133\172\231\148\168"][
                            "\229\134\156\231\148\176"
                        ]["\233\135\135\233\155\134"]:FireServer(unpack(args))
                        local args = {[1] = 2, [2] = nil}
                        game:GetService("ReplicatedStorage")["\228\186\139\228\187\182"]["\229\133\172\231\148\168"][
                            "\229\134\156\231\148\176"
                        ]["\233\135\135\233\155\134"]:FireServer(unpack(args))
                        local args = {[1] = 3, [2] = nil}
                        game:GetService("ReplicatedStorage")["\228\186\139\228\187\182"]["\229\133\172\231\148\168"][
                            "\229\134\156\231\148\176"
                        ]["\233\135\135\233\155\134"]:FireServer(unpack(args))
                        local args = {[1] = 4, [2] = nil}
                        game:GetService("ReplicatedStorage")["\228\186\139\228\187\182"]["\229\133\172\231\148\168"][
                            "\229\134\156\231\148\176"
                        ]["\233\135\135\233\155\134"]:FireServer(unpack(args))
                        local args = {[1] = 5, [2] = nil}
                        game:GetService("ReplicatedStorage")["\228\186\139\228\187\182"]["\229\133\172\231\148\168"][
                            "\229\134\156\231\148\176"
                        ]["\233\135\135\233\155\134"]:FireServer(unpack(args))
                        local args = {[1] = 6, [2] = nil}
                        game:GetService("ReplicatedStorage")["\228\186\139\228\187\182"]["\229\133\172\231\148\168"][
                            "\229\134\156\231\148\176"
                        ]["\233\135\135\233\155\134"]:FireServer(unpack(args))
                        wait(60) -- 等待60秒後再次執行
                    end
                end
            )
        end
    end
)
Options.AutoCollectherbs:SetValue(false) -- 預設開啟自動採草藥

local Toggle = Tabs.Main:AddToggle("invest", {Title = "自動執行投資", Default = false})

Toggle:OnChanged(
    function()
        -- 透過 Toggle.Value 控制是否啟動或停止
        if Toggle.Value then
            spawn(
                function()
                    while Toggle.Value do
                        for i = 1, 3 do
                            local args = {i}
                            game:GetService("ReplicatedStorage")["\228\186\139\228\187\182"]["\229\133\172\231\148\168"][
                                "\229\149\134\229\186\151"
                            ]["\233\147\182\232\161\140"]["\233\162\134\229\143\150\231\144\134\232\180\162"]:FireServer(
                                unpack(args)
                            )
                            print("領取", i)
                        end
                        wait(5)
                        for i = 1, 3 do
                            local args = {i}
                            game:GetService("ReplicatedStorage")["\228\186\139\228\187\182"]["\229\133\172\231\148\168"][
                                "\229\149\134\229\186\151"
                            ]["\233\147\182\232\161\140"]["\232\180\173\228\185\176\231\144\134\232\180\162"]:FireServer(
                                unpack(args)
                            )
                            print("投資", i)
                        end
                        wait(600)
                    end
                end
            )
        end
    end
)
Options.invest:SetValue(false)

local Toggle = Tabs.Main:AddToggle("rewardstasks", {Title = "任務完成自動領取(不包括每日任務)", Default = false})

Toggle:OnChanged(
    function()
        -- 透過 Toggle.Value 控制是否啟動或停止
        spawn(
            function()
                while Toggle.Value do
                    mainmissionchack()
                    gamepassmission()
                    wait(1)
                end
            end
        )
    end
)
Options.rewardstasks:SetValue(false)

Tabs.Main:AddButton(
    {
        Title = "GamePass -- 解鎖自動煉製",
        Callback = function()
            local superRefining = privileges:WaitForChild("超级炼制")
            superRefining.Value = false
            local automaticRefining = privileges:WaitForChild("自动炼制")
            automaticRefining.Value = true
        end
    }
)

Tabs.Main:AddButton(
    {
        Title = "GamePass -- 解鎖背包擴充",
        Callback = function()
            local backpack = privileges:WaitForChild("扩充背包")
            backpack.Value = true
        end
    }
)

-- ========================================================================== --
-- PAGE1 世界副本

local Toggle = Tabs.PAGE1:AddToggle("Autostart", {Title = "戰鬥結束後自動開始(只支援世界副本)", Default = false})

Toggle:OnChanged(
    function()
        -- 透過 Toggle.Value 控制是否啟動或停止
        spawn(
            function()
                while Toggle.Value do
                    checkAndUpdate()
                    if (restart == true) then
                        rootPart.CFrame = CFrame.new(closestPosition)
                        wait(0.5)
                        wait(savemodetime)
                        restart_level()
                        wait(0.5)
                        restart = false
                    end
                    wait(0.3)
                end
            end
        )
    end
)
Options.Autostart:SetValue(false)
-- 初始化變數
Level_settings_Value = 1
Level_Value = 1

-- 創建下拉選單
local Dropdown = Tabs.PAGE1:AddDropdown("Dropdown", {
    Title = "關卡難易度選擇",
    Values = {"簡單", "普通", "困難", "專家"},
    Multi = false,
    Default = 1,
})

-- 創建滑塊
local Level_settings_slider = Tabs.PAGE1:AddSlider("Slider", {
    Title = "世界副本關卡選擇",
    Default = 1,
    Min = 1,
    Max = 20,
    Rounding = 0,
    Callback = function(Value)
        Level_Value = Level_settings_Value + Value - 1
    end
})

-- 下拉選單改變事件
Dropdown:OnChanged(function(Value)
    --print("Dropdown changed:", Value)
    
    -- 設置對應難易度的基礎關卡值
    if Value == "簡單" then
        Level_settings_Value = 1
    elseif Value == "普通" then
        Level_settings_Value = 21
    elseif Value == "困難" then
        Level_settings_Value = 41
    elseif Value == "專家" then
        Level_settings_Value = 61
    end

    -- 重置滑塊值並更新描述
    Level_Value = Level_settings_Value
    Level_settings_slider:SetValue(1)
    Level_settings_slider:SetDesc("目前關卡設置： " .. Level_Value)
end)

-- 滑塊改變事件
Level_settings_slider:OnChanged(function(Value)
    Level_Value = Level_settings_Value + Value - 1
    Level_settings_slider:SetDesc("目前關卡設置： " .. Level_Value)
end)

Tabs.PAGE1:AddButton(
    {
        Title = "世界關卡傳送",
        Callback = function()
            local args = {
                [1] = Level_Value
            }

            game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\229\133\179\229\141\161"):FindFirstChild("\232\191\155\229\133\165\228\184\150\231\149\140\229\133\179\229\141\161"):FireServer(unpack(args))
        end
    }
)

-- ========================================================================== --
-- PAGE2 地下城
Tabs.PAGE2:AddParagraph(
    {
        Title = "地下城 -- 有空再做",
    }
)

-- ========================================================================== --
-- PAGE3 抽取


local Toggle = Tabs.PAGE3:AddToggle("Autoelixir", {Title = "自動煉丹藥", Default = false})

Toggle:OnChanged(
    function()
        -- 透過 Toggle.Value 控制是否啟動或停止
        if Toggle.Value then
            spawn(
                function()
                    while Toggle.Value do
                        game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\231\130\188\228\184\185"):FindFirstChild("\229\136\182\228\189\156"):FireServer()
                        wait(0.5)
                    end
                end
            )
        end
    end
)
Options.Autoelixir:SetValue(false)

local Toggle = Tabs.PAGE3:AddToggle("Autoelixirabsorb", {Title = "自動吸收丹藥（⚠️背包裡面所有的丹藥⚠️）", Default = false})

Toggle:OnChanged(
    function()
        if Toggle.Value then
            spawn(
                function()
                    while Toggle.Value do
                        game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\228\184\185\232\141\175"):FindFirstChild("\229\144\184\230\148\182\229\133\168\233\131\168"):FireServer()
                        wait(0.7)
                    end
                end
            )
        end
    end
)
Options.Autoelixirabsorb:SetValue(false)

local Toggle = Tabs.PAGE3:AddToggle("Autolottery", {Title = "自動抽法寶/技能", Default = false})

Toggle:OnChanged(
    function()
        -- 透過 Toggle.Value 控制是否啟動或停止
        if Toggle.Value then
            spawn(
                function()
                    while Toggle.Value do
                        updateExtractedValues()
                        wait(Autolotteryspeed)
                        compare_ticket_type(
                            sword_tickets,
                            skill_tickets,
                            extract_sword_level,
                            extract_skill_level,
                            extract_sword_value,
                            extract_skill_value,
                            diamonds,
                            useDiamonds
                        )
                    end
                end
            )
        end
    end
)
Options.Autolottery:SetValue(false)

local Toggle = Tabs.PAGE3:AddToggle("USEDiamondSwitch", {Title = "使用鑽石抽取", Default = false})

Toggle:OnChanged(
    function()
        -- 透過 Toggle.Value 控制是否啟動或停止
        if Toggle.Value then
            useDiamonds = Toggle.Value
        else
            useDiamonds = false
        end
    end
)
Options.USEDiamondSwitch:SetValue(false)

local Slider =
    Tabs.PAGE3:AddSlider(
    "Slider",
    {
        Title = "抽取速度調整",
        Default = 0.2,
        Min = 0,
        Max = 1,
        Rounding = 1,
        Callback = function(Value)
            Autolotteryspeed = Value
        end
    }
)

Slider:OnChanged(
    function(Value)
        Autolotteryspeed = Value
    end
)

--特殊定義晚上12點自動重製(狀態)
local function checkTime()
    while true do
        local currentTime = os.date("*t")
        if currentTime.hour == 0 and currentTime.min == 0 then
            wait(1)
            --任務--gamepass重製
            gamepassmissionnamechange()
            wait(60)
        else
            wait(1)
        end
    end
end
spawn(
    function()
        checkTime()
    end
)


-- ========================================================================== --
-- PAGE4 快速開啟
local replicatedStorage = game:GetService("ReplicatedStorage")
Tabs.PAGE4:AddButton(
    {
        Title = "開啟每日任務",
        Callback = function()
            local event = replicatedStorage:FindFirstChild("打开每日任务", true) -- 遞歸搜尋
            if event and event:IsA("BindableEvent") then
                event:Fire("打開每日任務")
            end
        end
    }
)

Tabs.PAGE4:AddButton(
    {
        Title = "開啟郵件",
        Callback = function()
            local event = replicatedStorage:FindFirstChild("打开邮件", true) -- 遞歸搜尋
            if event and event:IsA("BindableEvent") then
                event:Fire("打开郵件")
            end
        end
    }
)

Tabs.PAGE4:AddButton(
    {
        Title = "開啟轉盤",
        Callback = function()
            local event = replicatedStorage:FindFirstChild("打开转盘", true) -- 遞歸搜尋
            if event and event:IsA("BindableEvent") then
                event:Fire("打開轉盤")
            end
        end
    }
)

Tabs.PAGE4:AddButton(
    {
        Title = "開啟陣法",
        Callback = function()
            local event = replicatedStorage:FindFirstChild("打开阵法", true) -- 遞歸搜尋
            if event and event:IsA("BindableEvent") then
                event:Fire("打开陣法")
            end
        end
    }
)

Tabs.PAGE4:AddButton(
    {
        Title = "開啟世界樹",
        Callback = function()
            local event = replicatedStorage:FindFirstChild("打开世界树", true) -- 遞歸搜尋
            if event and event:IsA("BindableEvent") then
                event:Fire("打開世界樹")
            end
        end
    }
)
-- ========================================================================== --
-- PAGE5 更新日誌
Tabs.PAGE5:AddParagraph(
    {
        Title = "2024/12/20 -- [☑️] 腳本介面由 Elerium-v2 變更為 Fluent",
        Content = "手機端依舊使用 Elerium-v2 介面, 手機版還是會更新吧!?"
    }
)
Tabs.PAGE5:AddParagraph(
    {
        Title = "2025/01/07 -- [✅] 添加在線獎勵自動領取"
    }
)
Tabs.PAGE5:AddParagraph(
    {
        Title = "2025/01/05 -- [✅] 添加對於世界副本的功能"
    }
)

Tabs.PAGE5:AddParagraph(
    {
        Title = "2025/01/05 -- [✅] 添加自動煉丹&自動吸收丹藥"
    }
)
Tabs.PAGE5:AddParagraph(
    {
        Title = "2025/01/05 -- [☑️] 修正通行證任務無法自動領取"
    }
)
Tabs.PAGE5:AddParagraph(
    {
        Title = "2024/12/27 -- [☑️] 設定語言變更為繁體中文"
    }
)



-- ========================================================================== --
-- 設定頁

Tabs.Settings:AddParagraph(
    {
        Title = "⚠️ 建議只存Main和副本的設定就好 ⚠️",
    }
)

-- 附加模組：
-- SaveManager（允許您擁有配置系統）
-- InterfaceManager（允許您擁有介面管理系統）

-- 將庫交給我們的管理器
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- 忽略由 ThemeManager 使用的鍵。
-- （我們不希望配置保存主題，對吧？）
SaveManager:IgnoreThemeSettings()

-- 您可以添加要忽略的元素索引，這樣 SaveManager 就不會保存它們
SaveManager:SetIgnoreIndexes({})

-- 使用這種方式的使用案例：
-- 一個腳本中心可以將主題放在全域資料夾中
-- 而遊戲配置則放在每個遊戲的單獨資料夾中
InterfaceManager:SetFolder("GAME_Cultivation-Simulator")
SaveManager:SetFolder("Cultivation-Simulator/By：澤澤")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

Fluent:Notify(
    {
        Title = "GAME_Cultivation-Simulator",
        Content = "腳本已經加載。",
        Duration = 8
    }
)

-- 您可以使用 SaveManager:LoadAutoloadConfig() 來加載已標記為自動加載的配置！
SaveManager:LoadAutoloadConfig()

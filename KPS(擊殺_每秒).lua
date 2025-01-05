-- 定義玩家與貨幣相關物件
local player = game:GetService("Players").LocalPlayer
local stats = player:WaitForChild("值"):WaitForChild("统计")
local killsValue = stats:WaitForChild("杀敌数")

-- 建立主 GUI
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.IgnoreGuiInset = true  -- 防止 UI 被 Roblox 隱藏

-- 建立 KPS 顯示框
local kpsFrame = Instance.new("Frame", screenGui)
kpsFrame.Size = UDim2.new(0, 200, 0, 150)
kpsFrame.Position = UDim2.new(0, 10, 1, -160) -- 預設在左下角
kpsFrame.BackgroundColor3 = Color3.new(0, 0, 0)
kpsFrame.BorderSizePixel = 2
kpsFrame.BorderColor3 = Color3.new(1, 1, 1)

-- KPS 單位切換按鈕
local unitButton = Instance.new("TextButton", kpsFrame)
unitButton.Size = UDim2.new(0, 180, 0, 30)
unitButton.Position = UDim2.new(0, 10, 0, 10) -- 位於框架頂部
unitButton.BackgroundColor3 = Color3.new(0, 0, 0)
unitButton.TextColor3 = Color3.new(1, 1, 1)
unitButton.TextScaled = true
unitButton.Text = "切換單位"
unitButton.BorderSizePixel = 2
unitButton.BorderColor3 = Color3.new(1, 1, 1)

-- KPS 顯示標籤
local kpsLabel = Instance.new("TextLabel", kpsFrame)
kpsLabel.Size = UDim2.new(0, 180, 0, 45)
kpsLabel.Position = UDim2.new(0, 10, 0, 50) -- 顯示於框架內部，單位按鈕下方
kpsLabel.BackgroundColor3 = Color3.new(0, 0, 0)
kpsLabel.TextColor3 = Color3.new(1, 1, 1)
kpsLabel.TextScaled = true
kpsLabel.TextSize = 15  -- 設置數字顯示大小為 20，調整此數值來縮小字體大小
kpsLabel.Text = "0 "
kpsLabel.BorderSizePixel = 2
kpsLabel.BorderColor3 = Color3.new(1, 1, 1)

-- 添加 "關閉並停止計算" 按鈕
local closeButton = Instance.new("TextButton", kpsFrame)
closeButton.Size = UDim2.new(0, 180, 0, 30)
closeButton.Position = UDim2.new(0, 10, 1, -40)
closeButton.BackgroundColor3 = Color3.new(1, 0, 0)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.TextScaled = true
closeButton.Text = "關閉並停止計算"
closeButton.BorderSizePixel = 1

-- 添加關閉功能
closeButton.MouseButton1Click:Connect(function()
    running = false -- 停止計算
    screenGui:Destroy() -- 移除 UI
end)

-- 初始化變數
local previousKills = killsValue.Value
local previousTime = tick() -- 使用 tick() 來記錄上次更新的時間
local running = true -- 用於控制計算循環
local units = {"秒擊殺", "分鐘擊殺", "小時擊殺", "天擊殺"} -- 切換單位的選項
local currentUnitIndex = 1 -- 當前選擇的單位索引

-- 用於存儲過去 60 秒內的 KPS 值
local kpsHistory = {}  -- 存儲每秒的 KPS

-- 函數：每秒計算 KPS
local function calculateKPS()
    local currentKills = killsValue.Value
    local currentTime = tick()  -- 使用 tick() 來獲取當前時間
    local timeDifference = currentTime - previousTime  -- 計算時間差

    -- 防止时间差过小，避免除以零
    if timeDifference == 0 then
        timeDifference = 0.1
    end

    -- 計算每秒擊殺數 (KPS)，使用除法
    local kpsValue = (currentKills - previousKills) / timeDifference

    -- 更新計算的時間和擊殺數
    previousKills = currentKills
    previousTime = currentTime

    -- 根據當前選擇的單位進行轉換
    local kpsDisplay = 0
    local unitLabel = ""

    -- 加入 KPS 值到過去的 KPS 記錄中
    table.insert(kpsHistory, kpsValue)

    -- 確保 KPS 記錄不會超過 60 條
    if #kpsHistory > 60 then
        table.remove(kpsHistory, 1)  -- 移除最舊的記錄
    end

    -- 計算 60 秒內的平均 KPS 值
    local avgKPS = 0
    for _, value in ipairs(kpsHistory) do
        avgKPS = avgKPS + value
    end
    avgKPS = avgKPS / #kpsHistory  -- 計算平均值

    -- 根據當前選擇的單位進行顯示
    if currentUnitIndex == 1 then
        -- 秒擊殺
        kpsDisplay = math.floor(kpsValue)  -- 只顯示整數
        unitLabel = string.format("%d 擊殺/秒", kpsDisplay)
    elseif currentUnitIndex == 2 then
        -- 分鐘擊殺 (用過去 60 秒的平均 KPS)
        kpsDisplay = math.floor(avgKPS * 60)  -- 每分鐘的 KPS
        unitLabel = string.format("%d 擊殺/分鐘", kpsDisplay)
    elseif currentUnitIndex == 3 then
        -- 小時擊殺
        kpsDisplay = math.floor(avgKPS * 3600)  -- 每小時的 KPS
        -- 轉換為 K (千)
        if kpsDisplay >= 1000 then
            kpsDisplay = math.floor(kpsDisplay / 1000)  -- K
            unitLabel = string.format("%d (k)擊殺/小時", kpsDisplay) -- 顯示為 "數字 K 小時擊殺"
        else
            unitLabel = string.format("%d 擊殺/小時", kpsDisplay)
        end
    elseif currentUnitIndex == 4 then
        -- 天擊殺
        kpsDisplay = math.floor(avgKPS * 86400)  -- 每天的 KPS
        -- 轉換為 K (千)
        if kpsDisplay >= 1000 then
            kpsDisplay = math.floor(kpsDisplay / 1000)  -- K
            unitLabel = string.format("%d (k)擊殺/天", kpsDisplay)
        else
            unitLabel = string.format("%d 擊殺/天", kpsDisplay)
        end
    end

    -- 更新顯示的 KPS
    kpsLabel.Text = unitLabel  -- 顯示單位，移除了 "KPS:"
end

-- 啟動 KPS 計算
task.spawn(function()
    while running do
        calculateKPS()
        task.wait(1)  -- 每 1 秒更新一次 KPS
    end
end)

-- 添加單位切換功能
unitButton.MouseButton1Click:Connect(function()
    -- 切換單位
    currentUnitIndex = currentUnitIndex % #units + 1
end)

-- 函數：支援滑鼠拖動及手指拖曳
local function enableDrag(frame)
    local dragging = false
    local dragStart, startPos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- 開啟滑動功能
enableDrag(kpsFrame)

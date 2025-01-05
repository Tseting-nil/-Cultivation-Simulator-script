-- 定義玩家與貨幣相關物件
local player = game:GetService("Players").LocalPlayer
local currency = player:WaitForChild("值"):WaitForChild("货币"):WaitForChild("金币")

-- 建立主 GUI
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.IgnoreGuiInset = true  -- 防止 UI 被 Roblox 隱藏

-- 建立 GPS 顯示框
local gpsFrame = Instance.new("Frame", screenGui)
gpsFrame.Size = UDim2.new(0, 200, 0, 150)
gpsFrame.Position = UDim2.new(0, 220, 1, -160) -- 預設在左下角
gpsFrame.BackgroundColor3 = Color3.new(0, 0, 0)
gpsFrame.BorderSizePixel = 2
gpsFrame.BorderColor3 = Color3.new(1, 1, 1)

-- GPS 單位切換按鈕
local unitButton = Instance.new("TextButton", gpsFrame)
unitButton.Size = UDim2.new(0, 180, 0, 30)
unitButton.Position = UDim2.new(0, 10, 0, 10) -- 位於框架頂部
unitButton.BackgroundColor3 = Color3.new(0, 0, 0)
unitButton.TextColor3 = Color3.new(1, 1, 1)
unitButton.TextScaled = true
unitButton.Text = "切換單位"
unitButton.BorderSizePixel = 2
unitButton.BorderColor3 = Color3.new(1, 1, 1)

-- GPS 顯示標籤
local gpsLabel = Instance.new("TextLabel", gpsFrame)
gpsLabel.Size = UDim2.new(0, 180, 0, 45)
gpsLabel.Position = UDim2.new(0, 10, 0, 50) -- 顯示於框架內部，單位按鈕下方
gpsLabel.BackgroundColor3 = Color3.new(0, 0, 0)
gpsLabel.TextColor3 = Color3.new(1, 1, 1)
gpsLabel.TextScaled = true
gpsLabel.TextSize = 20  -- 設置數字顯示大小為 20，調整此數值來縮小字體大小
gpsLabel.Text = "0 "
gpsLabel.BorderSizePixel = 2
gpsLabel.BorderColor3 = Color3.new(1, 1, 1)

-- 添加 "關閉並停止計算" 按鈕
local closeButton = Instance.new("TextButton", gpsFrame)
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
local previousGold = currency.Value
local previousTime = tick() -- 使用 tick() 來記錄上次更新的時間
local running = true -- 用於控制計算循環
local units = {"秒金幣", "分鐘金幣", "小時金幣", "天金幣"} -- 切換單位的選項
local currentUnitIndex = 1 -- 當前選擇的單位索引

-- 用於存儲過去 60 秒內的 GPS 值
local gpsHistory = {}  -- 存儲每秒的 GPS

-- 函數：每秒計算 GPS
local function calculateGPS()
    local currentGold = currency.Value
    local currentTime = tick()  -- 使用 tick() 來獲取當前時間
    local timeDifference = currentTime - previousTime  -- 計算時間差

    -- 防止时间差过小，避免除以零
    if timeDifference == 0 then
        timeDifference = 0.1
    end

    -- 計算每秒金幣數 (GPS)，使用除法
    local gpsValue = (currentGold - previousGold) / timeDifference

    -- 更新計算的時間和金幣數
    previousGold = currentGold
    previousTime = currentTime

    -- 根據當前選擇的單位進行轉換
    local gpsDisplay = 0
    local unitLabel = ""

    -- 加入 GPS 值到過去的 GPS 記錄中
    table.insert(gpsHistory, gpsValue)

    -- 確保 GPS 記錄不會超過 60 條
    if #gpsHistory > 60 then
        table.remove(gpsHistory, 1)  -- 移除最舊的記錄
    end

    -- 計算 60 秒內的平均 GPS 值
    local avgGPS = 0
    for _, value in ipairs(gpsHistory) do
        avgGPS = avgGPS + value
    end
    avgGPS = avgGPS / #gpsHistory  -- 計算平均值

    -- 根據當前選擇的單位進行顯示
    if currentUnitIndex == 1 then
        -- 秒金幣
        gpsDisplay = math.floor(gpsValue)  -- 只顯示整數
        unitLabel = string.format("%d 金幣/秒", gpsDisplay)
    elseif currentUnitIndex == 2 then
        -- 分鐘金幣 (用過去 60 秒的平均 GPS)
        gpsDisplay = math.floor(avgGPS * 60)  -- 每分鐘的 GPS
        unitLabel = string.format("%d 金幣/分鐘", gpsDisplay)
    elseif currentUnitIndex == 3 then
        -- 小時金幣
        gpsDisplay = math.floor(avgGPS * 3600)  -- 每小時的 GPS
        -- 轉換為 K (千)
        if gpsDisplay >= 1000 then
            gpsDisplay = math.floor(gpsDisplay / 1000)  -- K
            unitLabel = string.format("%d (k)金幣/小時", gpsDisplay) -- 顯示為 "數字 K 小時金幣"
        else
            unitLabel = string.format("%d 金幣/小時", gpsDisplay)
        end
    elseif currentUnitIndex == 4 then
        -- 天金幣
        gpsDisplay = math.floor(avgGPS * 86400)  -- 每天的 GPS
        -- 轉換為 K (千)
        if gpsDisplay >= 1000 then
            gpsDisplay = math.floor(gpsDisplay / 1000)  -- K
            unitLabel = string.format("%d (k)金幣/天", gpsDisplay)
        else
            unitLabel = string.format("%d 金幣/天", gpsDisplay)
        end
    end

    -- 更新顯示的 GPS
    gpsLabel.Text = unitLabel  -- 顯示單位，移除了 "GPS:"
end

-- 啟動 GPS 計算
task.spawn(function()
    while running do
        calculateGPS()
        task.wait(1)  -- 每 1 秒更新一次 GPS
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
enableDrag(gpsFrame)

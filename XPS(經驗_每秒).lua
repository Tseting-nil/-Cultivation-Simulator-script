-- 縮寫轉換函數 - 將 K/M/B 轉換為實際數值
local function convertSymbols(text)
    -- 拆分成左右兩部分
    local left, right = text:match("([^/]+)/([^/]+)")

    -- 轉換單一數字(包含縮寫)
    local function convertPart(str)
        str = str:gsub("K", "000")
        str = str:gsub("M", "000000")
        str = str:gsub("B", "000000000")
        return tonumber(str)
    end

    local leftNum = convertPart(left)
    local rightNum = convertPart(right)
    
    -- 計算百分比 (0~1 的浮點數,用於精準推算)
    local percent = 0
    if leftNum and rightNum and rightNum ~= 0 then
        percent = leftNum / rightNum
    end

    return leftNum, rightNum, percent
end

-- 精準經驗值推算 - 利用百分比減少縮寫誤差
local function getAccurateExp(text)
    local _, total, percent = convertSymbols(text)
    if not total or not percent then
        return 0
    end
    -- 透過總經驗值 × 百分比,得到更精確的當前經驗值
    return total * percent
end

-- 定義玩家與貨幣相關物件
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local currency = playerGui.GUI:WaitForChild("主界面"):WaitForChild("主城"):WaitForChild("货币区域"):WaitForChild("等级"):WaitForChild("按钮"):WaitForChild("值")

-- 建立主 GUI
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.IgnoreGuiInset = true  -- 防止 UI 被 Roblox 隱藏

-- 建立 XPS 顯示框
local xpsFrame = Instance.new("Frame", screenGui)
xpsFrame.Size = UDim2.new(0, 200, 0, 150)
xpsFrame.Position = UDim2.new(0, 430, 1, -160) -- 預設在左下角
xpsFrame.BackgroundColor3 = Color3.new(0, 0, 0)
xpsFrame.BorderSizePixel = 2
xpsFrame.BorderColor3 = Color3.new(1, 1, 1)

-- XPS 單位切換按鈕
local unitButton = Instance.new("TextButton", xpsFrame)
unitButton.Size = UDim2.new(0, 180, 0, 30)
unitButton.Position = UDim2.new(0, 10, 0, 10) -- 位於框架頂部
unitButton.BackgroundColor3 = Color3.new(0, 0, 0)
unitButton.TextColor3 = Color3.new(1, 1, 1)
unitButton.TextScaled = true
unitButton.Text = "切換單位"
unitButton.BorderSizePixel = 2
unitButton.BorderColor3 = Color3.new(1, 1, 1)

-- XPS 顯示標籤
local xpsLabel = Instance.new("TextLabel", xpsFrame)
xpsLabel.Size = UDim2.new(0, 180, 0, 45)
xpsLabel.Position = UDim2.new(0, 10, 0, 50) -- 顯示於框架內部，單位按鈕下方
xpsLabel.BackgroundColor3 = Color3.new(0, 0, 0)
xpsLabel.TextColor3 = Color3.new(1, 1, 1)
xpsLabel.TextScaled = true
xpsLabel.TextSize = 20  -- 設置數字顯示大小為 20，調整此數值來縮小字體大小
xpsLabel.Text = "0 "
xpsLabel.BorderSizePixel = 2
xpsLabel.BorderColor3 = Color3.new(1, 1, 1)

-- 添加 "關閉並停止計算" 按鈕
local closeButton = Instance.new("TextButton", xpsFrame)
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
local running = true -- 用於控制計算循環 (必須在 closeButton 之前定義)
local previousExp = getAccurateExp(currency.Text)  -- 使用精準經驗值計算
local previousTime = tick() -- 使用 tick() 來記錄上次更新的時間
local units = {"秒經驗", "分鐘經驗", "小時經驗", "天經驗"} -- 切換單位的選項
local currentUnitIndex = 1 -- 當前選擇的單位索引

-- 用於存儲過去 60 秒內的 XPS 值 (用於平滑處理)
local xpsHistory = {}  -- 存儲每秒的 XPS

-- 函數：每秒計算 XPS (基於百分比的精準計算方案)
local function calculateXPS()
    -- 使用精準經驗值推算,減少縮寫誤差
    local currentExp = getAccurateExp(currency.Text)
    local currentTime = tick()  -- 使用 tick() 來獲取當前時間
    local timeDifference = currentTime - previousTime  -- 計算時間差

    -- 防止時間差過小,避免除以零
    if timeDifference == 0 then
        timeDifference = 0.1
    end

    -- 計算每秒經驗值 (XPS),使用除法
    local xpsValue = (currentExp - previousExp) / timeDifference

    -- 異常值過濾:如果經驗值差異為負數或過大,忽略此次計算
    if xpsValue < 0 or xpsValue > 1000000000 then
        xpsValue = 0
    end

    -- 更新計算的時間和經驗值
    previousExp = currentExp
    previousTime = currentTime

    -- 根據當前選擇的單位進行轉換
    local xpsDisplay = 0
    local unitLabel = ""

    -- 加入 XPS 值到過去的 XPS 記錄中 (用於平滑處理)
    table.insert(xpsHistory, xpsValue)

    -- 確保 XPS 記錄不會超過 60 條 (保留最近 60 秒的數據)
    if #xpsHistory > 60 then
        table.remove(xpsHistory, 1)  -- 移除最舊的記錄
    end

    -- 計算 60 秒內的平均 XPS 值 (平滑處理,減少抖動)
    local avgXPS = 0
    for _, value in ipairs(xpsHistory) do
        avgXPS = avgXPS + value
    end
    avgXPS = avgXPS / #xpsHistory  -- 計算平均值

    -- 根據當前選擇的單位進行顯示 (四捨五入至整數,避免小數誤差)
    if currentUnitIndex == 1 then
        -- 秒經驗
        xpsDisplay = math.floor(xpsValue + 0.5)  -- 四捨五入
        if xpsDisplay >= 10000 then
            xpsDisplay = math.floor(xpsDisplay / 1000)  -- K
            unitLabel = string.format("%d (k)經驗/秒", xpsDisplay)
        else
            unitLabel = string.format("%d 經驗/秒", xpsDisplay)
        end
    elseif currentUnitIndex == 2 then
        -- 分鐘經驗 (用過去 60 秒的平均 XPS)
        xpsDisplay = math.floor(avgXPS * 60 + 0.5)  -- 四捨五入
        if xpsDisplay >= 10000000 then
            xpsDisplay = math.floor(xpsDisplay / 1000000)  -- M
            unitLabel = string.format("%d (M)經驗/分鐘", xpsDisplay)
        elseif xpsDisplay >= 10000 then
            xpsDisplay = math.floor(xpsDisplay / 1000)  -- K
            unitLabel = string.format("%d (k)經驗/分鐘", xpsDisplay)
        else
            unitLabel = string.format("%d 經驗/分鐘", xpsDisplay)
        end
    elseif currentUnitIndex == 3 then
        -- 小時經驗
        xpsDisplay = math.floor(avgXPS * 3600 + 0.5)  -- 四捨五入
        if xpsDisplay >= 10000000 then
            xpsDisplay = math.floor(xpsDisplay / 1000000)  -- M
            unitLabel = string.format("%d (M)經驗/小時", xpsDisplay)
        elseif xpsDisplay >= 10000 then
            xpsDisplay = math.floor(xpsDisplay / 1000)  -- K
            unitLabel = string.format("%d (k)經驗/小時", xpsDisplay)
        else
            unitLabel = string.format("%d 經驗/小時", xpsDisplay)
        end
    elseif currentUnitIndex == 4 then
        -- 天經驗
        xpsDisplay = math.floor(avgXPS * 86400 + 0.5)  -- 四捨五入
        if xpsDisplay >= 10000000 then
            xpsDisplay = math.floor(xpsDisplay / 1000000)  -- M
            unitLabel = string.format("%d (M)經驗/天", xpsDisplay)
        elseif xpsDisplay >= 10000 then
            xpsDisplay = math.floor(xpsDisplay / 1000)  -- K
            unitLabel = string.format("%d (k)經驗/天", xpsDisplay)
        else
            unitLabel = string.format("%d 經驗/天", xpsDisplay)
        end
    end

    -- 更新顯示的 XPS
    xpsLabel.Text = unitLabel  -- 顯示單位，移除了 "XPS:"
end

-- 啟動 XPS 計算
task.spawn(function()
    while running do
        calculateXPS()
        task.wait(1)  -- 每 1 秒更新一次 XPS
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
enableDrag(xpsFrame)

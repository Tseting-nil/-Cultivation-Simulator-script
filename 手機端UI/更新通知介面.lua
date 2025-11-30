local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- 創建 ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "CustomKickNotice"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

-- 背景遮罩（毛玻璃效果）
local backdrop = Instance.new("Frame")
backdrop.Size = UDim2.new(1, 0, 1, 0)
backdrop.Position = UDim2.new(0, 0, 0, 0)
backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
backdrop.BackgroundTransparency = 0.3
backdrop.BorderSizePixel = 0
backdrop.Parent = gui

-- 主框架
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 650, 0, 400)
frame.Position = UDim2.new(0.5, -325, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
frame.BorderSizePixel = 0
frame.Parent = gui

-- 添加圓角效果
local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 16)
frameCorner.Parent = frame

-- 添加陰影效果
local shadow = Instance.new("Frame")
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Position = UDim2.new(0, -5, 0, -5)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.8
shadow.BorderSizePixel = 0
shadow.ZIndex = frame.ZIndex - 1
shadow.Parent = gui

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 16)
shadowCorner.Parent = shadow

-- 頂部裝飾條
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 4)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(255, 87, 34)
topBar.BorderSizePixel = 0
topBar.Parent = frame

local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0, 16)
topBarCorner.Parent = topBar

-- 頂部遮罩（讓裝飾條只在頂部有圓角）
local topBarMask = Instance.new("Frame")
topBarMask.Size = UDim2.new(1, 0, 0, 2)
topBarMask.Position = UDim2.new(0, 0, 1, -2)
topBarMask.BackgroundColor3 = Color3.fromRGB(255, 87, 34)
topBarMask.BorderSizePixel = 0
topBarMask.Parent = topBar

-- 標題容器
local titleContainer = Instance.new("Frame")
titleContainer.Size = UDim2.new(1, -40, 0, 60)
titleContainer.Position = UDim2.new(0, 20, 0, 20)
titleContainer.BackgroundTransparency = 1
titleContainer.Parent = frame

-- 圖標
local icon = Instance.new("TextLabel")
icon.Text = "⚠️"
icon.Font = Enum.Font.GothamBold
icon.TextSize = 32
icon.Size = UDim2.new(0, 40, 0, 40)
icon.Position = UDim2.new(0, 0, 0, 10)
icon.BackgroundTransparency = 1
icon.TextColor3 = Color3.fromRGB(255, 87, 34)
icon.Parent = titleContainer

-- 標題
local title = Instance.new("TextLabel")
title.Text = "腳本更新通知"
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.Size = UDim2.new(1, -50, 0, 40)
title.Position = UDim2.new(0, 50, 0, 10)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleContainer

-- 子標題
local subtitle = Instance.new("TextLabel")
subtitle.Text = "Component Missing Detected"
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 14
subtitle.Size = UDim2.new(1, -50, 0, 20)
subtitle.Position = UDim2.new(0, 50, 1, -20)
subtitle.BackgroundTransparency = 1
subtitle.TextColor3 = Color3.fromRGB(150, 150, 150)
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = titleContainer

-- 內容區域
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -40, 0, 180)
contentFrame.Position = UDim2.new(0, 20, 0, 100)
contentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = frame

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 12)
contentCorner.Parent = contentFrame

-- 訊息內容
local message = Instance.new("TextLabel")
message.Text = "該腳本將在12/31日停止使用，目前已提供全新版本: v6.4.0腳本！\n\n請前往以下GitHub頁面下載最新版本腳本，確保您能繼續享受最佳的遊戲體驗。"
message.Font = Enum.Font.Gotham
message.TextSize = 20
message.TextWrapped = true
message.TextXAlignment = Enum.TextXAlignment.Center
message.TextYAlignment = Enum.TextYAlignment.Center
message.Size = UDim2.new(1, -20, 1, -20)
message.Position = UDim2.new(0, 10, 0, 10)
message.BackgroundTransparency = 1
message.TextColor3 = Color3.fromRGB(220, 220, 220)
message.LineHeight = 1.2
message.Parent = contentFrame

-- 按鈕容器
local buttonContainer = Instance.new("Frame")
buttonContainer.Size = UDim2.new(1, -40, 0, 60)
buttonContainer.Position = UDim2.new(0, 20, 0, 320)
buttonContainer.BackgroundTransparency = 1
buttonContainer.Parent = frame

-- 複製連結按鈕
local copyButton = Instance.new("TextButton")
copyButton.Text = "📋 複製連結"
copyButton.Font = Enum.Font.GothamSemibold
copyButton.TextSize = 20
copyButton.Size = UDim2.new(0.48, 0, 0, 50)
copyButton.Position = UDim2.new(0, 0, 0, 0)
copyButton.BackgroundColor3 = Color3.fromRGB(174, 219, 52)
copyButton.TextColor3 = Color3.fromRGB(0, 0, 0)
copyButton.BorderSizePixel = 0
copyButton.Parent = buttonContainer

local copyButtonCorner = Instance.new("UICorner")
copyButtonCorner.CornerRadius = UDim.new(0, 10)
copyButtonCorner.Parent = copyButton

-- 加入遊戲按鈕
local joinButton = Instance.new("TextButton")
joinButton.Text = "🎮 繼續遊戲"
joinButton.Font = Enum.Font.GothamSemibold
joinButton.TextSize = 20
joinButton.Size = UDim2.new(0.48, 0, 0, 50)
joinButton.Position = UDim2.new(0.52, 0, 0, 0)
joinButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
joinButton.TextColor3 = Color3.fromRGB(0, 0, 0)
joinButton.BorderSizePixel = 0
joinButton.Parent = buttonContainer

local joinButtonCorner = Instance.new("UICorner")
joinButtonCorner.CornerRadius = UDim.new(0, 10)
joinButtonCorner.Parent = joinButton

-- 動畫效果
local function createButtonAnimation(button, hoverColor, normalColor)
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    button.MouseEnter:Connect(function()
        local tween = TweenService:Create(button, tweenInfo, {
            BackgroundColor3 = hoverColor,
            Size = UDim2.new(button.Size.X.Scale, button.Size.X.Offset, button.Size.Y.Scale, button.Size.Y.Offset + 2)
        })
        tween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local tween = TweenService:Create(button, tweenInfo, {
            BackgroundColor3 = normalColor,
            Size = UDim2.new(button.Size.X.Scale, button.Size.X.Offset, button.Size.Y.Scale, button.Size.Y.Offset - 2)
        })
        tween:Play()
    end)
end

-- 應用按鈕動畫
createButtonAnimation(copyButton, Color3.fromRGB(41, 128, 185), Color3.fromRGB(52, 152, 219))
createButtonAnimation(joinButton, Color3.fromRGB(39, 174, 96), Color3.fromRGB(46, 204, 113))

-- 複製連結功能
copyButton.MouseButton1Click:Connect(function()
    setclipboard("https://github.com/Tseting-nil/Cultivation-mortal-to-immortal-script")
    local originalText = copyButton.Text
    copyButton.Text = "✅ 已複製！"
    copyButton.BackgroundColor3 = Color3.fromRGB(39, 174, 96)
    
    -- 按鈕閃爍效果
    local flashTween = TweenService:Create(copyButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
        BackgroundTransparency = 0.3
    })
    flashTween:Play()
    flashTween.Completed:Connect(function()
        local flashBack = TweenService:Create(copyButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
            BackgroundTransparency = 0
        })
        flashBack:Play()
    end)
    
    wait(2)
    copyButton.Text = originalText
    copyButton.BackgroundColor3 = Color3.fromRGB(52, 152, 219)
end)

-- 關閉 UI 功能
joinButton.MouseButton1Click:Connect(function()
    local fadeOut = TweenService:Create(gui, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Enabled = false
    })
    fadeOut:Play()
    fadeOut.Completed:Connect(function()
        gui:Destroy()
    end)
end)

-- 入場動畫
frame.Position = UDim2.new(0.5, -325, 1.5, 0)
backdrop.BackgroundTransparency = 1

local slideIn = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.5, -325, 0.5, -200)
})

local fadeIn = TweenService:Create(backdrop, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
    BackgroundTransparency = 0.3
})

slideIn:Play()
fadeIn:Play()
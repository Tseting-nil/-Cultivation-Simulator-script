-- ====================== --
--GUI結構
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local MainFrame = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.231249496, 0, 0.209756389, 0)
Frame.Size = UDim2.new(0, 1031, 0, 543)

TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = Frame
TitleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TitleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TitleLabel.BorderSizePixel = 0
TitleLabel.Size = UDim2.new(0, 1031, 0, 65)
TitleLabel.Font = Enum.Font.SourceSans
TitleLabel.Text = "公告/更新日誌"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 60.000

MainFrame.Name = "MainFrame"
MainFrame.Parent = Frame
MainFrame.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0, 0, 0.119705342, 0)
MainFrame.Size = UDim2.new(0, 1031, 0, 478)

ScrollingFrame.Parent = MainFrame
ScrollingFrame.Active = true
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Position = UDim2.new(0, 0, 0.00418410031, 0)
ScrollingFrame.Size = UDim2.new(0, 1031, 0, 476)

-- ====================== --
--排版與捲軸設定
local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 10) -- 項目間距
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = ScrollingFrame

ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollingFrame.CanvasSize = UDim2.fromOffset(0, 0)

-- ====================== --
-- 公告函式
function addAnnouncement(content)
    local label = Instance.new("TextLabel")
    label.Name = "Announcement"
    label.Size = UDim2.new(1, 0, 0, 40)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 35
    label.Text = content
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.TextWrapped = true
    label.Parent = ScrollingFrame
end

-- ====================== --
-- 間距函式
function addSpacer(height)
    local spacer = Instance.new("Frame")
    spacer.Name = "Spacer"
    spacer.Size = UDim2.new(1, 0, 0, height or 10)
    spacer.BackgroundTransparency = 1
    spacer.Parent = ScrollingFrame
end

-- ====================== --
-- 日誌函式
function addChangelog(date, version, description)
    local container = Instance.new("Frame")
    container.Name = "ChangelogEntry"
    container.Size = UDim2.new(1, 0, 0, 60)
    container.BackgroundTransparency = 1
    container.Parent = ScrollingFrame

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 2)
    layout.Parent = container

    -- 第一行：日期 + 版本號
    local header = Instance.new("TextLabel")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 20)
    header.BackgroundTransparency = 1
    header.TextColor3 = Color3.fromRGB(220, 220, 220)
    header.Font = Enum.Font.Gotham
    header.TextSize = 30
    header.Text = string.format("[%s] %s", date, version)
    header.TextXAlignment = Enum.TextXAlignment.Center
    header.TextYAlignment = Enum.TextYAlignment.Center
    header.LayoutOrder = 1
    header.Parent = container

    -- 第二行：說明文字
    local content = Instance.new("TextLabel")
    content.Name = "Content"
    content.Size = UDim2.new(1, 0, 0, 30)
    content.BackgroundTransparency = 1
    content.TextColor3 = Color3.fromRGB(200, 200, 200)
    content.Font = Enum.Font.Gotham
    content.TextSize = 30
    content.Text = description
    content.TextWrapped = true
    content.TextXAlignment = Enum.TextXAlignment.Center
    content.TextYAlignment = Enum.TextYAlignment.Top
    content.LayoutOrder = 2
    content.Parent = container

    -- 第三行：底部空白 Frame（對齊）
    local footer = Instance.new("Frame")
    footer.Name = "Footer"
    footer.Size = UDim2.new(1, 0, 0, 10)
    footer.BackgroundTransparency = 1
    footer.LayoutOrder = 3
    footer.Parent = container
end

-- ====================== --
--顯示 UI
function showUI()
    Frame.Visible = true
end

-- ====================== --
--隱藏 UI
function hideUI()
    Frame.Visible = false
end


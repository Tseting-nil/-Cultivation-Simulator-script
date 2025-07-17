-- ====================== --
-- GUI 手機版本
local function createUIMobile()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local Frame = Instance.new("Frame")
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BorderSizePixel = 0
    Frame.Position = UDim2.new(0.170963883, 0, 0.143080816, 0)
    Frame.Size = UDim2.new(0, 481, 0, 278)
    Frame.Parent = ScreenGui

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "TitleLabe"
    TitleLabel.Parent = Frame
    TitleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TitleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TitleLabel.BorderSizePixel = 0
    TitleLabel.Position = UDim2.new(-0.000929612375, 0, -3.31521878e-05, 0)
    TitleLabel.Size = UDim2.new(0, 481, 0, 34)
    TitleLabel.Font = Enum.Font.SourceSans
    TitleLabel.Text = "公告/更新日誌"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 26.000

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = Frame
    MainFrame.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
    MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0, 0, 0.125899285, 0)
    MainFrame.Size = UDim2.new(0, 481, 0, 243)

    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Parent = MainFrame
    ScrollingFrame.Active = true
    ScrollingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.Size = UDim2.new(0, 481, 0, 241)

    return {
        ScreenGui = ScreenGui,
        Frame = Frame,
        TitleLabel = TitleLabel,
        MainFrame = MainFrame,
        ScrollingFrame = ScrollingFrame,
        addAnnouncementtextsize = 25,
        addChangelogtextsize = 20
    }
end
-- ====================== --
-- GUI 平板
local function createUIPad()
    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local TitleLabe = Instance.new("TextLabel")
    local MainFrame = Instance.new("Frame")
    local ScrollingFrame = Instance.new("ScrollingFrame")

    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Frame.Parent = ScreenGui
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BorderSizePixel = 0
    Frame.Position = UDim2.new(0.10439758, 0, 0.129509449, 0)
    Frame.Size = UDim2.new(0, 853, 0, 498)

    TitleLabe.Name = "TitleLabe"
    TitleLabe.Parent = Frame
    TitleLabe.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TitleLabe.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TitleLabe.BorderSizePixel = 0
    TitleLabe.Size = UDim2.new(0, 853, 0, 65)
    TitleLabe.Font = Enum.Font.SourceSans
    TitleLabe.Text = "公告/更新日誌"
    TitleLabe.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabe.TextSize = 60.000

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = Frame
    MainFrame.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
    MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.00130656734, 0, 0.130144969, 0)
    MainFrame.Size = UDim2.new(0, 852, 0, 433)

    ScrollingFrame.Parent = MainFrame
    ScrollingFrame.Active = true
    ScrollingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.Position = UDim2.new(-0.00199195254, 0, 0.00460878853, 0)
    ScrollingFrame.Size = UDim2.new(0, 853, 0, 431)

    return {
        ScreenGui = ScreenGui,
        Frame = Frame,
        TitleLabel = TitleLabe,
        MainFrame = MainFrame,
        ScrollingFrame = ScrollingFrame,
        addAnnouncementtextsize = 25,
        addChangelogtextsize = 20
    }
end
-- ====================== --
-- GUI PC 版本
local function createUIPC()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local Frame = Instance.new("Frame")
    Frame.Parent = ScreenGui
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BorderSizePixel = 0
    Frame.Position = UDim2.new(0.231249496, 0, 0.209756389, 0)
    Frame.Size = UDim2.new(0, 1031, 0, 543)

    local TitleLabel = Instance.new("TextLabel")
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

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = Frame
    MainFrame.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
    MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0, 0, 0.119705342, 0)
    MainFrame.Size = UDim2.new(0, 1031, 0, 478)

    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Parent = MainFrame
    ScrollingFrame.Active = true
    ScrollingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.Position = UDim2.new(0, 0, 0.00418410031, 0)
    ScrollingFrame.Size = UDim2.new(0, 1031, 0, 476)

    return {
        ScreenGui = ScreenGui,
        Frame = Frame,
        TitleLabel = TitleLabel,
        MainFrame = MainFrame,
        ScrollingFrame = ScrollingFrame,
        addAnnouncementtextsize = 35,
        addChangelogtextsize = 25
    }
end


-- 裝置檢測
local function selectUI()
    local player = game.Players.LocalPlayer
    local guiService = game:GetService("GuiService")
    local screenSize = guiService:GetScreenResolution()

    if screenSize.X < 800 then
        print("📱 Mobile UI loaded")
        return createUIMobile()
    elseif screenSize.X < 1200 then
        print("🖥️ Pad UI loaded")
        return createUIPad()
    else
        print("🖥️ PC UI loaded")
        return createUIPC()
    end
end

--主程序
local UI = selectUI()
local Frame = UI.Frame
local ScrollingFrame = UI.ScrollingFrame
local addAnnouncementtextsize = UI.addAnnouncementtextsize
local addChangelogtextsize = UI.addChangelogtextsize

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 10)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = ScrollingFrame

ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollingFrame.CanvasSize = UDim2.fromOffset(0, 0)

-- ====================== --
-- 修改標題函式
function changeTitle(newTitleText)
    UI.TitleLabel.Text = newTitleText
end

-- ====================== --
-- 標題函式(比公告字體大一點)
function addTitle(titleText)
    local label = Instance.new("TextLabel")
    label.Name = "TitleEntry"
    label.Size = UDim2.new(1, 0, 0, 50) -- 高度可調整
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamBold -- 加粗字體
    label.TextSize = (addAnnouncementtextsize + 5) -- 比公告再大一點
    label.Text = titleText
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.TextWrapped = true
    label.Parent = ScrollingFrame
end

-- ====================== --
-- 公告函式
function addAnnouncement(content)
    local label = Instance.new("TextLabel")
    label.Name = "Announcement"
    label.Size = UDim2.new(1, 0, 0, 40)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = addAnnouncementtextsize
    label.Text = content
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.TextWrapped = true
    label.Parent = ScrollingFrame
end

--  空白函式：空白分隔項
function addSpacer(height)
    local spacer = Instance.new("Frame")
    spacer.Name = "Spacer"
    spacer.Size = UDim2.new(1, 0, 0, height or 10)
    spacer.BackgroundTransparency = 1
    spacer.Parent = ScrollingFrame
end

-- ====================== --
-- 更新日誌函式
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
    header.TextSize = addChangelogtextsize
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
    content.TextSize = addChangelogtextsize
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
-- UI 顯示/隱藏
function showUI()
    Frame.Visible = true
end

function hideUI()
    Frame.Visible = false
end
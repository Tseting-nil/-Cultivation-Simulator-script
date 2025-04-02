-- 創建 UI 元素來顯示錯誤信息
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")  -- 用來顯示/隱藏 UI
local TitleLabel = Instance.new("TextLabel")  -- 標題欄位
local TextLabel = Instance.new("TextLabel")

ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui
MainFrame.Parent = ScreenGui

-- 設置 MainFrame
MainFrame.Size = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Position = UDim2.new(0.25, 0, 0.2, 0)  -- 整個視窗向下移動
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.Visible = true  -- 預設顯示

-- 設置標題
TitleLabel.Parent = MainFrame
TitleLabel.Size = UDim2.new(1, 0, 0.2, 0)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)  -- 位於 Frame 內部最上方
TitleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- 略深的背景
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 30
TitleLabel.TextWrapped = true
TitleLabel.Text = ""  -- 初始化標題文字

-- 設置錯誤信息顯示區
TextLabel.Parent = MainFrame
TextLabel.Size = UDim2.new(1, 0, 0.8, 0)
TextLabel.Position = UDim2.new(0, 0, 0.2, 0)  -- 位於標題下方
TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 24
TextLabel.TextWrapped = true
TextLabel.Text = ""  -- 初始化TextLabel的文本為空

-- 更新標題
function UpdTitleUI(message)
    TitleLabel.Text = message
end

-- 更新錯誤信息
function UpdtextUI(message)
    TextLabel.Text = TextLabel.Text .. "\n" .. message
end
-- 顯示/隱藏 UI
function UIon()
    MainFrame.Visible = true
end
function UIoff()
    MainFrame.Visible = false
end

function showUItimes(num)
    UIon()
    wait(num)
    UIoff()
end

-- 顯示錯誤信息
--[[
UpdTitleUI("這是標題")
UpdtextUI("這是內容1")
UpdtextUI("這是內容2")
]]--

-- 自動關閉視窗
--showUItimes(5)

local a = loadstring(game:HttpGet("https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/%E4%B8%AD%E8%8B%B1%E8%85%B3%E6%9C%AC%E8%87%AA%E5%8B%95%E8%BC%89%E5%85%A5JSON.lua", true))()

if a == 1 then
    local HttpService = game:GetService("HttpService")

    local library = loadstring(game:HttpGet("https://pastebin.com/raw/d40xPN0c", true))()
    local switch11
    local switch22

    -- 預設的配置
    local defaultConfig = {
        MobileEnglishUI = false,
        MobileChineseUI = false,
    }

    -- 檢查本地文件是否存在，若存在則讀取配置
    local function loadConfig()
        local jsonString
        if isfile("userSettings.json") then
            jsonString = readfile("userSettings.json")
        else
            jsonString = HttpService:JSONEncode(defaultConfig)  -- 若文件不存在則返回預設配置
        end
        return HttpService:JSONDecode(jsonString)
    end

    -- 加載配置
    local config = loadConfig()

    switch11 = config.MobileEnglishUI
    switch22 = config.MobileChineseUI

    local player = game.Players.LocalPlayer
    local playerGui = player:FindFirstChild("PlayerGui")
    if not playerGui then
        warn("無法找到 PlayerGui！")
        return
    end
    -- 動態創建 ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CustomScreenGui"
    screenGui.Parent = playerGui -- 設置父級為 PlayerGui

    -- 需要複製的 URL
    local urlToCopy = "https://github.com/Tseting-nil"
    -- 顯示通知的函數
    local function showNotification(message)
        -- 創建通知框架
        local notification = Instance.new("Frame")
        notification.Size = UDim2.new(0, 300, 0, 50)
        notification.Position = UDim2.new(1, -320, 1, -120) -- 右下角
        notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        notification.BackgroundTransparency = 0.5
        notification.BorderSizePixel = 0
        notification.Parent = screenGui
        -- 添加標籤
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.Position = UDim2.new(0, 0, 0, 0)
        label.Text = message
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.GothamBold
        label.TextScaled = true
        label.Parent = notification
        -- 延遲 3 秒後刪除通知
        task.delay(3, function()
            notification:Destroy()
        end)
    end

    local window = library:AddWindow("Cultivation-Simulator-Start", {
        main_color = Color3.fromRGB(41, 74, 122),
        min_size = Vector2.new(380, 346),
        can_resize = false,
    })

    local features = window:AddTab("Language/語言選擇")
    features:Show()
    features:AddLabel("!! This is no key system script / !! 此為無密鑰系統腳本 ")
    features:AddLabel("The Original code on Github /原始碼在我的Github")
    features:AddLabel("Github：https://github.com/Tseting-nil")
    features:AddButton("Github link / Github連結",function()
        local urlToCopy = "https://github.com/Tseting-nil"
        if setclipboard then
            setclipboard(urlToCopy)
            showNotification("URL Copy！") -- 顯示提示
        else
            showNotification("Error Copy！")
        end
    end)
    features:AddLabel("")
    features:AddLabel("You can only choose one/你只能選擇一個")
    local switch1 = features:AddSwitch("MobileEnglishUI/手機英文介面", function(bool)
        switch11 = bool
    end)
    switch1:Set(switch11)
    
    local switch2 = features:AddSwitch("MobileChineseUI/手機中文介面", function(bool)
        switch22 = bool
    end)
    switch2:Set(switch22)
    
    -- 使用 while 循环强制保持两个状态相反
    spawn(function()
        while true do
            -- 如果 switch1 被选中，就强制取消 switch2
            if switch11 then
                switch22 = false
                switch2:Set(false)
            -- 如果 switch2 被选中，就强制取消 switch1
            elseif switch22 then
                switch11 = false
                switch1:Set(false)
            end
            wait(0.1) -- 每 0.1 秒检查一次状态，避免过度消耗性能
        end
    end)
    features:AddButton("Load/載入",function()
        if switch11 == true then
            loadstring(game:HttpGet('https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/English%20script.lua'))()
        elseif switch22 == true then
            loadstring(game:HttpGet('https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/chinese%20script.lua'))()
        else
            print("請選擇介面")
        end
    end)
    features:AddLabel("Save for auto load/保存當前配置為自動載入")
    features:AddButton("Save/保存",function()
        -- 保存當前配置
        local config = {
            MobileEnglishUI = switch11,
            MobileChineseUI = switch22,
            AUTOLOAD = true
        }

        local jsonString = HttpService:JSONEncode(config)
        
        -- 使用 writefile 保存到本地
        writefile("userSettings.json", jsonString)
        print("配置已保存到 userSettings.json")
    end)
end


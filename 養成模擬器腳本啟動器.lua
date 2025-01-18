
local HttpService = game:GetService("HttpService")

local library = loadstring(game:HttpGet("https://pastebin.com/raw/d40xPN0c", true))()
local switch11
local switch22

-- 預設的配置
local defaultConfig = {
    MobileEnglishUI = false,
    MobileChineseUI = false,
}

-- 嘗試讀取本地 JSON 配置檔案
local file = io.open("userSettings.json", "r")
local config
if file then
    -- 讀取檔案內容
    local jsonString = file:read("*a")
    file:close()

    -- 解碼 JSON 字串
    config = HttpService:JSONDecode(jsonString)
else
    -- 如果檔案不存在，使用預設設置並創建檔案
    config = defaultConfig
    -- 將預設設置保存到檔案
    local jsonString = HttpService:JSONEncode(config)
    local file = io.open("userSettings.json", "w")
    if file then
        file:write(jsonString)
        file:close()
    else
        print("無法創建檔案。")
    end
end

switch11 = config.MobileEnglishUI
switch22 = config.MobileChineseUI

local window = library:AddWindow("Cultivation-Simulator-Start", {
    main_color = Color3.fromRGB(41, 74, 122),
    min_size = Vector2.new(350, 346),
    can_resize = false,
})

local features = window:AddTab("Language/語言選擇")
features:Show()

local switch1 = features:AddSwitch("MobileEnglishUI/手機英文介面", function(bool)
    switch11 = bool
end)
switch1:Set(switch11)

local switch2 = features:AddSwitch("MobileChineseUI/手機中文介面", function(bool)
    switch22 = bool
end)
switch2:Set(switch22)

features:AddButton("AutoLoad/自動載入",function()
    if switch11 == true then
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/English%20script.lua'))()
    elseif switch22 == true then
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/chinese%20script.lua'))()
    else
        print("請選擇介面")
    end

    -- 保存當前配置
    local config = {
        MobileEnglishUI = switch11,
        MobileChineseUI = switch22,
    }

    local jsonString = HttpService:JSONEncode(config)
    
    -- 保存到本地檔案
    local file = io.open("userSettings.json", "w")
    if file then
        file:write(jsonString)
        file:close()
    else
        print("無法開啟檔案進行寫入。")
    end
end)


local HttpService = game:GetService("HttpService")

-- 預設配置
local defaultConfig = {
    MobileEnglishUI = false,
    MobileChineseUI = false,
    AUTOLOAD = false
}

-- 檢測 userSettings.json 是否已存在並創建文件（如果不存在）
function createConfigFileIfNotExists()
    if not isfile("userSettings.json") then
        -- 如果文件不存在，將配置轉換為 JSON 格式
        local jsonString = HttpService:JSONEncode(defaultConfig)
        -- 創建並儲存 JSON 文件
        writefile("userSettings.json", jsonString)
        print("配置文件已創建並儲存為 userSettings.json")
    else
        print("userSettings.json 已存在")
    end
end

-- 刪除 userSettings.json 配置文件
function deleteConfigFile()
    if isfile("userSettings.json") then
        -- 使用 delfile 刪除文件
        delfile("userSettings.json")
        print("配置文件 userSettings.json 已刪除。")
    else
        print("配置文件 userSettings.json 不存在，無法刪除。")
    end
end

-- 從本地讀取配置文件
local function loadConfig()
    local jsonString
    local success, err = pcall(function()
        jsonString = readfile("userSettings.json")
    end)

    if success and jsonString then
        -- 解碼 JSON 字符串
        local config = HttpService:JSONDecode(jsonString)
        return config
    else
        print("配置文件讀取失敗或不存在，使用預設配置。")
        return defaultConfig
    end
end

-- 創建配置文件（如果不存在）
createConfigFileIfNotExists()


-- deleteConfigFile()  -- 如果需要刪除文件，請使用這行並把註解刪除

-- 加載配置
local config = loadConfig()

-- 顯示當前配置
print("手機英文介面：" .. tostring(config.MobileEnglishUI))
print("手機中文介面：" .. tostring(config.MobileChineseUI))

-- 在 GUI 或腳本中使用加載的配置
if config.MobileEnglishUI then
    -- 加載英文界面腳本
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/English%20script.lua"))()
    return 2
elseif config.MobileChineseUI then
    -- 加載中文界面腳本
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/chinese%20script.lua"))()
    return 2
else
    print("請選擇介面。")
    return 1
end

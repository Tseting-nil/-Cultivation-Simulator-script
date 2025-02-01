local HttpService = game:GetService("HttpService")

local function showNotification(message)
    local notification = Instance.new("Frame");
    notification.Size = UDim2.new(0, 300, 0, 50);
    notification.Position = UDim2.new(1, -320, 1, -120);
    notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    notification.BackgroundTransparency = 0.5;
    notification.BorderSizePixel = 0;
    notification.Parent = screenGui;
    local label = Instance.new("TextLabel");
    label.Size = UDim2.new(1, 0, 1, 0);
    label.Position = UDim2.new(0, 0, 0, 0);
    label.Text = message;
    label.TextColor3 = Color3.fromRGB(255, 255, 255);
    label.BackgroundTransparency = 1;
    label.Font = Enum.Font.GothamBold;
    label.TextScaled = true;
    label.Parent = notification;
    task.delay(3, function()
        notification:Destroy();
    end);
end

-- 預設配置
local defaultConfig = {
    MobileEnglishUI = false,
    MobileChineseUI = false,
    AUTOLOAD = false
}

-- 檢測 Cultivation_languageSet.json 是否已存在並創建文件（如果不存在）
function createConfigFileIfNotExists()
    if not isfile("Cultivation_languageSet.json") then
        -- 如果文件不存在，將配置轉換為 JSON 格式
        local jsonString = HttpService:JSONEncode(defaultConfig)
        -- 創建並儲存 JSON 文件
        writefile("Cultivation_languageSet.json", jsonString)
        print("配置文件已創建並儲存為 Cultivation_languageSet.json")
    else
        print("Cultivation_languageSet.json 已存在")
    end
end

-- 刪除 Cultivation_languageSet.json 配置文件
function deleteConfigFile()
    if isfile("Cultivation_languageSet.json") then
        -- 使用 delfile 刪除文件
        delfile("Cultivation_languageSet.json")
        print("配置文件 Cultivation_languageSet.json 已刪除。")
    else
        print("配置文件 Cultivation_languageSet.json 不存在，無法刪除。")
    end
end

-- 從本地讀取配置文件
local function loadConfig()
    local jsonString
    local success, err = pcall(function()
        jsonString = readfile("Cultivation_languageSet.json")
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
    showNotification("Loading...en-script");
    -- 加載英文界面腳本
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/English%20script.lua"))()
    return 2
elseif config.MobileChineseUI then
    showNotification("載入中...中文腳本");
    -- 加載中文界面腳本
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/chinese%20script.lua"))()
    return 2
else
    print("請選擇介面。")
    return 1
end

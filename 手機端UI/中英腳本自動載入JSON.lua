local HttpService = game:GetService("HttpService")

-- 預設的配置
local defaultConfig = {
    MobileEnglishUI = false,
    MobileChineseUI = false,
}

-- 嘗試讀取本地 JSON 配置檔案
local file = io.open("userSettings.json", "r")  -- 以讀取模式打開檔案
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
    local file = io.open("userSettings.json", "w")  -- 以寫入模式創建檔案
    if file then
        file:write(jsonString)  -- 寫入 JSON 字串
        file:close()  -- 關閉檔案
    else
        print("無法創建檔案。")
    end
end

local switch11 = config.MobileEnglishUI
local switch22 = config.MobileChineseUI

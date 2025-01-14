local httpService = game:GetService("HttpService")

local JsonHandler = {}

-- 初始化並讀取 JSON 檔案
local function initializeAndReadJson(filePath)
    assert(type(filePath) == "string", "檔案路徑必須是字符串類型")
    if not isfile(filePath) then
        writefile(filePath, httpService:JSONEncode({}))
    end

    local fileContent = readfile(filePath)
    local success, data = pcall(httpService.JSONDecode, httpService, fileContent)
    if not success then
        error("無法解析 JSON 檔案: " .. filePath)
    end
    return data
end

-- 寫入 JSON 檔案
local function writeJson(filePath, data)
    assert(type(data) == "table", "寫入的數據必須是表類型")
    writefile(filePath, httpService:JSONEncode(data))
end

-- 獲取玩家資料，如果不存在則初始化
function JsonHandler.getPlayerData(filePath, playerName)
    local data = initializeAndReadJson(filePath)

    -- 初始化玩家數據
    if not data[playerName] then
        data[playerName] = {
            OreDungeonMaxLevel = 1,
            GemDungeonMaxLevel = 1,
            GoldDungeonMaxLevel = 1,
            RelicDungeonMaxLevel = 1,
            RuneDungeonMaxLevel = 1,
            HoverDungeonMaxLevel = 1,
        }
        writeJson(filePath, data)
    end
    return data[playerName]
end

-- 更新玩家資料
function JsonHandler.updatePlayerData(filePath, playerName, updates)
    local data = initializeAndReadJson(filePath)

    -- 確保玩家數據存在
    if not data[playerName] then
        data[playerName] = {
            OreDungeonMaxLevel = 1,
            GemDungeonMaxLevel = 1,
            GoldDungeonMaxLevel = 1,
            RelicDungeonMaxLevel = 1,
            RuneDungeonMaxLevel = 1,
            HoverDungeonMaxLevel = 1,
        }
    end

    -- 更新數據
    for key, value in pairs(updates) do
        data[playerName][key] = value
    end

    writeJson(filePath, data)
end

-- 更新副本的最高等級
function JsonHandler.updateDungeonMaxLevel(filePath, playerName, dungeonChoice, dungeonMaxLevel)
    local playerData = JsonHandler.getPlayerData(filePath, playerName)

    -- 動態生成字段名
    local dungeonKey = dungeonChoice:gsub(" ", "") .. "MaxLevel"
    if playerData[dungeonKey] and playerData[dungeonKey] ~= dungeonMaxLevel then
        playerData[dungeonKey] = dungeonMaxLevel
        JsonHandler.updatePlayerData(filePath, playerName, { [dungeonKey] = dungeonMaxLevel })
        print("玩家資料已更新: " .. dungeonChoice .. " 等級: " .. dungeonMaxLevel)
    end
end

-- 簡易字段更新方法
function JsonHandler.updateField(filePath, playerName, field, value)
    assert(type(field) == "string", "字段名稱必須是字符串類型")
    local data = initializeAndReadJson(filePath)

    -- 確保玩家數據存在
    if not data[playerName] then
        data[playerName] = {}
    end

    -- 更新指定字段
    data[playerName][field] = value
    writeJson(filePath, data)
    print("更新完成: " .. playerName .. " 的 " .. field .. " 設為 " .. tostring(value))
end

return JsonHandler

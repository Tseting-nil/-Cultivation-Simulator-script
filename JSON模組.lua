local httpService = game:GetService("HttpService")

local JsonHandler = {}

-- 初始化 JSON 檔案
function JsonHandler.initializeJsonFile(filePath)
    assert(type(filePath) == "string", "檔案路徑必須是字符串類型")
    if not isfile(filePath) then
        writefile(filePath, httpService:JSONEncode({}))
    end
end

-- 獲取玩家資料，如果不存在則初始化
function JsonHandler.getPlayerData(filePath, playerName)
    JsonHandler.initializeJsonFile(filePath)

    local fileContent = readfile(filePath)
    local success, data = pcall(httpService.JSONDecode, httpService, fileContent)
    if not success then
        error("無法解析JSON檔案: " .. filePath)
    end

    if not data[playerName] then
        data[playerName] = {
            OreDungeonMaxLevel = 1,
            GemDungeonMaxLevel = 1,
            GoldDungeonMaxLevel = 1,
            RelicDungeonMaxLevel = 1,
            RuneDungeonMaxLevel = 1,
            HoverDungeonMaxLevel = 1,
        }
        writefile(filePath, httpService:JSONEncode(data))
    end
    return data[playerName]
end

-- 更新玩家資料
function JsonHandler.updatePlayerData(filePath, playerName, updates)
    JsonHandler.initializeJsonFile(filePath)

    local fileContent = readfile(filePath)
    local success, data = pcall(httpService.JSONDecode, httpService, fileContent)
    if not success then
        error("無法解析JSON檔案: " .. filePath)
    end

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

    -- 更新玩家資料
    for key, value in pairs(updates) do
        data[playerName][key] = value
    end

    writefile(filePath, httpService:JSONEncode(data))
end

-- 更新副本的最高等級
function JsonHandler.updateDungeonMaxLevel(filePath, playerName, dungeonChoice, dungeonMaxLevel)
    local playerData = JsonHandler.getPlayerData(filePath, playerName)

    -- 檢查並更新資料
    local dungeonKey = dungeonChoice:gsub(" ", "") .. "MaxLevel"
    if playerData[dungeonKey] and playerData[dungeonKey] ~= dungeonMaxLevel then
        playerData[dungeonKey] = dungeonMaxLevel
        JsonHandler.updatePlayerData(filePath, playerName, playerData)
        print("玩家資料已更新: " .. dungeonChoice .. " 等級: " .. dungeonMaxLevel)
    end
end

return JsonHandler

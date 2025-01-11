local httpService = game:GetService("HttpService")
--遊戲內部資料夾名稱更改(優先度最高)
loadstring(game:HttpGet('https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/%E9%81%8A%E6%88%B2%E7%89%A9%E4%BB%B6%E5%90%8D%E7%A8%B1%E6%9B%BF%E6%8F%9B.lua'))()
local player = game.Players.LocalPlayer
local playerGui = player.PlayerGui
-- 示例檔案路徑
local filePath = "DungeonsMaxLevel.json"  -- 確保這是有效的字符串
local playerName = player.Name


-- 初始化JSON檔案，如果檔案不存在則創建一個空的JSON檔案
local function initializeJsonFile(filePath)
    -- 確保傳遞的 filePath 是有效的字符串路徑
    if type(filePath) ~= "string" then
        error("檔案路徑必須是字符串類型")
    end

    if not isfile(filePath) then
        writefile(filePath, httpService:JSONEncode({}))
    end
end

-- 獲取指定玩家的資料，如果資料不存在，則創建一個預設的資料
local function getPlayerData(filePath, playerName)
    initializeJsonFile(filePath)  -- 確保檔案存在並已初始化
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

-- 獲取並更新副本的最高等級
local function getDungeonMaxLevel()
    local dungeonChoice = playerGui:WaitForChild("GUI"):WaitForChild("二级界面"):WaitForChild("关卡选择"):WaitForChild("副本选择弹出框"):WaitForChild("背景"):WaitForChild("标题"):WaitForChild("名称").Text
    local dungeonMaxLevel = tonumber(playerGui:WaitForChild("GUI"):WaitForChild("二级界面"):WaitForChild("关卡选择"):WaitForChild("副本选择弹出框"):WaitForChild("背景"):WaitForChild("难度"):WaitForChild("难度等级"):WaitForChild("值").Text)

    local playerData = getPlayerData(filePath, player.Name) -- 取得玩家當前資料

    -- 檢查資料是否需要更新
    local updated = false
    if dungeonChoice == "Ore Dungeon" and playerData.OreDungeonMaxLevel ~= dungeonMaxLevel then
        playerData.OreDungeonMaxLevel = dungeonMaxLevel
        updated = true
    elseif dungeonChoice == "Gem Dungeon" and playerData.GemDungeonMaxLevel ~= dungeonMaxLevel then
        playerData.GemDungeonMaxLevel = dungeonMaxLevel
        updated = true
    elseif dungeonChoice == "Gold Dungeon" and playerData.GoldDungeonMaxLevel ~= dungeonMaxLevel then
        playerData.GoldDungeonMaxLevel = dungeonMaxLevel
        updated = true
    elseif dungeonChoice == "Relic Dungeon" and playerData.RelicDungeonMaxLevel ~= dungeonMaxLevel then
        playerData.RelicDungeonMaxLevel = dungeonMaxLevel
        updated = true
    elseif dungeonChoice == "Rune Dungeon" and playerData.RuneDungeonMaxLevel ~= dungeonMaxLevel then
        playerData.RuneDungeonMaxLevel = dungeonMaxLevel
        updated = true
    elseif dungeonChoice == "Hover Dungeon" and playerData.HoverDungeonMaxLevel ~= dungeonMaxLevel then
        playerData.HoverDungeonMaxLevel = dungeonMaxLevel
        updated = true
    end

    -- 如果資料有更新才進行儲存
    if updated then
        local fileContent = readfile(filePath)
        local success, data = pcall(httpService.JSONDecode, httpService, fileContent)
        if success then
            data[player.Name] = playerData
            writefile(filePath, httpService:JSONEncode(data))
            print("玩家資料已更新並儲存: " .. dungeonChoice .. " 等級: " .. dungeonMaxLevel)
        else
            error("無法解析JSON檔案: " .. filePath)
        end
    end
end

-- 每秒更新副本最高等級
spawn(function()
    while true do
        getDungeonMaxLevel()
        wait(1)
    end
end)

local playerData = getPlayerData(filePath, playerName)
-- 打印玩家初始資料
print("玩家初始資料:")
for key, value in pairs(playerData) do
    print(key, value)
end

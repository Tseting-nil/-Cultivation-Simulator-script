local playerGui = game.Players.LocalPlayer.PlayerGui
local Online_Gift = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("节日活动商店"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("在线奖励"):WaitForChild("列表")
local allGiftsExist = true
local localCountdownActive = false

local OnlineGift_data = {}

-- 獲取單個禮物倒數計時
local function getGiftCountdown(index)
    local gift = Online_Gift:FindFirstChild("Online_Gift" .. index)
    if not gift then return nil end
    local countdownText = gift:FindFirstChild("按钮"):FindFirstChild("倒计时").Text
    if countdownText == "CLAIMED!" then
        return 0
    elseif countdownText == "DONE" then
        -- 執行遠程代碼以領取獎勵
        local args = {
            [1] = index -- 傳遞當前獎勵的索引
        }
        game:GetService("ReplicatedStorage")
            :FindFirstChild("\228\186\139\228\187\182")
            :FindFirstChild("\229\133\172\231\148\168")
            :FindFirstChild("\232\138\130\230\151\165\230\180\187\229\138\168")
            :FindFirstChild("\233\162\134\229\143\150\229\165\150\229\138\177")
            :FireServer(unpack(args))
        return 0 -- 回傳 0 表示該獎勵已完成
    else
        local minutes, seconds = countdownText:match("^(%d+):(%d+)$")
        if minutes and seconds then
            return tonumber(minutes) * 60 + tonumber(seconds)
        end
    end
    return nil
end

-- 檢查所有禮物倒數計時
local function checkOnlineGiftcountdown()
    -- 初始化變數
    local minCountdown = math.huge
    local Countdown = {}

    -- 獲取每個禮物的倒數計時
    for i = 1, 6 do
        local totalSeconds = getGiftCountdown(i)
        if totalSeconds then
            Countdown[i] = totalSeconds
            OnlineGift_data[i] = totalSeconds
            if totalSeconds < minCountdown and totalSeconds > 0 then
                minCountdown = totalSeconds
            end
        else
            Countdown[i] = nil
        end
    end

    -- 處理本地倒數計時
    if minCountdown ~= math.huge then
        if localCountdownActive then
            for i = 1, 6 do
                if Countdown[i] and Countdown[i] > 0 then
                    Countdown[i] = Countdown[i] - 1
                    local minutes = math.floor(Countdown[i] / 60)
                    local seconds = Countdown[i] % 60
                    local formattedTime = string.format("%02d:%02d", minutes, seconds)
                    Online_Gift:FindFirstChild("Online_Gift" .. i):FindFirstChild("按钮"):FindFirstChild("倒计时").Text = formattedTime
                end
            end
            minCountdown = minCountdown - 1
            --print("使用本地倒數計時，距離下次領取還有：" .. minCountdown .. "秒")
        else
            --print("距離下次領取還有：" .. minCountdown .. "秒")
        end
    end
end

-- 初始化並更改在線獎勵名稱
for i = 1, 6 do
    local giftName = "在线奖励0" .. i
    local gift = Online_Gift:FindFirstChild(giftName)
    if gift then
        gift.Name = "Online_Gift" .. tostring(gift.LayoutOrder + 1)
        --print("名稱已更改為：" .. gift.Name)
    else
        allGiftsExist = false
        break
    end
end

if allGiftsExist then
    print("在線獎勵--名稱--已全部更改")
else
    print("名稱已重複或部分名稱不存在")
end

-- 主循環：檢查並更新倒數計時
while true do
    checkOnlineGiftcountdown()
    if OnlineGift_data[6] == 0 then
        print("所有獎勵已完成，停止計時")
        break
    end
    wait(1)
end

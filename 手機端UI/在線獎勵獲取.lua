local playerGui = game.Players.LocalPlayer.PlayerGui
local Online_Gift = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("节日活动商店"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("在线奖励"):WaitForChild("列表")

local countdownList = {}  -- 用來儲存每個在線獎勳的倒計時文本
local countdownSeconds = {}  -- 用來儲存每個倒計時的秒數

local function GetOnlineGiftCountdown()

    -- 循環處理每個在線獎勳
    for i = 1, 6 do
        local rewardName = string.format("在线奖励%02d", i)
        local rewardFolder = Online_Gift:WaitForChild(rewardName, 5)
        
        if rewardFolder then
            local button = rewardFolder:WaitForChild("按钮", 5)
            local countdown = button and button:WaitForChild("倒计时", 5)
            
            if countdown then
                -- 儲存倒計時文本
                countdownList[rewardName] = countdown.text
            end
        end
    end

    -- 将倒计时文本转为秒数
    local function convertToSeconds(timeText)
        local minutes, seconds = string.match(timeText, "(%d+):(%d+)")
        if minutes and seconds then
            return tonumber(minutes) * 60 + tonumber(seconds)
        end
        return nil
    end

    -- 檢查每個倒計時的值
    local minTime = math.huge  --初始無窮大
    for i = 1, 6 do
        local rewardName = string.format("在线奖励%02d", i)
        local countdownText = countdownList[rewardName]

        -- 提取倒計時文本並判斷
        if countdownText then
            -- 如果狀態是 CLAIMED! 則跳過此獎勳
            if string.match(countdownText, "CLAIMED!") then
                print(rewardName .. " 狀態: 已領取，跳過")
            -- 如果是 DONE，表示已完成，執行遠程代碼
            elseif string.match(countdownText, "DONE") then
                print(rewardName .. " 狀態: 已完成")
                -- 遠程代碼執行
                local args = {
                    [1] = i  -- 傳遞對應的獎勳號碼 (1~6)
                }
                game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\232\138\130\230\151\165\230\180\187\229\138\168"):FindFirstChild("\233\162\134\229\143\150\229\165\150\229\138\177"):FireServer(unpack(args))

            -- 數字格式轉換成秒
            elseif string.match(countdownText, "%d+:%d+") then
                local totalSeconds = convertToSeconds(countdownText)
                if totalSeconds then
                    countdownSeconds[rewardName] = totalSeconds
                    print(rewardName .. " 狀態：到計時 - " .. countdownText .. " (" .. totalSeconds .. " 秒)")
                    -- 更新最小秒數
                    if totalSeconds < minTime then
                        minTime = totalSeconds
                    end
                end
            else
                print(rewardName .. " 錯誤 ")
            end
        end
    end

    -- 輸出最小秒數
    if minTime < math.huge then
        print("最小倒計時 " .. minTime .. " 秒")
    else
        print("未找到有效到計時")
    end

    return minTime
end


GetOnlineGiftCountdown()


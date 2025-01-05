-- 定義玩家與貨幣相關物件
local player = game:GetService("Players").LocalPlayer
local playerGui = player.PlayerGui
local lottery = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("商店"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("召唤")
local currency = player:WaitForChild("值"):WaitForChild("货币")
local diamonds = currency:WaitForChild("钻石")
--抽獎卷UI
local sword_tickets = currency:WaitForChild("法宝抽奖券").value
local skill_tickets = currency:WaitForChild("技能抽奖券").value
--法寶UI
local sword = lottery:WaitForChild("法宝"):WaitForChild("等级区域")
local sword_level = sword:WaitForChild("值").text
local sword_value = sword:WaitForChild("进度条"):WaitForChild("值"):WaitForChild("值").text
--技能UI
local skill = lottery:WaitForChild("技能"):WaitForChild("等级区域")
local skill_level = skill:WaitForChild("值").text
local skill_value = skill:WaitForChild("进度条"):WaitForChild("值"):WaitForChild("值").text
--數值
local extract_sword_level
local extract_sword_value
local extract_skill_level
local extract_skill_value
--狀態
local useDiamonds = false
-- 抽獎功能
local function usesword_ticket()
    print("抽獎：法寶")
    local args = {
        [1] = "\230\179\149\229\174\157",
        [2] = false
    }

    game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\229\149\134\229\186\151"):FindFirstChild("\229\143\172\229\148\164"):FindFirstChild("\230\138\189\229\165\150"):FireServer(unpack(args))
end
local function useskill_ticket()
    print("抽獎：技能")
    local args = {
        [1] = "\230\138\128\232\131\189",
        [2] = false
    }
    game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\229\149\134\229\186\151"):FindFirstChild("\229\143\172\229\148\164"):FindFirstChild("\230\138\189\229\165\150"):FireServer(unpack(args))

end

-- 配置參數
local MIN_TICKETS = 8         -- 最低抽獎券需求
local DIAMONDS_PER_TICKET = 50 -- 每張抽獎券需要的鑽石數量

-- 判斷是否可以使用抽獎券或鑽石補充
local function checkTicketsAndDiamonds(tickets, diamonds, itemType, useDiamonds)
    if tickets >= MIN_TICKETS then
        print(itemType .. "抽獎券足夠")
        return true
    end

    -- 計算缺少的抽獎券
    local missingTickets = MIN_TICKETS - tickets
    print(itemType .. "抽獎券不足，需要補充 " .. missingTickets .. " 張")

    if not useDiamonds then
        print(itemType .. "未啟用鑽石補充")
        return false
    end

    -- 計算補充所需的鑽石數量
    local requiredDiamonds = missingTickets * DIAMONDS_PER_TICKET
    if diamonds >= requiredDiamonds then
        print("鑽石足夠，將使用 " .. requiredDiamonds .. " 鑽石補充 " .. missingTickets .. " 張抽獎券")
        return true
    else
        print("鑽石不足，無法補充")
        return false
    end
end

-- 自動抽獎邏輯
local function processLottery(type, tickets, diamonds, useDiamonds)
    local canProceed = checkTicketsAndDiamonds(tickets, diamonds, type, useDiamonds)
    if canProceed then
        print("執行抽獎：" .. type)
        if type == "法寶" then
            usesword_ticket()
        elseif type == "技能" then
            useskill_ticket()
        end
    else
        print(type .. "條件未滿足，抽獎失敗")
    end
    return canProceed
end

-- 比較抽獎邏輯
local function compare_ticket_type(sword_tickets, skill_tickets, sword_level, skill_level, sword_value, skill_value, diamonds, useDiamonds)
    if sword_level == skill_level then
        if sword_value > skill_value then
            print("法寶進度 > 技能進度，優先使用技能抽獎券")
            processLottery("技能", skill_tickets, diamonds, useDiamonds)
        elseif sword_value < skill_value then
            print("法寶進度 < 技能進度，優先使用法寶抽獎券")
            processLottery("法寶", sword_tickets, diamonds, useDiamonds)
        else
            print("法寶進度 = 技能進度，同時使用")
            local canSword = processLottery("法寶", sword_tickets, diamonds, useDiamonds)
            local canSkill = processLottery("技能", skill_tickets, diamonds, useDiamonds)
            if not canSword and not canSkill then
                print("兩種抽獎券均不足，無法抽獎")
            end
        end
    elseif sword_level > skill_level then
        print("法寶等級 > 技能等級，優先使用技能抽獎券")
        processLottery("技能", skill_tickets, diamonds, useDiamonds)
    else
        print("法寶等級 < 技能等級，優先使用法寶抽獎券")
        processLottery("法寶", sword_tickets, diamonds, useDiamonds)
    end
end

-- 數據提取函數
local function fetchData()
    sword_level = sword:WaitForChild("值").Text
    sword_value = sword:WaitForChild("进度条"):WaitForChild("值"):WaitForChild("值").Text
    skill_level = skill:WaitForChild("值").Text
    skill_value = skill:WaitForChild("进度条"):WaitForChild("值"):WaitForChild("值").Text
    sword_tickets = currency:WaitForChild("法宝抽奖券").Value
    skill_tickets = currency:WaitForChild("技能抽奖券").Value
    diamonds = currency:WaitForChild("钻石").Value
end

local function updateExtractedValues()
    fetchData()
    extract_sword_level = tonumber(string.match(sword_level, "%d+"))
    extract_sword_value = tonumber(string.match(sword_value, "^(%d+)/"))
    extract_skill_level = tonumber(string.match(skill_level, "%d+"))
    extract_skill_value = tonumber(string.match(skill_value, "^(%d+)/"))
end

updateExtractedValues()
useDiamonds = false
compare_ticket_type(sword_tickets, skill_tickets, extract_sword_level, extract_skill_level, extract_sword_value, extract_skill_value, diamonds, useDiamonds)

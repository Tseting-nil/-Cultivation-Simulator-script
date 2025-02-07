local player = game:GetService("Players").LocalPlayer
local playerGui = game.Players.LocalPlayer.PlayerGui
--定義技能區
local lotteryskill = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("商店"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("召唤"):WaitForChild("技能")
local skilllevel = lotteryskill:WaitForChild("等级区域"):WaitForChild("值").text
skilllevel = string.gsub(skilllevel, "%D", "")
local skilllevel2 = lotteryskill:WaitForChild("等级区域"):WaitForChild("进度条"):WaitForChild("值"):WaitForChild("值").text
skilllevel2 = string.match(skilllevel2, "(%d+)/")
--定義法寶區
local lotteryweapon = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("商店"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("召唤"):WaitForChild("法宝")
local weaponlevel = lotteryweapon:WaitForChild("等级区域"):WaitForChild("值").text
weaponlevel = string.gsub(weaponlevel, "%D", "")
local weaponlevel2 = lotteryweapon:WaitForChild("等级区域"):WaitForChild("进度条"):WaitForChild("值"):WaitForChild("值").text
weaponlevel2 = string.match(weaponlevel2, "(%d+)/")
--定義貨幣區
local currency = player:WaitForChild("值"):WaitForChild("货币")
local diamonds = currency:WaitForChild("钻石")
local sword_tickets = currency:WaitForChild("法宝抽奖券").value
local skill_tickets = currency:WaitForChild("技能抽奖券").value
--定義抽獎相關參數
local useDiamonds = false
local Autolotteryspeed = 0.3 --不宜太快，遊戲抽獎為延遲抽獎
--更新/獲取數據
local function updData()
    skilllevel = lotteryskill:WaitForChild("等级区域"):WaitForChild("值").text
    skilllevel = string.gsub(skilllevel, "%D", "") or 0
    skilllevel2 = lotteryskill:WaitForChild("等级区域"):WaitForChild("进度条"):WaitForChild("值"):WaitForChild("值").text
    skilllevel2 = string.match(skilllevel2, "(%d+)/") or 0
    weaponlevel = lotteryweapon:WaitForChild("等级区域"):WaitForChild("值").text
    weaponlevel = string.gsub(weaponlevel, "%D", "") or 0
    weaponlevel2 = lotteryweapon:WaitForChild("等级区域"):WaitForChild("进度条"):WaitForChild("值"):WaitForChild("值").text
    weaponlevel2 = string.match(weaponlevel2, "(%d+)/") or 0
    diamonds = currency:WaitForChild("钻石").value
    sword_tickets = currency:WaitForChild("法宝抽奖券").value
    skill_tickets = currency:WaitForChild("技能抽奖券").value
    print("技能等級："..skilllevel.."技能進度："..skilllevel2)
    print("法寶等級："..weaponlevel.."法寶進度："..weaponlevel2)
    print("鑽石："..diamonds.."法寶抽獎券："..sword_tickets.."技能抽獎券："..skill_tickets)
end
local function useskill_ticket()
    print("抽獎：技能")
    local args = {
        [1] = "\230\138\128\232\131\189",
        [2] = false
    }
    game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\229\149\134\229\186\151"):FindFirstChild("\229\143\172\229\148\164"):FindFirstChild("\230\138\189\229\165\150"):FireServer(unpack(args))
end
local function usesword_ticket()
    print("抽獎：法寶")
    local args = {
        [1] = "\230\179\149\229\174\157",
        [2] = false
    }
    game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\229\149\134\229\186\151"):FindFirstChild("\229\143\172\229\148\164"):FindFirstChild("\230\138\189\229\165\150"):FireServer(unpack(args))
end

--判斷區(判斷：抽獎券是否足夠)
local function Compareskilltickets()
    if skill_tickets <= 8 and useDiamonds then
        if diamonds >= 400 then
            local compare = 8 - tonumber(skill_tickets)
            print("技能抽獎券不足，使用鑽石補足："..compare.."張")
            print("鑽石消耗："..compare*50)
            useskill_ticket()
        else
            print("鑽石不足")
        end
    elseif skill_tickets >= 8  then
        print("技能抽獎券足夠")
        useskill_ticket()
    else
        print("技能抽獎券不足且沒開啟鑽石補足")
    end
end
local function Compareweapentickets()
    if sword_tickets <= 8 and useDiamonds then
        if diamonds > 400 then
            local compare = 8 - tonumber(sword_tickets)
            print("法寶抽獎券不足，使用鑽石補足："..compare.."張")
            print("鑽石消耗："..compare*50)
            usesword_ticket()
        else
            print("鑽石不足")
        end
    elseif sword_tickets >= 8  then
        print("法寶抽獎券足夠")
        usesword_ticket()
    else
        print("法寶抽獎券不足且沒開啟鑽石補足")
    end
end
--判斷區(判斷：進度)
local function Compareprogress()
    if skilllevel2 > weaponlevel2 then
        print("法寶進度小於技能進度")
        Compareweapentickets()
    elseif skilllevel2 < weaponlevel2 then
        print("技能進度小於法寶進度")
        Compareskilltickets()
    else
        print("技能進度等於法寶進度")
        Compareskilltickets()
        Compareweapentickets()
    end
end

--判斷區(判斷：等級)
local function Comparelevel()
    updData()
    if skilllevel > weaponlevel then
        usesword_ticket()
        print("法寶等級小於技能等級")
    elseif skilllevel < weaponlevel then
        useskill_ticket()
        print("技能等級小於法寶等級")
    else
        print("技能等級等於法寶等級")
        Compareprogress()
    end
end
Comparelevel()
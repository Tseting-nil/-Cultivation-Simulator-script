local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local Dungeonslist = playerGui:WaitForChild("GUI"):WaitForChild("二级界面"):WaitForChild("关卡选择"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("副本"):WaitForChild("列表")
local DungeonDungeon = Dungeonslist:FindFirstChild("副本预制体")
local Dungeonnamechangechick = false
local Ore_Dungeonkey, Gem_Dungeonkey, Gold_Dungeonkey, Relic_Dungeonkey, Rune_Dungeonkey, Hover_Dungeonkey

--獲取副本鑰匙值
local function checkDungeonkey()
    Ore_Dungeonkey = string.match(Dungeonslist.OreDungeon:WaitForChild("钥匙"):WaitForChild("值").Text, "^%d+")
    Gem_Dungeonkey = string.match(Dungeonslist.GemDungeon:WaitForChild("钥匙"):WaitForChild("值").Text, "^%d+")
    Gold_Dungeonkey = string.match(Dungeonslist.GoldDungeon:WaitForChild("钥匙"):WaitForChild("值").Text, "^%d+")
    Relic_Dungeonkey = string.match(Dungeonslist.RelicDungeon:WaitForChild("钥匙"):WaitForChild("值").Text, "^%d+")
    Rune_Dungeonkey = string.match(Dungeonslist.RuneDungeon:WaitForChild("钥匙"):WaitForChild("值").Text, "^%d+")
    Hover_Dungeonkey  = string.match(Dungeonslist.HoverDungeon:WaitForChild("钥匙"):WaitForChild("值").Text, "^%d+")
end

--更改副本文件名稱
local function Dungeonnamechange()
    if DungeonDungeon then
        local dungeonFolder = Dungeonslist:FindFirstChild("副本预制体")
        if dungeonFolder then
            local dungeonsname = dungeonFolder:FindFirstChild("名称")
            dungeonsname = dungeonsname.Text
            dungeonsname = string.gsub(dungeonsname, "%s+", "")
            dungeonFolder.Name = dungeonsname
        else
            Dungeonnamechangechick = true
            print("地下城--名稱--已全部更改")
            checkDungeonkey()
        end
    end
end

while not Dungeonnamechangechick do
    Dungeonnamechange()
    task.wait(0.1)
end

task.wait(5)
print("礦石副本:", Ore_Dungeonkey,"金幣副本:", Gold_Dungeonkey ,"靈石副本:", Gem_Dungeonkey,"符石副本:", Rune_Dungeonkey,"遺物副本:", Relic_Dungeonkey,"懸浮地牢:",Hover_Dungeonkey)
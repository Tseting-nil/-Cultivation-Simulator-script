local player = game:GetService("Players").LocalPlayer;
local playerGui = player.PlayerGui;
--遊戲內部資料夾名稱更改(優先度最高)
loadstring(game:HttpGet('https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/%E9%81%8A%E6%88%B2%E7%89%A9%E4%BB%B6%E5%90%8D%E7%A8%B1%E6%9B%BF%E6%8F%9B.lua'))()
local mainmission = playerGui.GUI:WaitForChild("主界面"):WaitForChild("主城"):WaitForChild("主线任务"):WaitForChild("按钮"):WaitForChild("提示").Visible
local missionnamelist = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("商店"):WaitForChild("通行证任务"):WaitForChild("背景"):WaitForChild("任务列表")
local everydaymissionnamelist = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("每日任务"):WaitForChild("背景"):WaitForChild("任务列表")
local gamepassgiftnnamelist = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("商店"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("月通行证"):WaitForChild("背景"):WaitForChild("奖励区"):WaitForChild("奖励列表")
-- ========================================================================== --
-- 主線任務
function mainmissionchack()
    mainmission = playerGui.GUI:WaitForChild("主界面"):WaitForChild("主城"):WaitForChild("主线任务"):WaitForChild("按钮"):WaitForChild("提示").Visible 
    --print(mainmission)
    if mainmission == true then
        print("任務完成，可領取")
        game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\228\184\187\231\186\191\228\187\187\229\138\161"):FindFirstChild("\233\162\134\229\143\150\229\165\150\229\138\177"):FireServer()
    end
end
-- ========================================================================== --
-- 每日任務
function everydaymission()
    if everydaymissionnamelist then
        for _, child in ipairs(everydaymissionnamelist:GetChildren()) do
            if child:IsA("Frame") and child.Visible == true then
                --print("找到目的物件:", child.Name)
                local missionname = child.Name
                missionname = tonumber(missionname)
                -- 確保 child 中有名稱這個子物件
                local nameLabel = child:WaitForChild("名称")
                if nameLabel then
                    -- 提取任務進度 "0/100"
                    local taskProgress = nameLabel.Text:match("%((%d+/%d+)%)")
                    if taskProgress then
                        -- 分割數字並轉換為數字類型
                        local A_num, B_num = taskProgress:match("(%d+)%/(%d+)")
                        A_num = tonumber(A_num)
                        B_num = tonumber(B_num)
                        -- 判斷比例是否大於等於 1
                        if A_num and B_num and A_num / B_num >= 1 then
                            print("可領取")
                            local args = {
                                [1] = missionname
                            }

                            game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\230\175\143\230\151\165\228\187\187\229\138\161"):FindFirstChild("\233\162\134\229\143\150\229\165\150\229\138\177"):FireServer(unpack(args))
                       end
                    end
                end
            end
        end
    end
end
-- ========================================================================== --
-- 通行證任務
function gamepassmission()
    local udpdata = false
    if missionnamelist then
        for _, child in ipairs(missionnamelist:GetChildren()) do
            if child:IsA("Frame") and child.Visible == true then
                --print("找到目的物件:", child.Name)
                local missionname = child.Name
                missionname = tonumber(missionname)
                -- 確保 child 中有名稱這個子物件
                local nameLabel = child:WaitForChild("名称")
                if nameLabel then
                    -- 提取任務進度 "0/100"
                    local taskProgress = nameLabel.Text:match("%((%d+/%d+)%)")
                    if taskProgress then
                        -- 分割數字並轉換為數字類型
                        local A_num, B_num = taskProgress:match("(%d+)%/(%d+)")
                        A_num = tonumber(A_num)
                        B_num = tonumber(B_num)
                        -- 判斷比例是否大於等於 1
                        if A_num and B_num and A_num / B_num >= 1 then
                            print("可領取")
                            local args = {
                                [1] = missionname
                            }
                            game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\230\156\136\233\128\154\232\161\140\232\175\129"):FindFirstChild("\229\174\140\230\136\144\228\187\187\229\138\161"):FireServer(unpack(args))
                            --更新數據
                            if not udpdata then
                                game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\230\156\136\233\128\154\232\161\140\232\175\129"):FindFirstChild("\232\142\183\229\143\150\230\149\176\230\141\174"):FireServer()
                                udpdata = true
                            end
                        end
                    end
                end
            end
        end
    end
end
-- ========================================================================== --
-- 通行證獎勳
local function gamepassgiftdraw(num, havepadgamepass)
    local args = {
        [1] = 1, -- 免費通行證
        [2] = num -- 等級
    }
    game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\230\156\136\233\128\154\232\161\140\232\175\129"):FindFirstChild("\233\162\134\229\143\150"):FireServer(unpack(args))
    if havepadgamepass then
        local args = {
            [1] = 2, -- 付費通行證
            [2] = num -- 等級
        }
        game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\230\156\136\233\128\154\232\161\140\232\175\129"):FindFirstChild("\233\162\134\229\143\150"):FireServer(unpack(args))
    end
end

local padgamepassnamecheck = false
local padgamepassnamecheck2 = false
function gamepassgiftget()
    local padgamepass = game:GetService("Players").LocalPlayer.PlayerGui.GUI["\228\186\140\231\186\167\231\149\140\233\157\162"]["\229\149\134\229\186\151"]["\232\131\140\230\153\175"]["\229\143\179\228\190\167\231\149\140\233\157\162"]["\230\156\136\233\128\154\232\161\140\232\175\129"]["\232\131\140\230\153\175"]["\229\165\150\229\138\177\229\140\186"]["\229\165\150\229\138\177\229\136\151\232\161\168"]:GetChildren()[4]["\233\187\132\233\135\145"]["\232\131\140\230\153\175"]["\228\184\138\233\148\129"].Visible
    if gamepassgiftnnamelist then
        if padgamepass and not padgamepassnamecheck then
            print("無付費通行證")
            padgamepassnamecheck = true
        end
    end

    -- 使用寫死的for迴圈遍歷通行證獎勳（最多50）
    for index = 1, 50 do
        local namegamepassgif = gamepassgiftnnamelist:WaitForChild("gamepassgift" .. tostring(index))  -- 直接尋找對應的gamepassgift
        if namegamepassgif then
            -- 分別等待所需的子物件
            local giftgetgcheck = namegamepassgif:WaitForChild("进度预制体"):WaitForChild("进度").Visible
            local giftgetgcheck2 = namegamepassgif:WaitForChild("免费"):WaitForChild("背景"):WaitForChild("领取图标").Visible

            if giftgetgcheck and padgamepass and not giftgetgcheck2 then
                padgamepassnamecheck2 = false
                gamepassgiftdraw(index, true)
            elseif giftgetgcheck and not padgamepass and not giftgetgcheck2 then
                padgamepassnamecheck2 = false
                gamepassgiftdraw(index, false)
            elseif not giftgetgcheck and not padgamepassnamecheck2 then
                print("目前沒有通行證獎勳可領取")
                padgamepassnamecheck2 = true
                break
            end
        end
    end
end


--[[
--控制開關    
    mainmissionchack()
    everydaymission()
    gamepassmission()
    gamepassgiftget()
]]


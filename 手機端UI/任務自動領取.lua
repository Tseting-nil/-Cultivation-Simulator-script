local player = game:GetService("Players").LocalPlayer;
local playerGui = player.PlayerGui;
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
    if havepadgamepass then
        local args = {
            [1] = 2, -- 付費通行證
            [2] = num -- 等級
        }
        game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\230\156\136\233\128\154\232\161\140\232\175\129"):FindFirstChild("\233\162\134\229\143\150"):FireServer(unpack(args))
        warn("已領取付費通行證獎勵等級"..num)
    end
    local args = {
        [1] = 1, -- 免費通行證
        [2] = num -- 等級
    }
    game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\230\156\136\233\128\154\232\161\140\232\175\129"):FindFirstChild("\233\162\134\229\143\150"):FireServer(unpack(args))   
    print("已領取通行證獎勵等級"..num)
end
local padgamepass = true
local gamepassnamecheck = false
function gamepassgiftget()
    -- 使用for迴圈遍歷通行證獎勳（最多50）
    for index = 1, 50 do
        local namegamepassgif = gamepassgiftnnamelist:WaitForChild("gamepassgift" .. tostring(index))  -- 直接尋找對應的gamepassgift
         -- 分別等待所需的子物件
        local giftgetgcheck = namegamepassgif:WaitForChild("进度预制体"):WaitForChild("进度").Visible
        local giftgetgcheck2 = namegamepassgif:WaitForChild("免费"):WaitForChild("背景"):WaitForChild("领取图标").Visible -- 判斷通行證領取狀態(True代表以領取)
        local giftgetgcheck3 = namegamepassgif:WaitForChild("黄金"):WaitForChild("背景"):WaitForChild("领取图标").Visible -- 判斷通行證領取狀態(True代表以領取)
        padgamepass = namegamepassgif:WaitForChild("黄金"):WaitForChild("背景"):WaitForChild("上锁").Visible -- 判斷通行證上鎖(上鎖代表沒有購買付費通行證)
        --有付費通行證但未領取通行證獎勵
        if giftgetgcheck and not padgamepass and (not giftgetgcheck3 or not giftgetgcheck2) then
            gamepassgiftdraw(index, true)
            gamepassnamecheck = false
        elseif giftgetgcheck and padgamepass and not giftgetgcheck2 then
            gamepassgiftdraw(index, false)
            gamepassnamecheck = false
        elseif not giftgetgcheck and not gamepassnamecheck then
            print("目前沒有通行證獎勳可領取")
            gamepassnamecheck = true
            break
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


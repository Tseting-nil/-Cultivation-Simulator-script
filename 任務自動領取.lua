local player = game:GetService("Players").LocalPlayer;
local playerGui = player.PlayerGui;
--遊戲內部資料夾名稱更改(優先度最高)
loadstring(game:HttpGet('https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/%E9%81%8A%E6%88%B2%E7%89%A9%E4%BB%B6%E5%90%8D%E7%A8%B1%E6%9B%BF%E6%8F%9B.lua'))()
local mainmission = playerGui.GUI:WaitForChild("主界面"):WaitForChild("主城"):WaitForChild("主线任务"):WaitForChild("按钮"):WaitForChild("提示").Visible
local missionnamelist = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("商店"):WaitForChild("通行证任务"):WaitForChild("背景"):WaitForChild("任务列表")
local everydaymissionnamelist = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("每日任务"):WaitForChild("背景"):WaitForChild("任务列表")
function mainmissionchack()
    mainmission = playerGui.GUI:WaitForChild("主界面"):WaitForChild("主城"):WaitForChild("主线任务"):WaitForChild("按钮"):WaitForChild("提示").Visible 
    --print(mainmission)
    if mainmission == true then
        print("任務完成，可領取")
        game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\228\184\187\231\186\191\228\187\187\229\138\161"):FindFirstChild("\233\162\134\229\143\150\229\165\150\229\138\177"):FireServer()
    end
end

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

function gamepassmission()
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
                            game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\230\156\136\233\128\154\232\161\140\232\175\129"):FindFirstChild("\232\142\183\229\143\150\230\149\176\230\141\174"):FireServer()
                        end
                    end
                end
            end
        end
    end
end
--[[
--控制開關    
    mainmissionchack()
    everydaymission()
    gamepassmission()
]]


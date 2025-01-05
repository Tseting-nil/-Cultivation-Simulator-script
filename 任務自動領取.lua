local player = game:GetService("Players").LocalPlayer;
local playerGui = player.PlayerGui;
local mainmission = playerGui.GUI:WaitForChild("主界面"):WaitForChild("主城"):WaitForChild("主线任务"):WaitForChild("按钮"):WaitForChild("提示").Visible
local namechangechick = false
local missionnamelist = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("商店"):WaitForChild("通行证任务"):WaitForChild("背景"):WaitForChild("任务列表")
local function gamepassmissionnamechange()
    -- 檢查最終對象是否存在
    if missionnamelist then
        local gamepassmissionlist = missionnamelist:FindFirstChild("任务项预制体")
        if gamepassmissionlist then
            -- 獲取 LayoutOrder 的值
            local gamepassmissionLayoutOrder = gamepassmissionlist.LayoutOrder

            -- 將 LayoutOrder 值轉為字符串後設置為 Name
            gamepassmissionlist.Name = tostring(gamepassmissionLayoutOrder)

            -- 打印結果
            --print("LayoutOrder:", gamepassmissionLayoutOrder)
            --print("New Name:", gamepassmissionlist.Name)
        else
            -- 未找到 "任务项预制体"
            print("任務--名稱--已全部更改")
            namechangechick = true
        end
    end
end
while not namechangechick do
    gamepassmissionnamechange()
end

local function mainmissionchack()
    mainmission = playerGui.GUI:WaitForChild("主界面"):WaitForChild("主城"):WaitForChild("主线任务"):WaitForChild("按钮"):WaitForChild("提示").Visible 
    --print(mainmission)
    if mainmission == true then
        print("任務完成，可領取")
        game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\228\184\187\231\186\191\228\187\187\229\138\161"):FindFirstChild("\233\162\134\229\143\150\229\165\150\229\138\177"):FireServer()
    end
end

local function gamepassmission()
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

mainmissionchack()
gamepassmission()
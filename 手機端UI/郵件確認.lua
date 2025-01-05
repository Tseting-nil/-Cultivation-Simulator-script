local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local mailList = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("邮件"):WaitForChild("背景"):WaitForChild("邮件列表")

local mailCheckCompleted = false

--12點重製郵箱子檢查
local function updateStatus()
    mailCheckCompleted = false
end
local function checkTime()
    while true do
        local currentTime = os.date("*t")
        if currentTime.hour == 0 and currentTime.min == 0 then
            updateStatus()
            wait(60)
        else
            wait(1)
        end
    end
end
spawn(function()
    checkTime()
end)

-- 檢查郵件內容
local function checkMail()
    local newMail = mailList:FindFirstChild("FallingGemsfromtheSky")
    local gamePassMail = mailList:FindFirstChild("MysteriousLetter")

    if newMail or gamePassMail then
        local newMailText = ""
        if newMail then
            newMailText = newMail:WaitForChild("领取按钮"):WaitForChild("按钮"):WaitForChild("名称").Text
        end

        local gamePassMailText = ""
        if gamePassMail then
            gamePassMailText = gamePassMail:WaitForChild("领取按钮"):WaitForChild("按钮"):WaitForChild("名称").Text
        end

        if newMailText == "Claim" or gamePassMailText ~= "Unlock" then
            print("發現郵件未領取")
        else
            print("郵件已全部領取")
        end
    else
        print("郵件--名稱--未更改")
    end
end

-- 更改郵件文本
local function changeMailName()
    local mailFolder = mailList:FindFirstChild("邮件")
    if mailFolder then
        local mailNameObject = mailFolder:FindFirstChild("名称")
        if mailNameObject then
            local mailName = string.gsub(mailNameObject.Text, "%s+", "")
            mailFolder.Name = mailName
        end
    else
        mailCheckCompleted = true
        print("郵件--名稱--已全部更改")
    end
end

-- 主逻辑循环
while not mailCheckCompleted do
    changeMailName()
end
checkMail()

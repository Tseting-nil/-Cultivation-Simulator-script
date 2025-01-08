local player = game:GetService("Players").LocalPlayer;
local playerGui = player.PlayerGui;
local missionnamelist = playerGui.GUI:WaitForChild("二级界面"):WaitForChild("商店"):WaitForChild("通行证任务"):WaitForChild("背景"):WaitForChild("任务列表")
local namechangechick = false
--任務資料夾初始化名稱
local function gamepassmissionnamechange()
	-- 檢查最終對象是否存在
	if missionnamelist then
		local gamepassmissionlist = missionnamelist:FindFirstChild("任务项预制体")
		if gamepassmissionlist then
			-- 獲取 LayoutOrder 的值
			local gamepassmissionLayoutOrder = gamepassmissionlist.LayoutOrder
			-- 將 LayoutOrder 值轉為字符串後設置為 Name
			gamepassmissionlist.Name = tostring(gamepassmissionLayoutOrder)
		else
			--更新數據
			game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\230\156\136\233\128\154\232\161\140\232\175\129"):FindFirstChild("\232\142\183\229\143\150\230\149\176\230\141\174"):FireServer()
			print("任務--名稱--已全部更改")
			namechangechick = true
		end
	end
end
while not namechangechick do
	gamepassmissionnamechange()
end
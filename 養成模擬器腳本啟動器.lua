local a = loadstring(game:HttpGet("https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/%E4%B8%AD%E8%8B%B1%E8%85%B3%E6%9C%AC%E8%87%AA%E5%8B%95%E8%BC%89%E5%85%A5JSON.lua", true))()

if a == 1 then
    local HttpService = game:GetService("HttpService")

    local library = loadstring(game:HttpGet("https://pastebin.com/raw/d40xPN0c", true))()
    local switch11
    local switch22

    -- 預設的配置
    local defaultConfig = {
        MobileEnglishUI = false,
        MobileChineseUI = false,
    }

    -- 檢查本地文件是否存在，若存在則讀取配置
    local function loadConfig()
        local jsonString
        if isfile("Cultivation_languageSet.json") then
            jsonString = readfile("Cultivation_languageSet.json")
        else
            jsonString = HttpService:JSONEncode(defaultConfig)  -- 若文件不存在則返回預設配置
        end
        return HttpService:JSONDecode(jsonString)
    end

    -- 加載配置
    local config = loadConfig()

    switch11 = config.MobileEnglishUI
    switch22 = config.MobileChineseUI

    local player = game.Players.LocalPlayer
    local playerGui = player:FindFirstChild("PlayerGui")
    if not playerGui then
        warn("無法找到 PlayerGui！")
        return
    end
    -- 動態創建 ScreenGui
    local screenGui = Instance.new("ScreenGui");
	screenGui.Name = "CustomScreenGui";
	screenGui.Parent = playerGui;
	local urlToCopy = "https://github.com/Tseting-nil";
	local function showNotification(message)
		local notification = Instance.new("Frame");
		notification.Size = UDim2.new(0, 300, 0, 50);
		notification.Position = UDim2.new(1, -320, 1, -120);
		notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
		notification.BackgroundTransparency = 0.5;
		notification.BorderSizePixel = 0;
		notification.Parent = screenGui;
		local label = Instance.new("TextLabel");
		label.Size = UDim2.new(1, 0, 1, 0);
		label.Position = UDim2.new(0, 0, 0, 0);
		label.Text = message;
		label.TextColor3 = Color3.fromRGB(255, 255, 255);
		label.BackgroundTransparency = 1;
		label.Font = Enum.Font.GothamBold;
		label.TextScaled = true;
		label.Parent = notification;
		task.delay(3, function()
			notification:Destroy();
		end);
	end
	local window = library:AddWindow("Cultivation-Simulator-Start", {main_color=Color3.fromRGB(41, 74, 122),min_size=Vector2.new(380, 346),can_resize=false});
	local features = window:AddTab("Language/語言選擇");
	features:Show();
	features:AddLabel("Version：1.0 / 版本：1.0");
	features:AddLabel("The Original code on Github /原始碼在我的Github");
	features:AddButton("Github link / Github連結", function()
		local urlToCopy = "https://github.com/Tseting-nil";
		if setclipboard then
			setclipboard(urlToCopy);
			showNotification("URL Copy！");
		else
			showNotification("Error Copy！");
		end
	end);
	features:AddLabel("");
	local switch1 = features:AddSwitch("MobileEnglishUI/手機英文介面", function(bool)
		switch11 = bool;
	end);
	switch1:Set(switch11);
	local switch2 = features:AddSwitch("MobileChineseUI/手機中文介面", function(bool)
		switch22 = bool;
	end);
	switch2:Set(switch22);
	spawn(function()
		while true do
			if switch11 then
				switch22 = false;
				switch2:Set(false);
			end
			if switch22 then
				switch11 = false;
				switch1:Set(false);
			end
			wait(0.1);
		end
	end);
	features:AddButton("Load/載入", function()
		if (switch11 == true) then
            showNotification("Loading...");
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/English%20script.lua"))();
		
        elseif (switch22 == true) then
            showNotification("載入中...");
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/chinese%20script.lua"))();
		else
			print("請選擇介面");
		end
	end);
	features:AddLabel("Save for auto load/保存當前配置為自動載入");
	features:AddButton("Save/保存", function()
		local config = {MobileEnglishUI=switch11,MobileChineseUI=switch22,AUTOLOAD=true};
		local jsonString = HttpService:JSONEncode(config);
		writefile("Cultivation_languageSet.json", jsonString);
		print("配置已保存到 Cultivation_languageSet.json");
        showNotification("Config Save!!");
	end);
end

local a=loadstring(game:HttpGet("https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/imgui_en%E9%9D%A2%E6%9D%BF.lua",true))()function showNotification(b)local c=Instance.new("ScreenGui")c.Parent=game.Players.LocalPlayer:WaitForChild("PlayerGui")local d=Instance.new("Frame")d.Size=UDim2.new(0,300,0,50)d.Position=UDim2.new(1,-320,1,-120)d.BackgroundColor3=Color3.fromRGB(0,0,0)d.BackgroundTransparency=0.5;d.BorderSizePixel=0;d.Parent=c;local e=Instance.new("TextLabel")e.Size=UDim2.new(1,0,1,0)e.Position=UDim2.new(0,0,0,0)e.Text=b;e.TextColor3=Color3.fromRGB(255,255,255)e.BackgroundTransparency=1;e.Font=Enum.Font.GothamBold;e.TextScaled=true;e.Parent=d;task.delay(3,function()d:Destroy()end)end;local f=loadstring(game:HttpGet('https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/%E9%85%8D%E7%BD%AE%E4%B8%BB%E5%A0%B4%E6%99%AF.lua'))()loadstring(game:HttpGet('https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/%E4%BB%BB%E5%8B%99%E8%87%AA%E5%8B%95%E9%A0%98%E5%8F%96.lua'))()local g=loadstring(game:HttpGet('https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/JSON%E6%A8%A1%E7%B5%84.lua'))()local h=game:GetService("VirtualUser")game.Players.LocalPlayer.Idled:Connect(function()h:CaptureController()h:ClickButton2(Vector2.new())wait(2)end)local i=a:AddWindow("Cultivation-Simulator script ",{main_color=Color3.fromRGB(41,74,122),min_size=Vector2.new(408,335),can_resize=false})local j=i:AddTab("Rdme")local k=i:AddTab("Main")local l=i:AddTab("World")local m=i:AddTab("Dungeons")local n=i:AddTab("Pull")local o=i:AddTab("Misc")local p=i:AddTab("UI")local q=i:AddTab("Set")local r=game:GetService("Workspace")local s=game:GetService("Players").LocalPlayer;local t=game.Players;local u=game.Players.LocalPlayer;local v=s.PlayerGui;local w=f:match("%d+")print("重生點編號："..w)local x=r:waitForChild("主場景"..w):waitForChild("重生点")local y,z,A=x.Position.X,x.Position.Y+5,x.Position.Z;local B=false;local C;local D=s:WaitForChild("值")local E=D:WaitForChild("特权")local F=1;local G=true;local H=false;local I=0;local J=false;local K=3;local L=0;local M;local function N()local O=u.Character;if not O or not O:FindFirstChild("HumanoidRootPart")then return end;local P=O.HumanoidRootPart.Position;local Q=Vector3.new(500,500,500)/2;H=false;for R,s in pairs(t:GetPlayers())do if s~=u and s.Character and s.Character:FindFirstChild("HumanoidRootPart")then local S=s.Character.HumanoidRootPart.Position;local inRange=math.abs(S.X-P.X)<=Q.X and math.abs(S.Y-P.Y)<=Q.Y and math.abs(S.Z-P.Z)<=Q.Z;if inRange then H=true;break end end end;if H then if I==0 then print("有玩家在範圍內")showNotification("somepeople in range")L=2;K=5;I=1;J=true end elseif I==1 then print("範圍內玩家已離開")showNotification("player out of range")I=0;L=0;J=false end end;local function T()while true do if G then N()end;wait(0.1)end end;local function U()G=not G;print("檢測已"..(G and"啟用"or"關閉"))if not G then K=3;L=0 end end;local function V(W)local X=Online_Gift:FindFirstChild("Online_Gift"..W)if not X then return nil end;local Y=X:FindFirstChild("按钮"):FindFirstChild("倒计时").Text;if Y=="CLAIMED!"then return 0 elseif Y=="DONE"then local Z={[1]=W}game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\232\138\130\230\151\165\230\180\187\229\138\168"):FindFirstChild("\233\162\134\229\143\150\229\165\150\229\138\177"):FireServer(unpack(Z))return 0 else local _,a0=Y:match("^(%d+):(%d+)$")if _ and a0 then return tonumber(_)*60+tonumber(a0)end end;return nil end;local function a1()local a2=math.huge;local a3={}for a4=1,6 do local a5=V(a4)if a5 then a3[a4]=a5;OnlineGift_data[a4]=a5;if a5<a2 and a5>0 then a2=a5 end else a3[a4]=nil end end;if a2~=math.huge then if localCountdownActive then for a4=1,6 do if a3[a4]and a3[a4]>0 then a3[a4]=a3[a4]-1;local _=math.floor(a3[a4]/60)local a0=a3[a4]%60;local a6=string.format("%02d:%02d",_,a0)Online_Gift:FindFirstChild("Online_Gift"..a4):FindFirstChild("按钮"):FindFirstChild("倒计时").Text=a6 end end;a2=a2-1 else end end end;local function a7()for a4=1,6 do local a8="在线奖励0"..a4;local X=Online_Gift:FindFirstChild(a8)if X then X.Name="Online_Gift"..tostring(X.LayoutOrder+1)print("名稱已更改為："..X.Name)else allGiftsExist=false;break end end;if allGiftsExist then print("在線獎勵--名稱--已全部更改")else print("名稱已重複或部分名稱不存在")end end;local function a9()spawn(function()while true do local aa=os.time()local ab=os.date("!*t",aa)local ac=os.date("*t",aa+8*3600)if ac.hour==0 and ac.min==0 then print("UTC+8 時間為 00:00，開始執行更新數據...")spawn(function()allGiftsExist=true;a7()wait(1)a1()end)wait(60)end;wait(1)end end)end;a9()j:Show()j:AddLabel("Author： Tseting-nil  |  Version：V4.5.1")j:AddLabel("AntiAFK：Start")j:AddLabel("Created on： 2024/09/27")j:AddLabel("Last Updated： 2025/04/01")local ad=j:AddLabel("Current Time： 00/00/00 00:00:00")local ae=j:AddLabel("Time Zone： UTC+00:00")local function af()return os.date("%Y/%m/%d %H:%M:%S")end;local function ag()local ah=os.date("%z")return string.format("UTC%s",ah:sub(1,3)..":"..ah:sub(4,5))end;local function ai()ad.Text="Current Time："..af()ae.Text="Time Zone："..ag()end;spawn(function()while true do ai()wait(1)end end)local aj=j:AddLabel("重生點：重生點")aj.Text="重生點："..f.." -- If TP Error.Return home and Use TP FIX button"local function ak()f=loadstring(game:HttpGet('https://raw.githubusercontent.com/Tseting-nil/-Cultivation-Simulator-script/refs/heads/main/%E6%89%8B%E6%A9%9F%E7%AB%AFUI/%E9%85%8D%E7%BD%AE%E4%B8%BB%E5%A0%B4%E6%99%AF.lua'))()aj.Text="重生點："..f.." -- If TP Error.Return home and Use TP FIX button"print("最近的出生點："..f)w=f:match("%d+")print("重生點編號："..w)x=r:waitForChild("主場景"..w):waitForChild("重生点")y,z,A=x.Position.X,x.Position.Y+5,x.Position.Z;print("傳送座標："..y.." "..z.." "..A)s.Character:WaitForChild("HumanoidRootPart").CFrame=CFrame.new(y,z,A)end;j:AddButton("TP FIX",function()ak()end)local function al()if G then M.Text="Status：Safe Mode Enabled"showNotification("Safe Mode Enabled")else M.Text="Status：Safe Mode Disabled"showNotification("Safe Mode Disabled")end end;M=j:AddButton("Status：Safe Mode Enabled ",function()inRange=false;H=false;I=0;J=false;U()al()end)al()spawn(T)local c=Instance.new("ScreenGui")c.Parent=game.Players.LocalPlayer:WaitForChild("PlayerGui")local am=Instance.new("Frame")am.Size=UDim2.new(200,0,200,0)am.Position=UDim2.new(0,0,0,0)am.BackgroundColor3=Color3.fromRGB(0,0,0)am.Visible=false;am.Parent=c;j:AddButton("Black Screen: On/Off",function()am.Visible=not am.Visible end)local ad=k:AddLabel("Time until auto-fetch: 0 seconds")local v=game.Players.LocalPlayer.PlayerGui;local Online_Gift=v.GUI:WaitForChild("二级界面"):WaitForChild("节日活动商店"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("在线奖励"):WaitForChild("列表")local an=false;local ao={}local ap=false;local aq=os.date("%d")local function ar(as)local _,a0=string.match(as,"(%d+):(%d+)")if _ and a0 then return tonumber(_)*60+tonumber(a0)end;return nil end;local function at()ap=true;local au=math.huge;for a4=1,6 do local av=string.format("在线奖励%02d",a4)local aw=Online_Gift:FindFirstChild(av)if aw then local ax=aw:FindFirstChild("按钮")local ay=ax and ax:FindFirstChild("倒计时")if ay then local Y=ay.Text;ao[av]=Y;if string.match(Y,"CLAIMED!")then elseif string.match(Y,"DONE")then au=math.min(au,0)elseif string.match(Y,"%d+:%d+")then local a5=ar(Y)if a5 then au=math.min(au,a5)end end end end end;return au<math.huge and au or nil end;local a2=at()local az=a2;local function aA()local aB=at()if aB and aB==a2 then az=az-1 else a2=aB;az=a2 end;if az and az>0 then ad.Text=string.format("Time until auto-fetch: %d seconds",az)elseif az and az<=0 then ad.Text="Countdown complete, preparing to receive rewards"for a4=1,6 do local Z={[1]=a4}game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\232\138\130\230\151\165\230\180\187\229\138\168"):FindFirstChild("\233\162\134\229\143\150\229\165\150\229\138\177"):FireServer(unpack(Z))end else ad.Text="All rewards collected"an=false end end;local function aC()while an do aA()wait(1)end end;k:AddButton("Auto-collect online rewards",function()an=true;spawn(aC)end)local function aD()local aE=true;at()for a4=1,6 do local av=string.format("在线奖励%02d",a4)local aF=ao[av]if not aF or not string.match(aF,"DONE")then aE=false;break end end;if aE then print("All online rewards have been collected！")an=false end end;spawn(function()while an and not ap do aD()wait(60)end end)spawn(function()while true do local aG=tonumber(os.date("!*t").hour)local aH=os.date("!*t").day;local aI=aG+8;if aI>=24 then aI=aI-24 end;local aJ=aH;if aI==0 then if aq~=aJ then ap=false;print("UTC+8 00:00，自動領取在線獎勳")an=true;aq=aJ end end;wait(60)end end)local aK=k:AddSwitch("Auto-collect tasks (GamePass tasks and Gift)",function(aL)Autocollmissionbool=aL;if Autocollmissionbool then spawn(function()while Autocollmissionbool do mainmissionchack()everydaymission()gamepassmission()gamepassgiftget()wait(1)end end)end end)aK:Set(false)local aM=k:AddSwitch("Auto-execute investments",function(aL)investbool=aL;if investbool then spawn(function()while investbool do for a4=1,3 do local Z={a4}game:GetService("ReplicatedStorage")["\228\186\139\228\187\182"]["\229\133\172\231\148\168"]["\229\149\134\229\186\151"]["\233\147\182\232\161\140"]["\233\162\134\229\143\150\231\144\134\232\180\162"]:FireServer(unpack(Z))end;wait(5)for a4=1,3 do local Z={a4}game:GetService("ReplicatedStorage")["\228\186\139\228\187\182"]["\229\133\172\231\148\168"]["\229\149\134\229\186\151"]["\233\147\182\232\161\140"]["\232\180\173\228\185\176\231\144\134\232\180\162"]:FireServer(unpack(Z))end;wait(600)end end)end end)aM:Set(false)local aN=k:AddSwitch("Auto-harvest herbs",function(aL)AutoCollectherbsbool=aL;if AutoCollectherbsbool then spawn(function()while AutoCollectherbsbool do for a4=1,6 do local Z={[1]=a4,[2]=nil}game:GetService("ReplicatedStorage")["\228\186\139\228\187\182"]["\229\133\172\231\148\168"]["\229\134\156\231\148\176"]["\233\135\135\233\155\134"]:FireServer(unpack(Z))wait(0.1)end;wait(60)end end)end end)aN:Set(false)k:AddLabel("- - GamePass Unlock")local aO=k:AddSwitch("Unlock Auto-Crafting",function(aL)local aP=aL;E:WaitForChild("超级炼制").Value=false;E:WaitForChild("自动炼制").Value=aP end)aO:Set(true)local aQ=k:AddSwitch("Show all Currencies",function(aL)ShowAllbool=aL;if ShowAllbool then while ShowAllbool do game:GetService("Players").LocalPlayer.PlayerGui.GUI["\228\184\187\231\149\140\233\157\162"]["\228\184\187\229\159\142"]["\232\180\167\229\184\129\229\140\186\229\159\159"]["\230\180\187\229\138\168\231\137\169\229\147\129"].Visible=true;game:GetService("Players").LocalPlayer.PlayerGui.GUI["\228\184\187\231\149\140\233\157\162"]["\228\184\187\229\159\142"]["\232\180\167\229\184\129\229\140\186\229\159\159"]["\231\159\191\231\159\179"].Visible=false;game:GetService("Players").LocalPlayer.PlayerGui.GUI["\228\184\187\231\149\140\233\157\162"]["\228\184\187\229\159\142"]["\232\180\167\229\184\129\229\140\186\229\159\159"]["\231\172\166\231\159\179\231\178\137\230\156\171"].Visible=true;game:GetService("Players").LocalPlayer.PlayerGui.GUI["\228\184\187\231\149\140\233\157\162"]["\228\184\187\229\159\142"]["\232\180\167\229\184\129\229\140\186\229\159\159"]["\231\173\137\231\186\167"].Visible=true;game:GetService("Players").LocalPlayer.PlayerGui.GUI["\228\184\187\231\149\140\233\157\162"]["\228\184\187\229\159\142"]["\232\180\167\229\184\129\229\140\186\229\159\159"]["\231\180\171\233\146\187"].Visible=true;game:GetService("Players").LocalPlayer.PlayerGui.GUI["\228\184\187\231\149\140\233\157\162"]["\228\184\187\229\159\142"]["\232\180\167\229\184\129\229\140\186\229\159\159"]["\232\141\137\232\141\175"].Visible=false;game:GetService("Players").LocalPlayer.PlayerGui.GUI["\228\184\187\231\149\140\233\157\162"]["\228\184\187\229\159\142"]["\232\180\167\229\184\129\229\140\186\229\159\159"]["\233\135\145\229\184\129"].Visible=true;game:GetService("Players").LocalPlayer.PlayerGui.GUI["\228\184\187\231\149\140\233\157\162"]["\228\184\187\229\159\142"]["\232\180\167\229\184\129\229\140\186\229\159\159"]["\233\146\187\231\159\179"].Visible=true;wait(0.3)end end end)aQ:Set(false)k:AddButton("Remove the display of the reward",function()local aR=v.GUI:WaitForChild("二级界面"):FindFirstChild("展示奖励界面")if aR then aR:Destroy()print("成功刪除 UI 元件")else print("已刪除過")end end)k:AddButton("Redeem Game Code",function()local aS={"ilovethisgame","welcome","30klikes","40klikes","halloween","artistkapouki","45klikes","60klikes"}for a4=1,#aS do print(aS[a4])local Z={[1]=aS[a4]}game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\230\191\128\230\180\187\231\160\129"):FindFirstChild("\231\142\169\229\174\182\229\133\145\230\141\162\230\191\128\230\180\187\231\160\129"):FireServer(unpack(Z))end end)local aT=s:WaitForChild("值"):WaitForChild("主线进度"):WaitForChild("world").Value;local aU=aT;local function aV()aT=s:WaitForChild("值"):WaitForChild("主线进度"):WaitForChild("world").Value end;spawn(function()while true do aV()wait(1)end end)local aW=false;local aX=0.7;local aY=l:AddLabel("Current Selection： 01")local function aZ(F)if F>aT then if F<10 then aY.Text="Level Not Unlocked： 0"..F else aY.Text="Level Not Unlocked： "..F end else if F<10 then if aW then aY.Text="Current Selection： 0"..F.."    Infinite Battle Wave Set： "..aX*100 .." Waves"else aY.Text="Current Selection： 0"..F end else if aW then aY.Text="Current Selection： "..F.."    Infinite Battle Wave Set： "..aX*100 .." Waves"else aY.Text="Current Selection： "..F end end end end;local a_=l:AddDropdown("                Difficulty Level Selection                ",function(b0)if b0=="  World ： 01 .. Easy"then print("World ： 01")F=1;aY.Text="Current Selection： 01"elseif b0=="  World ： 21 .. Normal"then print("World ： 21")F=21;aZ(F)elseif b0=="  World ： 41 .. Hard"then print("World ： 41")F=41;aZ(F)elseif b0=="  World ： 61 .. Expert"then print("World ： 61")F=61;aZ(F)elseif b0=="  World ： 81 .. Master"then print("World ： 81")F=81;aZ(F)elseif b0=="  World ： 101"then print("World ： 101")F=101;aZ(F)elseif b0=="  Auto Max Choose"then local b1=false;print("Current Selection: Auto Max Level")if aT<10 then aY.Text="Current Selection Max Level: 0"..aT else aY.Text="Current Selection Max Level: "..aT end;F=aT;while true do local b2=string.match(aY.Text,"Current Selection Max Level")if b2~="Current Selection Max Level"then b1=false;print("Auto Max Level has stopped")break elseif not b1 then print("Auto Max Level has started")b1=true end;if aU~=aT then F=aT;aU=aT;C=tonumber(F)if aT<10 then aY.Text="  Current Selection Max Level: 0"..F else aY.Text="  Current Selection Max Level: "..F end;wait(L)wait(K+1)local Z={[1]=C}game:GetService("ReplicatedStorage"):FindFirstChild("LevelData"):FindFirstChild("MaxLevel"):FireServer(unpack(Z))end;wait(1)end end end)local b3=a_:Add("  World ： 01 .. Easy")local b4=a_:Add("  World ： 21 .. Normal")local b5=a_:Add("  World ： 41 .. Hard")local b6=a_:Add("  World ： 61 .. Expert")local b7=a_:Add("  World ： 81 .. Master")local b8=a_:Add("  Auto Max Choose")local b9=a_:Add(" ... ")l:AddButton("Select level +1",function()F=F+1;aZ(F)end)l:AddButton("Select level -1",function()F=F-1;aZ(F)end)local ba=0;local function bb()local Z={[1]=F}game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\229\133\179\229\141\161"):FindFirstChild("\232\191\155\229\133\165\228\184\150\231\149\140\229\133\179\229\141\161"):FireServer(unpack(Z))print("傳送世界關卡："..F)end;local function bc()C=tonumber(F)local Z={[1]=C}game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\229\133\179\229\141\161"):FindFirstChild("\232\191\155\229\133\165\228\184\150\231\149\140\229\133\179\229\141\161"):FireServer(unpack(Z))print("重啟世界關卡："..C)end;local function bd()local be=v.GUI:WaitForChild("主界面"):WaitForChild("战斗"):waitForChild("关卡信息"):waitForChild("文本").Text;local bf=string.match(be,"World")C=string.match(be,"World (%d+)-")local bg=string.match(be,"-(%d+/%d+)")local bh=v.GUI:WaitForChild("主界面"):WaitForChild("战斗"):waitForChild("变强提示").Visible;local bi=v.GUI:WaitForChild("主界面"):WaitForChild("战斗"):waitForChild("战斗结果图片").Visible;if(bh or bi)and Autostartwarld and bf then print("戰鬥失敗,重啟")B=true end;if bg then local bj,bk=string.match(bg,"(%d+)/(%d+)")ba=tonumber(bj)/tonumber(bk)if ba==1 and bf and Autostartwarld then B=true end;if ba>=aX and bf and Autostar2twarld then B=true end;if Autostartwarld and Autostar2twarld then showNotification("Both modes turned on will only execute Endless Battle")end end end;local function bl()wait(L)s.Character:WaitForChild("HumanoidRootPart").CFrame=CFrame.new(y,z,A)end;l:AddButton("TP",function()bb()end)l:AddLabel("!! Auto start no longer requires wave restrictions")local bm=l:AddSwitch("Auto-start After Battle (World Battle)",function(aL)Autostartwarld=aL;if Autostartwarld then while Autostartwarld do bd()if B then wait(L)bl()wait(0.5)wait(K)bc()B=false end;wait(1)end end end)bm:Set(false)local bn=l:AddSwitch("Endless Battle(Can Set)",function(aL)Autostar2twarld=aL;if Autostar2twarld then aW=true;aZ(F)while Autostar2twarld do bd()if B and not J then print("Endless battle begins, no players nearby")bc()B=false elseif B and J and ba==1 then print("Endless battle begins, there are players nearby, execute normal mode")wait(L)bl()wait(0.5)wait(K)bc()B=false end;wait(1)end else aW=false;aZ(F)end end)l:AddTextBox("Endless Battle wave setting (Default 70 Waves)",function(b0)local bo=tonumber(b0)if bo and bo>=0 and bo<=100 then aX=bo*0.01;print("Endless Battle wave setting: "..b0)aZ(F)else showNotification("Can only set a number between 0 and 100")print("Invalid input. Please enter a number between 0 and 100.")end end)bn:Set(false)l:AddButton("AFK Mode",function()local bp=game:GetService("Players").LocalPlayer:WaitForChild("值"):WaitForChild("设置"):WaitForChild("自动战斗")if bp.Value==true then bp.Value=false else bp.Value=true end end)l:AddButton("Fast Dungeon Selection",function()local bq=game:GetService("ReplicatedStorage"):FindFirstChild("打开关卡选择",true)if bq and bq:IsA("BindableEvent")then bq:Fire("打開煉丹爐")end end)local br=game:GetService("HttpService")local s=game.Players.LocalPlayer;local bs="DungeonsMaxLevel.json"local bt=false;local bu=false;local bv=true;local bw=false;local bx=false;local by={}local function bz()if not isfile(bs)then error("JSON 文件不存在："..bs)end;local bA=readfile(bs)local bB,bC=pcall(br.JSONDecode,br,bA)if not bB then error("無法解析 JSON 文件："..bs)end;local bD=s.Name;local bE=bC[bD]if not bE then error("LocalPlayer 的資料不存在於 JSON 文件中："..bD)end;return bE end;local function bF(bG)for bH,bI in pairs(bG)do local bJ=bH:gsub("MaxLevel","")by[bJ]=function()return bI end end end;local function bK()local bG=g.getPlayerData(bs,s.Name)by={}bF(bG)end;local function bL()local bB,bG=pcall(bz)if bB then bF(bG)print("Dungeon 函數已成功創建")else warn("提取資料失敗："..tostring(bG))end end;bL()spawn(function()while true do if bt then local bM=v:WaitForChild("GUI"):WaitForChild("二级界面"):WaitForChild("关卡选择"):WaitForChild("副本选择弹出框"):WaitForChild("背景"):WaitForChild("标题"):WaitForChild("名称").Text;local bN=tonumber(v:WaitForChild("GUI"):WaitForChild("二级界面"):WaitForChild("关卡选择"):WaitForChild("副本选择弹出框"):WaitForChild("背景"):WaitForChild("难度"):WaitForChild("难度等级"):WaitForChild("值").Text)g.updateDungeonMaxLevel(bs,s.Name,bM,bN)bK()end;wait(1)end end)local bG=g.getPlayerData(bs,s.Name)print("玩家初始資料:")for bO,bP in pairs(bG)do print(bO,bP)end;local bQ=v:WaitForChild("GUI"):WaitForChild("二级界面"):WaitForChild("关卡选择"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("副本"):WaitForChild("列表")local bR=0;local bS="1"local bT=0;local function bU(bH)local bV=bQ:FindFirstChild(bH)if bV then local bW=bV:WaitForChild("钥匙"):WaitForChild("值").Text;local bO=tonumber(string.match(bW,"^%d+"))if bO then return bO<10 and string.format("0%d",bO)or tostring(bO)end end;return nil end;local bX=v:WaitForChild("GUI"):WaitForChild("二级界面"):WaitForChild("关卡选择"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("活动副本"):WaitForChild("列表")local bY;local bZ={"EasterDungeon","Halloween","ChristmasDungeon"}local b_={}for R,bH in ipairs(bZ)do local bV=bX:FindFirstChild(bH)if bV then local c0=bV.Visible;if c0 then table.insert(b_,bH)end end end;local function c1()if#b_==0 then bY="NOT OPEN"return bY else for R,bH in ipairs(b_)do local bV=bX:FindFirstChild(bH)if bV then local c2=bV:FindFirstChild("钥匙")if c2 then local c3=c2:FindFirstChild("值")if c3 and c3.Text then local bW=c3.Text;local bO=tonumber(string.match(bW,"^%d+"))bY=bO;return bY end end end end end end;local function c4()Ore_Dungeonkey=bU("OreDungeon")Gem_Dungeonkey=bU("GemDungeon")Gold_Dungeonkey=bU("GoldDungeon")Relic_Dungeonkey=bU("RelicDungeon")Rune_Dungeonkey=bU("RuneDungeon")Hover_Dungeonkey=bU("HoverDungeon")Event_Dungeonkey=c1()end;c4()local c5=m:AddLabel("Dungeon Selection ...")local c6=m:AddDropdown("Dungeon Selection ...",function(b0)if b0=="    OreDungeon    "then bR=1;bS=tostring(by["OreDungeon"]and by["OreDungeon"]()or"0")c5.Text=" OreDungeon,  Key："..Ore_Dungeonkey.."  ,Level："..bS elseif b0=="    GemDungeon    "then bR=2;bS=tostring(by["GemDungeon"]and by["GemDungeon"]()or"0")c5.Text=" GemDungeon,  Key："..Gem_Dungeonkey.."  ,Level："..bS elseif b0=="    RuneDungeon    "then bR=3;bS=tostring(by["RuneDungeon"]and by["RuneDungeon"]()or"0")c5.Text=" RuneDungeon,  Key："..Rune_Dungeonkey.."  ,Level："..bS elseif b0=="    RelicDungeon    "then bR=4;bS=tostring(by["RelicDungeon"]and by["RelicDungeon"]()or"0")c5.Text=" RelicDungeon,  Key："..Relic_Dungeonkey.."  ,Level："..bS elseif b0=="    HoverDungeon    "then bR=7;bS=tostring(by["HoverDungeon"]and by["HoverDungeon"]()or"0")c5.Text=" HoverDungeon,  Key："..Hover_Dungeonkey.."  ,Level："..bS elseif b0=="    GoldDungeon    "then bR=6;bS=tostring(by["GoldDungeon"]and by["GoldDungeon"]()or"0")c5.Text=" GoldDungeon,  Key："..Gold_Dungeonkey.."  ,Level："..bS elseif b0=="    EventDungeon    "then bR=9;bS="1"c5.Text=" EventDungeon,  Key："..Event_Dungeonkey else bR=8;c5.Text="    ...    "end end)local c7=c6:Add("    OreDungeon    ")local c8=c6:Add("    GemDungeon    ")local c9=c6:Add("    RuneDungeon    ")local ca=c6:Add("    RelicDungeon    ")local cb=c6:Add("    HoverDungeon    ")local cc=c6:Add("    GoldDungeon    ")local cd=c6:Add("    EventDungeon    ")local ce=c6:Add("    ...    ")local function cf()if bR==0 then c5.Text="Dungeon Selection ..."elseif bR==1 then bS=tostring(by["OreDungeon"]and by["OreDungeon"]()or"0")c5.Text=" OreDungeon,  Key："..Ore_Dungeonkey.."  ,Level："..bS elseif bR==2 then bS=tostring(by["GemDungeon"]and by["GemDungeon"]()or"0")c5.Text=" GemDungeon,  Key："..Gem_Dungeonkey.."  ,Level："..bS elseif bR==3 then bS=tostring(by["RuneDungeon"]and by["RuneDungeon"]()or"0")c5.Text=" RuneDungeon,  Key："..Rune_Dungeonkey.."  ,Level："..bS elseif bR==4 then bS=tostring(by["RelicDungeon"]and by["RelicDungeon"]()or"0")c5.Text=" RelicDungeon,  Key："..Relic_Dungeonkey.."  ,Level："..bS elseif bR==7 then bS=tostring(by["HoverDungeon"]and by["HoverDungeon"]()or"0")c5.Text=" HoverDungeon,  Key："..Hover_Dungeonkey.."  ,Level："..bS elseif bR==6 then bS=tostring(by["GoldDungeon"]and by["GoldDungeon"]()or"0")c5.Text=" GoldDungeon,  Key："..Gold_Dungeonkey.."  ,Level："..bS elseif bR==9 then c5.Text=" EventDungeon,  Key："..Event_Dungeonkey elseif bR==8 then c5.Text="    ...    "end end;local function cg()c4()c7.Text="      OreDungeon             Key："..Ore_Dungeonkey.."  "c8.Text="      GemDungeon          Key："..Gem_Dungeonkey.."  "c9.Text="      RuneDungeon         Key："..Rune_Dungeonkey.."  "ca.Text="      RelicDungeon          Key："..Relic_Dungeonkey.."  "cb.Text="      HoverDungeon        Key："..Hover_Dungeonkey.."  "cc.Text="      GoldDungeon           Key："..Gold_Dungeonkey.."  "cd.Text="      EventDungeon         Key："..Event_Dungeonkey.."  "end;spawn(function()while true do cg()cf()wait(0.5)end end)local ch=m:AddSwitch("Sync dungeon entry interface difficulty",function(aL)bt=aL end)ch:Set(false)local function ci(bH,cj,ck)g.updatePlayerData(bs,s.Name,{[cj]=ck})bK()print("更新後的 "..bH.." 等級:",by[bH]())end;local function cl(cm)local ck=bS+cm;local cn={[1]={name="OreDungeon",field="OreDungeonMaxLevel"},[2]={name="GemDungeon",field="GemDungeonMaxLevel"},[3]={name="RuneDungeon",field="RuneDungeonMaxLevel"},[4]={name="RelicDungeon",field="RelicDungeonMaxLevel"},[7]={name="HoverDungeon",field="HoverDungeonMaxLevel"},[6]={name="GoldDungeon",field="GoldDungeonMaxLevel"}}local bV=cn[bR]if bV then ci(bV.name,bV.field,ck)else print("未選擇地下城")end end;local function co()local cp=tonumber(bS)local Z={[1]=bR,[2]=cp}game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\229\137\175\230\156\172"):FindFirstChild("\232\191\155\229\133\165\229\137\175\230\156\172"):FireServer(unpack(Z))end;local bZ={"Ore Dungeon","Gem Dungeon","Rune Dungeon","Relic Dungeon","Hover Dungeon","Gold Dungeon"}local cq={["Ore Dungeon"]="OreDungeon",["Gem Dungeon"]="GemDungeon",["Rune Dungeon"]="RuneDungeon",["Relic Dungeon"]="RelicDungeon",["Hover Dungeon"]="HoverDungeon",["Gold Dungeon"]="GoldDungeon"}local cr=false;local function cs()cr=true;local ct=0;local cu=nil;local cv=1;local cw={1,2,3,4,7,6}for a4,cx in ipairs(bZ)do local cy=tonumber(bU(cq[cx]))or 0;if cy>ct then ct=cy;cu=cx;cv=cw[a4]or 0 end end;return cu,cv end;local function cz()local cu,cv=cs()bR=cv;local bH=cu;local cA=tostring(by[cq[bH]]()or"0")print("已選擇最多鑰匙的地下城："..bH)showNotification("ChangeDungeon:"..bH)wait(0.5)wait(L)co()end;local function cB()local cC=v.GUI:WaitForChild("主界面"):WaitForChild("战斗"):WaitForChild("关卡信息"):WaitForChild("文本").Text;local cD=string.match(cC,"^(.-)%s%d")if cD=="Ore Dungeon"then local cE=bU("OreDungeon")local cF=tonumber(cE)local cG=tonumber(string.match(cC,"Keys:%s*(%d+)"))if cF~=cG and cF>0 then if bu and not cr then cl(1)end;cr=false;wait(L)bl()wait(0.5)wait(K)co()elseif cF==0 and bx then if cF~=cG then if bu and not bw then cl(1)bw=true;wait(3)bw=false end end;print("已啟用自動完成地下城")cz()end elseif cD=="Gem Dungeon"then local cE=bU("GemDungeon")local cF=tonumber(cE)local cG=tonumber(string.match(cC,"Keys:%s*(%d+)"))if cF~=cG and cF>0 then if bu and not cr then cl(1)end;cr=false;wait(L)bl()wait(0.5)wait(K)co()elseif cF==0 and bx then if cF~=cG then if bu and not bw then cl(1)bw=true;wait(3)bw=false end end;print("已啟用自動完成地下城")cz()end elseif cD=="Rune Dungeon"then local cE=bU("RuneDungeon")local cF=tonumber(cE)local cG=tonumber(string.match(cC,"Keys:%s*(%d+)"))if cF~=cG and cF>0 then if bu and not cr then cl(1)end;cr=false;wait(L)bl()wait(0.5)wait(K)co()elseif cF==0 and bx then if cF~=cG then if bu and not bw then cl(1)bw=true;wait(3)bw=false end end;print("已啟用自動完成地下城")cz()end elseif cD=="Relic Dungeon"then local cE=bU("RelicDungeon")local cF=tonumber(cE)local cG=tonumber(string.match(cC,"Keys:%s*(%d+)"))if cF~=cG and cF>0 then if bu and not cr then cl(1)end;cr=false;wait(L)bl()wait(0.5)wait(K)co()elseif cF==0 and bx then if cF~=cG then if bu and not bw then cl(1)bw=true;wait(3)bw=false end end;print("已啟用自動完成地下城")cz()end elseif cD=="Hover Dungeon"then local cE=bU("HoverDungeon")local cF=tonumber(cE)local cG=tonumber(string.match(cC,"Keys:%s*(%d+)"))if cF~=cG and cF>0 then if bu and not cr then cl(1)end;cr=false;wait(L)bl()wait(0.5)wait(K)co()elseif cF==0 and bx then if cF~=cG then if bu and not bw then cl(1)bw=true;wait(3)bw=false end end;print("已啟用自動完成地下城")cz()end elseif cD=="Gold Dungeon"then local cE=bU("GoldDungeon")local cF=tonumber(cE)local cG=tonumber(string.match(cC,"Keys:%s*(%d+)"))if cF~=cG and cF>0 then if bu and not cr then cl(1)end;cr=false;wait(L)bl()wait(0.5)wait(K)co()elseif cF==0 and bx then if cF~=cG then if bu and not bw then cl(1)bw=true;wait(3)bw=false end end;print("已啟用自動完成地下城")cz()end end end;local cH=m:AddSwitch("Auto-start After Battle (Dungeon) -- Victory Required",function(aL)AutostartDungeon=aL;if AutostartDungeon then while AutostartDungeon do cB()wait(0.5)end end end)cH:Set(false)local cI=m:AddSwitch("Automatically Increase Level by +1 After Battle",function(aL)bu=aL end)cI:Set(false)m:AddLabel("If open ,When no keys, it will change to other dungeon")local cJ=m:AddSwitch("Complete All Dungeons ",function(aL)bx=aL end)cJ:Set(false)m:AddTextBox("You can also manually input the level",function(b0)local cK=string.gsub(b0,"[^%d]","")local bT=tonumber(cK)if not bT then bT=1 end;if bR==1 then local cL="OreDungeonMaxLevel"g.updateField(bs,s.Name,cL,bT)bK()elseif bR==2 then local cL="GemDungeonMaxLevel"g.updateField(bs,s.Name,cL,bT)bK()elseif bR==3 then local cL="RuneDungeonMaxLevel"g.updateField(bs,s.Name,cL,bT)bK()elseif bR==4 then local cL="RelicDungeonMaxLevel"g.updateField(bs,s.Name,cL,bT)bK()elseif bR==5 then local cL="HoverDungeonMaxLevel"g.updateField(bs,s.Name,cL,bT)bK()elseif bR==6 then local cL="GoldDungeonMaxLevel"g.updateField(bs,s.Name,cL,bT)bK()else print("未選擇地下城")end end)m:AddButton("Level Selection +1",function()cl(1)end)m:AddButton("Level Selection -1",function()cl(-1)end)m:AddButton("TP",function()if Event_Dungeonkey=="NOT OPEN"and bR==9 then print("Event Dungeon Not Open")return else co()end end)local cM=n:AddSwitch("Auto Elixir ",function(aL)Autoelixir=aL;if Autoelixir then while Autoelixir do local cN=v.GUI:WaitForChild("二级界面"):WaitForChild("炼丹炉"):WaitForChild("背景"):WaitForChild("形象"):WaitForChild("制作"):WaitForChild("按钮"):WaitForChild("数量区"):WaitForChild("价格").text;cN=tonumber(cN)local cO=s:WaitForChild("值"):WaitForChild("货币"):WaitForChild("草药").Value;if cO>=cN then game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\231\130\188\228\184\185"):FindFirstChild("\229\136\182\228\189\156"):FireServer()else print("草药不足")end;wait(1)end end end)cM:Set(false)local cP=n:AddSwitch("Auto Absorb Elixir⚠️All Elixir in the backpack⚠️）",function(aL)Autoelixirabsorb=aL;if Autoelixirabsorb then while Autoelixirabsorb do local cQ=v.GUI:WaitForChild("二级界面"):waitForChild("主角"):WaitForChild("背景"):waitForChild("右侧界面"):WaitForChild("丹药"):waitForChild("背包区域"):WaitForChild("积分"):waitForChild("文本").text;if cQ~="0"then game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\228\184\185\232\141\175"):FindFirstChild("\229\144\184\230\148\182\229\133\168\233\131\168"):FireServer()end;wait(1.5)end end end)cP:Set(false)local s=game:GetService("Players").LocalPlayer;local v=game.Players.LocalPlayer.PlayerGui;local cR=v.GUI:WaitForChild("二级界面"):WaitForChild("商店"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("召唤"):WaitForChild("技能")local cS=cR:WaitForChild("等级区域"):WaitForChild("值").text;cS=string.gsub(cS,"%D","")local cT=cR:WaitForChild("等级区域"):WaitForChild("进度条"):WaitForChild("值"):WaitForChild("值").text;cT=string.match(cT,"(%d+)/")local cU=v.GUI:WaitForChild("二级界面"):WaitForChild("商店"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("召唤"):WaitForChild("法宝")local cV=cU:WaitForChild("等级区域"):WaitForChild("值").text;cV=string.gsub(cV,"%D","")local cW=cU:WaitForChild("等级区域"):WaitForChild("进度条"):WaitForChild("值"):WaitForChild("值").text;cW=string.match(cW,"(%d+)/")local cX=s:WaitForChild("值"):WaitForChild("货币")local cY=cX:WaitForChild("钻石")local cZ=cX:WaitForChild("法宝抽奖券").value;local c_=cX:WaitForChild("技能抽奖券").value;local d0=false;local d1=0.3;local d2=true;local d3=true;local function d4()cS=cR:WaitForChild("等级区域"):WaitForChild("值").text;cS=string.gsub(cS,"%D","")or 0;cT=cR:WaitForChild("等级区域"):WaitForChild("进度条"):WaitForChild("值"):WaitForChild("值").text;cT=string.match(cT,"(%d+)/")or 0;cV=cU:WaitForChild("等级区域"):WaitForChild("值").text;cV=string.gsub(cV,"%D","")or 0;cW=cU:WaitForChild("等级区域"):WaitForChild("进度条"):WaitForChild("值"):WaitForChild("值").text;cW=string.match(cW,"(%d+)/")or 0;cY=cX:WaitForChild("钻石").value;cZ=cX:WaitForChild("法宝抽奖券").value;c_=cX:WaitForChild("技能抽奖券").value;print("技能等級："..cS.."技能進度："..cT)print("法寶等級："..cV.."法寶進度："..cW)print("鑽石："..cY.."法寶抽獎券："..cZ.."技能抽獎券："..c_)end;local function d5()print("抽獎：技能")if d2 then local Z={[1]="\230\138\128\232\131\189"}game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\229\149\134\229\186\151"):FindFirstChild("\229\143\172\229\148\164"):FindFirstChild("\230\138\189\229\165\150"):FireServer(unpack(Z))end end;local function d6()print("抽獎：法寶")if d3 then local Z={[1]="\230\179\149\229\174\157"}game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\229\149\134\229\186\151"):FindFirstChild("\229\143\172\229\148\164"):FindFirstChild("\230\138\189\229\165\150"):FireServer(unpack(Z))end end;local function d7()if c_<=8 and d0 then if cY>=400 then local d8=8-tonumber(c_)print("技能抽獎券不足，使用鑽石補足："..d8 .."張")print("鑽石消耗："..d8*50)d5()else print("鑽石不足")end elseif c_>=8 then print("技能抽獎券足夠")d5()else print("技能抽獎券不足且沒開啟鑽石補足")end end;local function d9()if cZ<=8 and d0 then if cY>400 then local d8=8-tonumber(cZ)print("法寶抽獎券不足，使用鑽石補足："..d8 .."張")print("鑽石消耗："..d8*50)d6()else print("鑽石不足")end elseif cZ>=8 then print("法寶抽獎券足夠")d6()else print("法寶抽獎券不足且沒開啟鑽石補足")end end;local function da()if cT>cW then print("法寶進度小於技能進度")d9()elseif cT<cW then print("技能進度小於法寶進度")d7()else print("技能進度等於法寶進度")spawn(function()d7()end)d9()end end;local function db()d4()if cS>cV then d6()print("法寶等級小於技能等級")elseif cS<cV then d5()print("技能等級小於法寶等級")else print("技能等級等於法寶等級")da()end end;n:AddLabel("⚠️If lottery tickets are insufficient, it will stop")local dc=n:AddLabel("Weapon Tickets： "..cZ.."  Skill Tickets： "..c_)local function dd()local de=cX:WaitForChild("法宝抽奖券").value;local df=cX:WaitForChild("技能抽奖券").value;dc.Text="Weapon Tickets： "..de.."  Skill Tickets： "..df end;spawn(function()while true do dd()wait(1)end end)local dg=n:AddSwitch("Auto Draw Weapons/Skills -- Need Fix",function(aL)Autolottery=aL;if Autolottery then d2=true;d3=true;while Autolottery do db()wait(d1)wait(0.4)end else d2=false;d3=false end end)dg:Set(false)local dh=n:AddSwitch("Enable Diamond Draw",function(aL)d0=aL end)dh:Set(false)local di=o:AddSwitch("Upd Flying Sword",function(aL)AutoupdFlyingSword=aL;if AutoupdFlyingSword then while AutoupdFlyingSword do game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\233\163\158\229\137\145"):FindFirstChild("\229\141\135\231\186\167"):FireServer()wait(0.2)end end end)di:Set(false)local dj=o:AddSwitch("Upd weapon/skill",function(aL)AutoupdskillSword=aL;if AutoupdskillSword then while AutoupdskillSword do game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\230\179\149\229\174\157"):FindFirstChild("\229\141\135\231\186\167\229\133\168\233\131\168\230\179\149\229\174\157"):FireServer()game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\230\138\128\232\131\189"):FindFirstChild("\229\141\135\231\186\167\229\133\168\233\131\168\230\138\128\232\131\189"):FireServer()wait(1.5)end end end)dj:Set(false)local AutoupdRuneSwordSwitch=o:AddSwitch("Upd Rune",function(aL)AutoupdRuneSwordSwitch=aL;if AutoupdRuneSwordSwitch then while AutoupdRuneSwordSwitch do game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\233\152\181\230\179\149"):FindFirstChild("\229\141\135\231\186\167"):FireServer()wait(0.2)end end end)AutoupdRuneSwordSwitch:Set(false)local dk=v.GUI:WaitForChild("二级界面"):WaitForChild("公会"):WaitForChild("背景"):WaitForChild("右侧界面"):WaitForChild("主页"):WaitForChild("介绍"):waitForChild("名称"):waitForChild("文本"):waitForChild("文本").Text;local dl=v.GUI:WaitForChild("二级界面"):WaitForChild("公会"):WaitForChild("捐献"):WaitForChild("背景"):WaitForChild("按钮"):WaitForChild("确定按钮"):WaitForChild("次数").Text;local dm=tonumber(string.match(dl,"%d+"))local dn=o:AddLabel("Guide Name：Need chack Upd Guide".." || Contribute times： "..dm)o:AddButton("Upd Guide",function()local dp=game:GetService("ReplicatedStorage")local bq=dp:FindFirstChild("打开公会",true)bq:Fire("打开公会")wait(0.5)dl=v.GUI:WaitForChild("二级界面"):WaitForChild("公会"):WaitForChild("捐献"):WaitForChild("背景"):WaitForChild("按钮"):WaitForChild("确定按钮"):WaitForChild("次数").Text;dm=tonumber(string.match(dl,"%d+"))dn.Text="Guide Name："..dk.." || Contribute times： "..dm end)local dq=o:AddSwitch("Auto Contribute",function(aL)AutoDonate=aL;if AutoDonate then while AutoDonate do dl=v.GUI:WaitForChild("二级界面"):WaitForChild("公会"):WaitForChild("捐献"):WaitForChild("背景"):WaitForChild("按钮"):WaitForChild("确定按钮"):WaitForChild("次数").Text;dm=tonumber(string.match(dl,"%d+"))dn.Text="Guide Name："..dk.." || Contribute times： "..dm;if dm>0 then game:GetService("ReplicatedStorage"):FindFirstChild("\228\186\139\228\187\182"):FindFirstChild("\229\133\172\231\148\168"):FindFirstChild("\229\133\172\228\188\154"):FindFirstChild("\230\141\144\231\140\174"):FireServer()end;wait(0.5)end end end)dq:Set(false)local dp=game:GetService("ReplicatedStorage")p:AddButton("Daily Tasks",function()local bq=dp:FindFirstChild("打开每日任务",true)if bq and bq:IsA("BindableEvent")then bq:Fire("打開每日任務")end end)p:AddButton("Mail",function()local bq=dp:FindFirstChild("打开邮件",true)if bq and bq:IsA("BindableEvent")then bq:Fire("打开郵件")end end)p:AddButton("Wheel",function()local bq=dp:FindFirstChild("打开转盘",true)if bq and bq:IsA("BindableEvent")then bq:Fire("打開轉盤")end end)p:AddButton("Formation",function()local bq=dp:FindFirstChild("打开阵法",true)if bq and bq:IsA("BindableEvent")then bq:Fire("打开陣法")end end)p:AddButton("World Tree",function()local bq=dp:FindFirstChild("打开世界树",true)if bq and bq:IsA("BindableEvent")then bq:Fire("打開世界樹")end end)p:AddButton("Training Bench",function()local bq=dp:FindFirstChild("打开炼器台",true)if bq and bq:IsA("BindableEvent")then bq:Fire("打開練器台")end end)p:AddButton("Alchemy Furnace",function()local bq=dp:FindFirstChild("打开炼丹炉",true)if bq and bq:IsA("BindableEvent")then bq:Fire("打開煉丹爐")end end)q:AddLabel(" -- 語言配置/language config")q:AddButton("刪除語言配置/language config delete",function()local dr=game:GetService("HttpService")function deleteConfigFile()if isfile("Cultivation_languageSet.json")then delfile("Cultivation_languageSet.json")print("配置文件 Cultivation_languageSet.json 已刪除。")else print("配置文件 Cultivation_languageSet.json 不存在，無法刪除。")end end;deleteConfigFile()end)q:AddLabel("- - Statistics")q:AddButton("每秒擊殺/金幣數",function()loadstring(game:HttpGet("https://pastebin.com/raw/0NqSi46N"))()loadstring(game:HttpGet("https://pastebin.com/raw/HGQXdAiz"))()end)q:AddLabel(" If you have any questions or ideas, leave a comment on GitHub.")q:AddButton("Github Link",function()local ds="https://github.com/Tseting-nil"if setclipboard then setclipboard(ds)showNotification("Link Copied:) ！！")else showNotification("error！Link：github.com/Tseting-nil")end end)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

pcall(function()
local old = PlayerGui:FindFirstChild("Zerobix_VVIP_XSP_Hub") or game:GetService("CoreGui"):FindFirstChild("Zerobix_VVIP_XSP_Hub")
if old then old:Destroy() end
end)

pcall(function()
settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
Lighting.GlobalShadows = false
Lighting.FogEnd = 9e9
for _, eff in pairs(Lighting:GetChildren()) do
if eff:IsA("BlurEffect") or eff:IsA("SunRaysEffect") or eff:IsA("ColorCorrectionEffect") or eff:IsA("BloomEffect") then
eff:Destroy()
end
end
for _, obj in pairs(Workspace:GetDescendants()) do
if obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("Part") then
obj.Material = Enum.Material.SmoothPlastic
obj.Reflectance = 0
obj.CastShadow = false
elseif obj:IsA("Decal") or obj:IsA("Texture") then
obj:Destroy()
elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
obj.Enabled = false
end
end
end)
getgenv().EggRarities = {
{Name = "Divine", Color = Color3.fromRGB(255, 0, 127), Rank = 1},
{Name = "Eternal", Color = Color3.fromRGB(255, 69, 0), Rank = 2},
{Name = "Secret", Color = Color3.fromRGB(139, 0, 139), Rank = 3},
{Name = "Cosmic", Color = Color3.fromRGB(0, 255, 255), Rank = 4},
{Name = "Mythic", Color = Color3.fromRGB(255, 0, 255), Rank = 5},
{Name = "Legendary", Color = Color3.fromRGB(255, 215, 0), Rank = 6}
}

getgenv().BiomesList = {"All Map", "Forest", "Lake", "Desert", "Jungle", "Snow", "Volcano", "Abyss Ocean", "Prehistoric", "Cosmic", "Cherry Blossom", "Titan Temple"}
getgenv().FloorList = {"Legendary", "Mythic", "Cosmic", "Secret", "Eternal", "Divine"}

getgenv().AutoSteal = false
getgenv().AutoTrain = false
getgenv().AutoUpgradeAll = false
getgenv().ActiveBiome = "All Map"
getgenv().RarityFloorIndex = 6
getgenv().PriorityTarget = nil
local function FarmInteract(targetModel)
pcall(function()
local character = LocalPlayer.Character
local root = character and character:FindFirstChild("HumanoidRootPart")
if root and targetModel and targetModel.Parent then
local targetPart = targetModel:FindFirstChildWhichIsA("BasePart") or targetModel
if targetPart then
if fireproximityprompt then
local prompt = targetModel:FindFirstChildWhichIsA("ProximityPrompt", true)
if prompt then fireproximityprompt(prompt, 1) return end
end
if firetouchinterest then
local transmitter = targetModel:FindFirstChildWhichIsA("TouchTransmitter", true)
if transmitter then
firetouchinterest(root, transmitter.Parent, 0)
task.wait(0.005)
firetouchinterest(root, transmitter.Parent, 1)
return
end
end
local oldCFrame = root.CFrame
root.CFrame = targetPart.CFrame
task.wait(0.01)
root.CFrame = oldCFrame
end
end
end)
end
task.spawn(function()
while task.wait(0.005) do
if getgenv().PriorityTarget and getgenv().PriorityTarget.Parent then
FarmInteract(getgenv().PriorityTarget)
elseif getgenv().AutoSteal then
pcall(function()
for _, obj in pairs(Workspace:GetDescendants()) do
if obj:IsA("Model") and (obj.Name:lower():find("egg") or obj:FindFirstChildWhichIsA("TouchTransmitter", true)) then
local nameLower = obj.Name:lower()
local currentBiomeLower = getgenv().ActiveBiome:lower()
local isInBiome = obj:FindFirstAncestor(getgenv().ActiveBiome) or nameLower:find(currentBiomeLower)
if currentBiomeLower == "all map" or isInBiome then
for _, rarity in ipairs(getgenv().EggRarities) do
if nameLower:find(rarity.Name:lower()) then
if rarity.Rank <= getgenv().RarityFloorIndex then FarmInteract(obj) end
break
end
end
end
end
end)
end
end
end)
  task.spawn(function()
while task.wait(0.1) do
pcall(function()
local char = LocalPlayer.Character
if getgenv().AutoTrain and char then
local tool = char:FindFirstChildWhichIsA("Tool") or LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool")
if tool then tool.Parent = char tool:Activate() end
end
local upgrade = ReplicatedStorage:FindFirstChild("UpgradeEvent") or ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("UpgradeEvent")
if getgenv().AutoUpgradeAll and upgrade then 
upgrade:FireServer("Treadmill") 
upgrade:FireServer("Trail") 
end
end)
end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Zerobix_VVIP_XSP_Hub"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false
  local CrownIcon = Instance.new("TextButton", ScreenGui)
CrownIcon.Name = "CrownIcon"
CrownIcon.Position = UDim2.new(0.04, 0, 0.22, 0)
CrownIcon.Size = UDim2.new(0, 48, 0, 48)
CrownIcon.Text = "👑"
CrownIcon.TextSize = 22
CrownIcon.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
CrownIcon.TextColor3 = Color3.fromRGB(255, 215, 0)
CrownIcon.Active = true 
CrownIcon.Draggable = true
Instance.new("UICorner", CrownIcon).CornerRadius = UDim.new(0, 8)
local Stroke1 = Instance.new("UIStroke", CrownIcon)
Stroke1.Color = Color3.fromRGB(255, 215, 0)

local StealIcon = Instance.new("TextButton", ScreenGui)
StealIcon.Name = "StealIcon"
StealIcon.AnchorPoint = Vector2.new(1, 0)
StealIcon.Position = UDim2.new(0.895, 0, 0.21, 0) 
StealIcon.Size = UDim2.new(0, 44, 0, 44)
StealIcon.Text = "🔮"
StealIcon.TextSize = 18
StealIcon.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
StealIcon.TextColor3 = Color3.fromRGB(160, 80, 220)
StealIcon.Active = true 
StealIcon.Draggable = false
Instance.new("UICorner", StealIcon).CornerRadius = UDim.new(0, 8)
local PanelStroke = Instance.new("UIStroke", StealIcon)
PanelStroke.Color = Color3.fromRGB(45, 45, 55)
  local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
MainFrame.Size = UDim2.new(0, 370, 0, 260)
MainFrame.Position = UDim2.new(0.12, 0, 0.22, 0)
MainFrame.Active = true MainFrame.Draggable = true MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local FrameMainStroke = Instance.new("UIStroke", MainFrame)
FrameMainStroke.Color = Color3.fromRGB(255, 215, 0)

local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 110, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)
local SideLayout = Instance.new("UIListLayout", Sidebar)
SideLayout.Padding = UDim.new(0, 5) SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local TabTitle = Instance.new("TextLabel", Sidebar)
TabTitle.Size = UDim2.new(0.9, 0, 0, 35) TabTitle.Text = "ZEROBIX HUB" TabTitle.TextColor3 = Color3.fromRGB(255, 215, 0) TabTitle.Font = Enum.Font.SourceSansBold TabTitle.TextSize = 12 TabTitle.BackgroundTransparency = 1

local PagesContainer = Instance.new("Frame", MainFrame)
PagesContainer.Size = UDim2.new(1, -120, 1, -10)
PagesContainer.Position = UDim2.new(0, 115, 0, 5)
PagesContainer.BackgroundTransparency = 1
  local StealFrame = Instance.new("Frame", ScreenGui)
StealFrame.Name = "StealFrame"
StealFrame.BackgroundColor3 = Color3.fromRGB(12, 10, 24)
StealFrame.Size = UDim2.new(0, 330, 0, 400)
StealFrame.AnchorPoint = Vector2.new(1, 0)
StealFrame.Position = UDim2.new(0.88, -5, 0.21, 0)
StealFrame.Active = true StealFrame.Draggable = true StealFrame.Visible = false
Instance.new("UICorner", StealFrame).CornerRadius = UDim.new(0, 8)
local FrameStealStroke = Instance.new("UIStroke", StealFrame)
FrameStealStroke.Color = Color3.fromRGB(0, 255, 255)
FrameStealStroke.Thickness = 3

local Pages, TabButtons = {}, {}
local function CreateTab(tabName)
local page = Instance.new("ScrollingFrame", PagesContainer)
page.Size = UDim2.new(1, 0, 1, 0) page.BackgroundTransparency = 1 page.BorderSizePixel = 0 page.CanvasSize = UDim2.new(0, 0, 0, 400) page.ScrollBarThickness = 2 page.Visible = false
local layout = Instance.new("UIListLayout", page) layout.Padding = UDim.new(0, 6) layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Pages[tabName] = page
local btn = Instance.new("TextButton", Sidebar)
btn.Size = UDim2.new(0.92, 0, 0, 30) btn.Text = tabName btn.TextColor3 = Color3.fromRGB(140, 140, 150) btn.BackgroundColor3 = Color3.fromRGB(24, 24, 32) btn.Font = Enum.Font.SourceSansBold btn.TextSize = 10 Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
local s = Instance.new("UIStroke", btn) s.Color = Color3.fromRGB(40, 40, 50)
btn.MouseButton1Click:Connect(function()
for _, p in pairs(Pages) do p.Visible = false end
for b, st in pairs(TabButtons) do b.BackgroundColor3 = Color3.fromRGB(24, 24, 32) b.TextColor3 = Color3.fromRGB(140, 140, 150) st.Color = Color3.fromRGB(40, 40, 50) end
page.Visible = true btn.BackgroundColor3 = Color3.fromRGB(32, 32, 45) btn.TextColor3 = Color3.fromRGB(255, 215, 0) s.Color = Color3.fromRGB(255, 215, 0)
end)
TabButtons[btn] = s return page
  end
  local MainTab = CreateTab("Main Farm")
local BiomeTab = CreateTab("Select Biome")
local rTab = CreateTab("Egg Rarity")

local function CreateNativeToggle(parent, text, varName)
local btn = Instance.new("TextButton", parent)
btn.Size = UDim2.new(0.96, 0, 0, 34) btn.Text = "  " .. text btn.TextColor3 = Color3.fromRGB(160, 160, 170) btn.BackgroundColor3 = Color3.fromRGB(22, 22, 28) btn.Font = Enum.Font.SourceSansBold btn.TextSize = 11 btn.TextXAlignment = Enum.TextXAlignment.Left Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
local s = Instance.new("UIStroke", btn) s.Color = Color3.fromRGB(45, 45, 55)
local indicator = Instance.new("Frame", btn) indicator.Size = UDim2.new(0, 6, 0, 6) indicator.Position = UDim2.new(0.92, 0, 0.4, 0) indicator.BackgroundColor3 = Color3.fromRGB(200, 60, 60) Instance.new("UICorner", indicator).CornerRadius = UDim.new(1, 0)
btn.MouseButton1Click:Connect(function()
getgenv()[varName] = not getgenv()[varName]
if getgenv()[varName] then btn.TextColor3 = Color3.fromRGB(240, 240, 250) btn.BackgroundColor3 = Color3.fromRGB(24, 34, 28) indicator.BackgroundColor3 = Color3.fromRGB(50, 210, 100)
else btn.TextColor3 = Color3.fromRGB(160, 160, 170) btn.BackgroundColor3 = Color3.fromRGB(22, 22, 28) indicator.BackgroundColor3 = Color3.fromRGB(200, 60, 60) end
end)
end

CreateNativeToggle(MainTab, "Auto Steal Map", "AutoSteal")
CreateNativeToggle(MainTab, "Auto Gym Clicker", "AutoTrain")

for _, bName in ipairs(getgenv().BiomesList) do
local bBtn = Instance.new("TextButton", BiomeTab)
bBtn.Size = UDim2.new(0.96, 0, 0, 32) bBtn.Text = "Area: " .. bName bBtn.TextColor3 = Color3.fromRGB(200, 200, 210) bBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 32) bBtn.Font = Enum.Font.SourceSansBold bBtn.TextSize = 11 Instance.new("UICorner", bBtn).CornerRadius = UDim.new(0, 5)
bBtn.MouseButton1Click:Connect(function() getgenv().ActiveBiome = bName bBtn.TextColor3 = Color3.fromRGB(255, 215, 0) task.wait(0.2) bBtn.TextColor3 = Color3.fromRGB(200, 200, 210) end)
end

for _, fName in ipairs(getgenv().FloorList) do
local rBtn = Instance.new("TextButton", rTab)
rBtn.Size = UDim2.new(0.96, 0, 0, 32) rBtn.Text = "Limit: " .. fName rBtn.TextColor3 = Color3.fromRGB(200, 200, 210) rBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 32) rBtn.Font = Enum.Font.SourceSansBold rBtn.TextSize = 11 Instance.new("UICorner", rBtn).CornerRadius = UDim.new(0, 5)
rBtn.MouseButton1Click:Connect(function() for _, rar in ipairs(getgenv().EggRarities) do if rar.Name == fName then getgenv().RarityFloorIndex = rar.Rank break end end rBtn.TextColor3 = Color3.fromRGB(50, 210, 100) task.wait(0.2) rBtn.TextColor3 = Color3.fromRGB(200, 200, 210) end)
end

Pages["Main Farm"].Visible = true
local Header = Instance.new("Frame", StealFrame) Header.Size = UDim2.new(1, -20, 0, 40) Header.Position = UDim2.new(0, 10, 0, 8) Header.BackgroundTransparency = 1
local StealTitle = Instance.new("TextLabel", Header) StealTitle.Size = UDim2.new(0.5, 0, 1, 0) StealTitle.Text = "Steal Panel" StealTitle.TextColor3 = Color3.fromRGB(255, 255, 255) StealTitle.Font = Enum.Font.SourceSansBold StealTitle.TextSize = 22 StealTitle.BackgroundTransparency = 1
local SortBtn = Instance.new("TextButton", Header) SortBtn.Size = UDim2.new(0.42, 0, 0.8, 0) SortBtn.Position = UDim2.new(0.58, 0, 0.1, 0) SortBtn.Text = "Sort: Value" SortBtn.TextColor3 = Color3.fromRGB(0, 0, 0) SortBtn.BackgroundColor3 = Color3.fromRGB(173, 255, 47) SortBtn.Font = Enum.Font.SourceSansBold SortBtn.TextSize = 14 Instance.new("UICorner", SortBtn).CornerRadius = UDim.new(0, 4)
local SubHeader = Instance.new("Frame", StealFrame) SubHeader.Size = UDim2.new(1, -20, 0, 35) SubHeader.Position = UDim2.new(0, 10, 0, 52) SubHeader.BackgroundTransparency = 1
local AutoStealBtn = Instance.new("TextButton", SubHeader) AutoStealBtn.Size = UDim2.new(0.48, 0, 0.9, 0) AutoStealBtn.Text = "Auto Steal: OFF" AutoStealBtn.TextColor3 = Color3.fromRGB(0, 0, 0) AutoStealBtn.BackgroundColor3 = Color3.fromRGB(154, 205, 50) AutoStealBtn.Font = Enum.Font.SourceSansBold AutoStealBtn.TextSize = 12 Instance.new("UICorner", AutoStealBtn).CornerRadius = UDim.new(0, 4)
local TweenSpeedBtn = Instance.new("TextButton", SubHeader) TweenSpeedBtn.Size = UDim2.new(0.48, 0, 0.9, 0) TweenSpeedBtn.Position = UDim2.new(0.52, 0, 0, 0) TweenSpeedBtn.Text = "Tween Speed: 200%" TweenSpeedBtn.TextColor3 = Color3.fromRGB(0, 0, 0) TweenSpeedBtn.BackgroundColor3 = Color3.fromRGB(173, 255, 47) TweenSpeedBtn.Font = Enum.Font.SourceSansBold TweenSpeedBtn.TextSize = 12 Instance.new("UICorner", TweenSpeedBtn).CornerRadius = UDim.new(0, 4)
local ItemScrollList = Instance.new("ScrollingFrame", StealFrame) ItemScrollList.Size = UDim2.new(1, -20, 1, -105) ItemScrollList.Position = UDim2.new(0, 10, 0, 95) ItemScrollList.BackgroundColor3 = Color3.fromRGB(10, 8, 20) ItemScrollList.BorderSizePixel = 0 ItemScrollList.CanvasSize = UDim2.new(0, 0, 0, 600) ItemScrollList.ScrollBarThickness = 4 Instance.new("UICorner", ItemScrollList).CornerRadius = UDim.new(0, 4)
local ListLayout = Instance.new("UIListLayout", ItemScrollList) ListLayout.Padding = UDim.new(0, 4) ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

AutoStealBtn.MouseButton1Click:Connect(function()
getgenv().AutoSteal = not getgenv().AutoSteal
if getgenv().AutoSteal then AutoStealBtn.Text = "Auto Steal: ON" AutoStealBtn.BackgroundColor3 = Color3.fromRGB(50, 205, 50)
else AutoStealBtn.Text = "Auto Steal: OFF" AutoStealBtn.BackgroundColor3 = Color3.fromRGB(154, 205, 50) end
end)

task.spawn(function()
while task.wait(1.5) do
pcall(function()
for _, child in pairs(ItemScrollList:GetChildren()) do if child:IsA("Frame") then child:Destroy() end end
local Found = {}
for _, obj in pairs(Workspace:GetDescendants()) do
if obj:IsA("Model") and (obj.Name:lower():find("egg") or obj:FindFirstChildWhichIsA("TouchTransmitter", true)) then
local nameLower = obj.Name:lower()
local currentBiomeLower = getgenv().ActiveBiome:lower()
local inBiome = obj:FindFirstAncestor(getgenv().ActiveBiome) or nameLower:find(currentBiomeLower)
if currentBiomeLower == "all map" or inBiome then
local textCol = Color3.fromRGB(255, 255, 255)
for _, rarity in ipairs(getgenv().EggRarities) do if nameLower:find(rarity.Name:lower()) then textCol = rarity.Color break end end
local cleanName = obj.Name:gsub("FirstAreaEgg_", ""):gsub("_", " "):gsub("%d+", ""):gsub("Slot", "")
if cleanName == "" or cleanName == " " then cleanName = "Dinosaur Egg" end
local imgId = "rbxassetid://10850239105" local mesh = obj:FindFirstChildWhichIsA("MeshPart", true) or obj:FindFirstChildWhichIsA("SpecialMesh", true)
if mesh then imgId = mesh:IsA("MeshPart") and mesh.TextureID or mesh.TextureId end
table.insert(Found, {Instance = obj, Name = cleanName, Color = textCol, Img = imgId})
end
end
end
for _, data in ipairs(Found) do
local Row = Instance.new("Frame", ItemScrollList) Row.Size = UDim2.new(0.98, 0, 0, 40) Row.BackgroundColor3 = Color3.fromRGB(20, 20, 60) Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 4)
local RowStroke = Instance.new("UIStroke", Row) RowStroke.Color = Color3.fromRGB(0, 100, 200) RowStroke.Thickness = 1.5
local PetImg = Instance.new("ImageLabel", Row) PetImg.Size = UDim2.new(0, 28, 0, 28) PetImg.Position = UDim2.new(0, 8, 0, 6) PetImg.BackgroundTransparency = 1 PetImg.Image = data.Img Instance.new("UICorner", PetImg).CornerRadius = UDim.new(0, 4)
local Lbl = Instance.new("TextLabel", Row) Lbl.Size = UDim2.new(0.55, 0, 1, 0) Lbl.Position = UDim2.new(0, 42, 0, 0) Lbl.Text = data.Name Lbl.TextColor3 = data.Color Lbl.Font = Enum.Font.SourceSansBold Lbl.TextSize = 13 Lbl.BackgroundTransparency = 1 Lbl.TextXAlignment = Enum.TextXAlignment.Left
local Btn = Instance.new("TextButton", Row) Btn.Size = UDim2.new(0.24, 0, 0, 26) Btn.Position = UDim2.new(0.74, 0, 0, 7) Btn.Text = "Steal ⭐️" Btn.TextColor3 = Color3.fromRGB(255, 255, 255) Btn.BackgroundColor3 = Color3.fromRGB(0, 180, 0) Btn.Font = Enum.Font.SourceSansBold Btn.TextSize = 12 Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4) Instance.new("UIStroke", Btn).Color = Color3.fromRGB(255, 255, 255)
Btn.MouseButton1Click:Connect(function() Btn.BackgroundColor3 = Color3.fromRGB(255, 140, 0) getgenv().PriorityTarget = data.Instance task.wait(0.15) Btn.BackgroundColor3 = Color3.fromRGB(0, 180, 0) end)
end
end)
end
end)
local mainOpen = false CrownIcon.MouseButton1Click:Connect(function() mainOpen = not mainOpen MainFrame.Visible = mainOpen end)
local stealOpen = false StealIcon.MouseButton1Click:Connect(function() stealOpen = not stealOpen StealFrame.Visible = stealOpen end)
  -- =================================================================
-- 👑 ZEROBIX HUB v22.0 [KONSEP 2: SLIDE CARDS ENGINE] - PART 10 👑
-- =================================================================
local CardTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function UpdateSlideCards(scrollFrame, cardList, targetVar)
    local centerX = scrollFrame.AbsolutePosition.X + (scrollFrame.AbsoluteSize.X / 2)
    for _, cardData in ipairs(cardList) do
        local cardObj = cardData.Instance
        local cardCenter = cardObj.AbsolutePosition.X + (cardObj.AbsoluteSize.X / 2)
        local distance = math.abs(centerX - cardCenter)
        
        if distance < 60 then
            getgenv()[targetVar] = cardData.Value
            TweenService:Create(cardObj, CardTweenInfo, {
                Size = UDim2.new(0, 140, 0, 180),
                BackgroundColor3 = Color3.fromRGB(24, 20, 38)
            }):Play()
            cardObj:FindFirstChildWhichIsA("UIStroke").Color = Color3.fromRGB(255, 215, 0)
            cardObj:FindFirstChildWhichIsA("TextLabel").TextColor3 = Color3.fromRGB(255, 215, 0)
        else
            TweenService:Create(cardObj, CardTweenInfo, {
                Size = UDim2.new(0, 110, 0, 150),
                BackgroundColor3 = Color3.fromRGB(14, 14, 18)
            }):Play()
            cardObj:FindFirstChildWhichIsA("UIStroke").Color = Color3.fromRGB(45, 45, 55)
            cardObj:FindFirstChildWhichIsA("TextLabel").TextColor3 = Color3.fromRGB(140, 140, 150)
        end
    end
  end
  -- =================================================================
-- 👑 ZEROBIX HUB v22.0 [KONSEP 2: SLIDE CARDS ENGINE] - PART 11 👑
-- =================================================================
local BiomeScrollContainer = Instance.new("ScrollingFrame", BiomeTab)
BiomeScrollContainer.Size = UDim2.new(0.96, 0, 0, 200)
BiomeScrollContainer.Position = UDim2.new(0.02, 0, 0.1, 0)
BiomeScrollContainer.BackgroundTransparency = 1
BiomeScrollContainer.BorderSizePixel = 0
BiomeScrollContainer.CanvasSize = UDim2.new(0, 1600, 0, 0)
BiomeScrollContainer.ScrollingDirection = Enum.ScrollingDirection.X
BiomeScrollContainer.ScrollBarThickness = 0

local BiomeLayout = Instance.new("UIListLayout", BiomeScrollContainer)
BiomeLayout.FillDirection = Enum.FillDirection.Horizontal
BiomeLayout.SortOrder = Enum.SortOrder.LayoutOrder
BiomeLayout.VerticalAlignment = Enum.VerticalAlignment.Center
BiomeLayout.Padding = UDim.new(0, 15)

local ActiveBiomeCards = {}

for i, biomeName in ipairs(getgenv().BiomesList) do
    local Card = Instance.new("TextButton", BiomeScrollContainer)
    Card.Size = UDim2.new(0, 110, 0, 150)
    Card.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
    Card.Text = ""
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 12)
    local stroke = Instance.new("UIStroke", Card)
    stroke.Color = Color3.fromRGB(45, 45, 55)
    stroke.Thickness = 1.5
    -- =================================================================
-- 👑 ZEROBIX HUB v22.0 [KONSEP 2: SLIDE CARDS ENGINE] - PART 12 👑
-- =================================================================
    local CardLabel = Instance.new("TextLabel", Card)
    CardLabel.Size = UDim2.new(1, 0, 1, 0)
    CardLabel.Text = "✦\n\n" .. biomeName .. "\n\nBIOME"
    CardLabel.TextColor3 = Color3.fromRGB(140, 140, 150)
    CardLabel.Font = Enum.Font.SourceSansBold
    CardLabel.TextSize = 12
    CardLabel.BackgroundTransparency = 1
    
    table.insert(ActiveBiomeCards, {Instance = Card, Value = biomeName})
    
    Card.MouseButton1Click:Connect(function()
        local pos = Card.Position.X.Offset
        BiomeScrollContainer.CanvasPosition = Vector2.new(Card.AbsolutePosition.X - BiomeScrollContainer.AbsolutePosition.X, 0)
        UpdateSlideCards(BiomeScrollContainer, ActiveBiomeCards, "ActiveBiome")
    end)
end

BiomeScrollContainer:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
    UpdateSlideCards(BiomeScrollContainer, ActiveBiomeCards, "ActiveBiome")
end)
  -- =================================================================
-- 👑 ZEROBIX HUB v22.0 [KONSEP 2: SLIDE CARDS ENGINE] - PART 13 👑
-- =================================================================
local RarityScrollContainer = Instance.new("ScrollingFrame", rTab)
RarityScrollContainer.Size = UDim2.new(0.96, 0, 0, 200)
RarityScrollContainer.Position = UDim2.new(0.02, 0, 0.1, 0)
RarityScrollContainer.BackgroundTransparency = 1
RarityScrollContainer.CanvasSize = UDim2.new(0, 900, 0, 0)
RarityScrollContainer.ScrollingDirection = Enum.ScrollingDirection.X
RarityScrollContainer.ScrollBarThickness = 0

local RarityLayout = Instance.new("UIListLayout", RarityScrollContainer)
RarityLayout.FillDirection = Enum.FillDirection.Horizontal
RarityLayout.VerticalAlignment = Enum.VerticalAlignment.Center
RarityLayout.Padding = UDim.new(0, 15)

local ActiveRarityCards = {}

for _, floorName in ipairs(getgenv().FloorList) do
    local rRank = 6
    for _, rar in ipairs(getgenv().EggRarities) do
        if rar.Name == floorName then rRank = rar.Rank break end
    end
    
    local Card = Instance.new("TextButton", RarityScrollContainer)
    Card.Size = UDim2.new(0, 110, 0, 150)
    Card.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
    Card.Text = ""
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 12)
    local stroke = Instance.new("UIStroke", Card)
    stroke.Color = Color3.fromRGB(45, 45, 55)
    
    local CardLabel = Instance.new("TextLabel", Card)
    CardLabel.Size = UDim2.new(1, 0, 1, 0)
    CardLabel.Text = "⭐\n\nMIN\n\n" .. floorName
    CardLabel.TextColor3 = Color3.fromRGB(140, 140, 150)
    CardLabel.Font = Enum.Font.SourceSansBold
    CardLabel.TextSize = 12
    CardLabel.BackgroundTransparency = 1
    
    table.insert(ActiveRarityCards, {Instance = Card, Value = rRank})
end

RarityScrollContainer:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
    UpdateSlideCards(RarityScrollContainer, ActiveRarityCards, "RarityFloorIndex")
end)

print("[Zerobix Next-Gen]: Konsep 2 Slide-to-Select resmi aktif sempurna!")
  -- =================================================================
-- 👑 ZEROBIX HUB v22.0 [KONSEP 3: SPATIAL ITEM RADAR] - PART 14 👑
-- =================================================================
local function ScanMapAndRefreshRadar()
    pcall(function()
        for _, child in pairs(ItemScrollList:GetChildren()) do 
            if child:IsA("Frame") then child:Destroy() end 
        end
        local FoundObjects = {}
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("Model") and (obj.Name:lower():find("egg") or obj:FindFirstChildWhichIsA("TouchTransmitter", true)) then
                local nameLower = obj.Name:lower()
                local currentBiomeLower = getgenv().ActiveBiome:lower()
                local inBiome = obj:FindFirstAncestor(getgenv().ActiveBiome) or nameLower:find(currentBiomeLower)
                
                if currentBiomeLower == "all map" or inBiome then
                    local textColor = Color3.fromRGB(255, 255, 255)
                    for _, rarity in ipairs(getgenv().EggRarities) do 
                        if nameLower:find(rarity.Name:lower()) then 
                            textColor = rarity.Color 
                            break 
                        end 
                    end
                    
                    -- 🔥 STRING CLEANER ENGINE: Menerjemahkan nama sistem hancur jadi nama bersih
                    local cleanName = obj.Name:gsub("FirstAreaEgg_", ""):gsub("_", " "):gsub("%d+", ""):gsub("Slot", "")
                    if cleanName == "" or cleanName == " " then cleanName = "Dinosaur Egg" end
                    
                    -- 🔥 VVIP IMAGE PARSER: Membaca ID gambar tekstur 3D asset game secara otomatis
                    local imageId = "rbxassetid://10850239105"
                    local mesh = obj:FindFirstChildWhichIsA("MeshPart", true) or obj:FindFirstChildWhichIsA("SpecialMesh", true)
                    if mesh then imageId = mesh:IsA("MeshPart") and mesh.TextureID or mesh.TextureId end
                    
                    table.insert(FoundObjects, {Instance = obj, Name = cleanName, Color = textColor, Img = imageId})
                end
            end
        end
        -- =================================================================
-- 👑 ZEROBIX HUB v22.0 [KONSEP 3: SPATIAL ITEM RADAR] - PART 15 👑
-- =================================================================
        for _, data in ipairs(FoundObjects) do
            local CardRow = Instance.new("Frame", ItemScrollList)
            CardRow.Size = UDim2.new(0.96, 0, 0, 44)
            CardRow.BackgroundColor3 = Color3.fromRGB(16, 14, 26)
            Instance.new("UICorner", CardRow).CornerRadius = UDim.new(0, 6)
            
            -- Pendaran border hologram kustom mengikuti warna kelangkaan telur
            local StrokeCard = Instance.new("UIStroke", CardRow)
            StrokeCard.Color = data.Color
            StrokeCard.Thickness = 1
            
            -- Komponen Gambar Visual Pet/Telur Asli
            local PetImgLabel = Instance.new("ImageLabel", CardRow)
            PetImgLabel.Size = UDim2.new(0, 32, 0, 32)
            PetImgLabel.Position = UDim2.new(0, 8, 0, 6)
            PetImgLabel.BackgroundTransparency = 1
            PetImgLabel.Image = data.Img
            Instance.new("UICorner", PetImgLabel).CornerRadius = UDim.new(0, 4)
            
            -- Teks Label Nama Bersih Berpendar
            local NameLabel = Instance.new("TextLabel", CardRow)
            NameLabel.Size = UDim2.new(0.52, 0, 1, 0)
            NameLabel.Position = UDim2.new(0, 48, 0, 0)
            NameLabel.Text = data.Name
            NameLabel.TextColor3 = data.Color
            NameLabel.Font = Enum.Font.SourceSansBold
            NameLabel.TextSize = 12
            NameLabel.BackgroundTransparency = 1
            NameLabel.TextXAlignment = Enum.TextXAlignment.Left
          -- =================================================================
-- 👑 ZEROBIX HUB v22.0 [KONSEP 3: SPATIAL ITEM RADAR] - PART 16 👑
-- =================================================================
            -- Tombol Instant priority Lock
            local StealBtn = Instance.new("TextButton", CardRow)
            StealBtn.Size = UDim2.new(0.24, 0, 0, 26)
            StealBtn.Position = UDim2.new(0.72, 0, 0, 9)
            StealBtn.Text = "STEAL ✦"
            StealBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            StealBtn.BackgroundColor3 = Color3.fromRGB(24, 20, 36)
            StealBtn.Font = Enum.Font.SourceSansBold
            StealBtn.TextSize = 10
            Instance.new("UICorner", StealBtn).CornerRadius = UDim.new(0, 5)
            local btnStroke = Instance.new("UIStroke", StealBtn)
            btnStroke.Color = data.Color
            
            StealBtn.MouseButton1Click:Connect(function()
                btnStroke.Color = Color3.fromRGB(255, 140, 0)
                getgenv().PriorityTarget = data.Instance
                task.wait(0.2)
                btnStroke.Color = data.Color
            end)
        end
    end)
end

-- Loop penyegar data radar hologram secepat kilat (FPS Friendly)
task.spawn(function()
    while task.wait(1.5) do
        ScanMapAndRefreshRadar()
    end
end)

print("=====================================================")
print("👑 ZEROBIX HUB SVVIP PRO EDITION TAMAT SEMPURNA! 👑")
print("=====================================================")
  

-- Grow a Garden Premium - Script Complet (Fusionné & Stylisé)
-- Auteur: GPT & gorthekk | Compatible JJSploit / KRNL / Synapse

-- Services
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- Anti double load
if getgenv().GrowAGardenLoaded then return end
getgenv().GrowAGardenLoaded = true

-- Variables UI
local toggleKey = Enum.KeyCode.LeftControl
local uiOpen = true

-- Fonction pour rendre GUI déplaçable
local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                  startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- Création ScreenGui
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "GrowAGardenUI"

-- Main Frame
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
mainFrame.Active = true; makeDraggable(mainFrame)

-- UICorner
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

-- Toggle Button
local toggleBtn = Instance.new("TextButton", screenGui)
toggleBtn.Name = "ToggleBtn"
toggleBtn.Size = UDim2.new(0, 120, 0, 30)
toggleBtn.Position = UDim2.new(0.3, 0, 0.2, -35)
toggleBtn.Text = "Toggle UI"
toggleBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0,8)
toggleBtn.MouseButton1Click:Connect(function()
    uiOpen = not uiOpen
    mainFrame.Visible = uiOpen
end)

-- Gus: close button
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0, 5)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,6)
closeBtn.MouseButton1Click:Connect(function()
    uiOpen = false
    mainFrame.Visible = false
end)

-- Tab Buttons
local tabNames = {"Shop", "Pets", "Stats", "Plant", "Mutation", "Config"}
local tabs = {}
local tabButtons = {}
local buttonFrame = Instance.new("Frame", mainFrame)
buttonFrame.Size = UDim2.new(1, -20, 0, 30)
buttonFrame.Position = UDim2.new(0,10,0,40)
buttonFrame.BackgroundTransparency = 1

local spacing = 5
local btnWidth = (280 - spacing*(#tabNames-1)) / #tabNames

for i,name in ipairs(tabNames) do
    local btn = Instance.new("TextButton", buttonFrame)
    btn.Size = UDim2.new(0, btnWidth, 1, 0)
    btn.Position = UDim2.new(0, (i-1)*(btnWidth+spacing), 0, 0)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
    tabButtons[name] = btn
    btn.MouseButton1Click:Connect(function()
        for _,fr in pairs(tabs) do fr.Visible = false end
        tabs[name].Visible = true
    end)
end

-- Création des pages
for _,name in ipairs(tabNames) do
    local page = Instance.new("Frame", mainFrame)
    page.Name = name.."Page"
    page.Size = UDim2.new(1, -20, 1, -80)
    page.Position = UDim2.new(0,10,0,80)
    page.BackgroundTransparency = 1
    page.Visible = false
    tabs[name] = page
    -- Layout list
    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0,8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
end
-- Default page
tabs["Shop"].Visible = true

-- ====== Fonctions de catégorie ======
-- Shop
local function fillShop()
    local page = tabs["Shop"]
    page:ClearAllChildren()
    Instance.new("UIListLayout", page).Padding = UDim.new(0,8)
    local fruits = {"Watermelon","Strawberry","Coconut"}
    for _,item in ipairs(fruits) do
        local btn = Instance.new("TextButton", page)
        btn.Size = UDim2.new(1,0,0,30)
        btn.Text = "Buy "..item
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 14
        btn.BackgroundColor3 = Color3.fromRGB(70,70,70)
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
        btn.MouseButton1Click:Connect(function()
            print("[Shop] Achat de "..item)
            -- code achat
        end)
    end
end
-- Pets
local function fillPets()
    local page = tabs["Pets"]
    page:ClearAllChildren()
    Instance.new("UIListLayout", page).Padding = UDim.new(0,8)
    -- Exemples de pets
    local pets = { {name="PetA",chance=10},{name="PetB",chance=5} }
    for _,p in ipairs(pets) do
        local frame = Instance.new("Frame", page)
        frame.Size = UDim2.new(1,0,0,50)
        frame.BackgroundColor3 = Color3.fromRGB(50,50,50)
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0,6)
        local lbl = Instance.new("TextLabel", frame)
        lbl.Size = UDim2.new(1,0,1,0)
        lbl.Text = p.name.." - "..p.chance.."%"
        lbl.Font = Enum.Font.Gotham
        lbl.TextSize = 14
        lbl.TextColor3 = Color3.fromRGB(255,255,255)
    end
end
-- Stats
local function fillStats()
    local page = tabs["Stats"]
    page:ClearAllChildren()
    Instance.new("UIListLayout", page).Padding = UDim.new(0,8)
    local stats = {Plant=100,Water=200,Harvest=150}
    for k,v in pairs(stats) do
        local lbl = Instance.new("TextLabel", page)
        lbl.Size = UDim2.new(1,0,0,25)
        lbl.Text = k..": "..v
        lbl.Font = Enum.Font.Gotham
        lbl.TextSize = 14
        lbl.TextColor3 = Color3.fromRGB(255,255,255)
        lbl.BackgroundTransparency = 1
    end
end
-- Plant
local function fillPlant()
    local page = tabs["Plant"]
    page:ClearAllChildren()
    Instance.new("UIListLayout", page).Padding = UDim.new(0,8)
    local actions = {{"AutoPlant",function() print("AutoPlant") end},
                     {"AutoWater",function() print("AutoWater") end},
                     {"AutoHarvest",function() print("AutoHarvest") end}}
    for _,act in ipairs(actions) do
        local btn = Instance.new("TextButton", page)
        btn.Size = UDim2.new(1,0,0,30)
        btn.Text = act[1]
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 14
        btn.BackgroundColor3 = Color3.fromRGB(70,70,70)
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
        btn.MouseButton1Click:Connect(act[2])
    end
end
-- Mutation
local function fillMutation()
    local page = tabs["Mutation"]
    page:ClearAllChildren()
    Instance.new("UIListLayout", page).Padding = UDim.new(0,8)
    local mutations = {"Mutation1","Mutation2","Mutation3"}
    for _,m in ipairs(mutations) do
        local btn = Instance.new("TextButton", page)
        btn.Size = UDim2.new(1,0,0,30)
        btn.Text = m
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 14
        btn.BackgroundColor3 = Color3.fromRGB(70,70,70)
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
        btn.MouseButton1Click:Connect(function()
            print("[Mutation] "..m)
        end)
    end
end
-- Config
local function fillConfig()
    local page = tabs["Config"]
    page:ClearAllChildren()
    Instance.new("UIListLayout", page).Padding = UDim.new(0,8)
    local lbl = Instance.new("TextLabel", page)
    lbl.Size = UDim2.new(1,0,0,25)
    lbl.Text = "Toggle UI Key: "..tostring(toggleKey)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 14
end

-- Remplir toutes les pages
fillShop(); fillPets(); fillStats(); fillPlant(); fillMutation(); fillConfig()

-- Écoute touche pour toggle UI
UIS.InputBegan:Connect(function(input,gameProcessed)
    if not gameProcessed and input.KeyCode == toggleKey then
        uiOpen = not uiOpen
        mainFrame.Visible = uiOpen
    end
end)

print("Grow a Garden UI Chargée !")

-- GrowAGarden UI complet pour JJSploit
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

-- Variables auto
local autoPlant, autoWater, autoHarvest = false, false, false
local uiVisible = true
local dragging, dragInput, dragStart, startPos

-- Création UI principale
local MainFrame = Instance.new("Frame")
MainFrame.Name = "GrowAGardenMainFrame"
MainFrame.Size = UDim2.new(0, 450, 0, 400)
MainFrame.Position = UDim2.new(0.5, -225, 0.3, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
MainFrame.BorderSizePixel = 0
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Parent = player:WaitForChild("PlayerGui")

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 12)

-- Barre titre
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
local TitleCorner = Instance.new("UICorner", TitleBar)
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleBar.BorderSizePixel = 0

local TitleLabel = Instance.new("TextLabel", TitleBar)
TitleLabel.Size = UDim2.new(1, -50, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Grow A Garden UI"
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 20
TitleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Bouton fermer
local BtnToggle = Instance.new("TextButton", TitleBar)
BtnToggle.Size = UDim2.new(0, 40, 0, 30)
BtnToggle.Position = UDim2.new(1, -45, 0, 3)
BtnToggle.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
BtnToggle.Text = "X"
BtnToggle.Font = Enum.Font.GothamBold
BtnToggle.TextSize = 20
BtnToggle.TextColor3 = Color3.new(1,1,1)
BtnToggle.AutoButtonColor = true
BtnToggle.BorderSizePixel = 0
local BtnToggleCorner = Instance.new("UICorner", BtnToggle)
BtnToggleCorner.CornerRadius = UDim.new(0, 10)

-- Container menu boutons
local MenuButtonsFrame = Instance.new("Frame", MainFrame)
MenuButtonsFrame.Size = UDim2.new(1, 0, 0, 40)
MenuButtonsFrame.Position = UDim2.new(0, 0, 0, 35)
MenuButtonsFrame.BackgroundTransparency = 1

-- Container contenu
local ContentDisplay = Instance.new("Frame", MainFrame)
ContentDisplay.Size = UDim2.new(1, -20, 1, -85)
ContentDisplay.Position = UDim2.new(0, 10, 0, 75)
ContentDisplay.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
ContentDisplay.BorderSizePixel = 0
local ContentCorner = Instance.new("UICorner", ContentDisplay)
ContentCorner.CornerRadius = UDim.new(0, 10)

-- Menus
local menus = {"Shop", "Pets", "Stats", "Plant", "Mutation", "Config"}
local buttons = {}
local activeMenu = nil

-- Fonction utilitaire : clear contenu
local function clearContent()
    for _, v in pairs(ContentDisplay:GetChildren()) do
        if not v:IsA("UIListLayout") then
            v:Destroy()
        end
    end
end

-- Fonction création bouton menu
local function createMenuButton(name, index)
    local btn = Instance.new("TextButton", MenuButtonsFrame)
    btn.Size = UDim2.new(0, 70, 1, -8)
    btn.Position = UDim2.new(0, (index - 1) * 75 + 10, 0, 4)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.fromRGB(230, 230, 230)
    btn.BorderSizePixel = 0
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 8)
    return btn
end

-- Fonctions auto placeholders
local function doAutoPlant()
    -- Code auto plant ici
    -- print("[AutoPlant] Executing")
end

local function doAutoWater()
    -- Code auto water ici
    -- print("[AutoWater] Executing")
end

local function doAutoHarvest()
    -- Code auto harvest ici
    -- print("[AutoHarvest] Executing")
end

-- AntiBan placeholder simple
local function antiBan()
    -- Ex: simuler activité ou désactiver si détection
end

-- Affichage Shop
local function showShop()
    clearContent()
    local title = Instance.new("TextLabel", ContentDisplay)
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundTransparency = 1
    title.Text = "Boutique Fruits"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextXAlignment = Enum.TextXAlignment.Center

    local fruits = {"Watermelon", "Pineapple", "Cherry", "Strawberry"}

    for i, fruit in ipairs(fruits) do
        local btn = Instance.new("TextButton", ContentDisplay)
        btn.Size = UDim2.new(0, 180, 0, 35)
        btn.Position = UDim2.new(0, 20 + ((i-1)%2)*190, 0, 50 + math.floor((i-1)/2)*45)
        btn.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
        btn.Text = "Acheter "..fruit
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 18
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.BorderSizePixel = 0
        local corner = Instance.new("UICorner", btn)
        corner.CornerRadius = UDim.new(0, 10)
        btn.AutoButtonColor = true
        btn.MouseButton1Click:Connect(function()
            print("[Shop] Achat fruit:", fruit)
            -- Ici ton code d'achat
        end)
    end
end

-- Affichage Pets
local function showPets()
    clearContent()
    local title = Instance.new("TextLabel", ContentDisplay)
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundTransparency = 1
    title.Text = "Mes Pets"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextXAlignment = Enum.TextXAlignment.Center

    local pets = {
        {Name = "Dog", Chance = "30%"},
        {Name = "Cat", Chance = "20%"},
        {Name = "Bird", Chance = "10%"},
    }

    for i, pet in ipairs(pets) do
        local lbl = Instance.new("TextLabel", ContentDisplay)
        lbl.Size = UDim2.new(1, -20, 0, 25)
        lbl.Position = UDim2.new(0, 10, 0, 40 + (i-1)*30)
        lbl.BackgroundTransparency = 1
        lbl.Text = pet.Name .. " - Chance: " .. pet.Chance
        lbl.Font = Enum.Font.Gotham
        lbl.TextSize = 18
        lbl.TextColor3 = Color3.new(1,1,1)
        lbl.TextXAlignment = Enum.TextXAlignment.Left
    end
end

-- Affichage Stats
local function showStats()
    clearContent()
    local title = Instance.new("TextLabel", ContentDisplay)
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundTransparency = 1
    title.Text = "Statistiques"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextXAlignment = Enum.TextXAlignment.Center

    local stats = {
        {"Plants Planted", 100},
        {"Fruits Harvested", 50},
        {"Pets Collected", 5},
    }

    for i, stat in ipairs(stats) do
        local lbl = Instance.new("TextLabel", ContentDisplay)
        lbl.Size = UDim2.new(1, -20, 0, 25)
        lbl.Position = UDim2.new(0, 10, 0, 40 + (i-1)*30)
        lbl.BackgroundTransparency = 1
        lbl.Text = stat[1] .. ": " .. tostring(stat[2])
        lbl.Font = Enum.Font.Gotham
        lbl.TextSize = 18
        lbl.TextColor3 = Color3.new(1,1,1)
        lbl.TextXAlignment = Enum.TextXAlignment.Left
    end
end

-- Affichage Plant
local function showPlant()
    clearContent()
    local title = Instance.new("TextLabel", ContentDisplay)
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundTransparency = 1
    title.Text = "Menu Plantation"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextXAlignment = Enum.TextXAlignment.Center

    local autoPlantBtn = Instance.new("TextButton", ContentDisplay)
    autoPlantBtn.Size = UDim2.new(0, 150, 0, 35)
    autoPlantBtn.Position = UDim2.new(0, 20, 0, 50)
    autoPlantBtn.Text = "Auto Plant: OFF"
    autoPlantBtn.Font = Enum.Font.GothamBold
    autoPlantBtn.TextSize = 18
    autoPlantBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
    autoPlantBtn.TextColor3 = Color3.new(1,1,1)
    autoPlantBtn.BorderSizePixel = 0
    local corner1 = Instance.new("UICorner", autoPlantBtn)
    corner1.CornerRadius = UDim.new(0, 10)
    autoPlantBtn.MouseButton1Click:Connect(function()
        autoPlant = not autoPlant
        autoPlantBtn.Text = "Auto Plant: " .. (autoPlant and "ON" or "OFF")
        print("[AutoPlant] Toggled to", autoPlant)
    end)

    local autoWaterBtn = Instance.new("TextButton", ContentDisplay)
    autoWaterBtn.Size = UDim2.new(0, 150, 0, 35)
    autoWaterBtn.Position = UDim2.new(0, 200, 0, 50)
    autoWaterBtn.Text = "Auto Water: OFF"
    autoWaterBtn.Font = Enum.Font.GothamBold
    autoWaterBtn.TextSize = 18
    autoWaterBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
    autoWaterBtn.TextColor3 = Color3.new(1,1,1)
    autoWaterBtn.BorderSizePixel = 0
    local corner2 = Instance.new("UICorner", autoWaterBtn)
    corner2.CornerRadius = UDim.new(0, 10)
    autoWaterBtn.MouseButton1Click:Connect(function()
        autoWater = not autoWater
        autoWaterBtn.Text = "Auto Water: " .. (autoWater and "ON" or "OFF")
        print("[AutoWater] Toggled to", autoWater)
    end)

    local autoHarvestBtn = Instance.new("TextButton", ContentDisplay)
    autoHarvestBtn.Size = UDim2.new(0, 150, 0, 35)
    autoHarvestBtn.Position = UDim2.new(0, 20, 0, 100)
    autoHarvestBtn.Text = "Auto Harvest: OFF"
    autoHarvestBtn.Font = Enum.Font.GothamBold
    autoHarvestBtn.TextSize = 18
    autoHarvestBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
    autoHarvestBtn.TextColor3 = Color3.new(1,1,1)
    autoHarvestBtn.BorderSizePixel = 0
    local corner3 = Instance.new("UICorner", autoHarvestBtn)
    corner3.CornerRadius = UDim.new(0, 10)
    autoHarvestBtn.MouseButton1Click:Connect(function()
        autoHarvest = not autoHarvest
        autoHarvestBtn.Text = "Auto Harvest: " .. (autoHarvest and "ON" or "OFF")
        print("[AutoHarvest] Toggled to", autoHarvest)
    end)
end

-- Affichage Mutation
local function showMutation()
    clearContent()
    local title = Instance.new("TextLabel", ContentDisplay)
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundTransparency = 1
    title.Text = "Menu Mutation"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.TextColor3 = Color3.new(1,1,1)
    title.TextXAlignment = Enum.TextXAlignment.Center

    local mutations = {"Mutate All Fruits", "Reset Mutations"}

    for i, mut in ipairs(mutations) do
        local btn = Instance.new("TextButton", ContentDisplay)
        btn.Size = UDim2.new(0, 200, 0, 35)
        btn.Position = UDim2.new(0, 20, 0, 50 + (i-1)*45)
        btn.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
        btn.Text = mut
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 18
        btn.TextColor3 = Color3.new(1,1,1)
        btn.BorderSizePixel = 0
        local corner = Instance.new("UICorner", btn)
        corner.CornerRadius = UDim.new(0, 10)
        btn.AutoButtonColor = true
        btn.MouseButton1Click:Connect(function()
            print("[Mutation] Action: " .. mut)
            -- Place ici ta fonction mutation
        end)
    end
end

-- Affichage Config
local function showConfig()
    clearContent()
    local title = Instance.new("TextLabel", ContentDisplay)
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundTransparency = 1
    title.Text = "Configuration"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.TextColor3 = Color3.new(1,1,1)
    title.TextXAlignment = Enum.TextXAlignment.Center

    local info = Instance.new("TextLabel", ContentDisplay)
    info.Size = UDim2.new(1, -20, 0, 60)
    info.Position = UDim2.new(0, 10, 0, 50)
    info.BackgroundTransparency = 1
    info.Text = "Appuyez sur la touche [Left Ctrl] pour afficher/masquer l'interface."
    info.Font = Enum.Font.Gotham
    info.TextSize = 18
    info.TextColor3 = Color3.new(1,1,1)
    info.TextWrapped = true
    info.TextXAlignment = Enum.TextXAlignment.Center
    info.TextYAlignment = Enum.TextYAlignment.Center
end

-- Switch menu
local function switchMenu(name)
    activeMenu = name
    for _, btn in pairs(buttons) do
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        btn.TextColor3 = Color3.fromRGB(230,230,230)
    end
    buttons[name].BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    buttons[name].TextColor3 = Color3.fromRGB(255, 255, 255)

    if name == "Shop" then
        showShop()
    elseif name == "Pets" then
        showPets()
    elseif name == "Stats" then
        showStats()
    elseif name == "Plant" then
        showPlant()
    elseif name == "Mutation" then
        showMutation()
    elseif name == "Config" then
        showConfig()
    end
end

-- Création boutons menu
for i, name in ipairs(menus) do
    buttons[name] = createMenuButton(name, i)
    buttons[name].MouseButton1Click:Connect(function()
        switchMenu(name)
    end)
end

-- Initialisation menu actif
switchMenu("Shop")

-- Toggle via bouton X
BtnToggle.MouseButton1Click:Connect(function()
    uiVisible = not uiVisible
    MainFrame.Visible = uiVisible
end)

-- Toggle via Left Ctrl
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.LeftControl then
        uiVisible = not uiVisible
        MainFrame.Visible = uiVisible
    end
end)

-- Dragging
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Boucle auto (plante, eau, récolte)
RunService.Heartbeat:Connect(function()
    if autoPlant then
        doAutoPlant()
    end
    if autoWater then
        doAutoWater()
    end
    if autoHarvest then
        doAutoHarvest()
    end
    antiBan()
end)

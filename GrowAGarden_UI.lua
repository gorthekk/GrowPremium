-- GrowAGarden_Complete_UI.lua
-- Fusionné, stylisé, déplaçable, toggle avec LeftCtrl

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Config toggle UI key
local toggleKey = Enum.KeyCode.LeftControl

-- Helper function: create UI elements
local function create(className, properties)
    local obj = Instance.new(className)
    for prop, val in pairs(properties) do
        obj[prop] = val
    end
    return obj
end

-- Main UI
local ScreenGui = create("ScreenGui", {Name="GrowAGarden_UI", ResetOnSpawn=false, Parent=game.CoreGui})

local MainFrame = create("Frame", {
    Parent = ScreenGui,
    Size = UDim2.new(0, 450, 0, 350),
    Position = UDim2.new(0.3, 0, 0.3, 0),
    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
    BorderSizePixel = 0,
    ClipsDescendants = true,
})

-- Rounded corners
local UICorner = create("UICorner", {Parent=MainFrame, CornerRadius=UDim.new(0,10)})

-- Title bar for drag
local TitleBar = create("Frame", {
    Parent = MainFrame,
    Size = UDim2.new(1, 0, 0, 30),
    BackgroundColor3 = Color3.fromRGB(45, 45, 45),
})
create("UICorner", {Parent=TitleBar, CornerRadius=UDim.new(0,10)})

local TitleLabel = create("TextLabel", {
    Parent = TitleBar,
    Text = "Grow A Garden - Ultimate UI",
    Font = Enum.Font.GothamBold,
    TextSize = 18,
    TextColor3 = Color3.fromRGB(230,230,230),
    BackgroundTransparency = 1,
    Position = UDim2.new(0.02, 0, 0, 0),
    Size = UDim2.new(0.8, 0, 1, 0),
    TextXAlignment = Enum.TextXAlignment.Left,
})

-- Close/Minimize button
local CloseBtn = create("TextButton", {
    Parent = TitleBar,
    Text = "-",
    Font = Enum.Font.GothamBold,
    TextSize = 22,
    TextColor3 = Color3.fromRGB(230, 230, 230),
    BackgroundColor3 = Color3.fromRGB(65, 65, 65),
    Size = UDim2.new(0, 30, 1, 0),
    Position = UDim2.new(0.92, 0, 0, 0),
})
create("UICorner", {Parent=CloseBtn, CornerRadius=UDim.new(0,5)})

local minimized = false

CloseBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    for _, child in pairs(MainFrame:GetChildren()) do
        if child ~= TitleBar then
            child.Visible = not minimized
        end
    end
    CloseBtn.Text = minimized and "+" or "-"
    if minimized then
        MainFrame.Size = UDim2.new(0, 250, 0, 30)
    else
        MainFrame.Size = UDim2.new(0, 450, 0, 350)
    end
end)

-- Dragging system
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                  startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TitleBar.InputBegan:Connect(function(input)
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

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Tab buttons frame
local TabFrame = create("Frame", {
    Parent = MainFrame,
    Position = UDim2.new(0, 5, 0, 35),
    Size = UDim2.new(0, 440, 0, 30),
    BackgroundTransparency = 1,
})

local TabButtons = {}

local TabsContent = create("Frame", {
    Parent = MainFrame,
    Position = UDim2.new(0, 5, 0, 70),
    Size = UDim2.new(1, -10, 1, -75),
    BackgroundColor3 = Color3.fromRGB(40, 40, 40),
    BorderSizePixel = 0,
})
create("UICorner", {Parent=TabsContent, CornerRadius=UDim.new(0,8)})

-- Helper to create tab button
local function createTabButton(name, pos)
    local btn = create("TextButton", {
        Parent = TabFrame,
        Text = name,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = Color3.fromRGB(200, 200, 200),
        BackgroundColor3 = Color3.fromRGB(55, 55, 55),
        Position = UDim2.new(0, pos, 0, 0),
        Size = UDim2.new(0, 70, 1, 0),
    })
    create("UICorner", {Parent=btn, CornerRadius=UDim.new(0,5)})
    return btn
end

local currentTab = nil
local tabFrames = {}

-- Tab creation helper
local function createTab(name)
    local frame = create("Frame", {
        Parent = TabsContent,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Visible = false,
    })
    tabFrames[name] = frame
    return frame
end

local function selectTab(name)
    if currentTab then
        tabFrames[currentTab].Visible = false
        TabButtons[currentTab].BackgroundColor3 = Color3.fromRGB(55, 55, 55)
        TabButtons[currentTab].TextColor3 = Color3.fromRGB(200, 200, 200)
    end
    currentTab = name
    tabFrames[name].Visible = true
    TabButtons[name].BackgroundColor3 = Color3.fromRGB(100, 100, 255)
    TabButtons[name].TextColor3 = Color3.fromRGB(255, 255, 255)
end

-- Create tabs and buttons
local tabNames = {"Shop", "Pets", "Stats", "Plant", "Mutation", "Config"}
for i, name in ipairs(tabNames) do
    TabButtons[name] = createTabButton(name, (i-1)*75)
    local tabFrame = createTab(name)
    TabButtons[name].MouseButton1Click:Connect(function()
        selectTab(name)
    end)
end

selectTab("Shop")

-- ======= Contenus des onglets ======= --

-- SHOP TAB
local ShopTab = tabFrames["Shop"]
local shopTitle = create("TextLabel", {
    Parent = ShopTab,
    Text = "Acheter des Fruits",
    Font = Enum.Font.GothamBold,
    TextSize = 20,
    TextColor3 = Color3.fromRGB(220, 220, 220),
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 0, 10),
    Size = UDim2.new(1, -20, 0, 30),
})

-- Exemple de fruits à acheter
local fruits = {
    {name="Watermelon", price=50},
    {name="Strawberry", price=35},
    {name="Blueberry", price=40},
}

local function createFruitButton(fruit, y)
    local btn = create("TextButton", {
        Parent = ShopTab,
        Text = fruit.name .. " - $" .. fruit.price,
        Font = Enum.Font.Gotham,
        TextSize = 16,
        TextColor3 = Color3.fromRGB(255,255,255),
        BackgroundColor3 = Color3.fromRGB(70, 70, 70),
        Position = UDim2.new(0, 10, 0, y),
        Size = UDim2.new(0, 200, 0, 35),
    })
    create("UICorner", {Parent=btn, CornerRadius=UDim.new(0,5)})
    btn.MouseButton1Click:Connect(function()
        print("Acheter fruit:", fruit.name)
        -- TODO: Appeler fonction achat jeu ici
    end)
end

for i, fruit in ipairs(fruits) do
    createFruitButton(fruit, 50 + (i-1)*40)
end

-- PETS TAB
local PetsTab = tabFrames["Pets"]
local petsTitle = create("TextLabel", {
    Parent = PetsTab,
    Text = "Animaux et Œufs",
    Font = Enum.Font.GothamBold,
    TextSize = 20,
    TextColor3 = Color3.fromRGB(220, 220, 220),
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 0, 10),
    Size = UDim2.new(1, -20, 0, 30),
})

local pets = {
    {name="Bunny", chance=25, description="Un petit lapin adorable."},
    {name="Dragon", chance=5, description="Un dragon rare et puissant."},
    {name="Cat", chance=40, description="Un chat affectueux."},
}

local function createPetInfo(pet, y)
    local frame = create("Frame", {
        Parent = PetsTab,
        Position = UDim2.new(0, 10, 0, y),
        Size = UDim2.new(0, 400, 0, 70),
        BackgroundColor3 = Color3.fromRGB(60, 60, 60),
    })
    create("UICorner", {Parent=frame, CornerRadius=UDim.new(0,6)})

    local nameLabel = create("TextLabel", {
        Parent = frame,
        Text = pet.name .. " (".. pet.chance .."% chance)",
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        TextColor3 = Color3.fromRGB(240, 240, 240),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 5),
        Size = UDim2.new(1, -20, 0, 20),
    })

    local descLabel = create("TextLabel", {
        Parent = frame,
        Text = pet.description,
        Font = Enum.Font.Gotham,
        TextSize = 14,
        TextColor3 = Color3.fromRGB(200, 200, 200),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 30),
        Size = UDim2.new(1, -20, 0, 30),
        TextWrapped = true,
    })
end

for i, pet in ipairs(pets) do
    createPetInfo(pet, 50 + (i-1)*80)
end

-- STATS TAB
local StatsTab = tabFrames["Stats"]
local statsTitle = create("TextLabel", {
    Parent = StatsTab,
    Text = "Statistiques du Joueur",
    Font = Enum.Font.GothamBold,
    TextSize = 20,
    TextColor3 = Color3.fromRGB(220, 220, 220),
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 0, 10),
    Size = UDim2.new(1, -20, 0, 30),
})

local function updateStats()
    local plr = LocalPlayer
    -- Exemple fictif de stats
    local statsText = "Level: ".. (plr:FindFirstChild("leaderstats") and plr.leaderstats.Level.Value or "N/A") .. "\n" ..
                      "Fruits récoltés: 123\n" ..
                      "Plants actifs: 15\n"
    return statsText
end

local statsLabel = create("TextLabel", {
    Parent = StatsTab,
    Text = updateStats(),
    Font = Enum.Font.Gotham,
    TextSize = 16,
    TextColor3 = Color3.fromRGB(230,230,230),
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 0, 50),
    Size = UDim2.new(1, -20, 1, -60),
    TextWrapped = true,
    TextYAlignment = Enum.TextYAlignment.Top,
})

RunService.Heartbeat:Connect(function()
    statsLabel.Text = updateStats()
end)

-- PLANT TAB
local PlantTab = tabFrames["Plant"]
local plantTitle = create("TextLabel", {
    Parent = PlantTab,
    Text = "Contrôle des Plants",
    Font = Enum.Font.GothamBold,
    TextSize = 20,
    TextColor3 = Color3.fromRGB(220, 220, 220),
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 0, 10),
    Size = UDim2.new(1, -20, 0, 30),
})

local autoPlantToggle = create("TextButton", {
    Parent = PlantTab,
    Text = "Auto Plant: OFF",
    Font = Enum.Font.Gotham,
    TextSize = 16,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundColor3 = Color3.fromRGB(70, 70, 70),
    Position = UDim2.new(0, 10, 0, 50),
    Size = UDim2.new(0, 200, 0, 40),
})
create("UICorner", {Parent=autoPlantToggle, CornerRadius=UDim.new(0,6)})

local autoWaterToggle = create("TextButton", {
    Parent = PlantTab,
    Text = "Auto Water: OFF",
    Font = Enum.Font.Gotham,
    TextSize = 16,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundColor3 = Color3.fromRGB(70, 70, 70),
    Position = UDim2.new(0, 10, 0, 100),
    Size = UDim2.new(0, 200, 0, 40),
})
create("UICorner", {Parent=autoWaterToggle, CornerRadius=UDim.new(0,6)})

local autoHarvestToggle = create("TextButton", {
    Parent = PlantTab,
    Text = "Auto Harvest: OFF",
    Font = Enum.Font.Gotham,
    TextSize = 16,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundColor3 = Color3.fromRGB(70, 70, 70),
    Position = UDim2.new(0, 10, 0, 150),
    Size = UDim2.new(0, 200, 0, 40),
})
create("UICorner", {Parent=autoHarvestToggle, CornerRadius=UDim.new(0,6)})

local autoPlant = false
local autoWater = false
local autoHarvest = false

autoPlantToggle.MouseButton1Click:Connect(function()
    autoPlant = not autoPlant
    autoPlantToggle.Text = "Auto Plant: " .. (autoPlant and "ON" or "OFF")
end)

autoWaterToggle.MouseButton1Click:Connect(function()
    autoWater = not autoWater
    autoWaterToggle.Text = "Auto Water: " .. (autoWater and "ON" or "OFF")
end)

autoHarvestToggle.MouseButton1Click:Connect(function()
    autoHarvest = not autoHarvest
    autoHarvestToggle.Text = "Auto Harvest: " .. (autoHarvest and "ON" or "OFF")
end)

-- Simulate auto plant/water/harvest (pseudo-code)
RunService.Heartbeat:Connect(function()
    if autoPlant then
        -- TODO: call game function to plant all seeds
        -- print("Auto Planting...")
    end
    if autoWater then
        -- TODO: water all plants
        -- print("Auto Watering...")
    end
    if autoHarvest then
        -- TODO: harvest ready fruits
        -- print("Auto Harvesting...")
    end
end)

-- MUTATION TAB
local MutationTab = tabFrames["Mutation"]
local mutationTitle = create("TextLabel", {
    Parent = MutationTab,
    Text = "Menu Mutation",
    Font = Enum.Font.GothamBold,
    TextSize = 20,
    TextColor3 = Color3.fromRGB(220, 220, 220),
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 0, 10),
    Size = UDim2.new(1, -20, 0, 30),
})

local mutationButtonsData = {
    {name="Mutate All Fruits", action=function() print("Mutation: All Fruits") end},
    {name="Mutate Rare Fruits", action=function() print("Mutation: Rare Fruits") end},
    {name="Reset Mutations", action=function() print("Mutation: Reset") end},

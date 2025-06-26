-- Script Grow a Garden - UI JJSploit Compatible Version
-- Auteur : ChatGPT & [TON NOM]

-- ⚙️ Variables globales
local autoPlant = false
local autoWater = false
local autoHarvest = false
local autoMove = false
local selectedSeed = "Carrot"
local selectedMutation = "Moonlight"
local selectedShopFruit = "Mushroom"

-- 🧰 Fonctions de base
function toggleAutoPlant(state)
    autoPlant = state
    while autoPlant do
        game.ReplicatedStorage.PlantSeed:FireServer(selectedSeed)
        wait(2)
    end
end

function toggleAutoWater(state)
    autoWater = state
    while autoWater do
        game.ReplicatedStorage.WaterAll:FireServer()
        wait(3)
    end
end

function toggleAutoHarvest(state)
    autoHarvest = state
    while autoHarvest do
        game.ReplicatedStorage.HarvestAll:FireServer()
        wait(3)
    end
end

-- 📦 Shop
function buyFruit(fruitName)
    game.ReplicatedStorage.BuyItem:InvokeServer(fruitName, 0)
end

-- 🧬 Mutation forcée
function forceMutation(seed, target)
    game.ReplicatedStorage.ForceMutation:InvokeServer(seed, target)
end

-- 🧾 UI simple
local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "GrowAGardenGUI"

local mainFrame = Instance.new("Frame", ScreenGui)
mainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
mainFrame.Size = UDim2.new(0, 400, 0, 400)
mainFrame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
mainFrame.BorderSizePixel = 0

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Text = "🌱 Grow a Garden Premium"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 24

-- Exemple d’un toggle
local toggle = Instance.new("TextButton", mainFrame)
toggle.Position = UDim2.new(0, 10, 0, 60)
toggle.Size = UDim2.new(0, 200, 0, 30)
toggle.Text = "Auto Plant OFF"
toggle.MouseButton1Click:Connect(function()
    autoPlant = not autoPlant
    toggle.Text = autoPlant and "Auto Plant ON" or "Auto Plant OFF"
    toggleAutoPlant(autoPlant)
end)

-- + Ajouter le reste des boutons, dropdowns, etc.

-- Pour plus de simplicité, les menus déroulants sont à intégrer selon ton UI lib compatible JJSploit.
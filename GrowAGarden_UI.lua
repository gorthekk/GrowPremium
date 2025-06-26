-- Grow a Garden Premium - Script Fusionné (Fonctionnel + Stylisé UI)
-- Auteur : GPT + gorthekk | Compatible JJSploit / KRNL / Synapse

-- ✅ Chargement sécurisé
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local UIS = game:GetService("UserInputService")

-- ✅ Anti-double load
if getgenv().GrowAGardenLoaded then return end
getgenv().GrowAGardenLoaded = true

-- ✅ Interface principale
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "GrowAGardenUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Position = UDim2.new(0, 20, 0.2, 0)
Frame.Size = UDim2.new(0, 240, 0, 330)
Frame.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Frame.BorderSizePixel = 0
Frame.BackgroundTransparency = 0.1

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 12)

local UIListLayout = Instance.new("UIListLayout", Frame)
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- ✅ Bouton créateur
local function createButton(txt, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -20, 0, 35)
    Button.BackgroundColor3 = Color3.fromRGB(51, 51, 51)
    Button.Text = txt
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 14
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Parent = Frame

    local corner = Instance.new("UICorner", Button)
    corner.CornerRadius = UDim.new(0, 8)

    Button.MouseButton1Click:Connect(function()
        pcall(callback)
    end)
end

-- ✅ Fonctions simulées (à personnaliser selon les objets du jeu)
function AutoPlant()
    print("🌱 Auto Plant lancé")
end

function AutoWater()
    print("💧 Auto Water lancé")
end

function AutoHarvest()
    print("✂️ Auto Harvest lancé")
end

function BuyWatermelon()
    print("🍉 Achat de Watermelon effectué")
end

function ApplyMutation1()
    print("🧬 Mutation 1 appliquée")
end

-- ✅ Création des boutons
createButton("🌱 Activer Auto Plant", AutoPlant)
createButton("💧 Activer Auto Water", AutoWater)
createButton("✂️ Activer Auto Harvest", AutoHarvest)
createButton("🍉 Acheter Watermelon", BuyWatermelon)
createButton("🧬 Appliquer Mutation 1", ApplyMutation1)
createButton("❌ Fermer", function()
    ScreenGui:Destroy()
end)

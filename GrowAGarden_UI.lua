-- Grow a Garden Premium - Script fusionné complet

-- ====== Données (DataLists) ======
local Seeds = {
    "Watermelon Seed",
    "Strawberry Seed",
    "Coconut Seed",
    -- ajoute ici les autres seeds...
}
local Fruits = {
    "Watermelon",
    "Strawberry",
    "Coconut",
    -- ajoute ici les autres fruits...
}
local Mutations = {
    "Mutation1",
    "Mutation2",
    "Mutation3",
    -- ajoute ici les mutations disponibles...
}

-- ====== Fonctions ======
local function autoPlant()
    print("[Grow a Garden] Auto Plant activé")
    -- code pour planter automatiquement
end

local function autoWater()
    print("[Grow a Garden] Auto Water activé")
    -- code pour arroser automatiquement
end

local function autoHarvest()
    print("[Grow a Garden] Auto Harvest activé")
    -- code pour récolter automatiquement
end

local function buyFromShop(item)
    print("[Grow a Garden] Achat: "..item)
    -- code pour acheter un item
end

local function applyMutation(mutation)
    print("[Grow a Garden] Mutation appliquée: "..mutation)
    -- code pour appliquer mutation
end

-- ====== UI simple ======
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GrowAGardenPremiumUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 400)
Frame.Position = UDim2.new(0, 50, 0, 50)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Parent = ScreenGui

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Frame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

local function createButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.Parent = Frame
    btn.MouseButton1Click:Connect(callback)
    return btn
end

createButton("Activer Auto Plant", function() autoPlant() end)
createButton("Activer Auto Water", function() autoWater() end)
createButton("Activer Auto Harvest", function() autoHarvest() end)

createButton("Acheter Watermelon", function() buyFromShop("Watermelon") end)
createButton("Appliquer Mutation 1", function() applyMutation("Mutation1") end)

-- Tu peux rajouter ici d’autres boutons selon tes besoins

print("[Grow a Garden] Script fusionné chargé avec succès")

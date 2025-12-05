





--// Instinct ESP System
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Highlight settings
local highlightColor = Color3.fromRGB(0, 150, 255)
local highlightFillTransparency = 0.5
local outlineTransparency = 0.1

-- Billboard settings
local tagSize = UDim2.new(0, 100, 0, 20)

local function createHighlight(character)
    if character:FindFirstChild("InstinctHighlight") then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "InstinctHighlight"
    highlight.FillColor = highlightColor
    highlight.OutlineColor = highlightColor
    highlight.FillTransparency = highlightFillTransparency
    highlight.OutlineTransparency = outlineTransparency
    highlight.Parent = character
end

local function createNameTag(character, player)
    if character:FindFirstChild("Head") == nil then return end
    if character.Head:FindFirstChild("NameTag") then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "NameTag"
    billboard.Size = tagSize
    billboard.Adornee = character.Head
    billboard.AlwaysOnTop = true
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.Parent = character.Head

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1,0,1,0)
    text.BackgroundTransparency = 1
    text.Text = player.Name
    text.Font = Enum.Font.GothamBold
    text.TextColor3 = Color3.fromRGB(0, 150, 255)
    text.TextStrokeTransparency = 0.3
    text.TextScaled = true
    text.Parent = billboard
end

local function setupPlayer(player)
    if player == LocalPlayer then return end
    player.CharacterAdded:Connect(function(char)
        wait(1)
        createHighlight(char)
        createNameTag(char, player)
    end)

    if player.Character then
        createHighlight(player.Character)
        createNameTag(player.Character, player)
    end
end

-- Loop for existing + new players
for _, player in ipairs(Players:GetPlayers()) do
    setupPlayer(player)
end
Players.PlayerAdded:Connect(setupPlayer)

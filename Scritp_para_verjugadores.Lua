local LocalPlayer = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")

local Cheats = {
    b_b = false;
    b_f = false;
    b_f_t = 1;
    b_sd = true; -- Cambiado a true para mostrar la distancia a cada jugador en lugar de la barra de salud
    b_sn = false;
    b_sh = false;
    b_ht = "Text";
    b_rt = false;
    b_tc = false;
}

local CheatsFolder = Instance.new("Folder", game.CoreGui)
CheatsFolder.Name = "Cheats"
local ESPFolder = Instance.new("Folder", CheatsFolder)
ESPFolder.Name = "ESP"

function AddESP(player)
    local BillboardGui = Instance.new("BillboardGui", ESPFolder)
    BillboardGui.Name = player.Name
    BillboardGui.AlwaysOnTop = true
    BillboardGui.Size = UDim2.new(4, 0, 5.4, 0)
    BillboardGui.StudsOffset = Vector3.new(0, 3, 0) -- Levanta el BillboardGui para que sea visible desde lejos
    BillboardGui.ClipsDescendants = false
    
    local NameLabel = Instance.new("TextLabel", BillboardGui)
    NameLabel.Name = "NameLabel"
    NameLabel.BackgroundTransparency = 1
    NameLabel.TextStrokeTransparency = 0
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Size = UDim2.new(1, 0, 0, 18)
    NameLabel.Position = UDim2.new(0, 0, 0, 0)
    NameLabel.TextColor3 = Color3.fromRGB(173, 216, 230) -- Color azul claro
    NameLabel.TextSize = 14 -- Tamaño de texto inicial
    
    local DistanceLabel = Instance.new("TextLabel", BillboardGui)
    DistanceLabel.Name = "DistanceLabel"
    DistanceLabel.BackgroundTransparency = 1
    DistanceLabel.TextStrokeTransparency = 0
    DistanceLabel.TextXAlignment = Enum.TextXAlignment.Left
    DistanceLabel.Size = UDim2.new(1, 0, 0, 18)
    DistanceLabel.Position = UDim2.new(0, 0, 0, 18)
    DistanceLabel.TextColor3 = Color3.fromRGB(255, 0, 0) -- Color rojo fosforescente
    DistanceLabel.TextSize = 14 -- Tamaño de texto más grande
    
    local StrengthLabel = Instance.new("TextLabel", BillboardGui)
    StrengthLabel.Name = "StrengthLabel"
    StrengthLabel.BackgroundTransparency = 1
    StrengthLabel.TextStrokeTransparency = 0
    StrengthLabel.TextXAlignment = Enum.TextXAlignment.Left
    StrengthLabel.Size = UDim2.new(1, 0, 0, 18)
    StrengthLabel.Position = UDim2.new(0, 0, 0, 36)
    StrengthLabel.TextColor3 = Color3.fromRGB(255, 0, 0) -- Color rojo fosforescente
    StrengthLabel.TextSize = 14 -- Tamaño de texto más grande
    
    local RebirthLabel = Instance.new("TextLabel", BillboardGui)
    RebirthLabel.Name = "RebirthLabel"
    RebirthLabel.BackgroundTransparency = 1
    RebirthLabel.TextStrokeTransparency = 0
    RebirthLabel.TextXAlignment = Enum.TextXAlignment.Left
    RebirthLabel.Size = UDim2.new(1, 0, 0, 18)
    RebirthLabel.Position = UDim2.new(0, 0, 0, 54)
    RebirthLabel.TextColor3 = Color3.fromRGB(255, 0, 0) -- Color rojo fosforescente
    RebirthLabel.TextSize = 14 -- Tamaño de texto más grande
    
    local coroutineFunction = coroutine.create(function()
        while wait(0.1) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                BillboardGui.Adornee = player.Character.HumanoidRootPart
                if player.Team ~= LocalPlayer.Team then
                    BillboardGui.Enabled = true
                end
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude
                    DistanceLabel.Text = "Distance: " .. math.floor(distance)
                    UpdateNameLabelSize(NameLabel, distance) -- Actualizar tamaño de texto del nombre
                end
            end
            
            NameLabel.Text = player.Name
            
            local StatsFolder = player.Character:FindFirstChild("Stats")
            if StatsFolder then
                local Strength = StatsFolder:FindFirstChild("Strength")
                if Strength then
                    local StrengthValue = FormatLargeNumber(Strength.Value) -- Formatear número de fuerza
                    StrengthLabel.Text = "Strength: " .. tostring(StrengthValue)
                end
                
                local Rebirth = StatsFolder:FindFirstChild("Rebirth")
                if Rebirth then
                    local RebirthValue = Rebirth.Value
                    RebirthLabel.Text = "Rebirth: " .. tostring(RebirthValue)
                end
            end
            
            if not game:GetService("Players"):FindFirstChild(player.Name) then
                print(player.Name.." has left. Clearing ESP.")
                ESPFolder:FindFirstChild(player.Name):Destroy()
                coroutine.yield()
            end
        end
    end)
    coroutine.resume(coroutineFunction)
end

function UpdateNameLabelSize(NameLabel, distance)
    -- Ajustar el tamaño del texto del nombre basado en la distancia
    local scaleFactor = 1 / distance -- Escalar inversamente con la distancia
    local maxSize = 28 -- Tamaño máximo
    local minSize = 14 -- Tamaño mínimo
    
    local newSize = math.clamp(maxSize * scaleFactor, minSize, maxSize) -- Limitar el tamaño dentro del rango
    
    NameLabel.TextSize = newSize -- Actualizar el tamaño del texto del nombre
end

function FormatLargeNumber(number)
    local suffixes = {"", "K", "M", "B", "T"}
    local suffixIndex = 1
    while number >= 1000 do
        number = number / 1000
        suffixIndex = suffixIndex + 1
    end
    return string.format("%.1f%s", number, suffixes[suffixIndex])
end

-- Main
do
    wait(2)
    -- Agregar ESP para jugadores existentes
    for _, player in pairs(game:GetService("Players"):GetChildren()) do
        if player.Name ~= LocalPlayer.Name then
            if not ESPFolder:FindFirstChild(player.Name) then
                AddESP(player)
            end
        end
    end
    
    -- Detectar clic para abrir/cerrar el menú
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if input.KeyCode == Enum.KeyCode.KeypadOne then
            if not gameProcessed then
                -- Cambiar la visibilidad del menú cuando se presiona la tecla KeypadOne
                CheatsFolder.Enabled = not CheatsFolder.Enabled
            end
        end
    end)
    
    -- Actualizar automáticamente cada 10 segundos para agregar ESP a nuevos jugadores
    while wait(10) do
        for _, player in pairs(game:GetService("Players"):GetChildren()) do
            if player.Name ~= LocalPlayer.Name then
                if not ESPFolder:FindFirstChild(player.Name) then
                    AddESP(player)
                end
            end
        end
    end
end


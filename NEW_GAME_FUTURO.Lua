local function executeFirstCodeInfinitely()
    while true do
        game:GetService("ReplicatedStorage"):WaitForChild("Package"):WaitForChild("Events"):WaitForChild("NewGame"):InvokeServer()
        wait(0.001) -- Espera un segundo antes de ejecutar nuevamente
    end
end

local function executeSecondCodeInfinitely()
    while true do
        if game.PlaceId == 3345669323 then
            local args = {
                [1] = {
                    ["Hair"] = "Hair1",
                    ["Outfit"] = "Outfit1",
                    ["Skin Color"] = "5",
                    ["Energy Color"] = "92",
                    ["Hair Color"] = "93",
                    ["Face"] = "Face1",
                    ["Eye Color"] = "92",
                    ["Allignment"] = "Good"
                }
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("bruh"):InvokeServer(unpack(args))
        end
        wait(0.001) -- Espera un segundo antes de verificar nuevamente
    end
end

-- Iniciar ejecución infinita del primer código
spawn(executeFirstCodeInfinitely)

-- Iniciar ejecución infinita del segundo código
spawn(executeSecondCodeInfinitely)

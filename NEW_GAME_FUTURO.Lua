while true do
       local args = {
            [1] = {
                ["Hair"] = "Hair1",
                ["Outfit"] = "Outfit1",
                ["Skin Color"] = "5",
                ["Ergy Color"] = "92",
                ["Hair Color"] = "93",
                ["Face"] = "Face1",
                ["Eye Color"] = "92",
                ["Allignment"] = "Good"
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("bruh"):InvokeServer(unpack(args))
   end

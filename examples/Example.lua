-- Example usage
-- Letakkan sebagai LocalScript di StarterPlayerScripts
-- dan letakkan ModuleScript "UILibrary" di lokasi yang sesuai.

local UILibrary = require(script.Parent:WaitForChild("UILibrary"))

local Window = UILibrary:CreateWindow({
    Title = "My Game",
    Subtitle = "Testing UI",
    Size = UDim2.fromOffset(650, 450)
})

local PlayerTab = Window:CreateTab({
    Name = "Player"
})

local PlayerSection = PlayerTab:CreateSection("Player Testing")

PlayerSection:CreateButton({
    Name = "Test Button",
    Callback = function()
        print("Button clicked")
    end
})

PlayerSection:CreateToggle({
    Name = "Test Toggle",
    Default = false,
    Callback = function(enabled)
        print("Toggle:", enabled)
    end
})

PlayerSection:CreateSlider({
    Name = "WalkSpeed Test",
    Min = 0,
    Max = 100,
    Default = 16,
    Callback = function(value)
        print("Slider value:", value)
    end
})

PlayerSection:CreateDropdown({
    Name = "Select Mode",
    Values = {"Normal", "Test", "Debug"},
    Default = "Normal",
    Callback = function(value)
        print("Selected:", value)
    end
})

PlayerSection:CreateInput({
    Name = "Input",
    Placeholder = "Masukkan text...",
    Callback = function(text, enterPressed)
        print("Input:", text)
    end
})

Window:Notify({
    Title = "Apez UI",
    Content = "UI berhasil dijalankan.",
    Duration = 3
})

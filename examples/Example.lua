--[[
    LIB-PHILANX
    Example Script
    Version: 1.3.0

    Contoh penggunaan seluruh komponen utama
    yang tersedia pada LIB-PHILANX v1.3.0.
]]

-- ==================================================
-- LOAD LIBRARY
-- ==================================================

local UILibrary = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/apezts/LIB-PHILANX/main/src/UILibrary.lua"
))()

-- ==================================================
-- WINDOW
-- ==================================================

local Window = UILibrary:CreateWindow({
    Title = "LIB-PHILANX",
    Subtitle = "Example v1.3.0",
    Size = UDim2.fromOffset(650, 450)
})

-- ==================================================
-- PLAYER TAB
-- ==================================================

local PlayerTab = Window:CreateTab({
    Name = "Player",
    Icon = "👤"
})

local PlayerSection = PlayerTab:CreateSection("Player Settings")

PlayerSection:CreateLabel(
    "Contoh komponen LIB-PHILANX v1.3.0"
)

PlayerSection:CreateParagraph({
    Title = "Informasi",
    Content = "Ini adalah contoh penggunaan Paragraph."
})

PlayerSection:CreateDivider()

PlayerSection:CreateStatusBox({
    Type = "info",
    Title = "Info",
    Content = "Semua komponen sedang diuji."
})

PlayerSection:CreateButton({
    Name = "Test Button",

    Callback = function()
        print("LIB-PHILANX: Button clicked")

        Window:Notify({
            Title = "Button",
            Content = "Test Button berhasil ditekan.",
            Duration = 3
        })
    end
})

local Toggle = PlayerSection:CreateToggle({
    Name = "Test Toggle",
    Default = false,

    Callback = function(value)
        print("LIB-PHILANX: Toggle =", value)

        Window:Notify({
            Title = "Toggle",
            Content = "Status: " .. tostring(value),
            Duration = 2
        })
    end
})

local Slider = PlayerSection:CreateSlider({
    Name = "Test Slider",
    Min = 0,
    Max = 100,
    Default = 50,

    Callback = function(value)
        print("LIB-PHILANX: Slider =", value)
    end
})

local Dropdown = PlayerSection:CreateDropdown({
    Name = "Test Dropdown",

    Values = {
        "Normal",
        "Testing",
        "Debug"
    },

    Default = "Normal",

    Callback = function(value)
        print("LIB-PHILANX: Dropdown =", value)

        Window:Notify({
            Title = "Dropdown",
            Content = "Pilihan: " .. tostring(value),
            Duration = 2
        })
    end
})

PlayerSection:CreateInput({
    Placeholder = "Masukkan teks...",

    Callback = function(text, enterPressed)
        print("LIB-PHILANX: Input =", text)
        print("LIB-PHILANX: Enter =", enterPressed)
    end
})

-- ==================================================
-- SETTINGS TAB
-- ==================================================

local SettingsTab = Window:CreateTab({
    Name = "Settings",
    Icon = "⚙"
})

local SettingsSection = SettingsTab:CreateSection("Window Settings")

SettingsSection:CreateStatusBox({
    Type = "success",
    Title = "Library Loaded",
    Content = "LIB-PHILANX berhasil dimuat dari GitHub."
})

SettingsSection:CreateButton({
    Name = "Ubah Title",

    Callback = function()
        Window:SetTitle("LIB-PHILANX - Updated")

        Window:Notify({
            Title = "Window",
            Content = "Title berhasil diubah.",
            Duration = 2
        })
    end
})

SettingsSection:CreateButton({
    Name = "Ubah Subtitle",

    Callback = function()
        Window:SetSubtitle("Subtitle berhasil diubah")

        Window:Notify({
            Title = "Window",
            Content = "Subtitle berhasil diubah.",
            Duration = 2
        })
    end
})

SettingsSection:CreateButton({
    Name = "Toggle Visibility",

    Callback = function()
        Window:Toggle()
    end
})

SettingsSection:CreateButton({
    Name = "Cek Visibility",

    Callback = function()
        print("LIB-PHILANX: Visible =", Window:IsVisible())
    end
})

-- ==================================================
-- NOTIFICATION TEST
-- ==================================================

Window:Notify({
    Title = "LIB-PHILANX",
    Content = "Example v1.3.0 berhasil dimuat.",
    Duration = 4
})

Window:Notify({
    Title = "Notification Stack",
    Content = "Notification kedua untuk pengujian stack.",
    Duration = 5
})

-- ==================================================
-- STATUS BOX TEST
-- ==================================================

local StatusTab = Window:CreateTab({
    Name = "Status",
    Icon = "✓"
})

local StatusSection = StatusTab:CreateSection("Status Box")

StatusSection:CreateStatusBox({
    Type = "info",
    Title = "Information",
    Content = "Contoh status informasi."
})

StatusSection:CreateStatusBox({
    Type = "success",
    Title = "Success",
    Content = "Contoh status berhasil."
})

StatusSection:CreateStatusBox({
    Type = "warning",
    Title = "Warning",
    Content = "Contoh status peringatan."
})

StatusSection:CreateStatusBox({
    Type = "error",
    Title = "Error",
    Content = "Contoh status error."
})

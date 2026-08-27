# LIB-PHILANX API Documentation

Complete API reference for LIB-PHILANX UI Library.

---

## Getting Started

Load the library first:

```lua
local UILibrary = loadstring(game:HttpGet(
    "YOUR_GITHUB_RAW_URL"
))()
```

Create a window:

```lua
local Window = UILibrary:CreateWindow({
    Title = "LIB-PHILANX",
    Subtitle = "My Script"
})
```

---

# Window

## CreateWindow

Creates the main LIB-PHILANX window.

### Syntax

```lua
UILibrary:CreateWindow(options)
```

### Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `Title` | string | No | Window title |
| `Subtitle` | string | No | Window subtitle |
| `Logo` | string/number | No | Window logo asset |
| `Size` | UDim2 | No | Window size |

### Example

```lua
local Window = UILibrary:CreateWindow({
    Title = "My Script",
    Subtitle = "LIB-PHILANX",
    Logo = 132859114380485,
    Size = UDim2.fromOffset(650, 450)
})
```

---

## Window:SetTitle()

Changes the window title.

### Syntax

```lua
Window:SetTitle("New Title")
```

### Example

```lua
Window:SetTitle("My New Script")
```

---

## Window:SetSubtitle()

Changes the window subtitle.

### Syntax

```lua
Window:SetSubtitle("New Subtitle")
```

### Example

```lua
Window:SetSubtitle("Updated successfully")
```

---

## Window:SetLogo()

Changes the window logo.

The logo is updated on both the expanded window and the floating pill.

### Syntax

```lua
Window:SetLogo(assetId)
```

### Example

```lua
Window:SetLogo(132859114380485)
```

You can also provide an asset string:

```lua
Window:SetLogo("rbxassetid://132859114380485")
```

---

## Window:GetLogo()

Returns the current logo asset.

### Syntax

```lua
local Logo = Window:GetLogo()
```

### Example

```lua
print(Window:GetLogo())
```

---

# Tabs

## Window:CreateTab()

Creates a new tab.

### Syntax

```lua
local Tab = Window:CreateTab({
    Name = "Player",
    Icon = "..."
})
```

### Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `Name` | string | No | Tab name |
| `Icon` | string | No | Tab icon |

### Example

```lua
local PlayerTab = Window:CreateTab({
    Name = "Player"
})
```

---

# Sections

## Tab:CreateSection()

Creates a section inside a tab.

### Syntax

```lua
local Section = Tab:CreateSection("Player Settings")
```

### Example

```lua
local Section = PlayerTab:CreateSection("Movement")
```

---

# Components

All components are created through a section.

```lua
Section:CreateLabel(...)
Section:CreateParagraph(...)
Section:CreateDivider(...)
Section:CreateStatusBox(...)
Section:CreateButton(...)
Section:CreateToggle(...)
Section:CreateInput(...)
Section:CreateDropdown(...)
Section:CreateKeybind(...)
Section:CreateSlider(...)
```

---

# Label

## Section:CreateLabel()

Creates a simple text label.

### Syntax

```lua
local Label = Section:CreateLabel("Hello World")
```

### Example

```lua
Section:CreateLabel("Welcome to LIB-PHILANX")
```

---

# Paragraph

## Section:CreateParagraph()

Creates a paragraph/information block.

### Syntax

```lua
local Paragraph = Section:CreateParagraph({
    Title = "Information",
    Content = "This is an information message."
})
```

### Example

```lua
Section:CreateParagraph({
    Title = "About",
    Content = "This script uses LIB-PHILANX."
})
```

---

# Divider

## Section:CreateDivider()

Creates a visual divider between components.

### Syntax

```lua
Section:CreateDivider()
```

### Example

```lua
Section:CreateButton({
    Name = "Button"
})

Section:CreateDivider()

Section:CreateToggle({
    Name = "Toggle"
})
```

---

# StatusBox

## Section:CreateStatusBox()

Creates a status/information box.

### Syntax

```lua
local Status = Section:CreateStatusBox({
    Title = "Status",
    Content = "Ready"
})
```

---

# Button

## Section:CreateButton()

Creates a clickable button.

### Syntax

```lua
local Button = Section:CreateButton({
    Name = "Test",

    Callback = function()
        print("Button clicked")
    end
})
```

### API

```lua
Button:SetTitle("New Title")
Button:GetTitle()
Button:SetVisible(true)
Button:IsVisible()
```

### Example

```lua
local Button = Section:CreateButton({
    Name = "Execute",
    Callback = function()
        print("Executed")
    end
})

Button:SetTitle("Run Script")
```

---

# Toggle

## Section:CreateToggle()

Creates an on/off toggle.

### Syntax

```lua
local Toggle = Section:CreateToggle({
    Name = "Auto Farm",
    Default = false,

    Callback = function(value)
        print("Enabled:", value)
    end
})
```

### API

```lua
Toggle:Set(true)
Toggle:Get()
Toggle:SetTitle("Auto Farm")
Toggle:SetVisible(true)
```

### Example

```lua
local Toggle = Section:CreateToggle({
    Name = "Auto Farm",
    Default = false,

    Callback = function(enabled)
        print("Auto Farm:", enabled)
    end
})

Toggle:Set(true)
```

---

# Input

## Section:CreateInput()

Creates a text input.

### Syntax

```lua
local Input = Section:CreateInput({
    Name = "Username",

    Callback = function(value)
        print("Input:", value)
    end
})
```

### API

```lua
Input:SetValue("Player123")
Input:GetValue()
Input:Clear()
Input:SetVisible(true)
```

### Example

```lua
local Input = Section:CreateInput({
    Name = "Username"
})

Input:SetValue("Player123")

print(Input:GetValue())

Input:Clear()
```

---

# Dropdown

## Section:CreateDropdown()

Creates a dropdown selection.

### Syntax

```lua
local Dropdown = Section:CreateDropdown({
    Name = "Select Mode",

    Values = {
        "Easy",
        "Normal",
        "Hard"
    },

    Default = "Easy",

    Callback = function(value)
        print("Selected:", value)
    end
})
```

### API

```lua
Dropdown:SetValue("Hard")
Dropdown:GetValue()
Dropdown:SetVisible(true)
```

### Example

```lua
local Dropdown = Section:CreateDropdown({
    Name = "Difficulty",

    Values = {
        "Easy",
        "Normal",
        "Hard"
    },

    Default = "Normal"
})

Dropdown:SetValue("Hard")

print(Dropdown:GetValue())
```

---

# Keybind

## Section:CreateKeybind()

Creates a keybind component.

### Syntax

```lua
local Keybind = Section:CreateKeybind({
    Name = "Toggle UI",
    Default = Enum.KeyCode.RightShift,

    Callback = function()
        print("Keybind pressed")
    end
})
```

### Example

```lua
Section:CreateKeybind({
    Name = "Test Key",
    Default = Enum.KeyCode.F,

    Callback = function()
        print("F pressed")
    end
})
```

---

# Slider

## Section:CreateSlider()

Creates a numeric slider.

### Syntax

```lua
local Slider = Section:CreateSlider({
    Name = "WalkSpeed",
    Min = 0,
    Max = 100,
    Default = 16,

    Callback = function(value)
        print("Value:", value)
    end
})
```

### API

```lua
Slider:SetValue(50)
Slider:GetValue()
Slider:SetVisible(true)
```

### Example

```lua
local Slider = Section:CreateSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 100,
    Default = 16,

    Callback = function(value)
        print("WalkSpeed:", value)
    end
})

Slider:SetValue(50)

print(Slider:GetValue())
```

---

# Complete Example

```lua
local UILibrary = loadstring(game:HttpGet(
    "YOUR_GITHUB_RAW_URL"
))()

local Window = UILibrary:CreateWindow({
    Title = "LIB-PHILANX",
    Subtitle = "Example Script",
    Logo = 132859114380485
})

local PlayerTab = Window:CreateTab({
    Name = "Player"
})

local Movement = PlayerTab:CreateSection("Movement")

Movement:CreateLabel("Player Controls")

Movement:CreateParagraph({
    Title = "Information",
    Content = "Configure your player settings here."
})

local Speed = Movement:CreateSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 100,
    Default = 16,

    Callback = function(value)
        print("Speed:", value)
    end
})

local AutoFarm = Movement:CreateToggle({
    Name = "Auto Farm",
    Default = false,

    Callback = function(enabled)
        print("Auto Farm:", enabled)
    end
})

local Mode = Movement:CreateDropdown({
    Name = "Mode",

    Values = {
        "Easy",
        "Normal",
        "Hard"
    },

    Default = "Normal",

    Callback = function(value)
        print("Mode:", value)
    end
})

local TestButton = Movement:CreateButton({
    Name = "Test",

    Callback = function()
        print("Test clicked")
    end
})

Speed:SetValue(25)
AutoFarm:Set(false)
Mode:SetValue("Hard")
TestButton:SetTitle("Execute")
```

---

# Component API Pattern

LIB-PHILANX uses a component-object pattern.

When creating a component:

```lua
local Component = Section:CreateButton({
    Name = "Test"
})
```

the returned object can be used to control that component later.

For example:

```lua
Component:SetVisible(false)
```

This allows scripts to modify the UI at runtime without recreating the component.

---

# Visibility Control

Components that expose `SetVisible()` can be shown or hidden dynamically.

```lua
Button:SetVisible(false)
```

Show it again:

```lua
Button:SetVisible(true)
```

Check visibility:

```lua
local visible = Button:IsVisible()
```

---

# Runtime Updates

Component values can be modified after creation.

Example:

```lua
local Toggle = Section:CreateToggle({
    Name = "Auto Farm",
    Default = false
})

Toggle:Set(true)

print(Toggle:Get())
```

This makes it possible to build dynamic interfaces where one component controls another.

---

# Notes

- `Logo` can be provided as a numeric asset ID or an `rbxassetid://` string where supported.
- Callback functions are used to react to component interaction.
- Component API methods are intended for runtime UI manipulation.
- Keep references to components if you need to modify them later.
- Replace `YOUR_GITHUB_RAW_URL` with the actual raw URL of the LIB-PHILANX library.

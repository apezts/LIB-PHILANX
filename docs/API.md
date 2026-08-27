# LIB-PHILANX UI Library

A lightweight and customizable Roblox UI Library.

> Current version: **1.3.0**

## Overview

LIB-PHILANX is a custom UI library designed with a simple API and reusable UI components.

The library currently supports:

- Window
- Tabs
- Tab Icons
- Sections
- Buttons
- Toggles
- Sliders
- Dropdowns
- Text Input
- Labels
- Paragraphs
- Dividers
- Status Boxes
- Notifications
- Notification Stack
- Window visibility controls
- Window title/subtitle controls

Global Keybind is intentionally not included.

---

# Installation

The main library is located at:

`src/UILibrary.lua`

For executor-based testing, the library can be loaded from the raw GitHub file using a loader.

The loader should point to:

`src/UILibrary.lua`

---

# Basic Usage

The general API structure is:

```lua
local UILibrary = ...

local Window = UILibrary:CreateWindow({
    Title = "LIB-PHILANX",
    Subtitle = "My UI"
})

local Tab = Window:CreateTab({
    Name = "Player"
})

local Section = Tab:CreateSection("Testing")
```

Components are then created inside a Section.

---

# Window

## CreateWindow

Creates the main UI window.

```lua
local Window = UILibrary:CreateWindow({
    Title = "LIB-PHILANX",
    Subtitle = "My UI",
    Size = UDim2.fromOffset(650, 450)
})
```

### Parameters

| Parameter | Type | Description |
|---|---|---|
| Title | string | Window title |
| Subtitle | string | Window subtitle |
| Size | UDim2 | Window size |

---

# Tabs

## CreateTab

Creates a tab inside the window.

```lua
local Tab = Window:CreateTab({
    Name = "Player"
})
```

### Tab Icon

```lua
local Tab = Window:CreateTab({
    Name = "Player",
    Icon = "👤"
})
```

`Icon` is optional.

---

# Sections

## CreateSection

Creates a section inside a tab.

```lua
local Section = Tab:CreateSection("Player Settings")
```

Components can be placed inside the section.

---

# Components

## Button

```lua
Section:CreateButton({
    Name = "Test Button",

    Callback = function()
        print("Button clicked")
    end
})
```

### Parameters

| Parameter | Type | Description |
|---|---|---|
| Name | string | Button text |
| Callback | function | Function called when clicked |

---

## Toggle

```lua
local Toggle = Section:CreateToggle({
    Name = "Test Toggle",
    Default = false,

    Callback = function(value)
        print("Toggle:", value)
    end
})
```

### API

```lua
Toggle:Set(true)
Toggle:Set(false)

local value = Toggle:Get()
```

---

## Slider

```lua
local Slider = Section:CreateSlider({
    Name = "WalkSpeed",
    Min = 0,
    Max = 100,
    Default = 16,

    Callback = function(value)
        print("Slider:", value)
    end
})
```

### API

```lua
Slider:Set(50)

local value = Slider:Get()
```

---

## Dropdown

```lua
local Dropdown = Section:CreateDropdown({
    Name = "Mode",

    Values = {
        "Normal",
        "Testing",
        "Debug"
    },

    Default = "Normal",

    Callback = function(value)
        print("Selected:", value)
    end
})
```

### API

```lua
Dropdown:Set("Debug")

local value = Dropdown:Get()
```

---

## Input

```lua
Section:CreateInput({
    Placeholder = "Enter text...",

    Callback = function(text, enterPressed)
        print(text)
        print(enterPressed)
    end
})
```

---

# Label

Creates simple text.

```lua
Section:CreateLabel("This is a label.")
```

---

# Paragraph

Creates an information box.

```lua
local Paragraph = Section:CreateParagraph({
    Title = "Information",
    Content = "This is an example paragraph."
})
```

### API

```lua
Paragraph:SetTitle("New Title")
Paragraph:SetContent("New content")

Paragraph:Set("New content")
```

---

# Divider

Creates a horizontal divider.

```lua
Section:CreateDivider()
```

---

# Status Box

Creates an information box with a status type.

Supported types:

- `info`
- `success`
- `warning`
- `error`

Example:

```lua
local Status = Section:CreateStatusBox({
    Type = "success",
    Title = "Success",
    Content = "Operation completed."
})
```

### API

```lua
Status:SetTitle("New Title")
Status:SetContent("New content")
Status:SetType("warning")
```

---

# Notifications

Creates a notification.

```lua
Window:Notify({
    Title = "Success",
    Content = "Operation completed.",
    Duration = 3
})
```

Multiple notifications can be displayed at the same time.

### Custom notification color

```lua
Window:Notify({
    Title = "Warning",
    Content = "Be careful.",
    Duration = 3,
    Color = Color3.fromRGB(255, 190, 70)
})
```

---

# Window Controls

## SetVisible

Shows or hides the entire UI.

```lua
Window:SetVisible(true)
Window:SetVisible(false)
```

## Toggle

Toggles the UI visibility.

```lua
Window:Toggle()
```

## IsVisible

Returns the current visibility state.

```lua
local visible = Window:IsVisible()
print(visible)
```

## Destroy

Removes the UI.

```lua
Window:Destroy()
```

---

# Window Title

Change the title after the window has been created.

```lua
Window:SetTitle("New Title")
```

Get the current title:

```lua
local title = Window:GetTitle()
```

---

# Window Subtitle

Change the subtitle:

```lua
Window:SetSubtitle("New Subtitle")
```

Get the current subtitle:

```lua
local subtitle = Window:GetSubtitle()
```

---

# Versioning

LIB-PHILANX follows version numbers in the format:

`MAJOR.MINOR.PATCH`

Example:

- `1.0.0` — Initial library
- `1.1.0` — Keybind and window controls
- `1.2.0` — Notification improvements and tab icons
- `1.3.0` — Additional UI components and window title APIs

Future releases should preserve existing APIs whenever possible.

---

# Roadmap

Planned improvements may include:

- Better responsive layout
- More UI components
- Improved theme system
- Runtime theme changes
- Better cleanup management
- More documentation
- Performance improvements
- Accessibility improvements

Features that are not needed will not be added just for the sake of increasing the version number.

---

# License

License information will be added separately when the project license is finalized.

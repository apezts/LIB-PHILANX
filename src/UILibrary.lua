-- Apez UI Library
-- Version: 1.2.0
-- Original Roblox UI Library
-- For Roblox Studio / testing your own game

local UILibrary = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer

local Theme = {
    Background = Color3.fromRGB(20, 20, 24),
    Secondary = Color3.fromRGB(27, 27, 32),
    Tertiary = Color3.fromRGB(35, 35, 42),
    Accent = Color3.fromRGB(95, 140, 255),
    Text = Color3.fromRGB(245, 245, 245),
    SubText = Color3.fromRGB(165, 165, 175),
    Border = Color3.fromRGB(50, 50, 58),
    Success = Color3.fromRGB(80, 200, 120),
    Warning = Color3.fromRGB(255, 190, 70),
    Error = Color3.fromRGB(240, 80, 80)
}

local function New(class, props)
    local obj = Instance.new(class)
    for property, value in pairs(props or {}) do
        obj[property] = value
    end
    return obj
end

local function Corner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 6)
    c.Parent = obj
    return c
end

local function Stroke(obj, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color or Theme.Border
    s.Thickness = thickness or 1
    s.Parent = obj
    return s
end

local function Padding(obj, l, r, t, b)
    local p = Instance.new("UIPadding")
    p.PaddingLeft = UDim.new(0, l or 0)
    p.PaddingRight = UDim.new(0, r or 0)
    p.PaddingTop = UDim.new(0, t or 0)
    p.PaddingBottom = UDim.new(0, b or 0)
    p.Parent = obj
    return p
end

local function Tween(obj, props, duration)
    local t = TweenService:Create(
        obj,
        TweenInfo.new(duration or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        props
    )
    t:Play()
    return t
end

local function MakeDraggable(frame, handle)
    local dragging = false
    local dragStart
    local startPosition

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            dragStart = input.Position
            startPosition = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end

        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then

            local delta = input.Position - dragStart

            frame.Position = UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,
                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )
        end
    end)
end

function UILibrary:SetTheme(theme)
    for key, value in pairs(theme or {}) do
        if Theme[key] ~= nil then
            Theme[key] = value
        end
    end
end

function UILibrary:CreateWindow(options)
    options = options or {}

    local title = options.Title or "Apez UI"
    local subtitle = options.Subtitle or "UI Library"
    local size = options.Size or UDim2.fromOffset(650, 450)

    local ScreenGui = New("ScreenGui", {
        Name = "ApezUI",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })

    ScreenGui.Parent = Player:WaitForChild("PlayerGui")

    local Main = New("Frame", {
        Name = "Main",
        Parent = ScreenGui,
        Size = size,
        Position = UDim2.new(
            0.5,
            -size.X.Offset / 2,
            0.5,
            -size.Y.Offset / 2
        ),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0
    })

    Corner(Main, 10)
    Stroke(Main)

    local TopBar = New("Frame", {
        Name = "TopBar",
        Parent = Main,
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0
    })

    Corner(TopBar, 10)

    New("Frame", {
        Parent = TopBar,
        Position = UDim2.new(0, 0, 1, -15),
        Size = UDim2.new(1, 0, 0, 15),
        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0
    })

    New("TextLabel", {
        Parent = TopBar,
        Position = UDim2.fromOffset(18, 8),
        Size = UDim2.new(1, -120, 0, 25),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 17,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    New("TextLabel", {
        Parent = TopBar,
        Position = UDim2.fromOffset(19, 34),
        Size = UDim2.new(1, -120, 0, 18),
        BackgroundTransparency = 1,
        Text = subtitle,
        TextColor3 = Theme.SubText,
        Font = Enum.Font.Gotham,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local Minimize = New("TextButton", {
        Parent = TopBar,
        Position = UDim2.new(1, -75, 0, 17),
        Size = UDim2.fromOffset(25, 25),
        BackgroundColor3 = Theme.Tertiary,
        BorderSizePixel = 0,
        Text = "−",
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        AutoButtonColor = false
    })
    Corner(Minimize, 6)

    local Close = New("TextButton", {
        Parent = TopBar,
        Position = UDim2.new(1, -42, 0, 17),
        Size = UDim2.fromOffset(25, 25),
        BackgroundColor3 = Theme.Tertiary,
        BorderSizePixel = 0,
        Text = "×",
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        AutoButtonColor = false
    })
    Corner(Close, 6)

    local Body = New("Frame", {
        Name = "Body",
        Parent = Main,
        Position = UDim2.fromOffset(0, 60),
        Size = UDim2.new(1, 0, 1, -60),
        BackgroundTransparency = 1
    })

    local Sidebar = New("Frame", {
        Name = "Sidebar",
        Parent = Body,
        Size = UDim2.new(0, 155, 1, 0),
        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0
    })

    local TabList = New("ScrollingFrame", {
        Parent = Sidebar,
        Position = UDim2.fromOffset(10, 10),
        Size = UDim2.new(1, -20, 1, -20),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = Theme.Accent,
        CanvasSize = UDim2.new()
    })

    local TabLayout = New("UIListLayout", {
        Parent = TabList,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6)
    })

    TabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabList.CanvasSize = UDim2.fromOffset(
            0,
            TabLayout.AbsoluteContentSize.Y + 10
        )
    end)

    local Content = New("Frame", {
        Name = "Content",
        Parent = Body,
        Position = UDim2.fromOffset(155, 0),
        Size = UDim2.new(1, -155, 1, 0),
        BackgroundTransparency = 1
    })

    MakeDraggable(Main, TopBar)

    local pages = {}
    local Window = {}

    local minimized = false

    Minimize.MouseButton1Click:Connect(function()
        minimized = not minimized
        Body.Visible = not minimized

        if minimized then
            Tween(Main, {Size = UDim2.fromOffset(size.X.Offset, 60)}, 0.25)
        else
            Tween(Main, {Size = size}, 0.25)
        end
    end)

    Close.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    --==================================================
    -- WINDOW CONTROL
    --==================================================

    function Window:SetVisible(visible)
        ScreenGui.Enabled = visible == true
    end

    function Window:Toggle()
        ScreenGui.Enabled = not ScreenGui.Enabled
    end

    function Window:IsVisible()
        return ScreenGui.Enabled
    end

    function Window:Destroy()
        if ScreenGui and ScreenGui.Parent then
            ScreenGui:Destroy()
        end
    end

    function Window:CreateTab(options)
        options = options or {}

        local tabName = options.Name or "Tab"
        local tabIcon = options.Icon

        local TabButton = New("TextButton", {
            Parent = TabList,
            Size = UDim2.new(1, 0, 0, 36),
            BackgroundColor3 = Theme.Tertiary,
            BorderSizePixel = 0,
            Text = "",
            TextColor3 = Theme.SubText,
            Font = Enum.Font.GothamMedium,
            TextSize = 12,
            AutoButtonColor = false
        })

        Corner(TabButton, 6)

        if tabIcon then
            New("TextLabel", {
                Parent = TabButton,
                Position = UDim2.fromOffset(9, 0),
                Size = UDim2.fromOffset(24, 36),
                BackgroundTransparency = 1,
                Text = tostring(tabIcon),
                TextColor3 = Theme.SubText,
                Font = Enum.Font.GothamBold,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Center
            })

            New("TextLabel", {
                Parent = TabButton,
                Position = UDim2.fromOffset(38, 0),
                Size = UDim2.new(1, -46, 1, 0),
                BackgroundTransparency = 1,
                Text = tabName,
                TextColor3 = Theme.SubText,
                Font = Enum.Font.GothamMedium,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left
            })
        else
            New("TextLabel", {
                Parent = TabButton,
                Position = UDim2.fromOffset(12, 0),
                Size = UDim2.new(1, -24, 1, 0),
                BackgroundTransparency = 1,
                Text = tabName,
                TextColor3 = Theme.SubText,
                Font = Enum.Font.GothamMedium,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left
            })
        end

        local Page = New("ScrollingFrame", {
            Parent = Content,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = Theme.Accent,
            CanvasSize = UDim2.new(),
            Visible = false
        })

        Padding(Page, 15, 15, 15, 15)

        local Layout = New("UIListLayout", {
            Parent = Page,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 10)
        })

        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.fromOffset(
                0,
                Layout.AbsoluteContentSize.Y + 30
            )
        end)

        table.insert(pages, {
            Button = TabButton,
            Page = Page
        })

        local Tab = {}

        local function Select()
            for _, data in ipairs(pages) do
                data.Page.Visible = false
                Tween(data.Button, {
                    BackgroundColor3 = Theme.Tertiary
                }, 0.15)

                for _, child in ipairs(data.Button:GetChildren()) do
                    if child:IsA("TextLabel") then
                        Tween(child, {TextColor3 = Theme.SubText}, 0.15)
                    end
                end
            end

            Page.Visible = true

            Tween(TabButton, {
                BackgroundColor3 = Theme.Accent
            }, 0.15)

            for _, child in ipairs(TabButton:GetChildren()) do
                if child:IsA("TextLabel") then
                    Tween(child, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.15)
                end
            end
        end

        TabButton.MouseButton1Click:Connect(Select)

        if #pages == 1 then
            Select()
        end

        function Tab:CreateSection(name)
            local Section = New("Frame", {
                Parent = Page,
                Size = UDim2.new(1, 0, 0, 55),
                BackgroundColor3 = Theme.Secondary,
                BorderSizePixel = 0
            })

            Corner(Section, 7)
            Stroke(Section)

            New("TextLabel", {
                Parent = Section,
                Position = UDim2.fromOffset(12, 0),
                Size = UDim2.new(1, -24, 0, 45),
                BackgroundTransparency = 1,
                Text = name or "Section",
                TextColor3 = Theme.Text,
                Font = Enum.Font.GothamBold,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left
            })

            local Elements = New("Frame", {
                Parent = Section,
                Position = UDim2.fromOffset(10, 45),
                Size = UDim2.new(1, -20, 0, 0),
                BackgroundTransparency = 1
            })

            local ElementLayout = New("UIListLayout", {
                Parent = Elements,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 7)
            })

            ElementLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                Elements.Size = UDim2.new(
                    1,
                    -20,
                    0,
                    ElementLayout.AbsoluteContentSize.Y
                )

                Section.Size = UDim2.new(
                    1,
                    0,
                    0,
                    55 + ElementLayout.AbsoluteContentSize.Y
                )
            end)

            local SectionAPI = {}

            function SectionAPI:CreateButton(options)
                options = options or {}

                local Button = New("TextButton", {
                    Parent = Elements,
                    Size = UDim2.new(1, 0, 0, 38),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Text = options.Name or "Button",
                    TextColor3 = Theme.Text,
                    Font = Enum.Font.GothamMedium,
                    TextSize = 12,
                    AutoButtonColor = false
                })

                Corner(Button, 6)

                Button.MouseEnter:Connect(function()
                    Tween(Button, {BackgroundColor3 = Theme.Accent}, 0.15)
                end)

                Button.MouseLeave:Connect(function()
                    Tween(Button, {BackgroundColor3 = Theme.Tertiary}, 0.15)
                end)

                Button.MouseButton1Click:Connect(function()
                    if options.Callback then
                        task.spawn(options.Callback)
                    end
                end)

                return Button
            end

            function SectionAPI:CreateToggle(options)
                options = options or {}

                local enabled = options.Default or false

                local Button = New("TextButton", {
                    Parent = Elements,
                    Size = UDim2.new(1, 0, 0, 42),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Text = "",
                    AutoButtonColor = false
                })

                Corner(Button, 6)

                New("TextLabel", {
                    Parent = Button,
                    Position = UDim2.fromOffset(12, 0),
                    Size = UDim2.new(1, -65, 1, 0),
                    BackgroundTransparency = 1,
                    Text = options.Name or "Toggle",
                    TextColor3 = Theme.Text,
                    Font = Enum.Font.GothamMedium,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left
                })

                local Switch = New("Frame", {
                    Parent = Button,
                    Position = UDim2.new(1, -48, 0.5, -10),
                    Size = UDim2.fromOffset(38, 20),
                    BackgroundColor3 = enabled and Theme.Accent or Theme.Background,
                    BorderSizePixel = 0
                })
                Corner(Switch, 10)

                local Circle = New("Frame", {
                    Parent = Switch,
                    Size = UDim2.fromOffset(14, 14),
                    Position = enabled
                        and UDim2.new(1, -17, 0.5, -7)
                        or UDim2.fromOffset(3, 3),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0
                })
                Corner(Circle, 20)

                local function Update()
                    Tween(Switch, {
                        BackgroundColor3 = enabled and Theme.Accent or Theme.Background
                    }, 0.15)

                    Tween(Circle, {
                        Position = enabled
                            and UDim2.new(1, -17, 0.5, -7)
                            or UDim2.fromOffset(3, 3)
                    }, 0.15)

                    if options.Callback then
                        task.spawn(options.Callback, enabled)
                    end
                end

                Button.MouseButton1Click:Connect(function()
                    enabled = not enabled
                    Update()
                end)

                local API = {}

                function API:Set(value)
                    enabled = value
                    Update()
                end

                function API:Get()
                    return enabled
                end

                return API
            end

            function SectionAPI:CreateInput(options)
                options = options or {}

                local Box = New("TextBox", {
                    Parent = Elements,
                    Size = UDim2.new(1, 0, 0, 40),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    PlaceholderText = options.Placeholder or "Enter text...",
                    PlaceholderColor3 = Theme.SubText,
                    Text = options.Default or "",
                    TextColor3 = Theme.Text,
                    Font = Enum.Font.Gotham,
                    TextSize = 12,
                    ClearTextOnFocus = false
                })

                Corner(Box, 6)
                Padding(Box, 12, 12, 0, 0)

                Box.FocusLost:Connect(function(enterPressed)
                    if options.Callback then
                        task.spawn(options.Callback, Box.Text, enterPressed)
                    end
                end)

                return Box
            end

            function SectionAPI:CreateDropdown(options)
                options = options or {}

                local values = options.Values or {}
                local selected = options.Default or values[1]
                local opened = false

                local Holder = New("Frame", {
                    Parent = Elements,
                    Size = UDim2.new(1, 0, 0, 40),
                    BackgroundTransparency = 1
                })

                local Button = New("TextButton", {
                    Parent = Holder,
                    Size = UDim2.new(1, 0, 0, 40),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Text = "",
                    AutoButtonColor = false,
                    ZIndex = 5
                })
                Corner(Button, 6)

                New("TextLabel", {
                    Parent = Button,
                    Position = UDim2.fromOffset(12, 0),
                    Size = UDim2.new(0.5, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = options.Name or "Dropdown",
                    TextColor3 = Theme.Text,
                    Font = Enum.Font.GothamMedium,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 6
                })

                local ValueLabel = New("TextLabel", {
                    Parent = Button,
                    Position = UDim2.new(0.5, 0, 0, 0),
                    Size = UDim2.new(0.5, -12, 1, 0),
                    BackgroundTransparency = 1,
                    Text = tostring(selected or "Select"),
                    TextColor3 = Theme.Accent,
                    Font = Enum.Font.GothamMedium,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    ZIndex = 6
                })

                local List = New("Frame", {
                    Parent = Holder,
                    Position = UDim2.new(0, 0, 0, 45),
                    Size = UDim2.new(1, 0, 0, 0),
                    BackgroundColor3 = Theme.Secondary,
                    BorderSizePixel = 0,
                    Visible = false,
                    ZIndex = 20
                })
                Corner(List, 6)
                Stroke(List)

                local ListLayout = New("UIListLayout", {
                    Parent = List,
                    Padding = UDim.new(0, 3)
                })

                local function RefreshSize()
                    List.Size = UDim2.new(
                        1,
                        0,
                        0,
                        ListLayout.AbsoluteContentSize.Y + 8
                    )
                end

                for _, item in ipairs(values) do
                    local Option = New("TextButton", {
                        Parent = List,
                        Size = UDim2.new(1, -8, 0, 30),
                        BackgroundColor3 = Theme.Tertiary,
                        BorderSizePixel = 0,
                        Text = tostring(item),
                        TextColor3 = Theme.Text,
                        Font = Enum.Font.Gotham,
                        TextSize = 11,
                        AutoButtonColor = false,
                        ZIndex = 21
                    })
                    Corner(Option, 5)

                    Option.MouseButton1Click:Connect(function()
                        selected = item
                        ValueLabel.Text = tostring(item)
                        opened = false
                        List.Visible = false

                        Holder.Size = UDim2.new(1, 0, 0, 40)

                        if options.Callback then
                            task.spawn(options.Callback, item)
                        end
                    end)
                end

                Button.MouseButton1Click:Connect(function()
                    opened = not opened
                    List.Visible = opened

                    if opened then
                        RefreshSize()
                        Holder.Size = UDim2.new(
                            1,
                            0,
                            0,
                            45 + List.AbsoluteSize.Y
                        )
                    else
                        Holder.Size = UDim2.new(1, 0, 0, 40)
                    end
                end)

                ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(RefreshSize)

                local API = {}

                function API:Set(value)
                    selected = value
                    ValueLabel.Text = tostring(value)

                    if options.Callback then
                        task.spawn(options.Callback, value)
                    end
                end

                function API:Get()
                    return selected
                end

                return API
            end

            function SectionAPI:CreateKeybind(options)
                options = options or {}

                local CurrentKey = options.Default or Enum.KeyCode.RightShift

                local Holder = Create("TextButton", {
                    Parent = Elements,
                    Size = UDim2.new(1, 0, 0, 42),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Text = "",
                    AutoButtonColor = false
                })

                AddCorner(Holder, 6)

                Create("TextLabel", {
                    Parent = Holder,
                    Position = UDim2.fromOffset(12, 0),
                    Size = UDim2.new(1, -130, 1, 0),
                    BackgroundTransparency = 1,
                    Text = options.Name or "Keybind",
                    TextColor3 = Theme.Text,
                    Font = Enum.Font.GothamMedium,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left
                })

                local KeyLabel = Create("TextLabel", {
                    Parent = Holder,
                    Position = UDim2.new(1, -115, 0, 7),
                    Size = UDim2.fromOffset(100, 28),
                    BackgroundColor3 = Theme.Background,
                    BorderSizePixel = 0,
                    Text = CurrentKey.Name,
                    TextColor3 = Theme.Accent,
                    Font = Enum.Font.GothamBold,
                    TextSize = 11
                })

                AddCorner(KeyLabel, 5)

                local Listening = false

                Holder.MouseButton1Click:Connect(function()
                    if Listening then
                        return
                    end

                    Listening = true
                    KeyLabel.Text = "Press key..."

                    local connection
                    connection = UserInputService.InputBegan:Connect(function(input, processed)
                        if processed then
                            return
                        end

                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            CurrentKey = input.KeyCode
                            KeyLabel.Text = CurrentKey.Name
                            Listening = false
                            connection:Disconnect()

                            if options.Changed then
                                task.spawn(options.Changed, CurrentKey)
                            end
                        end
                    end)
                end)

                UserInputService.InputBegan:Connect(function(input, processed)
                    if processed or Listening then
                        return
                    end

                    if input.UserInputType == Enum.UserInputType.Keyboard
                        and input.KeyCode == CurrentKey then

                        if options.Callback then
                            task.spawn(options.Callback, CurrentKey)
                        end
                    end
                end)

                local API = {}

                function API:Set(key)
                    if typeof(key) == "EnumItem" and key.EnumType == Enum.KeyCode then
                        CurrentKey = key
                        KeyLabel.Text = CurrentKey.Name

                        if options.Changed then
                            task.spawn(options.Changed, CurrentKey)
                        end
                    end
                end

                function API:Get()
                    return CurrentKey
                end

                return API
            end

            function SectionAPI:CreateSlider(options)
                options = options or {}

                local min = options.Min or 0
                local max = options.Max or 100
                local value = math.clamp(options.Default or min, min, max)

                local Holder = New("Frame", {
                    Parent = Elements,
                    Size = UDim2.new(1, 0, 0, 55),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0
                })
                Corner(Holder, 6)

                New("TextLabel", {
                    Parent = Holder,
                    Position = UDim2.fromOffset(12, 6),
                    Size = UDim2.new(1, -70, 0, 18),
                    BackgroundTransparency = 1,
                    Text = options.Name or "Slider",
                    TextColor3 = Theme.Text,
                    Font = Enum.Font.GothamMedium,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left
                })

                local ValueLabel = New("TextLabel", {
                    Parent = Holder,
                    Position = UDim2.new(1, -58, 0, 6),
                    Size = UDim2.fromOffset(45, 18),
                    BackgroundTransparency = 1,
                    Text = tostring(value),
                    TextColor3 = Theme.Accent,
                    Font = Enum.Font.GothamBold,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Right
                })

                local Bar = New("Frame", {
                    Parent = Holder,
                    Position = UDim2.new(0, 12, 1, -17),
                    Size = UDim2.new(1, -24, 0, 6),
                    BackgroundColor3 = Theme.Background,
                    BorderSizePixel = 0
                })
                Corner(Bar, 6)

                local Fill = New("Frame", {
                    Parent = Bar,
                    Size = UDim2.new((value - min) / (max - min), 0, 1, 0),
                    BackgroundColor3 = Theme.Accent,
                    BorderSizePixel = 0
                })
                Corner(Fill, 6)

                local dragging = false

                local function SetValue(x)
                    local percent = math.clamp(
                        (x - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X,
                        0,
                        1
                    )

                    value = math.floor(min + ((max - min) * percent))
                    Fill.Size = UDim2.new(percent, 0, 1, 0)
                    ValueLabel.Text = tostring(value)

                    if options.Callback then
                        task.spawn(options.Callback, value)
                    end
                end

                Bar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1
                        or input.UserInputType == Enum.UserInputType.Touch then

                        dragging = true
                        SetValue(input.Position.X)
                    end
                end)

                UserInputService.InputChanged:Connect(function(input)
                    if not dragging then return end

                    if input.UserInputType == Enum.UserInputType.MouseMovement
                        or input.UserInputType == Enum.UserInputType.Touch then

                        SetValue(input.Position.X)
                    end
                end)

                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1
                        or input.UserInputType == Enum.UserInputType.Touch then

                        dragging = false
                    end
                end)

                local API = {}

                function API:Set(newValue)
                    value = math.clamp(newValue, min, max)

                    local percent = (value - min) / (max - min)

                    Fill.Size = UDim2.new(percent, 0, 1, 0)
                    ValueLabel.Text = tostring(value)

                    if options.Callback then
                        task.spawn(options.Callback, value)
                    end
                end

                function API:Get()
                    return value
                end

                return API
            end

            return SectionAPI
        end

        return Tab
    end

    function Window:Notify(options)
        options = options or {}

        local duration = options.Duration or 3
        local accent = options.Color or Theme.Accent

        local notification = New("Frame", {
            Parent = NotificationHolder,
            Size = UDim2.fromOffset(280, 75),
            BackgroundColor3 = Theme.Secondary,
            BorderSizePixel = 0,
            LayoutOrder = math.floor(os.clock() * 1000)
        })

        Corner(notification, 8)
        Stroke(notification)

        New("Frame", {
            Parent = notification,
            Position = UDim2.fromOffset(0, 8),
            Size = UDim2.fromOffset(3, 59),
            BackgroundColor3 = accent,
            BorderSizePixel = 0
        })

        New("TextLabel", {
            Parent = notification,
            Position = UDim2.fromOffset(14, 8),
            Size = UDim2.new(1, -24, 0, 20),
            BackgroundTransparency = 1,
            Text = options.Title or "Notification",
            TextColor3 = Theme.Text,
            Font = Enum.Font.GothamBold,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left
        })

        New("TextLabel", {
            Parent = notification,
            Position = UDim2.fromOffset(14, 30),
            Size = UDim2.new(1, -24, 0, 35),
            BackgroundTransparency = 1,
            Text = options.Content or "",
            TextColor3 = Theme.SubText,
            Font = Enum.Font.Gotham,
            TextSize = 11,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top
        })

        local progress = New("Frame", {
            Parent = notification,
            Position = UDim2.new(0, 0, 1, -3),
            Size = UDim2.new(1, 0, 0, 3),
            BackgroundColor3 = accent,
            BorderSizePixel = 0
        })

        notification.Position = UDim2.new(1, 320, 0, 0)
        Tween(notification, {Position = UDim2.new(0, 0, 0, 0)}, 0.25)
        Tween(progress, {Size = UDim2.new(0, 0, 0, 3)}, duration)

        task.delay(duration, function()
            if not notification.Parent then return end

            Tween(notification, {Position = UDim2.new(1, 320, 0, 0)}, 0.25)
            task.wait(0.3)

            if notification.Parent then
                notification:Destroy()
            end
        end)

        return notification
    end

    return Window
end

return UILibrary

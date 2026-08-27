-- LIB-PHILANX UI Library
-- Version: 2.8.3
-- Original Roblox UI Library
-- For Roblox Studio / testing your own game

local UILibrary = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer

local Theme = {
    Background = Color3.fromRGB(8, 12, 22),
    Secondary = Color3.fromRGB(12, 18, 32),
    Tertiary = Color3.fromRGB(18, 27, 46),
    Accent = Color3.fromRGB(35, 155, 255),
    Text = Color3.fromRGB(245, 250, 255),
    SubText = Color3.fromRGB(145, 165, 190),
    Border = Color3.fromRGB(35, 65, 100),
    Success = Color3.fromRGB(70, 215, 140),
    Warning = Color3.fromRGB(255, 195, 70),
    Error = Color3.fromRGB(245, 85, 95)
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


--==================================================
-- LOADING MANAGER
--==================================================

local LoadingManager = {
    Gui = nil,
    MainGui = nil,
    SetProgress = nil,
    Finished = false,
    Started = false,
    LastActivity = 0,
    ComponentCount = 0,
    CompletedCount = 0,
    Workload = 0,
    CompletedWorkload = 0,
    BootstrapCompleted = 0,
    BootstrapTotal = 5,
    FinishToken = 0,
    ComponentDelay = 0.018,
    IdleFinishDelay = 0.45
}

function LoadingManager:Start()
    if self.Started and self.Gui and self.Gui.Parent then
        return
    end

    self.Started = true
    self.Finished = false
    self.MainGui = nil
    self.LastActivity = os.clock()

    local gui = New("ScreenGui", {
        Name = "PhilanxLoading",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })
    gui.Parent = Player:WaitForChild("PlayerGui")
    self.Gui = gui

    local overlay = New("Frame", {
        Parent = gui,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 900
    })

    local card = New("Frame", {
        Parent = overlay,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(370, 205),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        ZIndex = 901
    })
    Corner(card, 12)
    Stroke(card, Theme.Border, 1)

    local accent = New("Frame", {
        Parent = card,
        Position = UDim2.fromOffset(16, 0),
        Size = UDim2.new(1, -32, 0, 3),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        ZIndex = 902
    })
    Corner(accent, 2)

    local logo = New("ImageLabel", {
        Parent = card,
        Position = UDim2.fromOffset(22, 27),
        Size = UDim2.fromOffset(56, 56),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = "rbxassetid://132859114380485",
        ImageColor3 = Color3.fromRGB(255, 255, 255),
        ScaleType = Enum.ScaleType.Fit,
        ZIndex = 902
    })

    local title = New("TextLabel", {
        Parent = card,
        Position = UDim2.fromOffset(92, 27),
        Size = UDim2.new(1, -114, 0, 28),
        BackgroundTransparency = 1,
        Text = "LIB-PHILANX",
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 19,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 902
    })

    local status = New("TextLabel", {
        Parent = card,
        Position = UDim2.fromOffset(92, 57),
        Size = UDim2.new(1, -114, 0, 20),
        BackgroundTransparency = 1,
        Text = "Initializing...",
        TextColor3 = Theme.SubText,
        Font = Enum.Font.Gotham,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 902
    })

    local track = New("Frame", {
        Parent = card,
        Position = UDim2.fromOffset(20, 117),
        Size = UDim2.new(1, -40, 0, 7),
        BackgroundColor3 = Theme.Tertiary,
        BorderSizePixel = 0,
        ZIndex = 902
    })
    Corner(track, 4)

    local fill = New("Frame", {
        Parent = track,
        Size = UDim2.fromOffset(0, 7),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        ZIndex = 903
    })
    Corner(fill, 4)

    local shine = New("Frame", {
        Parent = fill,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(-0.35, 0, 0.5, 0),
        Size = UDim2.new(0.28, 0, 1.8, 0),
        Rotation = 18,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.78,
        BorderSizePixel = 0,
        ZIndex = 904
    })

    task.spawn(function()
        while shine.Parent and not self.Finished do
            Tween(shine, {
                Position = UDim2.new(1.05, 0, 0.5, 0)
            }, 0.65)

            task.wait(0.18)

            if shine.Parent and not self.Finished then
                shine.Position = UDim2.new(-0.35, 0, 0.5, 0)
            end
        end
    end)

    local percent = New("TextLabel", {
        Parent = card,
        Position = UDim2.fromOffset(20, 133),
        Size = UDim2.new(1, -40, 0, 18),
        BackgroundTransparency = 1,
        Text = "0%",
        TextColor3 = Theme.SubText,
        Font = Enum.Font.GothamMedium,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Right,
        ZIndex = 902
    })

    local detail = New("TextLabel", {
        Parent = card,
        Position = UDim2.fromOffset(20, 157),
        Size = UDim2.new(1, -40, 0, 18),
        BackgroundTransparency = 1,
        Text = "Components processed: 0",
        TextColor3 = Theme.SubText,
        Font = Enum.Font.Gotham,
        TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 902
    })

    self.SetProgress = function(value, message, detailText)
        value = math.clamp(value, 0, 100)
        status.Text = message or status.Text
        percent.Text = tostring(math.floor(value)) .. "%"
        detail.Text = detailText or detail.Text

        Tween(fill, {
            Size = UDim2.new(value / 100, 0, 1, 0)
        }, 0.10)
    end

    self.SetProgress(0, "Initializing...", "Preparing library...")
end

function LoadingManager:UpdateBootstrap(message)
    self.BootstrapCompleted = math.clamp(self.BootstrapCompleted + 1, 0, self.BootstrapTotal)

    local progress = (self.BootstrapCompleted / self.BootstrapTotal) * 15

    if self.SetProgress then
        self.SetProgress(
            progress,
            message or "Initializing...",
            "Core " .. tostring(self.BootstrapCompleted) .. "/" .. tostring(self.BootstrapTotal)
        )
    end
end

function LoadingManager:ProcessComponent(name)
    if self.Finished then
        return
    end

    self.ComponentCount += 1
    self.LastActivity = os.clock()
    self.FinishToken += 1

    local myToken = self.FinishToken
    local label = tostring(name or "Component")

    -- Different components have different construction complexity.
    -- This makes the loading time follow the actual type of component.
    local weights = {
        Window = 3.0,
        Sidebar = 2.0,
        Tab = 2.0,
        Section = 2.0,
        Label = 0.8,
        Paragraph = 1.0,
        Divider = 0.5,
        StatusBox = 1.5,
        Button = 1.0,
        Toggle = 1.2,
        Input = 1.5,
        Dropdown = 2.0,
        Keybind = 1.5,
        Slider = 2.0
    }

    local weight = weights[label] or 1.0
    self.Workload += weight

    -- Convert accumulated workload into a smooth 15%-90% range.
    -- The curve intentionally slows down as workload grows so a large
    -- library remains visible longer without a fixed fake duration.
    local workloadProgress = 75 * (1 - math.exp(-self.Workload / 24))
    local progress = math.clamp(15 + workloadProgress, 15, 90)

    if self.SetProgress then
        self.SetProgress(
            progress,
            "Creating " .. label .. "...",
            "Components: " .. tostring(self.ComponentCount)
                .. "  •  Workload: " .. string.format("%.1f", self.Workload)
        )
    end

    -- Real per-component processing opportunity.
    local processingTime = 0.012 + (weight * 0.008)
    task.wait(processingTime)

    self.CompletedCount = self.ComponentCount
    self.CompletedWorkload = self.Workload
    self.LastActivity = os.clock()

    -- Finish only after no new components arrive.
    task.delay(self.IdleFinishDelay, function()
        if self.Finished then
            return
        end

        if self.FinishToken ~= myToken then
            return
        end

        if os.clock() - self.LastActivity >= self.IdleFinishDelay - 0.02 then
            self:Finish()
        end
    end)
end

function LoadingManager:Finish()
    if self.Finished then
        return
    end

    self.Finished = true

    if self.SetProgress then
        self.SetProgress(
            100,
            "Library ready.",
            "All components initialized: " .. tostring(self.CompletedCount)
                .. "  •  Workload: " .. string.format("%.1f", self.CompletedWorkload)
        )
    end

    task.wait(0.12)

    local gui = self.Gui
    if not gui or not gui.Parent then
        return
    end

    local overlay = gui:FindFirstChildOfClass("Frame")
    if overlay then
        Tween(overlay, {
            BackgroundTransparency = 1
        }, 0.18)

        local card = overlay:FindFirstChildOfClass("Frame")
        if card then
            Tween(card, {
                BackgroundTransparency = 1
            }, 0.18)
        end
    end

    task.wait(0.20)

    if gui.Parent then
        gui:Destroy()
    end

    -- Reveal the real library only after the loading screen is complete.
    local mainGui = self.MainGui
    if mainGui and mainGui.Parent then
        mainGui.Enabled = true
    end
end


--==================================================
-- CONFIG / PRESET MANAGER
--==================================================

local function CreateConfigManager()
    local manager = {
        Controls = {},
        ActiveName = nil,
        BaseFolder = "LIB-PHILANX",
        Folder = "LIB-PHILANX",
        GameName = "",
        GameId = 0,
        GameFolder = "",
        _IsAlive = function()
            return true
        end,
        Extension = ".json",
    }

    local function SanitizeGameName(name)
        name = tostring(name or "Unknown")
        name = name:gsub("[%c]", "")
        name = name:gsub('[\\/:*?"<>|]', "_")
        name = name:gsub("%s+", " ")
        name = name:gsub("^%s+", "")
        name = name:gsub("%s+$", "")

        if name == "" then
            name = "Unknown"
        end

        return name
    end

    local function FindGameFolderByGameId(gameId)
        if type(listfiles) ~= "function"
            or type(isfolder) ~= "function" then
            return nil
        end

        local ok, entries = pcall(listfiles, manager.BaseFolder)
        if not ok or type(entries) ~= "table" then
            return nil
        end

        local suffix = "_" .. tostring(gameId)

        for _, path in ipairs(entries) do
            path = tostring(path)

            if isfolder(path) then
                local folderName = path:match("([^\\/]+)$")

                if folderName
                    and #folderName >= #suffix
                    and folderName:sub(-#suffix) == suffix then
                    return path, folderName
                end
            end
        end

        return nil
    end

    local function GetCurrentGameIdentity()
        local placeName = "Unknown"
        local gameId = 0

        pcall(function()
            gameId = game.GameId

            local MarketplaceService = game:GetService("MarketplaceService")
            local productInfo = MarketplaceService:GetProductInfo(
                game.PlaceId,
                Enum.InfoType.Asset
            )

            if type(productInfo) == "table" and productInfo.Name then
                placeName = productInfo.Name
            end
        end)

        return SanitizeGameName(placeName), tonumber(gameId) or 0
    end

    local function InitializeGameFolder()
        local gameName, gameId = GetCurrentGameIdentity()

        manager.GameName = gameName
        manager.GameId = gameId

        if type(makefolder) ~= "function"
            or type(isfolder) ~= "function" then
            manager.GameFolder = gameName .. "_" .. tostring(gameId)
            manager.Folder = manager.BaseFolder .. "/" .. manager.GameFolder
            return manager.Folder
        end

        if not isfolder(manager.BaseFolder) then
            pcall(makefolder, manager.BaseFolder)
        end

        -- GameId is the authoritative key.
        -- The place name is only the readable prefix.
        local existingPath, existingFolderName =
            FindGameFolderByGameId(gameId)

        if existingPath and existingFolderName then
            manager.GameFolder = existingFolderName
            manager.Folder = existingPath

            local expectedFolderName =
                gameName .. "_" .. tostring(gameId)

            if existingFolderName ~= expectedFolderName
                and type(renamefolder) == "function" then

                local newFolderPath =
                    manager.BaseFolder .. "/" .. expectedFolderName

                if not isfolder(newFolderPath) then
                    local ok = pcall(
                        renamefolder,
                        existingPath,
                        newFolderPath
                    )

                    if ok and isfolder(newFolderPath) then
                        manager.GameFolder = expectedFolderName
                        manager.Folder = newFolderPath
                    end
                end
            end

            return manager.Folder
        end

        manager.GameFolder = gameName .. "_" .. tostring(gameId)
        manager.Folder = manager.BaseFolder .. "/" .. manager.GameFolder

        if not isfolder(manager.Folder) then
            pcall(makefolder, manager.Folder)
        end

        return manager.Folder
    end

    function manager:GetGameId()
        return manager.GameId
    end

    function manager:GetGameName()
        return manager.GameName
    end

    function manager:GetGameFolder()
        return manager.GameFolder
    end

    function manager:GetConfigFolder()
        return manager.Folder
    end

    local function CanUseFileAPI()
        return type(writefile) == "function"
            and type(readfile) == "function"
            and type(isfile) == "function"
    end

    local function EnsureFolder()
        if type(makefolder) == "function"
            and type(isfolder) == "function"
            and not isfolder(manager.Folder) then
            pcall(makefolder, manager.Folder)
        end
    end

    local function SafeName(name)
        name = tostring(name or "Default")
        name = name:gsub("[^%w_%-%s]", "")
        name = name:gsub("%s+", "_")
        if name == "" then
            name = "Default"
        end
        return name
    end

    local function Path(name)
        return manager.Folder .. "/" .. SafeName(name) .. manager.Extension
    end

    local function Encode(value)
        local valueType = typeof(value)

        if valueType == "EnumItem" then
            return {
                __type = "EnumItem",
                enum = tostring(value.EnumType),
                name = value.Name
            }
        end

        if valueType == "Color3" then
            return {
                __type = "Color3",
                r = value.R,
                g = value.G,
                b = value.B
            }
        end

        if type(value) == "table" then
            local result = {}

            for key, item in pairs(value) do
                if type(key) == "string" or type(key) == "number" then
                    result[key] = Encode(item)
                end
            end

            return result
        end

        if type(value) == "string"
            or type(value) == "number"
            or type(value) == "boolean"
            or value == nil then
            return value
        end

        return tostring(value)
    end

    local function Decode(value)
        if type(value) ~= "table" then
            return value
        end

        if value.__type == "EnumItem" then
            if value.enum == "KeyCode" and Enum.KeyCode[value.name] then
                return Enum.KeyCode[value.name]
            end

            return nil
        end

        if value.__type == "Color3" then
            return Color3.new(
                tonumber(value.r) or 0,
                tonumber(value.g) or 0,
                tonumber(value.b) or 0
            )
        end

        local result = {}

        for key, item in pairs(value) do
            result[key] = Decode(item)
        end

        return result
    end

    function manager:Register(id, controlType, control)
        id = tostring(id or "")

        if id == "" or not control then
            return false
        end

        manager.Controls[id] = {
            Type = controlType,
            Control = control
        }

        return true
    end

    function manager:GetRegistered()
        local result = {}

        for id, data in pairs(manager.Controls) do
            result[id] = data.Type
        end

        return result
    end

    function manager:Collect()
        local result = {}

        for id, data in pairs(manager.Controls) do
            local control = data.Control
            local value

            pcall(function()
                if data.Type == "Input" then
                    value = control.Text
                elseif control.GetValue then
                    value = control:GetValue()
                elseif control.Get then
                    value = control:Get()
                end
            end)

            if value ~= nil then
                result[id] = Encode(value)
            end
        end

        return result
    end

    function manager:Apply(data, fireCallback)
        if type(data) ~= "table" then
            return false, "Config data must be a table."
        end

        local applied = 0

        for id, encodedValue in pairs(data) do
            local entry = manager.Controls[tostring(id)]

            if entry then
                local value = Decode(encodedValue)
                local ok = pcall(function()
                    if entry.Type == "Input" then
                        entry.Control.Text = tostring(value or "")
                    elseif entry.Control.SetValue then
                        entry.Control:SetValue(value, fireCallback ~= false)
                    elseif entry.Control.Set then
                        entry.Control:Set(value, fireCallback ~= false)
                    end
                end)

                if ok then
                    applied += 1
                end
            end
        end

        return true, applied
    end

    function manager:Save(name)
        name = tostring(name or self.ActiveName or "Default")
        self.ActiveName = name

        local data = self:Collect()

        if not CanUseFileAPI() then
            self.Memory = self.Memory or {}
            self.Memory[SafeName(name)] = data
            return true, "memory"
        end

        EnsureFolder()

        local ok, encoded = pcall(function()
            return HttpService:JSONEncode(data)
        end)

        if not ok then
            return false, "JSON encode failed."
        end

        local success, err = pcall(writefile, Path(name), encoded)

        if not success then
            return false, tostring(err)
        end

        return true, Path(name)
    end

    function manager:Load(name, fireCallback)
        name = tostring(name or self.ActiveName or "Default")
        self.ActiveName = name

        local data

        if not CanUseFileAPI() then
            data = self.Memory and self.Memory[SafeName(name)]

            if not data then
                return false, "Config not found in memory."
            end
        else
            EnsureFolder()

            if not isfile(Path(name)) then
                return false, "Config not found."
            end

            local raw
            local okRead, errRead = pcall(readfile, Path(name))

            if not okRead then
                return false, tostring(errRead)
            end

            raw = errRead

            local okDecode, decoded = pcall(function()
                return HttpService:JSONDecode(raw)
            end)

            if not okDecode or type(decoded) ~= "table" then
                return false, "Invalid config JSON."
            end

            data = decoded
        end

        return self:Apply(data, fireCallback)
    end

    function manager:Delete(name)
        name = tostring(name or self.ActiveName or "Default")

        if not CanUseFileAPI() then
            if self.Memory then
                self.Memory[SafeName(name)] = nil
            end
            return true
        end

        if type(delfile) ~= "function" then
            return false, "delfile is unavailable."
        end

        if not isfile(Path(name)) then
            return false, "Config not found."
        end

        local ok, err = pcall(delfile, Path(name))
        return ok, ok and true or tostring(err)
    end

    function manager:Exists(name)
        name = tostring(name or self.ActiveName or "Default")

        if not CanUseFileAPI() then
            return self.Memory ~= nil
                and self.Memory[SafeName(name)] ~= nil
        end

        return isfile(Path(name))
    end

    function manager:List()
        local result = {}

        if not CanUseFileAPI() then
            for name in pairs(self.Memory or {}) do
                table.insert(result, name)
            end
            table.sort(result)
            return result
        end

        if type(listfiles) ~= "function" then
            return result
        end

        EnsureFolder()

        local ok, files = pcall(listfiles, manager.Folder)

        if not ok or type(files) ~= "table" then
            return result
        end

        for _, filePath in ipairs(files) do
            local name = tostring(filePath):match("([^/\\]+)%.json$")

            if name then
                table.insert(result, name)
            end
        end

        table.sort(result)
        return result
    end

    function manager:GetActive()
        return self.ActiveName
    end

    function manager:SetActive(name)
        self.ActiveName = tostring(name or "Default")
        return self.ActiveName
    end

    InitializeGameFolder()

    return manager
end

function UILibrary:CreateWindow(options)
    options = options or {}

    LoadingManager:Start()
    LoadingManager:UpdateBootstrap("Initializing library...")

    local title = options.Title or "Apez UI"
    local subtitle = options.Subtitle or "UI Library"
    local size = options.Size or UDim2.fromOffset(650, 450)

    -- Logo default LIB-PHILANX.
    local logo = options.Logo or "rbxassetid://132859114380485"

    local function NormalizeLogo(value)
        value = tostring(value or "")

        if value == "" then
            return "rbxassetid://132859114380485"
        end

        if tonumber(value) then
            return "rbxassetid://" .. value
        end

        if string.match(value, "^%d+$") then
            return "rbxassetid://" .. value
        end

        return value
    end

    logo = NormalizeLogo(logo)

    local ScreenGui = New("ScreenGui", {
        Name = "ApezUI",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Enabled = false
    })

    ScreenGui.Parent = Player:WaitForChild("PlayerGui")

    -- Main UI remains completely hidden while LoadingManager is active.
    LoadingManager.MainGui = ScreenGui

    local NotificationHolder = New("Frame", {
        Name = "NotificationHolder",
        Parent = ScreenGui,
        AnchorPoint = Vector2.new(1, 1),
        Position = UDim2.new(1, -20, 1, -20),
        Size = UDim2.fromOffset(300, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        ZIndex = 100
    })

    local NotificationLayout = New("UIListLayout", {
        Parent = NotificationHolder,
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        Padding = UDim.new(0, 8)
    })

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
    Stroke(Main, Theme.Border, 1)
    local TopBar = New("Frame", {
        Name = "TopBar",
        Parent = Main,
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0
    })

    Corner(TopBar, 10)

    -- Logo PHILANX pada header Window yang sedang expanded.
    local WindowLogoBadge = New("Frame", {
        Name = "WindowLogoBadge",
        Parent = TopBar,
        Position = UDim2.fromOffset(12, 10),
        Size = UDim2.fromOffset(34, 34),
        BackgroundColor3 = Color3.fromRGB(12, 24, 42),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 4
    })
    Corner(WindowLogoBadge, 17)

    local WindowLogo = New("ImageLabel", {
        Name = "WindowLogo",
        Parent = WindowLogoBadge,
        Position = UDim2.fromOffset(2, 2),
        Size = UDim2.fromOffset(30, 30),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = logo,
        ImageTransparency = 0,
        ImageColor3 = Color3.fromRGB(255, 255, 255),
        ScaleType = Enum.ScaleType.Fit,
        Visible = true,
        ZIndex = 5
    })

    task.spawn(function()
        task.wait(0.75)
        if WindowLogo.Parent then
            pcall(function()
                WindowLogo.Image = "rbxthumb://type=Asset&id=" .. string.match(logo, "%d+") .. "&w=150&h=150"
            end)
        end
    end)

    local TopAccent = New("Frame", {
        Name = "TopAccent",
        Parent = TopBar,
        Position = UDim2.new(0, 12, 1, -3),
        Size = UDim2.new(1, -24, 0, 3),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        ZIndex = 3
    })
    Corner(TopAccent, 2)

    New("Frame", {
        Parent = TopBar,
        Position = UDim2.new(0, 0, 1, -15),
        Size = UDim2.new(1, 0, 0, 15),
        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0
    })

    local TitleLabel = New("TextLabel", {
        Name = "TitleLabel",
        Parent = TopBar,
        Position = UDim2.fromOffset(54, 8),
        Size = UDim2.new(1, -154, 0, 25),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 17,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local SubtitleLabel = New("TextLabel", {
        Name = "SubtitleLabel",
        Parent = TopBar,
        Position = UDim2.fromOffset(55, 34),
        Size = UDim2.new(1, -154, 0, 18),
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

    local SidebarAccent = New("Frame", {
        Name = "SidebarAccent",
        Parent = Sidebar,
        Position = UDim2.new(1, -2, 0, 10),
        Size = UDim2.new(0, 2, 1, -20),
        BackgroundColor3 = Theme.Accent,
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

    LoadingManager:UpdateBootstrap("Creating sidebar...")
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

    local ContentAccent = New("Frame", {
        Name = "ContentAccent",
        Parent = Content,
        Position = UDim2.fromOffset(0, 10),
        Size = UDim2.new(0, 1, 1, -20),
        BackgroundColor3 = Theme.Border,
        BorderSizePixel = 0
    })

    MakeDraggable(Main, TopBar)

    local function ButtonHover(button, normalColor, hoverColor)
        button.MouseEnter:Connect(function()
            Tween(button, {
                BackgroundColor3 = hoverColor
            }, 0.12)
        end)

        button.MouseLeave:Connect(function()
            Tween(button, {
                BackgroundColor3 = normalColor
            }, 0.12)
        end)
    end

    ButtonHover(
        Minimize,
        Theme.Tertiary,
        Color3.fromRGB(28, 48, 76)
    )

    ButtonHover(
        Close,
        Theme.Tertiary,
        Color3.fromRGB(85, 35, 55)
    )

    local function AddHover(button, normalColor, hoverColor)
        if not button or not button:IsA("GuiButton") then
            return
        end

        button.MouseEnter:Connect(function()
            Tween(button, {
                BackgroundColor3 = hoverColor
            }, 0.12)
        end)

        button.MouseLeave:Connect(function()
            Tween(button, {
                BackgroundColor3 = normalColor
            }, 0.12)
        end)
    end

    local function AddPressAnimation(button, normalColor, pressColor)
        if not button or not button:IsA("GuiButton") then
            return
        end

        button.MouseButton1Down:Connect(function()
            Tween(button, {
                BackgroundColor3 = pressColor
            }, 0.08)
        end)

        button.MouseButton1Up:Connect(function()
            Tween(button, {
                BackgroundColor3 = normalColor
            }, 0.08)
        end)
    end

    local pages = {}
    local Window = {}
    local ConfigManager = CreateConfigManager()

    ConfigManager._IsAlive = function()
        return ScreenGui ~= nil and ScreenGui.Parent ~= nil
    end

    --==================================================
    -- FLOATING PILL
    --==================================================

    -- Shadow layer untuk memberi depth tanpa mengubah fungsi pill.
    local PillShadow = New("Frame", {
        Name = "PhilanxPillShadow",
        Parent = ScreenGui,
        Position = UDim2.new(0, 80, 0, 84),
        Size = UDim2.fromOffset(230, 44),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.55,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 198
    })

    Corner(PillShadow, 22)

    -- Root pill tetap TextButton agar cursor dan perilaku klik sama
    -- seperti tombol UI lainnya.
    local Pill = New("TextButton", {
        Name = "PhilanxPill",
        Parent = ScreenGui,
        AnchorPoint = Vector2.new(0, 0),
        Position = UDim2.new(0, 80, 0, 80),
        Size = UDim2.fromOffset(230, 44),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        Visible = false,
        ZIndex = 200
    })

    Corner(Pill, 22)

    local PillStroke = Stroke(Pill, Theme.Border, 1)

    -- Gradient halus agar permukaan pill lebih premium.
    local PillGradient = New("UIGradient", {
        Parent = Pill,
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 31, 52)),
            ColorSequenceKeypoint.new(0.5, Theme.Background),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(7, 14, 27))
        },
        Rotation = 90
    })

    -- Highlight tipis di bagian atas.
    local PillHighlight = New("Frame", {
        Name = "Highlight",
        Parent = Pill,
        Position = UDim2.fromOffset(10, 2),
        Size = UDim2.new(1, -20, 0, 1),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.82,
        BorderSizePixel = 0,
        ZIndex = 201
    })

    Corner(PillHighlight, 1)

    -- Logo PHILANX PNG transparan.
    local PillIconBadge = New("Frame", {
        Name = "LogoBadge",
        Parent = Pill,
        Position = UDim2.fromOffset(6, 6),
        Size = UDim2.fromOffset(32, 32),
        BackgroundColor3 = Color3.fromRGB(12, 24, 42),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 202
    })
    Corner(PillIconBadge, 16)

    local PillIcon = New("ImageLabel", {
        Name = "Logo",
        Parent = PillIconBadge,
        Position = UDim2.fromOffset(2, 2),
        Size = UDim2.fromOffset(28, 28),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = logo,
        ImageTransparency = 0,
        ImageColor3 = Color3.fromRGB(255, 255, 255),
        ScaleType = Enum.ScaleType.Fit,
        Visible = true,
        ZIndex = 203
    })

    task.spawn(function()
        pcall(function()
            local ContentProvider = game:GetService("ContentProvider")
            ContentProvider:PreloadAsync({PillIcon})
        end)

        task.wait(0.75)
        if PillIcon.Parent then
            pcall(function()
                PillIcon.Image = "rbxthumb://type=Asset&id=" .. string.match(logo, "%d+") .. "&w=150&h=150"
            end)
        end
    end)

    local function ApplyLogo(newLogo)
        logo = NormalizeLogo(newLogo)

        WindowLogo.Image = logo
        PillIcon.Image = logo

        task.spawn(function()
            pcall(function()
                local ContentProvider = game:GetService("ContentProvider")
                ContentProvider:PreloadAsync({WindowLogo, PillIcon})
            end)

            task.wait(0.75)

            if WindowLogo.Parent then
                pcall(function()
                    local id = string.match(logo, "%d+")
                    if id then
                        WindowLogo.Image = "rbxthumb://type=Asset&id=" .. id .. "&w=150&h=150"
                    end
                end)
            end

            if PillIcon.Parent then
                pcall(function()
                    local id = string.match(logo, "%d+")
                    if id then
                        PillIcon.Image = "rbxthumb://type=Asset&id=" .. id .. "&w=150&h=150"
                    end
                end)
            end
        end)
    end

    local PillTitle = New("TextLabel", {
        Parent = Pill,
        Position = UDim2.fromOffset(50, 0),
        Size = UDim2.new(1, -62, 1, 0),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = 202
    })

    -- Accent line yang lebih tipis dan rapi.
    local PillLine = New("Frame", {
        Name = "AccentLine",
        Parent = Pill,
        Position = UDim2.new(0, 44, 1, -4),
        Size = UDim2.new(1, -76, 0, 2),
        BackgroundColor3 = Theme.Accent,
        BorderSizePixel = 0,
        ZIndex = 203
    })

    Corner(PillLine, 1)

    local PillLineGradient = New("UIGradient", {
        Parent = PillLine,
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Theme.Accent),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 210, 255)),
            ColorSequenceKeypoint.new(1, Theme.Accent)
        }
    })

    -- Glow tipis di bawah accent line.
    local PillGlow = New("Frame", {
        Name = "AccentGlow",
        Parent = Pill,
        Position = UDim2.new(0, 44, 1, -3),
        Size = UDim2.new(1, -76, 0, 2),
        BackgroundColor3 = Theme.Accent,
        BackgroundTransparency = 0.75,
        BorderSizePixel = 0,
        ZIndex = 202
    })

    Corner(PillGlow, 1)

    MakeDraggable(Pill, Pill)

    local minimized = false
    local destroyed = false

    local function SetPillVisible(visible)
        Pill.Visible = visible
        PillShadow.Visible = visible
    end

    local function SyncPillShadow()
        PillShadow.Position = UDim2.new(
            Pill.Position.X.Scale,
            Pill.Position.X.Offset,
            Pill.Position.Y.Scale,
            Pill.Position.Y.Offset + 4
        )
    end

    Pill:GetPropertyChangedSignal("Position"):Connect(function()
        if Pill.Visible then
            SyncPillShadow()
        end
    end)

    -- Hover polish: stroke dan line sedikit lebih terang.
    Pill.MouseEnter:Connect(function()
        if destroyed then
            return
        end

        Tween(PillStroke, {
            Color = Theme.Accent,
            Transparency = 0.05
        }, 0.12)

        Tween(PillLine, {
            Size = UDim2.new(1, -66, 0, 2)
        }, 0.12)

        Tween(PillGlow, {
            BackgroundTransparency = 0.55
        }, 0.12)
    end)

    Pill.MouseLeave:Connect(function()
        if destroyed then
            return
        end

        Tween(PillStroke, {
            Color = Theme.Border,
            Transparency = 0
        }, 0.12)

        Tween(PillLine, {
            Size = UDim2.new(1, -76, 0, 2)
        }, 0.12)

        Tween(PillGlow, {
            BackgroundTransparency = 0.75
        }, 0.12)
    end)

    local function SetMinimized(state, animate)
        if destroyed then
            return
        end

        minimized = state == true

        if minimized then
            Body.Visible = false

            if animate then
                Tween(Main, {
                    Size = UDim2.fromOffset(size.X.Offset, 60)
                }, 0.18)
            else
                Main.Size = UDim2.fromOffset(size.X.Offset, 60)
            end

            task.delay(0.18, function()
                if destroyed or not minimized then
                    return
                end

                Main.Visible = false
                SetPillVisible(true)
                SyncPillShadow()
            end)
        else
            SetPillVisible(false)
            Main.Visible = true
            Body.Visible = true

            if animate then
                Main.Size = UDim2.fromOffset(size.X.Offset, 60)

                Tween(Main, {
                    Size = size
                }, 0.20)
            else
                Main.Size = size
            end
        end
    end

    Minimize.MouseButton1Click:Connect(function()
        SetMinimized(not minimized, true)
    end)

    -- Seluruh pill menjadi tombol restore.
    Pill.MouseButton1Click:Connect(function()
        SetMinimized(false, true)
    end)

    Close.MouseButton1Click:Connect(function()
        if destroyed then
            return
        end

        destroyed = true
        ScreenGui:Destroy()
    end)

    --==================================================
    -- WINDOW CONTROL
    --==================================================

    function Window:SetVisible(visible)
        if destroyed then
            return
        end

        ScreenGui.Enabled = visible == true
    end

    -- Backward-compatible show/hide control.
    function Window:Toggle()
        if destroyed then
            return
        end

        ScreenGui.Enabled = not ScreenGui.Enabled
    end

    function Window:IsVisible()
        if destroyed then
            return false
        end

        return ScreenGui.Enabled
    end

    function Window:Minimize()
        SetMinimized(true, true)
    end

    function Window:Restore()
        SetMinimized(false, true)
    end

    function Window:ToggleMinimize()
        SetMinimized(not minimized, true)
    end

    function Window:IsMinimized()
        return minimized
    end

    function Window:Destroy()
        if destroyed then
            return
        end

        destroyed = true

        if ScreenGui and ScreenGui.Parent then
            ScreenGui:Destroy()
        end
    end

    --==================================================
    -- WINDOW TITLE API
    --==================================================

    function Window:SetTitle(newTitle)
        local value = tostring(newTitle)
        TitleLabel.Text = value
        PillTitle.Text = value
    end

    function Window:SetSubtitle(newSubtitle)
        SubtitleLabel.Text = tostring(newSubtitle)
    end

    function Window:SetLogo(newLogo)
        if destroyed then
            return
        end

        ApplyLogo(newLogo)
    end

    function Window:GetLogo()
        return logo
    end

    function Window:GetTitle()
        return TitleLabel.Text
    end

    function Window:GetSubtitle()
        return SubtitleLabel.Text
    end

    --==================================================
    -- CONFIG API v2.5.2
    --==================================================

    function Window:CreateConfig(name)
        local config = {}

        ConfigManager:SetActive(name or "Default")

        function config:Save()
            return ConfigManager:Save(name or "Default")
        end

        function config:Load(fireCallback)
            return ConfigManager:Load(name or "Default", fireCallback)
        end

        function config:Delete()
            return ConfigManager:Delete(name or "Default")
        end

        function config:Exists()
            return ConfigManager:Exists(name or "Default")
        end


        function config:GetName()
            return name or "Default"
        end

        function config:SetName(newName)
            name = tostring(newName or "Default")
            ConfigManager:SetActive(name)
            return name
        end

        function config:List()
            return ConfigManager:List()
        end

        function config:GetValues()
            return ConfigManager:Collect()
        end

        return config
    end


    function Window:RegisterConfig(id, controlType, control)
        return ConfigManager:Register(id, controlType, control)
    end

    function Window:SaveConfig(name)
        local ok, result = ConfigManager:Save(name)

        if ok and Window.Notify then
            Window:Notify({
                Title = "Config Saved",
                Content = tostring(name or ConfigManager:GetActive())
                    .. " berhasil disimpan.",
                Duration = 2
            })
        end

        return ok, result
    end

    function Window:LoadConfig(name, fireCallback)
        local ok, result = ConfigManager:Load(name, fireCallback)

        if ok and Window.Notify then
            Window:Notify({
                Title = "Config Loaded",
                Content = tostring(name or ConfigManager:GetActive())
                    .. " berhasil dimuat.",
                Duration = 2
            })
        end

        return ok, result
    end

    function Window:DeleteConfig(name)
        return ConfigManager:Delete(name)
    end

    function Window:ConfigExists(name)
        return ConfigManager:Exists(name)
    end

    function Window:ListConfigs()
        return ConfigManager:List()
    end

    function Window:GetActiveConfig()
        return ConfigManager:GetActive()
    end

    function Window:SetActiveConfig(name)
        return ConfigManager:SetActive(name)
    end

    function Window:GetConfigValues()
        return ConfigManager:Collect()
    end

    function Window:GetRegisteredConfigs()
        return ConfigManager:GetRegistered()
    end

    function Window:CreateTab(options)
        options = options or {}

        LoadingManager:UpdateBootstrap("Creating tabs...")
        LoadingManager:ProcessComponent("Tab")

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

        -- Tab hover hanya memengaruhi tab yang sedang diarahkan cursor.
        -- Background active/selected tidak pernah ditimpa oleh hover.
        TabButton.MouseEnter:Connect(function()
            local isSelected = false

            for _, data in ipairs(pages) do
                if data.Button == TabButton and data.Page.Visible then
                    isSelected = true
                    break
                end
            end

            if not isSelected then
                Tween(TabButton, {
                    BackgroundColor3 = Color3.fromRGB(20, 55, 95)
                }, 0.12)
            end
        end)

        TabButton.MouseLeave:Connect(function()
            local isSelected = false

            for _, data in ipairs(pages) do
                if data.Button == TabButton and data.Page.Visible then
                    isSelected = true
                    break
                end
            end

            if not isSelected then
                Tween(TabButton, {
                    BackgroundColor3 = Theme.Tertiary
                }, 0.12)
            end
        end)

        local Page = New("ScrollingFrame", {
            Parent = Content,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Theme.Accent,
            ScrollBarImageTransparency = 0.15,
            CanvasSize = UDim2.new(),
            AutomaticCanvasSize = Enum.AutomaticSize.None,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            ScrollingEnabled = true,
            Active = true,
            ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,
            Visible = false
        })

        Padding(Page, 15, 15, 15, 20)

        local Layout = New("UIListLayout", {
            Parent = Page,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 10)
        })

        local function UpdatePageCanvas()
            Page.CanvasSize = UDim2.fromOffset(
                0,
                Layout.AbsoluteContentSize.Y + 20
            )
        end

        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdatePageCanvas)
        task.defer(UpdatePageCanvas)

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

            -- Selected state selalu menjadi prioritas atas hover.
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
            LoadingManager:ProcessComponent("Section")

            local Section = New("Frame", {
                Parent = Page,
                Size = UDim2.new(1, 0, 0, 55),
                BackgroundColor3 = Theme.Secondary,
                BorderSizePixel = 0,
                ClipsDescendants = true
            })

            Corner(Section, 7)
            Stroke(Section)

            local SectionTitle = New("TextLabel", {
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

            local SectionHeader = New("TextButton", {
                Parent = Section,
                Position = UDim2.fromOffset(0, 0),
                Size = UDim2.new(1, 0, 0, 45),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Text = "",
                AutoButtonColor = false,
                ZIndex = 5
            })

            local SectionArrow = New("TextLabel", {
                Parent = SectionHeader,
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -12, 0.5, 0),
                Size = UDim2.fromOffset(20, 20),
                BackgroundTransparency = 1,
                Text = "−",
                TextColor3 = Theme.SubText,
                Font = Enum.Font.GothamBold,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center,
                ZIndex = 6
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

            local collapsed = false

            local function UpdateSectionSize(animate)
                local contentHeight = collapsed and 0 or ElementLayout.AbsoluteContentSize.Y

                local targetElementsSize = UDim2.new(
                    1,
                    -20,
                    0,
                    contentHeight
                )

                local targetSectionSize = UDim2.new(
                    1,
                    0,
                    0,
                    collapsed and 45 or (55 + contentHeight)
                )

                if animate then
                    Tween(Elements, {Size = targetElementsSize}, 0.18)
                    Tween(Section, {Size = targetSectionSize}, 0.18)
                    Tween(SectionArrow, {
                        Rotation = collapsed and 0 or 0
                    }, 0.18)
                else
                    Elements.Size = targetElementsSize
                    Section.Size = targetSectionSize
                end

                SectionArrow.Text = collapsed and "+" or "−"
            end

            ElementLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                if not collapsed then
                    UpdateSectionSize(false)
                end
            end)

            local SectionAPI = {}

            function SectionAPI:SetCollapsed(value)
                collapsed = value == true
                UpdateSectionSize(true)
            end

            function SectionAPI:Toggle()
                SectionAPI:SetCollapsed(not collapsed)
            end

            function SectionAPI:IsCollapsed()
                return collapsed
            end

            SectionHeader.MouseButton1Click:Connect(function()
                SectionAPI:Toggle()
            end)

            AddHover(
                SectionHeader,
                Theme.Secondary,
                Color3.fromRGB(20, 55, 95)
            )

            task.defer(function()
                if not collapsed then
                    UpdateSectionSize(false)
                end
            end)

            function SectionAPI:CreateLabel(text)
            LoadingManager:ProcessComponent("Label")
                local Label = New("TextLabel", {
                    Parent = Elements,
                    Size = UDim2.new(1, 0, 0, 28),
                    BackgroundTransparency = 1,
                    Text = tostring(text or ""),
                    TextColor3 = Theme.Text,
                    Font = Enum.Font.GothamMedium,
                    TextSize = 12,
                    TextWrapped = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Center
                })
                return Label
            end

            function SectionAPI:CreateParagraph(options)
            LoadingManager:ProcessComponent("Paragraph")
                options = options or {}

                local Paragraph = New("Frame", {
                    Parent = Elements,
                    Size = UDim2.new(1, 0, 0, 65),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0
                })

                Corner(Paragraph, 6)
                Stroke(Paragraph, Theme.Border, 1)

                New("TextLabel", {
                    Parent = Paragraph,
                    Position = UDim2.fromOffset(12, 7),
                    Size = UDim2.new(1, -24, 0, 18),
                    BackgroundTransparency = 1,
                    Text = options.Title or "Information",
                    TextColor3 = Theme.Text,
                    Font = Enum.Font.GothamBold,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left
                })

                local Content = New("TextLabel", {
                    Parent = Paragraph,
                    Position = UDim2.fromOffset(12, 28),
                    Size = UDim2.new(1, -24, 0, 30),
                    BackgroundTransparency = 1,
                    Text = options.Content or "",
                    TextColor3 = Theme.SubText,
                    Font = Enum.Font.Gotham,
                    TextSize = 11,
                    TextWrapped = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top
                })

                local API = {}

                function API:SetTitle(title)
                    local titleLabel = Paragraph:FindFirstChildWhichIsA("TextLabel")
                    if titleLabel then
                        titleLabel.Text = tostring(title)
                    end
                end

                function API:SetContent(content)
                    Content.Text = tostring(content)
                end

                function API:Set(text)
                    Content.Text = tostring(text)
                end

                return API
            end

            function SectionAPI:CreateDivider()
            LoadingManager:ProcessComponent("Divider")
                local Divider = New("Frame", {
                    Parent = Elements,
                    Size = UDim2.new(1, 0, 0, 1),
                    BackgroundColor3 = Theme.Border,
                    BorderSizePixel = 0
                })
                return Divider
            end

            function SectionAPI:CreateStatusBox(options)
            LoadingManager:ProcessComponent("StatusBox")
                options = options or {}

                local status = string.lower(options.Type or "info")
                local statusColor = Theme.Accent

                if status == "success" then
                    statusColor = Theme.Success
                elseif status == "warning" then
                    statusColor = Theme.Warning
                elseif status == "error" then
                    statusColor = Theme.Error
                end

                local Box = New("Frame", {
                    Parent = Elements,
                    Size = UDim2.new(1, 0, 0, 62),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0
                })

                Corner(Box, 6)
                Stroke(Box)

                local Accent = New("Frame", {
                    Parent = Box,
                    Position = UDim2.fromOffset(0, 7),
                    Size = UDim2.fromOffset(3, 48),
                    BackgroundColor3 = statusColor,
                    BorderSizePixel = 0
                })

                Corner(Accent, 3)

                local Title = New("TextLabel", {
                    Parent = Box,
                    Position = UDim2.fromOffset(13, 7),
                    Size = UDim2.new(1, -25, 0, 18),
                    BackgroundTransparency = 1,
                    Text = options.Title or string.upper(status),
                    TextColor3 = statusColor,
                    Font = Enum.Font.GothamBold,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left
                })

                local Content = New("TextLabel", {
                    Parent = Box,
                    Position = UDim2.fromOffset(13, 28),
                    Size = UDim2.new(1, -25, 0, 27),
                    BackgroundTransparency = 1,
                    Text = options.Content or "",
                    TextColor3 = Theme.SubText,
                    Font = Enum.Font.Gotham,
                    TextSize = 11,
                    TextWrapped = true,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top
                })

                local API = {}

                function API:SetTitle(title)
                    Title.Text = tostring(title)
                end

                function API:SetContent(content)
                    Content.Text = tostring(content)
                end

                function API:SetType(newType)
                    local newStatus = string.lower(newType or "info")
                    local newColor = Theme.Accent

                    if newStatus == "success" then
                        newColor = Theme.Success
                    elseif newStatus == "warning" then
                        newColor = Theme.Warning
                    elseif newStatus == "error" then
                        newColor = Theme.Error
                    end

                    Accent.BackgroundColor3 = newColor
                    Title.TextColor3 = newColor
                end

                return API
            end

            function SectionAPI:CreateButton(options)
            LoadingManager:ProcessComponent("Button")
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

                Button.MouseButton1Click:Connect(function()
                    if options.Callback then
                        task.spawn(options.Callback)
                    end
                end)

                AddHover(
                    Button,
                    Theme.Tertiary,
                    Color3.fromRGB(22, 58, 98)
                )

                AddPressAnimation(
                    Button,
                    Theme.Tertiary,
                    Color3.fromRGB(28, 92, 145)
                )

                return Button
            end

            function SectionAPI:CreateToggle(options)
            LoadingManager:ProcessComponent("Toggle")
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

                AddHover(
                    Button,
                    Theme.Tertiary,
                    Color3.fromRGB(20, 55, 95)
                )

                local TitleLabel = New("TextLabel", {
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

                function API:Set(value, fireCallback)
                    enabled = value == true
                    Tween(Switch, {
                        BackgroundColor3 = enabled and Theme.Accent or Theme.Background
                    }, 0.15)

                    Tween(Circle, {
                        Position = enabled
                            and UDim2.new(1, -17, 0.5, -7)
                            or UDim2.fromOffset(3, 3)
                    }, 0.15)

                    if fireCallback ~= false and options.Callback then
                        task.spawn(options.Callback, enabled)
                    end
                end

                function API:Get()
                    return enabled
                end
                function API:SetTitle(newTitle)
                    TitleLabel.Text = tostring(newTitle or "")
                end

                function API:SetVisible(visible)
                    Button.Visible = visible == true
                end

                if options.ConfigIgnore ~= true then
                    ConfigManager:Register(
                    options.Id or options.Name,
                    "Toggle",
                    API
                )
                end

                return API
            end

            function SectionAPI:CreateInput(options)
            LoadingManager:ProcessComponent("Input")
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

                if options.ConfigIgnore ~= true then
                    ConfigManager:Register(
                    options.Id or options.Name,
                    "Input",
                    Box
                )
                end

                return Box
            end

            function SectionAPI:CreateDropdown(options)
            LoadingManager:ProcessComponent("Dropdown")
            options = options or {}

            local values = options.Values or {}
            local multi = options.Multi == true
            local useSearch = options.Search ~= false
            local selected = multi and nil or (options.Default or values[1])
            local selectedMap = {}
            local opened = false
            local optionObjects = {}
            local searchQuery = ""
            local maxSelected = tonumber(options.MaxSelected)

            local Holder
            local Button
            local TitleLabel
            local ValueLabel
            local List
            local SearchBox
            local ListLayout

            local function IsSelected(item)
                return selectedMap[item] == true
            end

            local function GetSelectedList()
                local result = {}

                for _, item in ipairs(values) do
                    if selectedMap[item] then
                        table.insert(result, item)
                    end
                end

                return result
            end

            local function SetSelected(item, state)
                if state then
                    selectedMap[item] = true
                else
                    selectedMap[item] = nil
                end
            end

            -- Default values
            if multi then
                local defaults = options.Default

                if type(defaults) == "table" then
                    for _, item in ipairs(defaults) do
                        for _, valid in ipairs(values) do
                            if valid == item then
                                SetSelected(item, true)
                                break
                            end
                        end
                    end
                elseif defaults ~= nil then
                    for _, valid in ipairs(values) do
                        if valid == defaults then
                            SetSelected(defaults, true)
                            break
                        end
                    end
                end
            elseif selected ~= nil then
                SetSelected(selected, true)
            end

            Holder = New("Frame", {
                Parent = Elements,
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundTransparency = 1
            })

            Button = New("TextButton", {
                Parent = Holder,
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundColor3 = Theme.Tertiary,
                BorderSizePixel = 0,
                Text = "",
                AutoButtonColor = false,
                ZIndex = 5
            })
            Corner(Button, 6)

            AddHover(
                Button,
                Theme.Tertiary,
                Color3.fromRGB(20, 55, 95)
            )

            TitleLabel = New("TextLabel", {
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

            ValueLabel = New("TextLabel", {
                Parent = Button,
                Position = UDim2.new(0.5, 0, 0, 0),
                Size = UDim2.new(0.5, -12, 1, 0),
                BackgroundTransparency = 1,
                Text = "Select",
                TextColor3 = Theme.Accent,
                Font = Enum.Font.GothamMedium,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Right,
                TextTruncate = Enum.TextTruncate.AtEnd,
                ZIndex = 6
            })

            List = New("Frame", {
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

            local topPadding = 5
            local bottomPadding = 5
            local itemGap = 3
            local searchHeight = useSearch and 32 or 0

            if useSearch then
                SearchBox = New("TextBox", {
                    Parent = List,
                    Size = UDim2.new(1, -10, 0, 32),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Text = "",
                    PlaceholderText = options.SearchPlaceholder or "Search...",
                    PlaceholderColor3 = Theme.SubText,
                    TextColor3 = Theme.Text,
                    Font = Enum.Font.Gotham,
                    TextSize = 11,
                    ClearTextOnFocus = false,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    LayoutOrder = 1,
                    ZIndex = 22
                })
                Corner(SearchBox, 5)

                New("UIPadding", {
                    Parent = SearchBox,
                    PaddingLeft = UDim.new(0, 10),
                    PaddingRight = UDim.new(0, 10)
                })
            end

            ListLayout = New("UIListLayout", {
                Parent = List,
                Padding = UDim.new(0, itemGap),
                SortOrder = Enum.SortOrder.LayoutOrder
            })

            local function RefreshSize()
                if not ListLayout then
                    return
                end

                local contentHeight = ListLayout.AbsoluteContentSize.Y + topPadding + bottomPadding

                List.Size = UDim2.new(
                    1,
                    0,
                    0,
                    math.max(contentHeight, 0)
                )
            end

            local function UpdateDisplay()
                if multi then
                    local result = GetSelectedList()

                    if #result == 0 then
                        ValueLabel.Text = "Select"
                    elseif #result <= 2 then
                        local display = {}

                        for _, item in ipairs(result) do
                            table.insert(display, tostring(item))
                        end

                        ValueLabel.Text = table.concat(display, ", ")
                    else
                        ValueLabel.Text = tostring(#result) .. " selected"
                    end
                else
                    ValueLabel.Text = tostring(selected or "Select")
                end
            end

            local function RefreshOption(item)
                local data = optionObjects[item]

                if not data then
                    return
                end

                local selectedState = IsSelected(item)

                if selectedState then
                    data.Option.BackgroundColor3 = Theme.Background
                    data.Label.TextColor3 = Theme.Accent
                    data.Mark.Text = "✓"
                    data.Mark.TextColor3 = Theme.Accent
                    data.OptionStroke.Enabled = true
                    data.OptionStroke.Color = Theme.Accent
                else
                    data.Option.BackgroundColor3 = Theme.Tertiary
                    data.Label.TextColor3 = Theme.Text
                    data.Mark.Text = ""
                    data.Mark.TextColor3 = Theme.Text
                    data.OptionStroke.Enabled = false
                end
            end

            local function UpdateSearch()
                if not useSearch or not SearchBox then
                    return
                end

                searchQuery = string.lower(SearchBox.Text or "")

                for _, item in ipairs(values) do
                    local data = optionObjects[item]

                    if data then
                        local itemText = string.lower(tostring(item))

                        data.Option.Visible =
                            searchQuery == ""
                            or string.find(itemText, searchQuery, 1, true) ~= nil
                    end
                end

                task.defer(RefreshSize)
            end

            local function CreateOption(item, index)
                if optionObjects[item] then
                    return optionObjects[item]
                end

                local Option = New("TextButton", {
                    Parent = List,
                    Size = UDim2.new(1, -10, 0, 30),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Text = "",
                    AutoButtonColor = false,
                    LayoutOrder = (index or #values) + 1,
                    ZIndex = 21
                })
                Corner(Option, 5)

                local OptionStroke = Stroke(Option)
                OptionStroke.Enabled = false
                OptionStroke.Thickness = 1

                local Mark = New("TextLabel", {
                    Parent = Option,
                    Position = UDim2.fromOffset(8, 0),
                    Size = UDim2.fromOffset(22, 30),
                    BackgroundTransparency = 1,
                    Text = "",
                    TextColor3 = Theme.Accent,
                    Font = Enum.Font.GothamBold,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    ZIndex = 22
                })

                local OptionLabel = New("TextLabel", {
                    Parent = Option,
                    Position = UDim2.fromOffset(34, 0),
                    Size = UDim2.new(1, -42, 1, 0),
                    BackgroundTransparency = 1,
                    Text = tostring(item),
                    TextColor3 = Theme.Text,
                    Font = Enum.Font.Gotham,
                    TextSize = 11,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ZIndex = 22
                })

                optionObjects[item] = {
                    Option = Option,
                    Mark = Mark,
                    Label = OptionLabel,
                    OptionStroke = OptionStroke
                }

                RefreshOption(item)

                Option.MouseEnter:Connect(function()
                    if not IsSelected(item) then
                        Tween(OptionLabel, {
                            TextColor3 = Theme.Accent
                        }, 0.10)
                    end
                end)

                Option.MouseLeave:Connect(function()
                    if not IsSelected(item) then
                        Tween(OptionLabel, {
                            TextColor3 = Theme.Text
                        }, 0.10)
                    end
                end)

                Option.MouseButton1Click:Connect(function()
                    if multi then
                        local currentlySelected = IsSelected(item)

                        if not currentlySelected
                            and maxSelected
                            and #GetSelectedList() >= maxSelected then
                            if options.MaxSelectedCallback then
                                task.spawn(options.MaxSelectedCallback, maxSelected)
                            end
                            return
                        end

                        SetSelected(item, not currentlySelected)
                        RefreshOption(item)
                        UpdateDisplay()

                        if options.Callback then
                            task.spawn(options.Callback, GetSelectedList())
                        end

                        return
                    end

                    selected = item
                    selectedMap = {}
                    SetSelected(item, true)

                    for _, value in ipairs(values) do
                        RefreshOption(value)
                    end

                    UpdateDisplay()

                    opened = false
                    List.Visible = false

                    Tween(Holder, {
                        Size = UDim2.new(1, 0, 0, 40)
                    }, 0.16)

                    Tween(List, {
                        Size = UDim2.new(1, 0, 0, 0)
                    }, 0.16)

                    task.delay(0.17, function()
                        if not opened then
                            List.Visible = false
                        end
                    end)

                    if options.Callback then
                        task.spawn(options.Callback, selected)
                    end
                end)

                return optionObjects[item]
            end

            for index, item in ipairs(values) do
                CreateOption(item, index)
            end

            if useSearch and SearchBox then
                SearchBox:GetPropertyChangedSignal("Text"):Connect(UpdateSearch)
            end

            ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(RefreshSize)

            local function CloseDropdown()
                opened = false

                Tween(Holder, {
                    Size = UDim2.new(1, 0, 0, 40)
                }, 0.16)

                Tween(List, {
                    Size = UDim2.new(1, 0, 0, 0)
                }, 0.16)

                task.delay(0.17, function()
                    if not opened then
                        List.Visible = false
                    end
                end)
            end

            Button.MouseButton1Click:Connect(function()
                if opened then
                    CloseDropdown()
                    return
                end

                opened = true
                List.Visible = true

                if useSearch and SearchBox then
                    UpdateSearch()
                end

                task.defer(function()
                    if not opened then
                        return
                    end

                    RefreshSize()

                    local targetHeight = List.AbsoluteSize.Y

                    List.Size = UDim2.new(1, 0, 0, 0)

                    Tween(List, {
                        Size = UDim2.new(1, 0, 0, targetHeight)
                    }, 0.18)

                    Tween(Holder, {
                        Size = UDim2.new(
                            1,
                            0,
                            0,
                            45 + targetHeight
                        )
                    }, 0.18)
                end)
            end)

            UpdateDisplay()

            for _, item in ipairs(values) do
                RefreshOption(item)
            end

            local API = {}

            function API:Set(value, fireCallback)
                self:SetValue(value, fireCallback)
            end

            function API:Get()
                return self:GetValue()
            end

            function API:SetVisible(visible)
                Holder.Visible = visible == true
            end

            function API:SetTitle(newTitle)
                TitleLabel.Text = tostring(newTitle or "")
            end

            function API:IsMulti()
                return multi
            end

            function API:GetValue()
                if multi then
                    return GetSelectedList()
                end

                return selected
            end

            function API:SetValue(newValue, fireCallback)
                if multi then
                    local wanted = type(newValue) == "table" and newValue or {newValue}
                    selectedMap = {}

                    for _, value in ipairs(wanted) do
                        if maxSelected and #GetSelectedList() >= maxSelected then
                            break
                        end

                        for _, item in ipairs(values) do
                            if item == value then
                                SetSelected(item, true)
                                break
                            end
                        end
                    end

                    for _, item in ipairs(values) do
                        RefreshOption(item)
                    end

                    UpdateDisplay()

                    if fireCallback ~= false and options.Callback then
                        task.spawn(options.Callback, GetSelectedList())
                    end
                else
                    for _, item in ipairs(values) do
                        if item == newValue then
                            selected = item
                            selectedMap = {[item] = true}

                            for _, value in ipairs(values) do
                                RefreshOption(value)
                            end

                            UpdateDisplay()

                            if fireCallback ~= false and options.Callback then
                                task.spawn(options.Callback, selected)
                            end

                            break
                        end
                    end
                end
            end

            function API:SelectAll(fireCallback)
                if not multi then
                    return
                end

                selectedMap = {}

                local limit = maxSelected or #values
                local count = 0

                for _, item in ipairs(values) do
                    if count >= limit then
                        break
                    end

                    SetSelected(item, true)
                    count = count + 1
                end

                for _, item in ipairs(values) do
                    RefreshOption(item)
                end

                UpdateDisplay()

                if fireCallback ~= false and options.Callback then
                    task.spawn(options.Callback, GetSelectedList())
                end
            end

            function API:DeselectAll(fireCallback)
                if not multi then
                    return
                end

                selectedMap = {}

                for _, item in ipairs(values) do
                    RefreshOption(item)
                end

                UpdateDisplay()

                if fireCallback ~= false and options.Callback then
                    task.spawn(options.Callback, {})
                end
            end

            function API:ClearSelection(fireCallback)
                self:DeselectAll(fireCallback)
            end

            function API:GetMaxSelected()
                return maxSelected
            end

            function API:SetMaxSelected(limit)
                if not multi then
                    return
                end

                if limit == nil then
                    maxSelected = nil
                else
                    limit = tonumber(limit)

                    if not limit or limit < 1 then
                        return
                    end

                    maxSelected = math.floor(limit)
                end

                local current = GetSelectedList()

                if maxSelected and #current > maxSelected then
                    selectedMap = {}

                    for index, item in ipairs(current) do
                        if index > maxSelected then
                            break
                        end
                        SetSelected(item, true)
                    end

                    for _, item in ipairs(values) do
                        RefreshOption(item)
                    end

                    UpdateDisplay()
                end
            end

            function API:AddOption(item)
                if item == nil or optionObjects[item] then
                    return false
                end

                table.insert(values, item)
                CreateOption(item, #values)
                RefreshOption(item)
                task.defer(RefreshSize)
                return true
            end

            function API:RemoveOption(item)
                local data = optionObjects[item]

                if not data then
                    return false
                end

                if selectedMap[item] then
                    selectedMap[item] = nil
                end

                if selected == item then
                    selected = nil
                end

                data.Option:Destroy()
                optionObjects[item] = nil

                for index, value in ipairs(values) do
                    if value == item then
                        table.remove(values, index)
                        break
                    end
                end

                for index, value in ipairs(values) do
                    local option = optionObjects[value]
                    if option then
                        option.Option.LayoutOrder = index + 1
                    end
                end

                UpdateDisplay()
                task.defer(RefreshSize)
                return true
            end

            function API:SetValues(newValues, fireCallback)
                if type(newValues) ~= "table" then
                    return
                end

                values = {}
                selectedMap = {}
                selected = nil
                optionObjects = {}

                for _, child in ipairs(List:GetChildren()) do
                    if child:IsA("TextButton") then
                        child:Destroy()
                    end
                end

                for index, item in ipairs(newValues) do
                    if item ~= nil and not optionObjects[item] then
                        table.insert(values, item)
                    end
                end

                for index, item in ipairs(values) do
                    CreateOption(item, index)
                end

                if multi then
                    -- Re-apply only defaults that are still valid.
                    local defaults = options.Default
                    local defaultList = type(defaults) == "table" and defaults or {defaults}

                    for _, item in ipairs(defaultList) do
                        for _, valid in ipairs(values) do
                            if valid == item then
                                if not maxSelected or #GetSelectedList() < maxSelected then
                                    SetSelected(item, true)
                                end
                                break
                            end
                        end
                    end
                elseif options.Default ~= nil then
                    for _, item in ipairs(values) do
                        if item == options.Default then
                            selected = item
                            SetSelected(item, true)
                            break
                        end
                    end
                end

                UpdateDisplay()

                for _, item in ipairs(values) do
                    RefreshOption(item)
                end

                if useSearch and SearchBox then
                    UpdateSearch()
                end

                task.defer(RefreshSize)

                if fireCallback ~= false and options.Callback then
                    task.spawn(
                        options.Callback,
                        multi and GetSelectedList() or selected
                    )
                end
            end

            function API:Clear(fireCallback)
                selected = nil
                selectedMap = {}

                if useSearch and SearchBox then
                    SearchBox.Text = ""
                end

                for _, item in ipairs(values) do
                    RefreshOption(item)
                end

                UpdateDisplay()

                if fireCallback and options.Callback then
                    task.spawn(options.Callback, multi and {} or nil)
                end
            end

            function API:SetSearch(text)
                if useSearch and SearchBox then
                    SearchBox.Text = tostring(text or "")
                end
            end

            function API:GetSearch()
                if useSearch and SearchBox then
                    return SearchBox.Text
                end

                return ""
            end

            function API:ClearSearch()
                if useSearch and SearchBox then
                    SearchBox.Text = ""
                end
            end

            if options.ConfigIgnore ~= true then
                ConfigManager:Register(
                    options.Id or options.Name,
                    "Dropdown",
                    API
                )
            end

            return API
        end

        function Tab:CreateConfigManager(options)
            LoadingManager:ProcessComponent("ConfigManager")
            options = options or {}

            local defaultName = tostring(options.DefaultName or "Default")

            local managerSection = Tab:CreateSection(options.SectionName or "Configuration")
            local nameInput = managerSection:CreateInput({
                Name = options.NameInput or "Config Name",
                Placeholder = options.Placeholder or "Enter config name...",
                Default = defaultName,
                ConfigIgnore = true
            })

            local selectedName = defaultName

            local configDropdown = managerSection:CreateDropdown({
                Name = options.SelectorName or "Available Configs",
                Values = {},
                Default = nil,
                Search = options.Search ~= false,
                ConfigIgnore = true,

                Callback = function(value)
                    if type(value) == "table" then
                        value = value[1]
                    end

                    if value ~= nil and tostring(value) ~= "" then
                        selectedName = tostring(value)
                        nameInput.Text = selectedName
                    end
                end
            })

            local function Notify(title, content)
                if Window.Notify then
                    Window:Notify({
                        Title = title,
                        Content = content,
                        Duration = 2
                    })
                end
            end

            local function Refresh()
                local configs = ConfigManager:List()

                configDropdown:SetValues(configs, false)

                if #configs > 0 then
                    local wanted = selectedName
                    local found = false

                    for _, configName in ipairs(configs) do
                        if configName == wanted then
                            configDropdown:SetValue(configName, false)
                            nameInput.Text = configName
                            found = true
                            break
                        end
                    end

                    if not found then
                        selectedName = configs[1]
                        nameInput.Text = selectedName
                        configDropdown:SetValue(selectedName, false)
                    end
                else
                    selectedName = defaultName
                    nameInput.Text = defaultName
                end

                return configs
            end

            configDropdown:SetValue(defaultName, false)

            configDropdown = configDropdown

            -- Selecting an existing config updates the name field.
            local originalSelectorCallback = options.SelectCallback

            -- Use a separate lightweight selector listener through a wrapper
            -- API exposed by the returned manager. The dropdown itself is also
            -- returned to the caller for direct access.
            local function GetName()
                local text = tostring(nameInput.Text or "")

                if text == "" then
                    return selectedName ~= "" and selectedName or defaultName
                end

                selectedName = text
                return text
            end

            managerSection:CreateButton({
                Name = options.SaveText or "Save Config",
                ConfigIgnore = true,
                Callback = function()
                    local name = GetName()
                    selectedName = name

                    local ok, result = ConfigManager:Save(name)

                    if ok then
                        selectedName = name
                        nameInput.Text = name
                        Refresh()
                        configDropdown:SetValue(name, false)
                        Notify("Config Saved", name .. " berhasil disimpan.")
                    else
                        Notify("Config Error", tostring(result))
                    end
                end
            })

            managerSection:CreateButton({
                Name = options.LoadText or "Load Config",
                ConfigIgnore = true,
                Callback = function()
                    local name = GetName()
                    selectedName = name

                    local ok, result = ConfigManager:Load(name, false)

                    if ok then
                        Notify("Config Loaded", name .. " berhasil dimuat.")
                    else
                        Notify("Config Error", tostring(result))
                    end
                end
            })

            managerSection:CreateButton({
                Name = options.DeleteText or "Delete Config",
                ConfigIgnore = true,
                Callback = function()
                    local name = GetName()
                    local ok, result = ConfigManager:Delete(name)

                    if ok then
                        selectedName = ""
                        local configs = Refresh()

                        if #configs > 0 then
                            selectedName = configs[1]
                            nameInput.Text = selectedName
                            configDropdown:SetValue(selectedName, false)
                        end

                        Notify("Config Deleted", name .. " berhasil dihapus.")
                    else
                        Notify("Config Error", tostring(result))
                    end
                end
            })

            managerSection:CreateButton({
                Name = options.RefreshText or "Refresh Configs",
                ConfigIgnore = true,
                Callback = function()
                    local configs = Refresh()
                    Notify("Config List", tostring(#configs) .. " config tersedia.")
                end
            })


            Refresh()

            if options.AutoLoad == true then
                task.defer(function()
                    ConfigManager:StartAutoLoad(
                        options.AutoLoadName or defaultName,
                        false
                    )
                end)
            end

            if options.AutoSave == true then
                ConfigManager:StartAutoSave()
            end

            local API = {}

            function API:Refresh()
                return Refresh()
            end

            function API:Save(name)
                name = tostring(name or GetName())
                nameInput.Text = name
                selectedName = name
                return ConfigManager:Save(name)
            end

            function API:Load(name, fireCallback)
                name = tostring(name or GetName())
                nameInput.Text = name
                selectedName = name
                return ConfigManager:Load(name, fireCallback)
            end

            function API:Delete(name)
                name = tostring(name or GetName())
                local ok, result = ConfigManager:Delete(name)
                Refresh()
                return ok, result
            end

            function API:Exists(name)
                return ConfigManager:Exists(name or GetName())
            end

            function API:List()
                return ConfigManager:List()
            end

            function API:GetName()
                return GetName()
            end

            function API:SetName(name)
                name = tostring(name or defaultName)
                selectedName = name
                nameInput.Text = name
                return name
            end

            function API:GetSelector()
                return configDropdown
            end

            function API:GetInput()
                return nameInput
            end

            function API:GetGameId()
                return ConfigManager:GetGameId()
            end

            function API:GetGameName()
                return ConfigManager:GetGameName()
            end

            function API:GetGameFolder()
                return ConfigManager:GetGameFolder()
            end

            function API:GetConfigFolder()
                return ConfigManager:GetConfigFolder()
            end

            return API
        end

        function SectionAPI:CreateKeybind(options)
            LoadingManager:ProcessComponent("Keybind")
                options = options or {}

                local CurrentKey = options.Default or Enum.KeyCode.RightShift

                local Holder = New("TextButton", {
                    Parent = Elements,
                    Size = UDim2.new(1, 0, 0, 42),
                    BackgroundColor3 = Theme.Tertiary,
                    BorderSizePixel = 0,
                    Text = "",
                    AutoButtonColor = false
                })

                Corner(Holder, 6)

                New("TextLabel", {
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

                local KeyLabel = New("TextLabel", {
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

                Corner(KeyLabel, 5)

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

                if options.ConfigIgnore ~= true then
                    ConfigManager:Register(
                    options.Id or options.Name,
                    "Keybind",
                    API
                )
                end

                return API
            end
        function SectionAPI:CreateSlider(options)
            LoadingManager:ProcessComponent("Slider")
            options = options or {}

            local minimum = tonumber(options.Min or options.Minimum or 0) or 0
            local maximum = tonumber(options.Max or options.Maximum or 100) or 100
            local step = tonumber(options.Step or 1) or 1
            local decimals = options.Decimals ~= nil and tonumber(options.Decimals) or nil

            if maximum < minimum then
                minimum, maximum = maximum, minimum
            end

            if step <= 0 then
                step = 1
            end

            -- Step is applied to the actual value calculation.
            -- Example: Min=0, Max=100, Step=5 -> 0,5,10,15,...100.
            local function snapValue(raw)
                raw = tonumber(raw)
                if not raw then
                    return minimum
                end

                local steps = math.floor(((raw - minimum) / step) + 0.5)
                local snapped = minimum + (steps * step)

                if decimals ~= nil then
                    local factor = 10 ^ math.max(0, math.floor(decimals))
                    snapped = math.floor(snapped * factor + 0.5) / factor
                end

                return math.clamp(snapped, minimum, maximum)
            end

            local value = snapValue(
                options.Default ~= nil and options.Default or minimum
            )

            local Holder = New("Frame", {
                Parent = Elements,
                Size = UDim2.new(1, 0, 0, 62),
                BackgroundTransparency = 1
            })

            local Row = New("TextButton", {
                Parent = Holder,
                Size = UDim2.new(1, 0, 0, 62),
                BackgroundColor3 = Theme.Tertiary,
                BorderSizePixel = 0,
                Text = "",
                AutoButtonColor = false,
                ZIndex = 5
            })
            Corner(Row, 6)

            AddHover(
                Row,
                Theme.Tertiary,
                Color3.fromRGB(20, 55, 95)
            )

            local TitleLabel = New("TextLabel", {
                Parent = Row,
                Position = UDim2.fromOffset(12, 0),
                Size = UDim2.new(0.65, 0, 0, 30),
                BackgroundTransparency = 1,
                Text = options.Name or "Slider",
                TextColor3 = Theme.Text,
                Font = Enum.Font.GothamMedium,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 6
            })

            local ValueLabel = New("TextLabel", {
                Parent = Row,
                Position = UDim2.new(0.65, 0, 0, 0),
                Size = UDim2.new(0.35, -12, 0, 30),
                BackgroundTransparency = 1,
                TextColor3 = Theme.Accent,
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Right,
                ZIndex = 6
            })

            local Bar = New("Frame", {
                Parent = Row,
                Position = UDim2.new(0, 12, 0, 42),
                Size = UDim2.new(1, -24, 0, 6),
                BackgroundColor3 = Theme.Background,
                BorderSizePixel = 0,
                ZIndex = 6
            })
            Corner(Bar, 3)

            local Fill = New("Frame", {
                Parent = Bar,
                Size = UDim2.new(0, 0, 1, 0),
                BackgroundColor3 = Theme.Accent,
                BorderSizePixel = 0,
                ZIndex = 7
            })
            Corner(Fill, 3)

            local dragging = false
            local ignoreRowClick = false

            local function formatValue(v)
                if decimals ~= nil then
                    return string.format(
                        "%." .. math.max(0, math.floor(decimals)) .. "f",
                        v
                    )
                end

                if math.abs(v - math.floor(v)) < 0.000001 then
                    return tostring(math.floor(v))
                end

                return tostring(v)
            end

            local function updateVisual()
                local alpha

                if maximum == minimum then
                    alpha = 0
                else
                    alpha = math.clamp(
                        (value - minimum) / (maximum - minimum),
                        0,
                        1
                    )
                end

                ValueLabel.Text = formatValue(value)
                Fill.Size = UDim2.new(alpha, 0, 1, 0)
            end

            local function setValue(newValue, fireCallback)
                local oldValue = value
                value = snapValue(newValue)
                updateVisual()

                if value ~= oldValue
                    and fireCallback ~= false
                    and options.Callback then
                    task.spawn(options.Callback, value)
                end
            end

            local function valueFromX(x)
                local width = Bar.AbsoluteSize.X

                if width <= 0 then
                    return value
                end

                local alpha = math.clamp(
                    (x - Bar.AbsolutePosition.X) / width,
                    0,
                    1
                )

                return minimum + ((maximum - minimum) * alpha)
            end

            Bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch then

                    dragging = true
                    ignoreRowClick = true
                    setValue(valueFromX(input.Position.X), true)
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if not dragging then
                    return
                end

                if input.UserInputType == Enum.UserInputType.MouseMovement
                    or input.UserInputType == Enum.UserInputType.Touch then

                    setValue(valueFromX(input.Position.X), true)
                end
            end)

            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1
                    or input.UserInputType == Enum.UserInputType.Touch then

                    dragging = false

                    task.defer(function()
                        ignoreRowClick = false
                    end)
                end
            end)

            Row.MouseButton1Click:Connect(function()
                if ignoreRowClick then
                    return
                end

                local mouse = Player:GetMouse()
                setValue(valueFromX(mouse.X), true)
            end)

            local API = {}

            function API:Set(newValue, fireCallback)
                setValue(newValue, fireCallback)
            end

            function API:SetValue(newValue, fireCallback)
                setValue(newValue, fireCallback)
            end

            function API:Get()
                return value
            end

            function API:GetValue()
                return value
            end

            function API:SetMin(newMinimum, fireCallback)
                newMinimum = tonumber(newMinimum)

                if not newMinimum then
                    return
                end

                minimum = newMinimum

                if maximum < minimum then
                    maximum = minimum
                end

                setValue(value, fireCallback)
            end

            function API:SetMax(newMaximum, fireCallback)
                newMaximum = tonumber(newMaximum)

                if not newMaximum then
                    return
                end

                maximum = newMaximum

                if maximum < minimum then
                    minimum = maximum
                end

                setValue(value, fireCallback)
            end

            function API:SetStep(newStep, fireCallback)
                newStep = tonumber(newStep)

                if not newStep or newStep <= 0 then
                    return
                end

                step = newStep
                setValue(value, fireCallback)
            end

            function API:GetMin()
                return minimum
            end

            function API:GetMax()
                return maximum
            end

            function API:GetStep()
                return step
            end

            function API:SetDecimals(newDecimals, fireCallback)
                newDecimals = tonumber(newDecimals)

                if newDecimals == nil or newDecimals < 0 then
                    return
                end

                decimals = math.floor(newDecimals)
                setValue(value, fireCallback)
            end

            function API:GetDecimals()
                return decimals
            end

            function API:SetTitle(newTitle)
                TitleLabel.Text = tostring(newTitle or "")
            end

            function API:SetVisible(visible)
                Holder.Visible = visible == true
            end

            updateVisual()

            if options.ConfigIgnore ~= true then
                ConfigManager:Register(
                    options.Id or options.Name,
                    "Slider",
                    API
                )
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
            LayoutOrder = math.floor(os.clock() * 1000),
            ZIndex = 100
        })

        Corner(notification, 8)
        Stroke(notification)

        New("Frame", {
            Parent = notification,
            Position = UDim2.fromOffset(0, 8),
            Size = UDim2.fromOffset(3, 59),
            BackgroundColor3 = accent,
            BorderSizePixel = 0,
            ZIndex = 101
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
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 101
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
            TextYAlignment = Enum.TextYAlignment.Top,
            ZIndex = 101
        })

        local progress = New("Frame", {
            Parent = notification,
            Position = UDim2.new(0, 0, 1, -3),
            Size = UDim2.new(1, 0, 0, 3),
            BackgroundColor3 = accent,
            BorderSizePixel = 0,
            ZIndex = 101
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

        LoadingManager:UpdateBootstrap("Finalizing...")
    LoadingManager:UpdateBootstrap("Library initialized...")

    task.delay(0.45, function()
        if not LoadingManager.Finished and LoadingManager.ComponentCount == 0 then
            LoadingManager.CompletedCount = 0
            LoadingManager:Finish()
        end
    end)

return Window
end

return UILibrary

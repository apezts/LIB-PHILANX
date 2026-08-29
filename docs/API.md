# LIB-PHILANX UI Library --- API Documentation

**Version:** 2.8.3\
**Platform:** Roblox Studio / testing your own game\
**Language:** Luau

> Dokumentasi ini dibuat berdasarkan implementasi
> `LIB-PHILANX UI Library` yang digunakan saat ini. Nama method, option,
> return value, dan perilaku di bawah mengikuti source library tersebut.

------------------------------------------------------------------------

## 1. Quick Start

Loader library dapat digunakan seperti ini:

``` lua
local UILibrary = loadstring(game:HttpGet("YOUR_LIBRARY_URL"))()
```

Kemudian buat window:

``` lua
local Window = UILibrary:CreateWindow({
    Title = "PHILANX HUB",
    Subtitle = "Library Example",
    Size = UDim2.fromOffset(650, 450),
    Logo = "rbxassetid://132859114380485"
})
```

> `Logo` menerima asset ID maupun string asset URL yang valid. Jika
> nil/kosong, library menggunakan logo default PHILANX.

Source menyediakan `CreateWindow(options)` dan default `Title`,
`Subtitle`, `Size`, serta `Logo`.

------------------------------------------------------------------------

# 2. Library API

## `UILibrary:SetTheme(theme)`

Mengubah warna theme yang tersedia.

### Syntax

``` lua
UILibrary:SetTheme({
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
})
```

### Theme keys

  Key            Tipe
  -------------- ----------
  `Background`   `Color3`
  `Secondary`    `Color3`
  `Tertiary`     `Color3`
  `Accent`       `Color3`
  `Text`         `Color3`
  `SubText`      `Color3`
  `Border`       `Color3`
  `Success`      `Color3`
  `Warning`      `Color3`
  `Error`        `Color3`

Key yang tidak dikenal akan diabaikan.

------------------------------------------------------------------------

# 3. Window API

## `UILibrary:CreateWindow(options)`

Membuat window utama.

### Options

``` lua
local Window = UILibrary:CreateWindow({
    Title = "PHILANX HUB",
    Subtitle = "Library Example",
    Size = UDim2.fromOffset(650, 450),
    Logo = "rbxassetid://132859114380485"
})
```

  -----------------------------------------------------------------------------------
  Option            Tipe              Default                       Keterangan
  ----------------- ----------------- ----------------------------- -----------------
  `Title`           string            `"Apez UI"`                   Judul window

  `Subtitle`        string            `"UI Library"`                Subjudul

  `Size`            `UDim2`           `UDim2.fromOffset(650,450)`   Ukuran window

  `Logo`            string/number     logo default                  Logo header dan
                                                                    floating pill
  -----------------------------------------------------------------------------------

------------------------------------------------------------------------

## Window visibility

### `Window:SetVisible(visible)`

``` lua
Window:SetVisible(true)
Window:SetVisible(false)
```

Menampilkan atau menyembunyikan window.

------------------------------------------------------------------------

### `Window:Toggle()`

``` lua
Window:Toggle()
```

Membalik status visibility window.

------------------------------------------------------------------------

### `Window:IsVisible()`

``` lua
local visible = Window:IsVisible()
print(visible)
```

**Return:** `boolean`

------------------------------------------------------------------------

# 4. Window Minimize API

## `Window:Minimize()`

``` lua
Window:Minimize()
```

Meminimalkan window menjadi floating pill.

------------------------------------------------------------------------

## `Window:Restore()`

``` lua
Window:Restore()
```

Mengembalikan window dari kondisi minimize.

------------------------------------------------------------------------

## `Window:ToggleMinimize()`

``` lua
Window:ToggleMinimize()
```

Toggle antara minimize dan restore.

------------------------------------------------------------------------

## `Window:IsMinimized()`

``` lua
local minimized = Window:IsMinimized()
```

**Return:** `boolean`

------------------------------------------------------------------------

## `Window:Destroy()`

``` lua
Window:Destroy()
```

Menghapus UI.

------------------------------------------------------------------------

# 5. Window Title / Logo API

## `Window:SetTitle(title)`

``` lua
Window:SetTitle("PHILANX HUB")
```

Mengubah title window dan title floating pill.

------------------------------------------------------------------------

## `Window:SetSubtitle(subtitle)`

``` lua
Window:SetSubtitle("My Game")
```

------------------------------------------------------------------------

## `Window:SetLogo(logo)`

``` lua
Window:SetLogo("rbxassetid://123456789")
```

Mengubah logo window dan floating pill.

------------------------------------------------------------------------

## `Window:GetTitle()`

``` lua
local title = Window:GetTitle()
```

**Return:** `string`

------------------------------------------------------------------------

## `Window:GetSubtitle()`

``` lua
local subtitle = Window:GetSubtitle()
```

**Return:** `string`

------------------------------------------------------------------------

## `Window:GetLogo()`

``` lua
local logo = Window:GetLogo()
```

**Return:** `string`

------------------------------------------------------------------------

# 6. Tab API

## `Window:CreateTab(options)`

Membuat tab.

``` lua
local MainTab = Window:CreateTab({
    Name = "Main",
    Icon = "🏠"
})
```

### Options

  Option   Tipe     Keterangan
  -------- -------- ------------------------------------
  `Name`   string   Nama tab
  `Icon`   string   Icon/text yang ditampilkan di kiri

`Icon` bersifat opsional.

------------------------------------------------------------------------

# 7. Section API

## `Tab:CreateSection(name)`

``` lua
local Section = MainTab:CreateSection("Main Settings")
```

Section dapat di-collapse.

------------------------------------------------------------------------

## `Section:SetCollapsed(value)`

``` lua
Section:SetCollapsed(true)
Section:SetCollapsed(false)
```

------------------------------------------------------------------------

## `Section:Toggle()`

``` lua
Section:Toggle()
```

------------------------------------------------------------------------

## `Section:IsCollapsed()`

``` lua
local collapsed = Section:IsCollapsed()
```

**Return:** `boolean`

------------------------------------------------------------------------

# 8. Label

## `Section:CreateLabel(text)`

Membuat text label sederhana.

``` lua
Section:CreateLabel("PHILANX HUB")
```

### Return

Mengembalikan object `TextLabel`.

Contoh:

``` lua
local Label = Section:CreateLabel("Loading...")
Label.Text = "Ready!"
```

------------------------------------------------------------------------

# 9. Paragraph

## `Section:CreateParagraph(options)`

Membuat box informasi dengan title dan content.

``` lua
local Info = Section:CreateParagraph({
    Title = "Information",
    Content = "Ini adalah contoh paragraph."
})
```

### Options

  Option      Tipe     Default
  ----------- -------- -----------------
  `Title`     string   `"Information"`
  `Content`   string   `""`

### API

#### `Paragraph:SetTitle(title)`

``` lua
Info:SetTitle("Status")
```

#### `Paragraph:SetContent(content)`

``` lua
Info:SetContent("Library sudah aktif.")
```

#### `Paragraph:Set(text)`

``` lua
Info:Set("Text baru")
```

------------------------------------------------------------------------

# 10. Divider

## `Section:CreateDivider()`

``` lua
Section:CreateDivider()
```

Membuat garis pemisah horizontal.

**Return:** `Frame`

------------------------------------------------------------------------

# 11. Status Box

## `Section:CreateStatusBox(options)`

Membuat box status.

``` lua
local Status = Section:CreateStatusBox({
    Type = "success",
    Title = "Success",
    Content = "Key berhasil diverifikasi."
})
```

### Options

  Option      Tipe     Nilai
  ----------- -------- ---------------------------------------
  `Type`      string   `info`, `success`, `warning`, `error`
  `Title`     string   default berdasarkan type
  `Content`   string   `""`

### Contoh semua type

``` lua
Section:CreateStatusBox({
    Type = "info",
    Title = "INFO",
    Content = "Informasi."
})

Section:CreateStatusBox({
    Type = "success",
    Title = "SUCCESS",
    Content = "Berhasil."
})

Section:CreateStatusBox({
    Type = "warning",
    Title = "WARNING",
    Content = "Perhatian."
})

Section:CreateStatusBox({
    Type = "error",
    Title = "ERROR",
    Content = "Terjadi kesalahan."
})
```

### API

#### `StatusBox:SetTitle(title)`

``` lua
Status:SetTitle("New Title")
```

#### `StatusBox:SetContent(content)`

``` lua
Status:SetContent("New content")
```

#### `StatusBox:SetType(type)`

``` lua
Status:SetType("warning")
```

------------------------------------------------------------------------

# 12. Button

## `Section:CreateButton(options)`

``` lua
Section:CreateButton({
    Name = "Test Button",

    Callback = function()
        print("Button clicked")
    end
})
```

### Options

  Option           Tipe       Keterangan
  ---------------- ---------- -----------------------------------
  `Name`           string     Text button
  `Callback`       function   Dipanggil ketika button diklik
  `ConfigIgnore`   boolean    Jika `true`, tidak dipakai config
  `Id`             string     ID config jika diperlukan

### Callback

Button tidak mengirim argument.

``` lua
Callback = function()
    print("Clicked")
end
```

### Return

Mengembalikan `TextButton`.

------------------------------------------------------------------------

# 13. Toggle

## `Section:CreateToggle(options)`

``` lua
local AutoFarm = Section:CreateToggle({
    Name = "Auto Farm",
    Default = false,

    Callback = function(enabled)
        print("Auto Farm:", enabled)
    end
})
```

### Options

  Option           Tipe       Default
  ---------------- ---------- ------------
  `Name`           string     `"Toggle"`
  `Default`        boolean    `false`
  `Callback`       function   nil
  `Id`             string     `Name`
  `ConfigIgnore`   boolean    `false`

### Callback

``` lua
Callback = function(enabled)
    if enabled then
        print("ON")
    else
        print("OFF")
    end
end
```

### API

#### `Toggle:Set(value, fireCallback)`

``` lua
AutoFarm:Set(true)
AutoFarm:Set(false)
```

Untuk tidak menjalankan callback:

``` lua
AutoFarm:Set(true, false)
```

------------------------------------------------------------------------

#### `Toggle:Get()`

``` lua
local enabled = AutoFarm:Get()
```

**Return:** `boolean`

------------------------------------------------------------------------

#### `Toggle:SetTitle(title)`

``` lua
AutoFarm:SetTitle("Auto Farm v2")
```

------------------------------------------------------------------------

#### `Toggle:SetVisible(visible)`

``` lua
AutoFarm:SetVisible(false)
AutoFarm:SetVisible(true)
```

------------------------------------------------------------------------

# 14. Input

## `Section:CreateInput(options)`

Input adalah `TextBox`.

``` lua
local Username = Section:CreateInput({
    Placeholder = "Masukkan username...",
    Default = "",

    Callback = function(text, enterPressed)
        print(text)
        print("Enter:", enterPressed)
    end
})
```

### Options

  Option           Tipe       Default
  ---------------- ---------- -----------------------
  `Placeholder`    string     `"Enter text..."`
  `Default`        string     `""`
  `Callback`       function   nil
  `Id`             string     `Name` jika diberikan
  `ConfigIgnore`   boolean    `false`

### Callback

Callback dipanggil ketika TextBox kehilangan focus.

``` lua
Callback = function(text, enterPressed)
    print("Text:", text)
    print("Enter pressed:", enterPressed)
end
```

### Return

`CreateInput()` mengembalikan object `TextBox`.

``` lua
local Input = Section:CreateInput({
    Placeholder = "Text..."
})

Input.Text = "Hello"
print(Input.Text)
```

> Catatan: implementasi saat ini menggunakan `Box.Text` untuk
> membaca/menyimpan nilai input. Karena itu input tidak memakai API
> `Get()`/`Set()` seperti Toggle.

------------------------------------------------------------------------

# 15. Dropdown

## `Section:CreateDropdown(options)`

Dropdown mendukung:

-   Single select
-   Multi select
-   Search
-   Maximum selected item

------------------------------------------------------------------------

## 15.1 Single Dropdown

``` lua
local Mode = Section:CreateDropdown({
    Name = "Mode",

    Values = {
        "Normal",
        "Fast",
        "Extreme"
    },

    Default = "Normal",

    Multi = false,

    Search = true,

    SearchPlaceholder = "Search mode...",

    Callback = function(value)
        print("Selected:", value)
    end
})
```

### Options

  Option                Tipe          Default
  --------------------- ------------- ---------------------------
  `Name`                string        `"Dropdown"`
  `Values`              table         `{}`
  `Default`             value/table   item pertama untuk single
  `Multi`               boolean       `false`
  `Search`              boolean       `true`
  `SearchPlaceholder`   string        `"Search..."`
  `MaxSelected`         number        nil
  `Callback`            function      nil
  `Id`                  string        `Name`
  `ConfigIgnore`        boolean       `false`

------------------------------------------------------------------------

## 15.2 Multi Dropdown

``` lua
local Features = Section:CreateDropdown({
    Name = "Features",

    Values = {
        "Auto Farm",
        "Auto Collect",
        "ESP",
        "Speed"
    },

    Default = {
        "Auto Farm",
        "ESP"
    },

    Multi = true,

    MaxSelected = 3,

    Callback = function(values)
        for _, value in ipairs(values) do
            print(value)
        end
    end
})
```

Callback multi dropdown menerima table.

------------------------------------------------------------------------

## 15.3 `Dropdown:Get()`

``` lua
local value = Mode:Get()
```

Single:

``` lua
print(value)
```

Multi:

``` lua
local values = Features:Get()

for _, value in ipairs(values) do
    print(value)
end
```

------------------------------------------------------------------------

## 15.4 `Dropdown:GetValue()`

``` lua
local value = Mode:GetValue()
```

Untuk multi dropdown, return berupa table.

------------------------------------------------------------------------

## 15.5 `Dropdown:Set(value, fireCallback)`

``` lua
Mode:Set("Fast")
```

Tanpa callback:

``` lua
Mode:Set("Fast", false)
```

Untuk multi:

``` lua
Features:Set({
    "ESP",
    "Speed"
})
```

------------------------------------------------------------------------

## 15.6 `Dropdown:SetValue(value, fireCallback)`

``` lua
Mode:SetValue("Extreme")
```

Multi:

``` lua
Features:SetValue({
    "Auto Farm",
    "ESP"
})
```

------------------------------------------------------------------------

## 15.7 `Dropdown:IsMulti()`

``` lua
if Features:IsMulti() then
    print("Multi dropdown")
end
```

**Return:** `boolean`

------------------------------------------------------------------------

## 15.8 `Dropdown:SelectAll(fireCallback)`

Hanya untuk multi dropdown.

``` lua
Features:SelectAll()
```

------------------------------------------------------------------------

## 15.9 `Dropdown:DeselectAll(fireCallback)`

``` lua
Features:DeselectAll()
```

------------------------------------------------------------------------

## 15.10 `Dropdown:ClearSelection(fireCallback)`

Alias untuk `DeselectAll`.

``` lua
Features:ClearSelection()
```

------------------------------------------------------------------------

## 15.11 `Dropdown:GetMaxSelected()`

``` lua
local max = Features:GetMaxSelected()
```

------------------------------------------------------------------------

## 15.12 `Dropdown:SetMaxSelected(limit)`

``` lua
Features:SetMaxSelected(2)
```

Untuk menghapus batas:

``` lua
Features:SetMaxSelected(nil)
```

------------------------------------------------------------------------

## 15.13 `Dropdown:AddOption(item)`

``` lua
Mode:AddOption("Ultra")
```

**Return:** `true` jika berhasil, `false` jika gagal.

------------------------------------------------------------------------

## 15.14 `Dropdown:RemoveOption(item)`

``` lua
Mode:RemoveOption("Ultra")
```

**Return:** `boolean`

------------------------------------------------------------------------

## 15.15 `Dropdown:SetValues(values, fireCallback)`

Mengganti seluruh daftar option.

``` lua
Mode:SetValues({
    "Normal",
    "Fast",
    "Extreme",
    "Ultra"
})
```

------------------------------------------------------------------------

## 15.16 `Dropdown:Clear(fireCallback)`

Menghapus selection.

``` lua
Mode:Clear()
```

Multi:

``` lua
Features:Clear()
```

------------------------------------------------------------------------

## 15.17 Search API

### `Dropdown:SetSearch(text)`

``` lua
Mode:SetSearch("fast")
```

### `Dropdown:GetSearch()`

``` lua
print(Mode:GetSearch())
```

### `Dropdown:ClearSearch()`

``` lua
Mode:ClearSearch()
```

------------------------------------------------------------------------

## 15.18 Dropdown display API

### `Dropdown:SetTitle(title)`

``` lua
Mode:SetTitle("Farm Mode")
```

### `Dropdown:SetVisible(visible)`

``` lua
Mode:SetVisible(false)
Mode:SetVisible(true)
```

------------------------------------------------------------------------

# 16. Keybind

## `Section:CreateKeybind(options)`

``` lua
local ToggleKey = Section:CreateKeybind({
    Name = "Toggle UI",

    Default = Enum.KeyCode.RightShift,

    Changed = function(key)
        print("Key changed:", key.Name)
    end,

    Callback = function(key)
        print("Key pressed:", key.Name)
    end
})
```

### Options

  Option           Tipe             Keterangan
  ---------------- ---------------- -------------------------------
  `Name`           string           Nama keybind
  `Default`        `Enum.KeyCode`   Default `RightShift`
  `Changed`        function         Dipanggil saat keybind diubah
  `Callback`       function         Dipanggil saat key ditekan
  `Id`             string           ID config
  `ConfigIgnore`   boolean          Ignore config jika `true`

### API

#### `Keybind:Set(key)`

``` lua
ToggleKey:Set(Enum.KeyCode.F)
```

------------------------------------------------------------------------

#### `Keybind:Get()`

``` lua
local key = ToggleKey:Get()

print(key.Name)
```

**Return:** `Enum.KeyCode`

------------------------------------------------------------------------

### Menggunakan keybind

User dapat klik element keybind, lalu menekan keyboard key baru.

Ketika key yang tersimpan ditekan, `Callback` akan dipanggil.

``` lua
Callback = function(key)
    Window:Toggle()
end
```

------------------------------------------------------------------------

# 17. Slider

## `Section:CreateSlider(options)`

``` lua
local Speed = Section:CreateSlider({
    Name = "Speed",

    Min = 0,
    Max = 100,
    Step = 5,
    Default = 50,
    Decimals = 0,

    Callback = function(value)
        print("Speed:", value)
    end
})
```

### Options

  Option              Tipe         Default
  ------------------- ------------ ------------
  `Name`              string       `"Slider"`
  `Min` / `Minimum`   number       `0`
  `Max` / `Maximum`   number       `100`
  `Step`              number       `1`
  `Decimals`          number/nil   nil
  `Default`           number       minimum
  `Callback`          function     nil
  `Id`                string       `Name`
  `ConfigIgnore`      boolean      `false`

### Step

Contoh:

``` lua
Min = 0,
Max = 100,
Step = 5
```

Nilai yang valid:

``` text
0
5
10
15
...
100
```

------------------------------------------------------------------------

## Slider API

### `Slider:Set(value, fireCallback)`

``` lua
Speed:Set(75)
```

Tanpa callback:

``` lua
Speed:Set(75, false)
```

------------------------------------------------------------------------

### `Slider:SetValue(value, fireCallback)`

``` lua
Speed:SetValue(80)
```

------------------------------------------------------------------------

### `Slider:Get()`

``` lua
local value = Speed:Get()
```

------------------------------------------------------------------------

### `Slider:GetValue()`

``` lua
local value = Speed:GetValue()
```

------------------------------------------------------------------------

### `Slider:SetMin(minimum, fireCallback)`

``` lua
Speed:SetMin(10)
```

------------------------------------------------------------------------

### `Slider:SetMax(maximum, fireCallback)`

``` lua
Speed:SetMax(200)
```

------------------------------------------------------------------------

### `Slider:SetStep(step, fireCallback)`

``` lua
Speed:SetStep(10)
```

------------------------------------------------------------------------

### `Slider:GetMin()`

``` lua
print(Speed:GetMin())
```

------------------------------------------------------------------------

### `Slider:GetMax()`

``` lua
print(Speed:GetMax())
```

------------------------------------------------------------------------

### `Slider:GetStep()`

``` lua
print(Speed:GetStep())
```

------------------------------------------------------------------------

### `Slider:SetDecimals(decimals, fireCallback)`

``` lua
Speed:SetDecimals(2)
```

Contoh:

``` text
10.00
10.25
10.50
10.75
```

------------------------------------------------------------------------

### `Slider:GetDecimals()`

``` lua
print(Speed:GetDecimals())
```

------------------------------------------------------------------------

### `Slider:SetTitle(title)`

``` lua
Speed:SetTitle("Farm Speed")
```

------------------------------------------------------------------------

### `Slider:SetVisible(visible)`

``` lua
Speed:SetVisible(false)
Speed:SetVisible(true)
```

------------------------------------------------------------------------

# 18. Notification

## `Window:Notify(options)`

Membuat notification di kanan bawah.

``` lua
Window:Notify({
    Title = "Success",
    Content = "Setting berhasil disimpan.",
    Duration = 3
})
```

### Options

  Option       Tipe       Default
  ------------ ---------- ------------------
  `Title`      string     `"Notification"`
  `Content`    string     `""`
  `Duration`   number     `3`
  `Color`      `Color3`   Theme Accent

### Contoh warna

``` lua
Window:Notify({
    Title = "Success",
    Content = "Berhasil!",
    Duration = 3,
    Color = Color3.fromRGB(70, 215, 140)
})
```

Return berupa notification `Frame`.

------------------------------------------------------------------------

# 19. Config System

Config system terintegrasi langsung dengan component.

Component yang dapat diregistrasikan ke config:

-   Toggle
-   Input
-   Dropdown
-   Keybind
-   Slider

Button tidak memiliki state yang perlu disimpan oleh config.

Component akan otomatis didaftarkan kecuali:

``` lua
ConfigIgnore = true
```

atau tidak mempunyai ID/nama yang dapat digunakan.

------------------------------------------------------------------------

# 20. Config ID

Disarankan selalu memberikan `Id` unik.

``` lua
local AutoFarm = Section:CreateToggle({
    Name = "Auto Farm",
    Id = "AutoFarm",
    Default = false
})
```

Contoh:

``` lua
local Speed = Section:CreateSlider({
    Name = "Speed",
    Id = "FarmSpeed",
    Min = 0,
    Max = 100,
    Default = 50
})
```

Jangan menggunakan ID yang sama untuk dua component berbeda.

------------------------------------------------------------------------

# 21. Ignore Config

Untuk component yang tidak ingin disimpan:

``` lua
local Temporary = Section:CreateToggle({
    Name = "Temporary Toggle",
    Default = false,
    ConfigIgnore = true
})
```

------------------------------------------------------------------------

# 22. Window Config API

## `Window:CreateConfig(name)`

Membuat object config wrapper.

``` lua
local Config = Window:CreateConfig("Default")
```

### API

``` lua
Config:Save()
Config:Load()
Config:Delete()
Config:Exists()
Config:GetName()
Config:SetName("NewName")
Config:List()
Config:GetValues()
```

Contoh:

``` lua
local Config = Window:CreateConfig("MyConfig")

Config:Save()

local exists = Config:Exists()

if exists then
    Config:Load(false)
end
```

------------------------------------------------------------------------

## `Window:RegisterConfig(id, controlType, control)`

Registrasi manual.

``` lua
Window:RegisterConfig(
    "MySetting",
    "Toggle",
    MyToggle
)
```

Biasanya tidak diperlukan karena component otomatis melakukan
registration.

------------------------------------------------------------------------

## `Window:SaveConfig(name)`

``` lua
local ok, result = Window:SaveConfig("MyConfig")

if ok then
    print("Saved:", result)
else
    warn("Save failed:", result)
end
```

**Return:**

``` text
ok, result
```

------------------------------------------------------------------------

## `Window:LoadConfig(name, fireCallback)`

``` lua
local ok, result =
    Window:LoadConfig("MyConfig", false)
```

Jika `fireCallback`:

``` lua
Window:LoadConfig("MyConfig", true)
```

maka callback component akan dijalankan ketika nilai diterapkan.

------------------------------------------------------------------------

## `Window:DeleteConfig(name)`

``` lua
local ok, result =
    Window:DeleteConfig("MyConfig")
```

------------------------------------------------------------------------

## `Window:ConfigExists(name)`

``` lua
if Window:ConfigExists("MyConfig") then
    print("Config exists")
end
```

**Return:** `boolean`

------------------------------------------------------------------------

## `Window:ListConfigs()`

``` lua
local configs = Window:ListConfigs()

for _, name in ipairs(configs) do
    print(name)
end
```

**Return:** `table`

------------------------------------------------------------------------

## `Window:GetActiveConfig()`

``` lua
local active = Window:GetActiveConfig()
```

------------------------------------------------------------------------

## `Window:SetActiveConfig(name)`

``` lua
Window:SetActiveConfig("MyConfig")
```

------------------------------------------------------------------------

## `Window:GetConfigValues()`

Mengambil nilai semua component yang terdaftar.

``` lua
local values = Window:GetConfigValues()

for id, value in pairs(values) do
    print(id, value)
end
```

------------------------------------------------------------------------

## `Window:GetRegisteredConfigs()`

``` lua
local registered =
    Window:GetRegisteredConfigs()

for id, controlType in pairs(registered) do
    print(id, controlType)
end
```

Contoh hasil:

``` text
AutoFarm    Toggle
FarmSpeed   Slider
FarmMode    Dropdown
FarmKey     Keybind
```

------------------------------------------------------------------------

# 23. Config Manager UI

Library juga memiliki method:

``` lua
Tab:CreateConfigManager(options)
```

Method ini adalah UI wrapper untuk config system.

> Jika ingin membuat UI Config sendiri menggunakan
> Button/Input/Dropdown, method ini tidak wajib digunakan.

### Options

``` lua
local ConfigUI =
    Tab:CreateConfigManager({
        SectionName = "Configuration",
        DefaultName = "Default",
        NameInput = "Config Name",
        Placeholder = "Enter config name...",
        SelectorName = "Available Configs",
        Search = true,

        SaveText = "Save Config",
        LoadText = "Load Config",
        DeleteText = "Delete Config",
        RefreshText = "Refresh Configs",

        AutoLoad = false,
        AutoLoadName = "Default",
        AutoSave = false
    })
```

### API return

``` lua
ConfigUI:Refresh()
ConfigUI:Save(name)
ConfigUI:Load(name, fireCallback)
ConfigUI:Delete(name)
ConfigUI:Exists(name)
ConfigUI:List()
ConfigUI:GetName()
ConfigUI:SetName(name)

ConfigUI:GetSelector()
ConfigUI:GetInput()

ConfigUI:GetGameId()
ConfigUI:GetGameName()
ConfigUI:GetGameFolder()
ConfigUI:GetConfigFolder()
```

------------------------------------------------------------------------

# 24. Config Storage

Config disimpan berdasarkan game.

Struktur dasarnya:

``` text
PHILANX-HUB/
└── GameName_GameId/
    ├── Default.json
    ├── Farm.json
    └── PvP.json
```

`GameId` digunakan sebagai identitas utama folder game, sedangkan nama
game digunakan sebagai prefix yang mudah dibaca.

Jika file API tidak tersedia, library memiliki fallback memory storage
selama runtime.

------------------------------------------------------------------------

# 25. Config Data Types

Config manager dapat menangani:

-   string
-   number
-   boolean
-   table
-   `EnumItem`, khususnya `Enum.KeyCode`
-   `Color3`

`EnumItem` disimpan dengan metadata type dan name, lalu direkonstruksi
ketika config dimuat.

`Color3` juga diubah ke nilai `r`, `g`, `b` saat serialization.

------------------------------------------------------------------------

# 26. Contoh Lengkap --- Semua Element

``` lua
local UILibrary = loadstring(game:HttpGet("YOUR_LIBRARY_URL"))()

UILibrary:SetTheme({
    Accent = Color3.fromRGB(35, 155, 255)
})

local Window = UILibrary:CreateWindow({
    Title = "PHILANX HUB",
    Subtitle = "Library Example",
    Size = UDim2.fromOffset(650, 450),
    Logo = "rbxassetid://132859114380485"
})

--==================================================
-- TAB
--==================================================

local MainTab = Window:CreateTab({
    Name = "Main",
    Icon = "🏠"
})

--==================================================
-- BASIC ELEMENTS
--==================================================

local Basic = MainTab:CreateSection("Basic Elements")

Basic:CreateLabel("PHILANX HUB Example")

local Paragraph = Basic:CreateParagraph({
    Title = "Information",
    Content = "Contoh semua element yang tersedia."
})

Basic:CreateDivider()

local Status = Basic:CreateStatusBox({
    Type = "success",
    Title = "Library Ready",
    Content = "Semua component berhasil dibuat."
})

--==================================================
-- CONTROLS
--==================================================

local Controls = MainTab:CreateSection("Controls")

local Button = Controls:CreateButton({
    Name = "Test Button",

    Callback = function()
        print("Button clicked")

        Window:Notify({
            Title = "Button",
            Content = "Test Button clicked.",
            Duration = 2
        })
    end
})

local Toggle = Controls:CreateToggle({
    Name = "Test Toggle",
    Id = "TestToggle",
    Default = false,

    Callback = function(value)
        print("Toggle:", value)
    end
})

local Input = Controls:CreateInput({
    Placeholder = "Type something...",
    Default = "",

    Callback = function(text, enterPressed)
        print("Input:", text)
        print("Enter:", enterPressed)
    end
})

local SingleDropdown = Controls:CreateDropdown({
    Name = "Single Dropdown",
    Id = "SingleDropdown",

    Values = {
        "Normal",
        "Fast",
        "Extreme"
    },

    Default = "Normal",
    Multi = false,
    Search = true,

    Callback = function(value)
        print("Single:", value)
    end
})

local MultiDropdown = Controls:CreateDropdown({
    Name = "Multi Dropdown",
    Id = "MultiDropdown",

    Values = {
        "ESP",
        "Speed",
        "Auto Farm",
        "Auto Collect"
    },

    Default = {
        "ESP"
    },

    Multi = true,
    MaxSelected = 3,
    Search = true,

    Callback = function(values)
        print("Multi selected:")

        for _, value in ipairs(values) do
            print("-", value)
        end
    end
})

local Keybind = Controls:CreateKeybind({
    Name = "Test Keybind",
    Id = "TestKeybind",

    Default = Enum.KeyCode.RightShift,

    Changed = function(key)
        print("Key changed:", key.Name)
    end,

    Callback = function(key)
        Window:Toggle()
    end
})

local Slider = Controls:CreateSlider({
    Name = "Test Slider",
    Id = "TestSlider",

    Min = 0,
    Max = 100,
    Step = 5,
    Default = 50,
    Decimals = 0,

    Callback = function(value)
        print("Slider:", value)
    end
})

--==================================================
-- NOTIFICATIONS
--==================================================

local NotificationTab = Window:CreateTab({
    Name = "Notifications",
    Icon = "🔔"
})

local NotificationSection =
    NotificationTab:CreateSection("Notifications")

NotificationSection:CreateButton({
    Name = "Info",

    Callback = function()
        Window:Notify({
            Title = "Info",
            Content = "Information notification.",
            Duration = 3
        })
    end
})

NotificationSection:CreateButton({
    Name = "Success",

    Callback = function()
        Window:Notify({
            Title = "Success",
            Content = "Success notification.",
            Duration = 3,
            Color = Color3.fromRGB(70, 215, 140)
        })
    end
})

NotificationSection:CreateButton({
    Name = "Warning",

    Callback = function()
        Window:Notify({
            Title = "Warning",
            Content = "Warning notification.",
            Duration = 3,
            Color = Color3.fromRGB(255, 195, 70)
        })
    end
})

NotificationSection:CreateButton({
    Name = "Error",

    Callback = function()
        Window:Notify({
            Title = "Error",
            Content = "Error notification.",
            Duration = 3,
            Color = Color3.fromRGB(245, 85, 95)
        })
    end
})

--==================================================
-- CONFIG
--==================================================

local ConfigTab = Window:CreateTab({
    Name = "Config",
    Icon = "⚙"
})

local ConfigSection =
    ConfigTab:CreateSection("Configuration")

local ConfigName = ConfigSection:CreateInput({
    Placeholder = "Config name...",
    Default = "Default",
    ConfigIgnore = true
})

local ConfigSelector = ConfigSection:CreateDropdown({
    Name = "Available Configs",
    Values = Window:ListConfigs(),
    Multi = false,
    Search = true,
    ConfigIgnore = true,

    Callback = function(value)
        if value ~= nil then
            ConfigName.Text = tostring(value)
        end
    end
})

local function RefreshConfigs()
    ConfigSelector:SetValues(
        Window:ListConfigs(),
        false
    )
end

ConfigSection:CreateButton({
    Name = "Save Config",
    ConfigIgnore = true,

    Callback = function()
        local name = ConfigName.Text

        if name == "" then
            Window:Notify({
                Title = "Config",
                Content = "Nama config kosong.",
                Duration = 2
            })

            return
        end

        local ok, result =
            Window:SaveConfig(name)

        if ok then
            RefreshConfigs()

            Window:Notify({
                Title = "Config Saved",
                Content = name .. " berhasil disimpan.",
                Duration = 2
            })
        else
            Window:Notify({
                Title = "Config Error",
                Content = tostring(result),
                Duration = 3
            })
        end
    end
})

ConfigSection:CreateButton({
    Name = "Load Config",
    ConfigIgnore = true,

    Callback = function()
        local name = ConfigName.Text

        if name == "" then
            return
        end

        local ok, result =
            Window:LoadConfig(name, false)

        if ok then
            Window:Notify({
                Title = "Config Loaded",
                Content = name .. " berhasil dimuat.",
                Duration = 2
            })
        else
            Window:Notify({
                Title = "Config Error",
                Content = tostring(result),
                Duration = 3
            })
        end
    end
})

ConfigSection:CreateButton({
    Name = "Delete Config",
    ConfigIgnore = true,

    Callback = function()
        local name = ConfigName.Text

        if name == "" then
            return
        end

        local ok, result =
            Window:DeleteConfig(name)

        if ok then
            RefreshConfigs()

            Window:Notify({
                Title = "Config Deleted",
                Content = name .. " berhasil dihapus.",
                Duration = 2
            })
        else
            Window:Notify({
                Title = "Config Error",
                Content = tostring(result),
                Duration = 3
            })
        end
    end
})

ConfigSection:CreateButton({
    Name = "Refresh Configs",
    ConfigIgnore = true,

    Callback = function()
        RefreshConfigs()

        Window:Notify({
            Title = "Config",
            Content = "Config list diperbarui.",
            Duration = 2
        })
    end
})

RefreshConfigs()
```

------------------------------------------------------------------------

# 27. Contoh Config Otomatis

Jika hanya ingin menyimpan setting tanpa membuat UI Config manual:

``` lua
local Window = UILibrary:CreateWindow({
    Title = "PHILANX HUB"
})

local Tab = Window:CreateTab({
    Name = "Main"
})

local Section = Tab:CreateSection("Settings")

local AutoFarm = Section:CreateToggle({
    Name = "Auto Farm",
    Id = "AutoFarm",
    Default = false
})

local Speed = Section:CreateSlider({
    Name = "Speed",
    Id = "Speed",
    Min = 0,
    Max = 100,
    Default = 50
})

-- Save
Window:SaveConfig("Default")

-- Load
Window:LoadConfig("Default", false)

-- Delete
Window:DeleteConfig("Default")
```

------------------------------------------------------------------------

# 28. Best Practice ID

Gunakan ID yang stabil dan unik:

``` lua
Id = "AutoFarm"
Id = "FarmSpeed"
Id = "FarmMode"
Id = "FarmFeatures"
Id = "FarmKey"
```

Hindari:

``` lua
Id = "Toggle"
Id = "Slider"
Id = "Dropdown"
```

jika terdapat lebih dari satu component dengan ID yang sama.

------------------------------------------------------------------------

# 29. Fire Callback Saat Load

Secara default API `LoadConfig` menerima parameter:

``` lua
Window:LoadConfig(name, fireCallback)
```

### Tanpa callback

``` lua
Window:LoadConfig("Default", false)
```

Ini hanya menerapkan state component.

### Dengan callback

``` lua
Window:LoadConfig("Default", true)
```

Callback masing-masing component akan dipanggil ketika nilai diterapkan.

------------------------------------------------------------------------

# 30. Contoh Membaca Semua Setting

``` lua
local values = Window:GetConfigValues()

for id, value in pairs(values) do
    print(id, value)
end
```

Untuk value berbentuk table:

``` lua
for id, value in pairs(values) do
    if type(value) == "table" then
        print(id, "table")

        for _, item in ipairs(value) do
            print("  ", item)
        end
    else
        print(id, value)
    end
end
```

------------------------------------------------------------------------

# 31. Complete API Reference

## UILibrary

``` text
UILibrary:SetTheme(theme)
UILibrary:CreateWindow(options)
```

## Window

``` text
Window:SetVisible(visible)
Window:Toggle()
Window:IsVisible()

Window:Minimize()
Window:Restore()
Window:ToggleMinimize()
Window:IsMinimized()
Window:Destroy()

Window:SetTitle(title)
Window:SetSubtitle(subtitle)
Window:SetLogo(logo)

Window:GetTitle()
Window:GetSubtitle()
Window:GetLogo()

Window:CreateConfig(name)
Window:RegisterConfig(id, controlType, control)

Window:SaveConfig(name)
Window:LoadConfig(name, fireCallback)
Window:DeleteConfig(name)
Window:ConfigExists(name)
Window:ListConfigs()
Window:GetActiveConfig()
Window:SetActiveConfig(name)
Window:GetConfigValues()
Window:GetRegisteredConfigs()

Window:CreateTab(options)
Window:Notify(options)
```

## Tab

``` text
Tab:CreateSection(name)
Tab:CreateConfigManager(options)
```

## Section

``` text
Section:SetCollapsed(value)
Section:Toggle()
Section:IsCollapsed()

Section:CreateLabel(text)
Section:CreateParagraph(options)
Section:CreateDivider()
Section:CreateStatusBox(options)
Section:CreateButton(options)
Section:CreateToggle(options)
Section:CreateInput(options)
Section:CreateDropdown(options)
Section:CreateKeybind(options)
Section:CreateSlider(options)
```

## Paragraph

``` text
Paragraph:SetTitle(title)
Paragraph:SetContent(content)
Paragraph:Set(text)
```

## StatusBox

``` text
StatusBox:SetTitle(title)
StatusBox:SetContent(content)
StatusBox:SetType(type)
```

## Toggle

``` text
Toggle:Set(value, fireCallback)
Toggle:Get()
Toggle:SetTitle(title)
Toggle:SetVisible(visible)
```

## Dropdown

``` text
Dropdown:Set(value, fireCallback)
Dropdown:Get()
Dropdown:SetVisible(visible)
Dropdown:SetTitle(title)
Dropdown:IsMulti()

Dropdown:GetValue()
Dropdown:SetValue(value, fireCallback)

Dropdown:SelectAll(fireCallback)
Dropdown:DeselectAll(fireCallback)
Dropdown:ClearSelection(fireCallback)

Dropdown:GetMaxSelected()
Dropdown:SetMaxSelected(limit)

Dropdown:AddOption(item)
Dropdown:RemoveOption(item)
Dropdown:SetValues(values, fireCallback)

Dropdown:Clear(fireCallback)

Dropdown:SetSearch(text)
Dropdown:GetSearch()
Dropdown:ClearSearch()
```

## Keybind

``` text
Keybind:Set(key)
Keybind:Get()
```

## Slider

``` text
Slider:Set(value, fireCallback)
Slider:SetValue(value, fireCallback)

Slider:Get()
Slider:GetValue()

Slider:SetMin(minimum, fireCallback)
Slider:SetMax(maximum, fireCallback)
Slider:SetStep(step, fireCallback)

Slider:GetMin()
Slider:GetMax()
Slider:GetStep()

Slider:SetDecimals(decimals, fireCallback)
Slider:GetDecimals()

Slider:SetTitle(title)
Slider:SetVisible(visible)
```

## Config Manager UI

``` text
ConfigUI:Refresh()
ConfigUI:Save(name)
ConfigUI:Load(name, fireCallback)
ConfigUI:Delete(name)
ConfigUI:Exists(name)
ConfigUI:List()

ConfigUI:GetName()
ConfigUI:SetName(name)

ConfigUI:GetSelector()
ConfigUI:GetInput()

ConfigUI:GetGameId()
ConfigUI:GetGameName()
ConfigUI:GetGameFolder()
ConfigUI:GetConfigFolder()
```

------------------------------------------------------------------------

# 32. Notes

1.  `CreateInput()` mengembalikan `TextBox` Roblox langsung.
2.  Toggle, Dropdown, Keybind, dan Slider mengembalikan API wrapper.
3.  Component state dapat masuk config secara otomatis.
4.  Gunakan `ConfigIgnore = true` untuk component yang tidak ingin
    disimpan.
5.  Gunakan `Id` unik untuk config.
6.  Multi Dropdown mengembalikan table.
7.  Keybind menggunakan `Enum.KeyCode`.
8.  Slider menerapkan `Step` pada nilai aktual.
9.  `Color3` dan `Enum.KeyCode` memiliki serialization khusus di config.
10. Config dipisahkan berdasarkan `GameId`.
11. Jika file API tidak tersedia, config memiliki fallback memory selama
    runtime.
12. `CreateConfigManager()` adalah wrapper UI tambahan; UI Config manual
    dapat dibuat langsung menggunakan element library dan
    `Window:SaveConfig()`, `LoadConfig()`, `DeleteConfig()`, dan
    `ListConfigs()`.

------------------------------------------------------------------------

## Source Basis

Dokumentasi ini disusun dari source `LIB-PHILANX UI Library` versi 2.8.3
yang diberikan, termasuk implementasi window, tab, section, component,
notification, dan config system.

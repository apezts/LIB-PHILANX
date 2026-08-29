# LIB-PHILANX UI Library

## API Reference --- Version 2.8.3

Dokumentasi ini dibuat langsung berdasarkan source **LIB-PHILANX UI
Library v2.8.3** yang diberikan.

> **Penting:** dokumentasi ini hanya mendokumentasikan API yang
> benar-benar ada di source. Jika sebuah opsi atau method tidak ada di
> source, dokumentasi tidak akan menganggapnya tersedia.

------------------------------------------------------------------------

# 1. Quick Start

## Load Library

``` lua
local UILibrary = loadstring(game:HttpGet("YOUR_LIBRARY_URL"))()
```

## Create Window

``` lua
local Window = UILibrary:CreateWindow({
    Title = "My Game",
    Subtitle = "My Script",
    Size = UDim2.fromOffset(650, 450),
    Logo = "rbxassetid://123456789"
})
```

## Create Tab

``` lua
local MainTab = Window:CreateTab({
    Name = "Main",
    Icon = "★"
})
```

## Create Section

``` lua
local MainSection = MainTab:CreateSection("General")
```

## Create Component

``` lua
MainSection:CreateButton({
    Name = "Start",
    Callback = function()
        print("Started")
    end
})
```

------------------------------------------------------------------------

# 2. API Structure

Struktur utama library:

``` text
UILibrary
└── Window
    ├── Tabs
    │   └── Sections
    │       ├── Label
    │       ├── Paragraph
    │       ├── Divider
    │       ├── StatusBox
    │       ├── Button
    │       ├── Toggle
    │       ├── Input
    │       ├── Dropdown
    │       ├── Keybind
    │       └── Slider
    │
    ├── Notification
    ├── Config
    └── Window Runtime API
```

------------------------------------------------------------------------

# 3. Library

## `UILibrary:SetTheme(theme)`

Mengubah nilai theme yang dikenali oleh library.

### Syntax

``` lua
UILibrary:SetTheme({
    Accent = Color3.fromRGB(120, 90, 255)
})
```

### Supported Theme Keys

``` text
Background
Secondary
Tertiary
Accent
Text
SubText
Border
Success
Warning
Error
```

### Example

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

### Important

`SetTheme()` mengubah shared `Theme` table. Source saat ini tidak
menyediakan mekanisme lengkap untuk me-retint seluruh object UI yang
sudah dibuat sebelumnya.

------------------------------------------------------------------------

# 4. Window

## `UILibrary:CreateWindow(options)`

Membuat window utama library.

### Basic

``` lua
local Window = UILibrary:CreateWindow({
    Title = "My Game",
    Subtitle = "My Script"
})
```

### Full Example

``` lua
local Window = UILibrary:CreateWindow({
    Title = "MY GAME",
    Subtitle = "Main Script",
    Size = UDim2.fromOffset(650, 450),
    Logo = "rbxassetid://123456789"
})
```

## Options

  Option       Type            Default                        Description
  ------------ --------------- ------------------------------ -----------------
  `Title`      string          `"Apez UI"`                    Judul window
  `Subtitle`   string          `"UI Library"`                 Subjudul window
  `Size`       UDim2           `UDim2.fromOffset(650, 450)`   Ukuran window
  `Logo`       string/number   Logo PHILANX                   Logo window

### Logo

Asset ID angka akan otomatis diubah menjadi:

``` lua
Logo = 123456789
```

menjadi:

``` lua
Logo = "rbxassetid://123456789"
```

String asset juga dapat digunakan:

``` lua
Logo = "rbxassetid://123456789"
```

------------------------------------------------------------------------

# 5. Window Visibility

## `Window:SetVisible(visible)`

Menampilkan atau menyembunyikan window.

``` lua
Window:SetVisible(true)
```

``` lua
Window:SetVisible(false)
```

## `Window:Toggle()`

Membalik status visibility.

``` lua
Window:Toggle()
```

## `Window:IsVisible()`

Mengambil status visibility.

``` lua
local visible = Window:IsVisible()

print(visible)
```

------------------------------------------------------------------------

# 6. Window Minimize

## `Window:Minimize()`

Meminimalkan window menjadi floating pill.

``` lua
Window:Minimize()
```

## `Window:Restore()`

Mengembalikan window dari keadaan minimized.

``` lua
Window:Restore()
```

## `Window:ToggleMinimize()`

Toggle antara minimized dan normal.

``` lua
Window:ToggleMinimize()
```

## `Window:IsMinimized()`

Memeriksa apakah window sedang minimized.

``` lua
local minimized = Window:IsMinimized()

print(minimized)
```

------------------------------------------------------------------------

# 7. Window Title

## `Window:SetTitle(title)`

Mengubah judul window.

``` lua
Window:SetTitle("My New Game")
```

Judul pada floating pill juga ikut diperbarui.

## `Window:GetTitle()`

``` lua
local title = Window:GetTitle()
```

## `Window:SetSubtitle(subtitle)`

``` lua
Window:SetSubtitle("Updated Script")
```

## `Window:GetSubtitle()`

``` lua
local subtitle = Window:GetSubtitle()
```

------------------------------------------------------------------------

# 8. Window Logo

## `Window:SetLogo(logo)`

Mengubah logo window.

``` lua
Window:SetLogo("rbxassetid://123456789")
```

atau:

``` lua
Window:SetLogo(123456789)
```

## `Window:GetLogo()`

``` lua
local logo = Window:GetLogo()
```

------------------------------------------------------------------------

# 9. Destroy Window

## `Window:Destroy()`

Menghapus seluruh ScreenGui library.

``` lua
Window:Destroy()
```

Setelah window dihancurkan, beberapa operasi runtime tidak lagi memiliki
UI untuk dikontrol.

------------------------------------------------------------------------

# 10. Tab

## `Window:CreateTab(options)`

Membuat tab baru.

### Basic

``` lua
local MainTab = Window:CreateTab({
    Name = "Main"
})
```

### With Icon

``` lua
local MainTab = Window:CreateTab({
    Name = "Main",
    Icon = "★"
})
```

## Options

  Option   Type     Description
  -------- -------- ---------------
  `Name`   string   Nama tab
  `Icon`   string   Icon/text tab

### Multiple Tabs

``` lua
local MainTab = Window:CreateTab({
    Name = "Main",
    Icon = "★"
})

local SettingsTab = Window:CreateTab({
    Name = "Settings",
    Icon = "⚙"
})

local ConfigTab = Window:CreateTab({
    Name = "Config",
    Icon = "▣"
})
```

> Tab pertama yang dibuat otomatis menjadi tab yang dipilih.

------------------------------------------------------------------------

# 11. Section

## `Tab:CreateSection(name)`

Membuat section di dalam tab.

``` lua
local Section = MainTab:CreateSection("General")
```

Section bersifat collapsible.

------------------------------------------------------------------------

## `Section:SetCollapsed(value)`

Collapse atau expand section.

``` lua
Section:SetCollapsed(true)
```

``` lua
Section:SetCollapsed(false)
```

## `Section:Toggle()`

``` lua
Section:Toggle()
```

## `Section:IsCollapsed()`

``` lua
local collapsed = Section:IsCollapsed()
```

### Contoh

``` lua
local Settings = MainTab:CreateSection("Settings")

Settings:SetCollapsed(true)

task.wait(2)

Settings:SetCollapsed(false)
```

------------------------------------------------------------------------

# 12. Label

## `Section:CreateLabel(text)`

Membuat text label sederhana.

### Syntax

``` lua
local Label = Section:CreateLabel("Hello World")
```

### Example

``` lua
local StatusLabel = Section:CreateLabel(
    "Status: Waiting..."
)
```

### Returned Value

Method ini mengembalikan Roblox `TextLabel`.

Karena yang dikembalikan adalah instance `TextLabel`, property Roblox
biasa dapat diakses:

``` lua
StatusLabel.Text = "Status: Ready!"
```

``` lua
StatusLabel.TextSize = 14
```

### Kapan digunakan?

Gunakan Label untuk:

-   status singkat
-   informasi satu baris
-   teks biasa
-   separator berbentuk teks

------------------------------------------------------------------------

# 13. Paragraph

Paragraph cocok untuk informasi yang memiliki **judul +
deskripsi/content**.

## `Section:CreateParagraph(options)`

### Syntax

``` lua
local Info = Section:CreateParagraph({
    Title = "Information",
    Content = "This is an information paragraph."
})
```

## Options

  Option      Type     Default           Description
  ----------- -------- ----------------- ---------------
  `Title`     string   `"Information"`   Judul
  `Content`   string   `""`              Isi/deskripsi

### Contoh

``` lua
local Info = Section:CreateParagraph({
    Title = "Auto Farm",
    Content = "Mengaktifkan fitur auto farm akan menjalankan sistem farming secara otomatis."
})
```

## Runtime API

### `Paragraph:SetTitle(title)`

``` lua
Info:SetTitle("New Information")
```

### `Paragraph:SetContent(content)`

``` lua
Info:SetContent(
    "New description."
)
```

### `Paragraph:Set(text)`

Shortcut untuk mengubah content.

``` lua
Info:Set("Updated description.")
```

### Contoh Dynamic

``` lua
local Info = Section:CreateParagraph({
    Title = "Status",
    Content = "Loading..."
})

task.wait(2)

Info:SetContent("Loaded successfully.")
```

------------------------------------------------------------------------

# 14. Divider

## `Section:CreateDivider()`

Membuat garis pemisah visual.

``` lua
local Divider = Section:CreateDivider()
```

Tidak memiliki option tambahan.

### Contoh

``` lua
Section:CreateLabel("Player Settings")

Section:CreateDivider()

Section:CreateLabel("Game Settings")
```

------------------------------------------------------------------------

# 15. StatusBox

StatusBox digunakan untuk menampilkan informasi dengan status visual.

## `Section:CreateStatusBox(options)`

### Syntax

``` lua
local Status = Section:CreateStatusBox({
    Type = "success",
    Title = "Success",
    Content = "Operation completed."
})
```

## Options

  Option      Type     Default            Description
  ----------- -------- ------------------ --------------
  `Type`      string   `"info"`           Jenis status
  `Title`     string   uppercase status   Judul
  `Content`   string   `""`               Deskripsi

## Status Type

``` text
info
success
warning
error
```

### Info

``` lua
Section:CreateStatusBox({
    Type = "info",
    Title = "Information",
    Content = "This is an information message."
})
```

### Success

``` lua
Section:CreateStatusBox({
    Type = "success",
    Title = "Success",
    Content = "Successfully completed."
})
```

### Warning

``` lua
Section:CreateStatusBox({
    Type = "warning",
    Title = "Warning",
    Content = "Please check your settings."
})
```

### Error

``` lua
Section:CreateStatusBox({
    Type = "error",
    Title = "Error",
    Content = "Something went wrong."
})
```

## Runtime API

### `StatusBox:SetTitle(title)`

``` lua
Status:SetTitle("Updated")
```

### `StatusBox:SetContent(content)`

``` lua
Status:SetContent(
    "Updated status information."
)
```

### `StatusBox:SetType(type)`

``` lua
Status:SetType("warning")
```

------------------------------------------------------------------------

# 16. Button

Button menjalankan callback ketika ditekan.

## `Section:CreateButton(options)`

### Basic

``` lua
local Button = Section:CreateButton({
    Name = "Test Button",

    Callback = function()
        print("Button clicked")
    end
})
```

## Options

  -----------------------------------------------------------------------
  Option            Type              Default           Description
  ----------------- ----------------- ----------------- -----------------
  `Name`            string            `"Button"`        Text button

  `Callback`        function          nil               Function yang
                                                        dipanggil ketika
                                                        button ditekan
  -----------------------------------------------------------------------

### Callback

``` lua
Section:CreateButton({
    Name = "Start",

    Callback = function()
        print("Game started")
    end
})
```

## Description

### Apakah Button mendukung `Desc` / `Description`?

**Tidak pada source v2.8.3 yang diberikan.**

Button saat ini hanya membuat satu text:

``` lua
Text = options.Name or "Button"
```

dan callback:

``` lua
if options.Callback then
    task.spawn(options.Callback)
end
```

Jadi format seperti:

``` lua
Desc = "Test Button"
```

atau:

``` lua
Description = "Test Button"
```

**belum merupakan API Button pada v2.8.3.**

Begitu juga method berikut **tidak tersedia** pada Button saat ini:

``` lua
Button:SetDesc(...)
Button:SetDescription(...)
```

### Jika membutuhkan deskripsi

Gunakan Paragraph sebelum Button:

``` lua
Section:CreateParagraph({
    Title = "Start Game",
    Content = "Menjalankan game dari awal."
})

Section:CreateButton({
    Name = "Start",
    Callback = function()
        print("Game started")
    end
})
```

Ini sesuai dengan component yang memang tersedia di library.

### Returned Value

Button mengembalikan Roblox `TextButton`.

``` lua
local Button = Section:CreateButton({
    Name = "Test"
})
```

Karena returned value adalah `TextButton`, property Roblox dapat
digunakan:

``` lua
Button.Text = "New Text"
```

------------------------------------------------------------------------

# 17. Toggle

Toggle digunakan untuk nilai boolean `true` / `false`.

## `Section:CreateToggle(options)`

### Basic

``` lua
local AutoFarm = Section:CreateToggle({
    Name = "Auto Farm",
    Default = false,

    Callback = function(enabled)
        print("Auto Farm:", enabled)
    end
})
```

## Options

  -----------------------------------------------------------------------
  Option            Type              Default           Description
  ----------------- ----------------- ----------------- -----------------
  `Name`            string            `"Toggle"`        Nama toggle

  `Default`         boolean           `false`           Nilai awal

  `Callback`        function          nil               Dipanggil ketika
                                                        nilai berubah

  `Id`              string            `Name`            ID config

  `ConfigIgnore`    boolean           `false`           Tidak didaftarkan
                                                        ke config jika
                                                        true
  -----------------------------------------------------------------------

## Callback

Callback menerima nilai boolean.

``` lua
Callback = function(enabled)
    if enabled then
        print("Enabled")
    else
        print("Disabled")
    end
end
```

## Runtime API

### `Toggle:Set(value, fireCallback)`

``` lua
AutoFarm:Set(true)
```

``` lua
AutoFarm:Set(false)
```

Untuk mengubah tanpa menjalankan callback:

``` lua
AutoFarm:Set(true, false)
```

### `Toggle:Get()`

``` lua
local enabled = AutoFarm:Get()
```

### `Toggle:SetTitle(title)`

``` lua
AutoFarm:SetTitle("Auto Farm v2")
```

### `Toggle:SetVisible(visible)`

``` lua
AutoFarm:SetVisible(false)
```

``` lua
AutoFarm:SetVisible(true)
```

## Game Example

``` lua
local AutoFarmEnabled = false

local AutoFarm = Section:CreateToggle({
    Name = "Auto Farm",
    Id = "AutoFarm",
    Default = false,

    Callback = function(value)
        AutoFarmEnabled = value
    end
})
```

Game logic:

``` lua
if AutoFarmEnabled then
    -- Auto Farm logic
end
```

------------------------------------------------------------------------

# 18. Input

Input menggunakan Roblox `TextBox`.

## `Section:CreateInput(options)`

### Basic

``` lua
local Input = Section:CreateInput({
    Placeholder = "Enter text...",
    Default = ""
})
```

### Full

``` lua
local Username = Section:CreateInput({
    Name = "Username",
    Placeholder = "Enter username...",
    Default = "Player",

    Callback = function(text, enterPressed)
        print("Text:", text)
        print("Enter:", enterPressed)
    end
})
```

## Options

  -------------------------------------------------------------------------
  Option            Type              Default             Description
  ----------------- ----------------- ------------------- -----------------
  `Name`            string            ---                 Diteruskan
                                                          sebagai ID config
                                                          jika tidak ada
                                                          `Id`

  `Placeholder`     string            `"Enter text..."`   Placeholder
                                                          TextBox

  `Default`         string            `""`                Text awal

  `Callback`        function          nil                 Dipanggil ketika
                                                          FocusLost

  `Id`              string            `Name`              ID config

  `ConfigIgnore`    boolean           `false`             Abaikan config
  -------------------------------------------------------------------------

> `Name` saat ini tidak digunakan sebagai label visual terpisah pada
> TextBox. Ia terutama berguna sebagai fallback ID config.

## Callback

Callback menerima:

``` lua
Callback = function(text, enterPressed)
    print(text)
    print(enterPressed)
end
```

`enterPressed` menunjukkan apakah focus hilang karena tombol Enter.

## Returned Value

Input mengembalikan Roblox `TextBox`.

``` lua
local Input = Section:CreateInput({
    Placeholder = "Type..."
})
```

### Read Value

``` lua
print(Input.Text)
```

### Set Value

``` lua
Input.Text = "Hello"
```

## Game Example

``` lua
local PlayerName = Section:CreateInput({
    Name = "PlayerName",
    Placeholder = "Player name...",
    Default = ""
})

Section:CreateButton({
    Name = "Print Name",

    Callback = function()
        print("Selected:", PlayerName.Text)
    end
})
```

------------------------------------------------------------------------

# 19. Dropdown

Dropdown mendukung:

-   Single selection
-   Multi selection
-   Search
-   Maximum selected item
-   Dynamic option
-   Runtime value changes
-   Config

## `Section:CreateDropdown(options)`

------------------------------------------------------------------------

## Single Dropdown

``` lua
local Mode = Section:CreateDropdown({
    Name = "Game Mode",

    Values = {
        "Easy",
        "Normal",
        "Hard"
    },

    Default = "Normal",
    Multi = false,
    Search = true,

    Callback = function(value)
        print("Selected:", value)
    end
})
```

## Options

  -----------------------------------------------------------------------------
  Option                  Type              Default           Description
  ----------------------- ----------------- ----------------- -----------------
  `Name`                  string            `"Dropdown"`      Nama dropdown

  `Values`                table             `{}`              Daftar option

  `Default`               value/table       first value untuk Nilai awal
                                            single            

  `Multi`                 boolean           `false`           Multi-select

  `Search`                boolean           `true`            Search box

  `SearchPlaceholder`     string            `"Search..."`     Placeholder
                                                              search

  `MaxSelected`           number            nil               Batas pilihan
                                                              untuk multi

  `MaxSelectedCallback`   function          nil               Dipanggil saat
                                                              batas tercapai

  `Callback`              function          nil               Callback pilihan

  `Id`                    string            `Name`            ID config

  `ConfigIgnore`          boolean           `false`           Abaikan config
  -----------------------------------------------------------------------------

------------------------------------------------------------------------

# 20. Dropdown Default

## Single

``` lua
Default = "Normal"
```

Jika `Default` tidak diberikan, single dropdown menggunakan item
pertama:

``` lua
Values = {
    "Easy",
    "Normal",
    "Hard"
}
```

maka default:

``` text
Easy
```

## Multi

Default dapat berupa table:

``` lua
Default = {
    "ESP",
    "Speed"
}
```

Atau satu nilai:

``` lua
Default = "ESP"
```

Hanya nilai yang terdapat di `Values` yang akan digunakan sebagai
default.

------------------------------------------------------------------------

# 21. Dropdown Callback

## Single

Callback menerima selected value:

``` lua
Callback = function(value)
    print(value)
end
```

## Multi

Callback menerima table:

``` lua
Callback = function(values)
    for _, value in ipairs(values) do
        print(value)
    end
end
```

------------------------------------------------------------------------

# 22. Dropdown Runtime API

## `Dropdown:Set(value, fireCallback)`

Single:

``` lua
Mode:Set("Hard")
```

Multi:

``` lua
Features:Set({
    "ESP",
    "Speed"
})
```

## `Dropdown:Get()`

``` lua
local value = Mode:Get()
```

## `Dropdown:SetVisible(visible)`

``` lua
Mode:SetVisible(false)
```

## `Dropdown:SetTitle(title)`

``` lua
Mode:SetTitle("Difficulty")
```

## `Dropdown:IsMulti()`

``` lua
print(Mode:IsMulti())
```

## `Dropdown:GetValue()`

``` lua
local value = Mode:GetValue()
```

------------------------------------------------------------------------

# 23. Dropdown `SetValue`

## Single

``` lua
Mode:SetValue("Hard")
```

## Multi

``` lua
Features:SetValue({
    "ESP",
    "Jump"
})
```

## Disable Callback

``` lua
Mode:SetValue("Hard", false)
```

`fireCallback = false` mencegah callback dipanggil.

------------------------------------------------------------------------

# 24. Multi Dropdown API

## `SelectAll()`

Memilih semua option yang tersedia.

``` lua
Features:SelectAll()
```

## `DeselectAll()`

Membatalkan semua pilihan.

``` lua
Features:DeselectAll()
```

## `ClearSelection()`

Mengosongkan selection.

``` lua
Features:ClearSelection()
```

Ketiga method tersebut menerima optional:

``` lua
Features:SelectAll(false)
Features:DeselectAll(false)
Features:ClearSelection(false)
```

------------------------------------------------------------------------

# 25. Dropdown Maximum Selection

## `GetMaxSelected()`

``` lua
local max = Features:GetMaxSelected()
```

## `SetMaxSelected(limit)`

``` lua
Features:SetMaxSelected(3)
```

Menghapus batas:

``` lua
Features:SetMaxSelected(nil)
```

### Example

``` lua
local Features = Section:CreateDropdown({
    Name = "Features",

    Values = {
        "ESP",
        "Speed",
        "Jump",
        "Auto Farm"
    },

    Multi = true,
    MaxSelected = 2
})
```

Jika user mencoba memilih lebih dari batas, `MaxSelectedCallback` dapat
digunakan.

``` lua
MaxSelectedCallback = function(limit)
    print("Maximum:", limit)
end
```

------------------------------------------------------------------------

# 26. Dropdown Dynamic Options

## `AddOption(item)`

``` lua
Features:AddOption("Auto Collect")
```

Jika option sudah ada, tidak ditambahkan ulang.

## `RemoveOption(item)`

``` lua
Features:RemoveOption("Auto Collect")
```

## `SetValues(values, fireCallback)`

Mengganti seluruh daftar option.

``` lua
Features:SetValues({
    "Option A",
    "Option B",
    "Option C"
})
```

Tanpa callback:

``` lua
Features:SetValues({
    "A",
    "B"
}, false)
```

## `Clear(fireCallback)`

Menghapus selection.

``` lua
Features:Clear()
```

------------------------------------------------------------------------

# 27. Dropdown Search

Search aktif secara default.

## Disable Search

``` lua
Search = false
```

## Custom Placeholder

``` lua
SearchPlaceholder = "Search feature..."
```

## `SetSearch(text)`

``` lua
Features:SetSearch("ESP")
```

## `GetSearch()`

``` lua
local search = Features:GetSearch()
```

## `ClearSearch()`

``` lua
Features:ClearSearch()
```

------------------------------------------------------------------------

# 28. Complete Multi Dropdown Example

``` lua
local Features = Section:CreateDropdown({
    Name = "Features",

    Values = {
        "ESP",
        "Speed",
        "Jump",
        "Auto Farm",
        "Auto Collect"
    },

    Default = {
        "ESP"
    },

    Multi = true,
    Search = true,
    SearchPlaceholder = "Search feature...",
    MaxSelected = 3,

    Callback = function(values)
        print("Selected features:")

        for _, value in ipairs(values) do
            print("-", value)
        end
    end,

    MaxSelectedCallback = function(limit)
        print("Maximum selected:", limit)
    end
})
```

------------------------------------------------------------------------

# 29. Keybind

Keybind digunakan untuk memilih keyboard key.

## `Section:CreateKeybind(options)`

### Basic

``` lua
local ToggleKey = Section:CreateKeybind({
    Name = "Toggle UI",
    Default = Enum.KeyCode.RightShift,

    Callback = function(key)
        print("Pressed:", key.Name)
    end,

    Changed = function(key)
        print("Changed:", key.Name)
    end
})
```

## Options

  Option           Type           Default        Description
  ---------------- -------------- -------------- ------------------------------
  `Name`           string         `"Keybind"`    Nama
  `Default`        Enum.KeyCode   `RightShift`   Key awal
  `Callback`       function       nil            Dipanggil ketika key ditekan
  `Changed`        function       nil            Dipanggil ketika key berubah
  `Id`             string         `Name`         ID config
  `ConfigIgnore`   boolean        `false`        Abaikan config

------------------------------------------------------------------------

# 30. Keybind Callback

``` lua
Callback = function(key)
    print("Pressed:", key.Name)
end
```

Keybind akan menjalankan callback ketika:

``` lua
input.KeyCode == CurrentKey
```

dan input merupakan keyboard input.

------------------------------------------------------------------------

# 31. Keybind Changed

``` lua
Changed = function(key)
    print("New key:", key.Name)
end
```

Callback `Changed` dipanggil ketika user mengganti key.

------------------------------------------------------------------------

# 32. Keybind Runtime API

## `Keybind:Set(key)`

``` lua
ToggleKey:Set(Enum.KeyCode.F)
```

Hanya `Enum.KeyCode` yang valid.

## `Keybind:Get()`

``` lua
local key = ToggleKey:Get()

print(key.Name)
```

### Example

``` lua
local ToggleKey = Section:CreateKeybind({
    Name = "Toggle UI",
    Id = "ToggleUI",
    Default = Enum.KeyCode.RightShift,

    Callback = function()
        Window:Toggle()
    end
})
```

------------------------------------------------------------------------

# 33. Slider

Slider digunakan untuk nilai numerik.

## `Section:CreateSlider(options)`

### Basic

``` lua
local Speed = Section:CreateSlider({
    Name = "Speed",

    Min = 0,
    Max = 100,
    Default = 50,

    Callback = function(value)
        print("Speed:", value)
    end
})
```

## Full

``` lua
local Speed = Section:CreateSlider({
    Name = "Speed",
    Id = "Speed",

    Min = 0,
    Max = 100,

    Default = 50,
    Step = 5,
    Decimals = 0,

    Callback = function(value)
        print("Speed:", value)
    end
})
```

## Options

  Option           Type         Default      Description
  ---------------- ------------ ------------ ----------------
  `Name`           string       `"Slider"`   Nama
  `Min`            number       `0`          Minimum
  `Minimum`        number       `0`          Alias minimum
  `Max`            number       `100`        Maximum
  `Maximum`        number       `100`        Alias maximum
  `Default`        number       minimum      Nilai awal
  `Step`           number       `1`          Increment
  `Decimals`       number/nil   nil          Jumlah desimal
  `Callback`       function     nil          Callback value
  `Id`             string       `Name`       ID config
  `ConfigIgnore`   boolean      `false`      Abaikan config

------------------------------------------------------------------------

# 34. Slider Min / Max

Keduanya tersedia:

``` lua
Min = 0
Max = 100
```

atau:

``` lua
Minimum = 0
Maximum = 100
```

Jika maximum lebih kecil daripada minimum, library menukar keduanya.

------------------------------------------------------------------------

# 35. Slider Step

Step digunakan pada perhitungan value.

``` lua
Min = 0
Max = 100
Step = 5
```

Maka value akan mengikuti:

``` text
0
5
10
15
20
...
100
```

Contoh:

``` lua
local Speed = Section:CreateSlider({
    Name = "Speed",
    Min = 0,
    Max = 100,
    Step = 5,
    Default = 50
})
```

------------------------------------------------------------------------

# 36. Slider Decimals

``` lua
Decimals = 2
```

Contoh:

``` lua
local Multiplier = Section:CreateSlider({
    Name = "Multiplier",

    Min = 0,
    Max = 5,

    Step = 0.1,
    Decimals = 2,

    Default = 1
})
```

------------------------------------------------------------------------

# 37. Slider Runtime API

## `Slider:Set(value, fireCallback)`

``` lua
Speed:Set(75)
```

Tanpa callback:

``` lua
Speed:Set(75, false)
```

## `Slider:SetValue(value, fireCallback)`

``` lua
Speed:SetValue(80)
```

## `Slider:Get()`

``` lua
local value = Speed:Get()
```

## `Slider:GetValue()`

``` lua
local value = Speed:GetValue()
```

------------------------------------------------------------------------

# 38. Slider Limits Runtime

## `SetMin`

``` lua
Speed:SetMin(10)
```

## `GetMin`

``` lua
local min = Speed:GetMin()
```

## `SetMax`

``` lua
Speed:SetMax(200)
```

## `GetMax`

``` lua
local max = Speed:GetMax()
```

## `SetStep`

``` lua
Speed:SetStep(10)
```

## `GetStep`

``` lua
local step = Speed:GetStep()
```

## `SetDecimals`

``` lua
Speed:SetDecimals(2)
```

## `GetDecimals`

``` lua
local decimals = Speed:GetDecimals()
```

------------------------------------------------------------------------

# 39. Slider UI Runtime

## `SetTitle`

``` lua
Speed:SetTitle("Walk Speed")
```

## `SetVisible`

``` lua
Speed:SetVisible(false)
```

``` lua
Speed:SetVisible(true)
```

------------------------------------------------------------------------

# 40. Notification

Notification dibuat melalui Window.

## `Window:Notify(options)`

### Basic

``` lua
Window:Notify({
    Title = "Success",
    Content = "Game started!",
    Duration = 3
})
```

## Options

  Option       Type     Default            Description
  ------------ -------- ------------------ ---------------
  `Title`      string   `"Notification"`   Judul
  `Content`    string   `""`               Isi/deskripsi
  `Duration`   number   `3`                Durasi
  `Color`      Color3   `Theme.Accent`     Warna accent

### Custom Color

``` lua
Window:Notify({
    Title = "Warning",
    Content = "Low health!",
    Duration = 3,
    Color = Color3.fromRGB(255, 195, 70)
})
```

### Returned Value

`Window:Notify()` mengembalikan Roblox `Frame` notification.

------------------------------------------------------------------------

# 41. Config System

Config system menyimpan state dari component yang terdaftar.

Component yang mendukung config:

``` text
Toggle
Input
Dropdown
Keybind
Slider
```

Button tidak didaftarkan sebagai state config karena Button adalah
action.

------------------------------------------------------------------------

# 42. Config ID

Gunakan ID unik untuk component yang ingin disimpan.

### Recommended

``` lua
local AutoFarm = Section:CreateToggle({
    Name = "Auto Farm",
    Id = "AutoFarm"
})

local Speed = Section:CreateSlider({
    Name = "Speed",
    Id = "FarmSpeed"
})

local Mode = Section:CreateDropdown({
    Name = "Mode",
    Id = "FarmMode"
})
```

Jika `Id` tidak diberikan, library menggunakan:

``` lua
options.Name
```

sebagai ID.

------------------------------------------------------------------------

# 43. `ConfigIgnore`

Component dapat dikecualikan dari config:

``` lua
ConfigIgnore = true
```

Example:

``` lua
local TemporaryToggle = Section:CreateToggle({
    Name = "Temporary",
    ConfigIgnore = true
})
```

Component tersebut tidak diregister ke ConfigManager.

------------------------------------------------------------------------

# 44. Create Config Object

## `Window:CreateConfig(name)`

``` lua
local Config = Window:CreateConfig("Default")
```

Object config memiliki:

``` lua
Config:Save()
Config:Load(fireCallback)
Config:Delete()
Config:Exists()
Config:GetName()
Config:SetName(name)
Config:List()
Config:GetValues()
```

------------------------------------------------------------------------

# 45. Config Save

``` lua
Config:Save()
```

Contoh:

``` lua
local Config = Window:CreateConfig("MyConfig")

local ok, result = Config:Save()

print(ok)
print(result)
```

------------------------------------------------------------------------

# 46. Config Load

``` lua
Config:Load()
```

Dengan callback:

``` lua
Config:Load(true)
```

Tanpa callback:

``` lua
Config:Load(false)
```

------------------------------------------------------------------------

# 47. Config Delete

``` lua
Config:Delete()
```

## Config Exists

``` lua
if Config:Exists() then
    print("Config exists")
end
```

## Config Name

``` lua
print(Config:GetName())
```

``` lua
Config:SetName("MyNewConfig")
```

## List Configs

``` lua
local configs = Config:List()

for _, name in ipairs(configs) do
    print(name)
end
```

## Get Current Values

``` lua
local values = Config:GetValues()

for id, value in pairs(values) do
    print(id, value)
end
```

------------------------------------------------------------------------

# 48. Window Config API

Selain object config, Window menyediakan API langsung.

## `Window:RegisterConfig(id, controlType, control)`

Register control secara manual.

``` lua
Window:RegisterConfig(
    "MyToggle",
    "Toggle",
    Toggle
)
```

Return:

``` text
true
```

atau:

``` text
false
```

------------------------------------------------------------------------

## `Window:SaveConfig(name)`

``` lua
local ok, result =
    Window:SaveConfig("MyConfig")
```

Jika berhasil, Window juga menampilkan notification `Config Saved`.

------------------------------------------------------------------------

## `Window:LoadConfig(name, fireCallback)`

``` lua
local ok, result =
    Window:LoadConfig("MyConfig")
```

Dengan callback:

``` lua
Window:LoadConfig("MyConfig", true)
```

Tanpa callback:

``` lua
Window:LoadConfig("MyConfig", false)
```

Jika berhasil, Window menampilkan notification `Config Loaded`.

------------------------------------------------------------------------

## `Window:DeleteConfig(name)`

``` lua
local ok, result =
    Window:DeleteConfig("MyConfig")
```

## `Window:ConfigExists(name)`

``` lua
if Window:ConfigExists("MyConfig") then
    print("Exists")
end
```

## `Window:ListConfigs()`

``` lua
local configs =
    Window:ListConfigs()

for _, name in ipairs(configs) do
    print(name)
end
```

## `Window:GetActiveConfig()`

``` lua
local active =
    Window:GetActiveConfig()
```

## `Window:SetActiveConfig(name)`

``` lua
Window:SetActiveConfig("MyConfig")
```

## `Window:GetConfigValues()`

``` lua
local values =
    Window:GetConfigValues()
```

## `Window:GetRegisteredConfigs()`

``` lua
local controls =
    Window:GetRegisteredConfigs()

for id, controlType in pairs(controls) do
    print(id, controlType)
end
```

------------------------------------------------------------------------

# 49. Config Manager UI

Library menyediakan UI config siap pakai.

## `Tab:CreateConfigManager(options)`

### Basic

``` lua
local ConfigUI = ConfigTab:CreateConfigManager({
    DefaultName = "Default"
})
```

### Full

``` lua
local ConfigUI = ConfigTab:CreateConfigManager({
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

## Options

  Option           Type      Default                    Description
  ---------------- --------- -------------------------- ------------------------
  `SectionName`    string    `"Configuration"`          Nama section
  `DefaultName`    string    `"Default"`                Nama config default
  `NameInput`      string    `"Config Name"`            Nama input
  `Placeholder`    string    `"Enter config name..."`   Placeholder
  `SelectorName`   string    `"Available Configs"`      Nama dropdown
  `Search`         boolean   `true`                     Search config
  `SaveText`       string    `"Save Config"`            Text tombol save
  `LoadText`       string    `"Load Config"`            Text tombol load
  `DeleteText`     string    `"Delete Config"`          Text tombol delete
  `RefreshText`    string    `"Refresh Configs"`        Text tombol refresh
  `AutoLoad`       boolean   `false`                    Load otomatis
  `AutoLoadName`   string    `DefaultName`              Config untuk auto-load
  `AutoSave`       boolean   `false`                    Save otomatis

------------------------------------------------------------------------

# 50. Config Manager Runtime API

## `ConfigUI:Refresh()`

Refresh daftar config.

``` lua
ConfigUI:Refresh()
```

## `ConfigUI:Save(name)`

``` lua
ConfigUI:Save("MyConfig")
```

## `ConfigUI:Load(name, fireCallback)`

``` lua
ConfigUI:Load("MyConfig")
```

## `ConfigUI:Delete(name)`

``` lua
ConfigUI:Delete("MyConfig")
```

## `ConfigUI:Exists(name)`

``` lua
if ConfigUI:Exists("MyConfig") then
    print("Exists")
end
```

## `ConfigUI:List()`

``` lua
local configs = ConfigUI:List()
```

## `ConfigUI:GetName()`

``` lua
local name = ConfigUI:GetName()
```

## `ConfigUI:SetName(name)`

``` lua
ConfigUI:SetName("MyConfig")
```

## `ConfigUI:GetSelector()`

Mengambil dropdown config selector.

``` lua
local Selector =
    ConfigUI:GetSelector()
```

## `ConfigUI:GetInput()`

Mengambil TextBox nama config.

``` lua
local Input =
    ConfigUI:GetInput()
```

------------------------------------------------------------------------

# 51. Config Manager Game Information

Config manager juga menyediakan informasi folder/game.

## `ConfigUI:GetGameId()`

``` lua
local gameId =
    ConfigUI:GetGameId()
```

## `ConfigUI:GetGameName()`

``` lua
local gameName =
    ConfigUI:GetGameName()
```

## `ConfigUI:GetGameFolder()`

``` lua
local folder =
    ConfigUI:GetGameFolder()
```

## `ConfigUI:GetConfigFolder()`

``` lua
local folder =
    ConfigUI:GetConfigFolder()
```

------------------------------------------------------------------------

# 52. Config Storage

Config menggunakan game identity.

Struktur konseptual:

``` text
PHILANX-HUB/
└── GameName_GameId/
    ├── Config1.json
    ├── Config2.json
    └── Config3.json
```

`GameId` menjadi key utama untuk menentukan folder game.

Nama game digunakan sebagai prefix yang mudah dibaca.

------------------------------------------------------------------------

# 53. Config File Naming

Nama config disanitasi sebelum menjadi nama file.

Secara umum:

``` text
My Config
```

akan digunakan sebagai nama aman:

``` text
My_Config.json
```

Karakter yang tidak diizinkan akan dibersihkan.

------------------------------------------------------------------------

# 54. Config Serialization

Serializer source mendukung:

``` text
string
number
boolean
nil
table
Color3
EnumItem
```

### Color3

Color3 disimpan dalam bentuk:

``` lua
{
    __type = "Color3",
    r = value.R,
    g = value.G,
    b = value.B
}
```

### EnumItem

EnumItem disimpan dalam bentuk informasi enum + name.

Saat decode, source secara khusus mendukung `Enum.KeyCode`.

------------------------------------------------------------------------

# 55. File API Fallback

Config mencoba menggunakan file API jika tersedia.

API yang digunakan:

``` text
writefile
readfile
isfile
makefolder
isfolder
listfiles
delfile
```

Jika file API tidak tersedia, ConfigManager memiliki fallback memory
untuk penyimpanan runtime.

------------------------------------------------------------------------

# 56. Config Collect / Apply

Secara internal ConfigManager mengumpulkan value dari registered
controls.

Untuk Input:

``` lua
control.Text
```

Untuk control lain, ConfigManager menggunakan:

``` lua
control:GetValue()
```

atau:

``` lua
control:Get()
```

Ketika loading:

``` lua
control:SetValue(value, fireCallback)
```

atau:

``` lua
control:Set(value, fireCallback)
```

------------------------------------------------------------------------

# 57. Recommended Config Pattern

``` lua
local AutoFarm = Settings:CreateToggle({
    Name = "Auto Farm",
    Id = "AutoFarm",
    Default = false
})

local Speed = Settings:CreateSlider({
    Name = "Farm Speed",
    Id = "FarmSpeed",
    Min = 0,
    Max = 100,
    Default = 50
})

local Mode = Settings:CreateDropdown({
    Name = "Mode",
    Id = "FarmMode",

    Values = {
        "Safe",
        "Normal",
        "Fast"
    },

    Default = "Normal"
})
```

Kemudian:

``` lua
local ConfigUI = ConfigTab:CreateConfigManager({
    DefaultName = "Default"
})
```

------------------------------------------------------------------------

# 58. Complete Game UI Template

``` lua
local UILibrary =
    loadstring(game:HttpGet("YOUR_LIBRARY_URL"))()

--==================================================
-- WINDOW
--==================================================

local Window = UILibrary:CreateWindow({
    Title = "MY GAME",
    Subtitle = "Game Script",
    Size = UDim2.fromOffset(650, 450)
})

--==================================================
-- MAIN
--==================================================

local MainTab = Window:CreateTab({
    Name = "Main",
    Icon = "★"
})

local General = MainTab:CreateSection("General")

General:CreateParagraph({
    Title = "Welcome",
    Content = "Configure your game features here."
})

--==================================================
-- SETTINGS
--==================================================

local Settings = MainTab:CreateSection("Settings")

local Enabled = Settings:CreateToggle({
    Name = "Enabled",
    Id = "Enabled",
    Default = false,

    Callback = function(value)
        print("Enabled:", value)
    end
})

local Mode = Settings:CreateDropdown({
    Name = "Mode",
    Id = "Mode",

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

local Speed = Settings:CreateSlider({
    Name = "Speed",
    Id = "Speed",

    Min = 0,
    Max = 100,
    Step = 5,
    Default = 50,

    Callback = function(value)
        print("Speed:", value)
    end
})

--==================================================
-- ACTION
--==================================================

Settings:CreateButton({
    Name = "Start",

    Callback = function()
        Window:Notify({
            Title = "Game",
            Content = "Started.",
            Duration = 2
        })
    end
})

--==================================================
-- CONFIG
--==================================================

local ConfigTab = Window:CreateTab({
    Name = "Config",
    Icon = "▣"
})

local ConfigUI = ConfigTab:CreateConfigManager({
    SectionName = "Configuration",
    DefaultName = "Default"
})
```

------------------------------------------------------------------------

# 59. Recommended Game Logic Pattern

Jangan menaruh seluruh game logic di callback UI.

Gunakan state variable.

### UI

``` lua
local AutoFarmEnabled = false

local AutoFarm = Settings:CreateToggle({
    Name = "Auto Farm",
    Id = "AutoFarm",
    Default = false,

    Callback = function(value)
        AutoFarmEnabled = value
    end
})
```

### Game Logic

``` lua
local function RunAutoFarm()
    if not AutoFarmEnabled then
        return
    end

    -- Auto Farm logic
end
```

### Loop

``` lua
task.spawn(function()
    while task.wait(0.1) do
        if AutoFarmEnabled then
            RunAutoFarm()
        end
    end
end)
```

Dengan struktur ini UI hanya mengubah state, sedangkan logic game tetap
terpisah.

------------------------------------------------------------------------

# 60. Practical Workflow

Saat membuat script/game baru:

## Step 1 --- Window

``` lua
local Window = UILibrary:CreateWindow({
    Title = "MY GAME"
})
```

## Step 2 --- Tabs

``` lua
local Main = Window:CreateTab({
    Name = "Main"
})

local Settings = Window:CreateTab({
    Name = "Settings"
})

local Config = Window:CreateTab({
    Name = "Config"
})
```

## Step 3 --- Sections

``` lua
local General =
    Main:CreateSection("General")

local GameSettings =
    Settings:CreateSection("Game Settings")
```

## Step 4 --- Components

``` lua
GameSettings:CreateToggle(...)
GameSettings:CreateDropdown(...)
GameSettings:CreateSlider(...)
GameSettings:CreateKeybind(...)
GameSettings:CreateInput(...)
```

## Step 5 --- Connect State

``` lua
local Enabled = false

GameSettings:CreateToggle({
    Name = "Enabled",

    Callback = function(value)
        Enabled = value
    end
})
```

## Step 6 --- Game Logic

``` lua
local function UpdateGame()
    if not Enabled then
        return
    end

    -- Game logic
end
```

## Step 7 --- Config

``` lua
Config:CreateConfigManager({
    DefaultName = "Default"
})
```

------------------------------------------------------------------------

# 61. API Cheat Sheet

## Library

``` lua
UILibrary:SetTheme(theme)
UILibrary:CreateWindow(options)
```

## Window

``` lua
Window:CreateTab(options)

Window:SetVisible(value)
Window:Toggle()
Window:IsVisible()

Window:Minimize()
Window:Restore()
Window:ToggleMinimize()
Window:IsMinimized()

Window:SetTitle(title)
Window:GetTitle()

Window:SetSubtitle(subtitle)
Window:GetSubtitle()

Window:SetLogo(logo)
Window:GetLogo()

Window:Notify(options)

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

Window:Destroy()
```

## Tab

``` lua
Tab:CreateSection(name)
Tab:CreateConfigManager(options)
```

## Section

``` lua
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

``` lua
Paragraph:SetTitle(title)
Paragraph:SetContent(content)
Paragraph:Set(text)
```

## StatusBox

``` lua
StatusBox:SetTitle(title)
StatusBox:SetContent(content)
StatusBox:SetType(type)
```

## Toggle

``` lua
Toggle:Set(value, fireCallback)
Toggle:Get()
Toggle:SetTitle(title)
Toggle:SetVisible(visible)
```

## Dropdown

``` lua
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

``` lua
Keybind:Set(key)
Keybind:Get()
```

## Slider

``` lua
Slider:Set(value, fireCallback)
Slider:SetValue(value, fireCallback)

Slider:Get()
Slider:GetValue()

Slider:SetMin(value, fireCallback)
Slider:GetMin()

Slider:SetMax(value, fireCallback)
Slider:GetMax()

Slider:SetStep(value, fireCallback)
Slider:GetStep()

Slider:SetDecimals(value, fireCallback)
Slider:GetDecimals()

Slider:SetTitle(title)
Slider:SetVisible(visible)
```

## Config Object

``` lua
Config:Save()
Config:Load(fireCallback)
Config:Delete()
Config:Exists()

Config:GetName()
Config:SetName(name)

Config:List()
Config:GetValues()
```

## Config Manager UI

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

# 62. Component Comparison

  ---------------------------------------------------------------------------------
  Component            Callback     Persistent    Runtime API   Description/Content
                                        Config                
  -------------- -------------- -------------- -------------- ---------------------
  Label                     ---            ---         Roblox                  Text
                                                    TextLabel 

  Paragraph                 ---            ---            Yes       Title + Content

  Divider                   ---            ---            ---      Visual separator

  StatusBox                 ---            ---            Yes     Title + Content +
                                                                               Type

  Button                    Yes            ---         Roblox      **Tidak ada Desc
                                                   TextButton                 API**

  Toggle                    Yes            Yes            Yes                  Name

  Input                     Yes            Yes        TextBox           Placeholder

  Dropdown                  Yes            Yes            Yes                Search

  Keybind                   Yes            Yes            Yes                   Key

  Slider                    Yes            Yes            Yes         Numeric value

  Notification              ---            ---  Returns Frame       Title + Content
  ---------------------------------------------------------------------------------

------------------------------------------------------------------------

# 63. Important API Accuracy Notes

## Button Description

Source v2.8.3 **belum mempunyai**:

``` lua
Desc
Description
SetDesc()
SetDescription()
```

Untuk component dengan deskripsi, gunakan:

``` lua
Paragraph
StatusBox
```

## Input

`CreateInput()` mengembalikan `TextBox`, bukan wrapper API custom.

## Label

`CreateLabel()` mengembalikan `TextLabel`.

## Button

`CreateButton()` mengembalikan `TextButton`.

## Config

Config hanya bekerja untuk component yang didaftarkan.

## IDs

Untuk project besar, gunakan ID yang unik:

``` lua
Id = "AutoFarm"
Id = "FarmSpeed"
Id = "FarmMode"
```

Jangan memakai ID sama untuk beberapa control.

------------------------------------------------------------------------

# 64. Suggested Documentation Style

Untuk setiap component baru yang ditambahkan ke LIB-PHILANX, dokumentasi
sebaiknya mengikuti format:

``` text
# Component

## Creating Component

## Options

## Basic Example

## Callback

## Description / Content
  hanya jika memang didukung source

## Runtime API

## Dynamic API
  jika ada

## Config

## Game Example

## Important Notes
```

Dengan format ini dokumentasi tetap mudah dibaca ketika library semakin
besar.

------------------------------------------------------------------------

# 65. Source Reference

Library yang didokumentasikan:

``` text
LIB-PHILANX UI Library
Version: 2.8.3
```

Source menyatakan bahwa library ditujukan untuk Roblox Studio / testing
game sendiri.

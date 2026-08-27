# DOKUMENTASI API LIB-PHILANX
## Versi 2.8.3

> Dokumen ini dibuat berdasarkan source LIB-PHILANX versi 2.8.3.
> Dokumen ini hanya menjelaskan API yang benar-benar tersedia pada implementasi saat ini.

---

## 1. Library

### `UILibrary:CreateWindow(options)`

Membuat jendela utama LIB-PHILANX.

Pilihan yang umum digunakan oleh source saat ini:

```lua
local Window = UILibrary:CreateWindow({
    Title = "Antarmuka Saya",
    Subtitle = "Skrip Saya",
    Size = UDim2.fromOffset(650, 450),
    Logo = "rbxassetid://123456789"
})
```

### `UILibrary:SetTheme(theme)`

Mengubah nilai tema yang dikenali oleh library.

Kunci tema dasar yang tersedia:

- `Background`
- `Secondary`
- `Tertiary`
- `Accent`
- `Text`
- `SubText`
- `Border`
- `Success`
- `Warning`
- `Error`

Catatan penting: implementasi saat ini hanya mengubah tabel Theme bersama. Sistem ini belum menjadi sistem perubahan tema saat berjalan yang lengkap untuk semua objek antarmuka yang sudah dibuat.

---

# 2. API Jendela

### Visibilitas

```lua
Window:SetVisible(true)
Window:SetVisible(false)

Window:Toggle()

local visible = Window:IsVisible()
```

### Minimalkan

```lua
Window:Minimize()
Window:Restore()
Window:ToggleMinimize()

local minimized = Window:IsMinimized()
```

Sistem minimalkan menggunakan tombol mengambang untuk memulihkan jendela.

### Hancurkan

```lua
Window:Destroy()
```

Menghancurkan ScreenGui utama.

### Judul / Subjudul / Logo

```lua
Window:SetTitle("Judul Baru")
Window:GetTitle()

Window:SetSubtitle("Subjudul Baru")
Window:GetSubtitle()

Window:SetLogo("rbxassetid://123456789")
Window:GetLogo()
```

---

# 3. Tab

### `Window:CreateTab(options)`

```lua
local Tab = Window:CreateTab({
    Name = "Utama",
    Icon = "★"
})
```

Pilihan yang digunakan saat ini:

- `Name`
- `Icon`

### API Tab

Tab menyediakan:

```lua
Tab:CreateSection("Nama Bagian")
```

Tab pertama yang dibuat akan otomatis dipilih.

---

# 4. Bagian

### `Tab:CreateSection(name)`

```lua
local Section = Tab:CreateSection("Umum")
```

Bagian dapat dibuka dan ditutup.

### API Bagian

```lua
Section:SetCollapsed(true)
Section:SetCollapsed(false)

Section:Toggle()

local collapsed = Section:IsCollapsed()
```

### Komponen Bagian

```lua
Section:CreateLabel(...)
Section:CreateParagraph(...)
Section:CreateDivider()
Section:CreateStatusBox(...)
Section:CreateButton(...)
Section:CreateToggle(...)
Section:CreateInput(...)
Section:CreateDropdown(...)
Section:CreateKeybind(...)
Section:CreateSlider(...)
```

---

# 5. Label

### `Section:CreateLabel(text)`

```lua
Section:CreateLabel("Ini adalah label")
```

Mengembalikan instance `TextLabel` yang dibuat.

---

# 6. Paragraf

### `Section:CreateParagraph(options)`

```lua
local Paragraph = Section:CreateParagraph({
    Title = "Informasi",
    Content = "Ini adalah paragraf informasi."
})
```

API:

```lua
Paragraph:SetTitle("Judul Baru")
Paragraph:SetContent("Isi Baru")
Paragraph:Set("Isi Baru")
```

---

# 7. Pemisah

### `Section:CreateDivider()`

```lua
local Divider = Section:CreateDivider()
```

Membuat pemisah visual.

---

# 8. Kotak Status

### `Section:CreateStatusBox(options)`

```lua
local Status = Section:CreateStatusBox({
    Type = "success",
    Title = "Berhasil",
    Content = "Semuanya sudah siap."
})
```

Jenis status yang didukung:

- `info`
- `success`
- `warning`
- `error`

API:

```lua
Status:SetTitle("Judul Baru")
Status:SetContent("Isi Baru")
Status:SetType("warning")
```

---

# 9. Tombol

### `Section:CreateButton(options)`

```lua
Section:CreateButton({
    Name = "Jalankan",
    Callback = function()
        print("Berhasil dijalankan")
    end
})
```

Pilihan yang didukung:

- `Name`
- `Callback`

Callback dijalankan ketika tombol diklik.

---

# 10. Sakelar

### `Section:CreateToggle(options)`

```lua
local Toggle = Section:CreateToggle({
    Name = "ESP",
    Default = false,
    Callback = function(value)
        print("ESP:", value)
    end
})
```

Pilihan yang digunakan saat ini:

- `Name`
- `Default`
- `Callback`
- `Id`
- `ConfigIgnore`

API:

```lua
Toggle:Set(true)
Toggle:Set(false)

local value = Toggle:Get()

Toggle:SetTitle("Judul Baru")
Toggle:SetVisible(true)
Toggle:SetVisible(false)
```

`Set(value, false)` dapat digunakan jika callback tidak ingin dijalankan.

---

# 11. Masukan

### `Section:CreateInput(options)`

```lua
local Input = Section:CreateInput({
    Name = "Nama Pemain",
    Placeholder = "Masukkan nama...",
    Default = "",
    Callback = function(text, enterPressed)
        print(text, enterPressed)
    end
})
```

Implementasi saat ini mengembalikan instance `TextBox` Roblox secara langsung.

Pilihan yang digunakan saat ini:

- `Placeholder`
- `Default`
- `Callback`
- `Id`
- `ConfigIgnore`

Callback dijalankan ketika `FocusLost`.

---

# 12. Daftar Pilihan

### `Section:CreateDropdown(options)`

Implementasi saat ini mendukung mode satu pilihan dan banyak pilihan.

## Satu Pilihan

```lua
local Dropdown = Section:CreateDropdown({
    Name = "Mode",
    Values = {"Mudah", "Normal", "Sulit"},
    Default = "Normal",
    Multi = false,
    Search = true,
    Callback = function(value)
        print(value)
    end
})
```

## Banyak Pilihan

```lua
local Dropdown = Section:CreateDropdown({
    Name = "Fitur",
    Values = {"ESP", "Aimbot", "Kecepatan"},
    Default = {"ESP", "Kecepatan"},
    Multi = true,
    Search = true,
    MaxSelected = 2,
    Callback = function(values)
        print(values)
    end
})
```

Pilihan yang digunakan saat ini:

- `Name`
- `Values`
- `Default`
- `Multi`
- `Search`
- `SearchPlaceholder`
- `MaxSelected`
- `MaxSelectedCallback`
- `Callback`
- `Id`
- `ConfigIgnore`

### API Daftar Pilihan

```lua
Dropdown:Set(value, fireCallback)
Dropdown:Get()

Dropdown:SetValue(value, fireCallback)
Dropdown:GetValue()

Dropdown:SetVisible(true)
Dropdown:SetVisible(false)

Dropdown:SetTitle("Judul Baru")

Dropdown:IsMulti()
```

Untuk Daftar Pilihan Banyak:

```lua
Dropdown:SelectAll(fireCallback)
Dropdown:DeselectAll(fireCallback)
Dropdown:ClearSelection(fireCallback)

Dropdown:GetMaxSelected()
Dropdown:SetMaxSelected(limit, fireCallback)
```

Pilihan:

```lua
Dropdown:AddOption("Pilihan Baru")
Dropdown:RemoveOption("Pilihan Baru")

Dropdown:SetValues({
    "A",
    "B",
    "C"
}, fireCallback)
```

Pencarian:

```lua
Dropdown:SetSearch("abc")

local search = Dropdown:GetSearch()

Dropdown:ClearSearch()
```

Penghapusan umum:

```lua
Dropdown:Clear(fireCallback)
```

### Status Pilihan

Implementasi secara khusus melacak pilihan yang sedang dipilih.

Pilihan yang sedang dipilih ditampilkan dengan:

- teks aksen
- tanda centang
- garis tepi aksen

Hal ini berlaku untuk mode satu pilihan dan banyak pilihan.

---

# 13. Tombol Pintas

### `Section:CreateKeybind(options)`

```lua
local Keybind = Section:CreateKeybind({
    Name = "Sakelar Antarmuka",
    Default = Enum.KeyCode.RightShift,

    Callback = function(key)
        print("Pressed:", key.Name)
    end,

    Changed = function(key)
        print("Changed:", key.Name)
    end
})
```

Pilihan yang digunakan saat ini:

- `Name`
- `Default`
- `Callback`
- `Changed`
- `Id`
- `ConfigIgnore`

API:

```lua
Keybind:Set(Enum.KeyCode.F)
local key = Keybind:Get()
```

Mengklik kontrol tombol pintas akan masuk ke mode mendengarkan dan menunggu tombol pada papan ketik.

---

# 14. Penggeser

### `Section:CreateSlider(options)`

```lua
local Slider = Section:CreateSlider({
    Name = "Kecepatan Berjalan",
    Min = 0,
    Max = 100,
    Default = 50,
    Step = 5,
    Decimals = 0,

    Callback = function(value)
        print(value)
    end
})
```

Pilihan yang digunakan saat ini:

- `Name`
- `Min`
- `Minimum`
- `Max`
- `Maximum`
- `Default`
- `Step`
- `Decimals`
- `Callback`
- `Id`
- `ConfigIgnore`

### Slider API

```lua
Slider:Set(value, fireCallback)
Slider:SetValue(value, fireCallback)

local value = Slider:Get()
local value = Slider:GetValue()

Slider:SetMin(minimum, fireCallback)
Slider:SetMax(maximum, fireCallback)
Slider:SetStep(step, fireCallback)
Slider:SetDecimals(decimals, fireCallback)

local min = Slider:GetMin()
local max = Slider:GetMax()
local step = Slider:GetStep()
local decimals = Slider:GetDecimals()

Slider:SetTitle("Judul Baru")
Slider:SetVisible(true)
Slider:SetVisible(false)
```

`Step` diterapkan pada nilai sebenarnya.

Contoh:

```text
Min = 0
Max = 100
Step = 5

0, 5, 10, 15, ... 100
```

---

# 15. Notifikasi

### `Window:Notify(options)`

```lua
Window:Notify({
    Title = "Konfigurasi Tersimpan",
    Content = "Test1 berhasil disimpan.",
    Duration = 3
})
```

Pilihan yang didukung:

- `Title`
- `Content`
- `Duration`
- `Color`

Contoh:

```lua
Window:Notify({
    Title = "Berhasil",
    Content = "Operasi berhasil diselesaikan.",
    Duration = 3,
    Color = Color3.fromRGB(70, 215, 140)
})
```

Notifikasi muncul dengan animasi, menampilkan bilah kemajuan durasi, kemudian menghilang secara otomatis.

---

# 16. Pengelola Konfigurasi

### `Tab:CreateConfigManager(options)`

Pengelola Konfigurasi menyediakan:

- pemilih konfigurasi
- pencarian konfigurasi
- simpan
- muat
- hapus
- segarkan
- masukan nama konfigurasi

Contoh:

```lua
local ConfigUI = ConfigTab:CreateConfigManager({
    DefaultName = "Bawaan"
})
```

### API Pengelola Konfigurasi

```lua
ConfigUI:Refresh()

ConfigUI:Save("Utama")
ConfigUI:Load("Utama", false)
ConfigUI:Delete("Utama")

ConfigUI:Exists("Utama")

local configs = ConfigUI:List()

ConfigUI:GetName()
ConfigUI:SetName("Utama")

ConfigUI:GetSelector()
ConfigUI:GetInput()
```

Informasi penyimpanan game:

```lua
ConfigUI:GetGameId()
ConfigUI:GetGameName()
ConfigUI:GetGameFolder()
ConfigUI:GetConfigFolder()
```

---

# 17. API Konfigurasi Jendela

Jendela juga menyediakan fungsi konfigurasi berikut:

```lua
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
```

---

# 18. Penyimpanan Konfigurasi

Struktur penyimpanan saat ini adalah:

```text
LIB-PHILANX/
└── [PlaceName]_[GameId]/
    ├── Config1.json
    ├── Config2.json
    └── ...
```

Contoh:

```text
LIB-PHILANX/
└── Just a baseplate_9271746647/
    ├── Test1.json
    └── Test2.json
```

### Aturan Identitas

`GameId` merupakan identitas utama.

Nama tempat hanya digunakan sebagai awalan yang mudah dibaca.

Sistem pencari mencari folder yang sudah ada dan diakhiri dengan:

```text
_[GameId]
```

Karena itu, awalan nama yang mudah dibaca tidak menentukan identitas konfigurasi.

---

# 19. Serialisasi Konfigurasi

Serialisasi saat ini mendukung:

- `string`
- `number`
- `boolean`
- `nil`
- `table`
- `Color3`
- `EnumItem`

Dukungan `EnumItem` saat ini dapat mengembalikan `Enum.KeyCode`.

`Color3` disimpan dalam bentuk:

```lua
{
    __type = "Color3",
    r = value.R,
    g = value.G,
    b = value.B
}
```

---

# 20. Pendaftaran Konfigurasi

Komponen dapat mendaftarkan dirinya ke:

```lua
ConfigManager:Register(
    id,
    controlType,
    control
)
```

Kontrol yang didaftarkan oleh komponen bawaan akan dikumpulkan ketika penyimpanan dilakukan.

`ConfigIgnore = true` membuat komponen tidak didaftarkan.

---

# 21. Sistem Pemuatan

Library memiliki pengelola pemuatan yang melacak proses pembuatan komponen.

Bobot beban kerja komponen saat ini meliputi:

- Window
- Sidebar
- Tab
- Section
- Label
- Paragraph
- Divider
- StatusBox
- Button
- Toggle
- Input
- Dropdown
- Keybind
- Slider

Layar pemuatan menampilkan:

- status proses
- persentase
- jumlah komponen yang sudah diproses
- beban kerja

Library utama tetap dinonaktifkan sampai proses pemuatan selesai.

---

# 22. Catatan Penyelesaian Saat Ini

Source saat ini memiliki karakteristik yang sudah terkonfirmasi berikut:

### Sudah selesai

- jendela utama
- tab
- bagian
- komponen tampilan
- Button
- Toggle
- Input
- Slider
- daftar pilihan satu
- daftar pilihan banyak
- pencarian daftar pilihan
- Keybind
- StatusBox
- Paragraph
- Divider
- Notification
- muating screen
- Config Manager
- penyimpanan konfigurasi berdasarkan GameId

### Tidak termasuk target fitur akhir saat ini

- pemuatan otomatis
- penyimpanan otomatis
- penggantian nama konfigurasi
- ekspor konfigurasi
- impor konfigurasi
- peningkatan baru pada daftar pilihan
- peningkatan baru pada tombol pintas
- peningkatan baru pada jendela

### Bagian penyelesaian yang masih perlu diperiksa

- pengujian regresi
- kecocokan konfigurasi pada semua komponen yang terdaftar
- perilaku penghancuran dan pembersihan
- perilaku tema
- kecocokan dengan pelaksana
- pengujian kondisi khusus dan kesalahan
- catatan perubahan dan versi rilis akhir

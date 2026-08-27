# LIB-PHILANX UI Library

Library UI Roblox yang ringan, sederhana, dan dapat dikembangkan.

> Versi saat ini: **1.3.0**

## Tentang

LIB-PHILANX adalah UI Library buatan sendiri dengan API yang sederhana dan komponen UI yang dapat digunakan kembali.

Fitur yang tersedia saat ini:

- Window
- Tab
- Icon Tab
- Section
- Button
- Toggle
- Slider
- Dropdown
- Input
- Label
- Paragraph
- Divider
- Status Box
- Notification
- Notification Stack
- Kontrol visibilitas Window
- Kontrol Title dan Subtitle Window

**Global Keybind sengaja tidak digunakan.**

---

# Struktur Repository

```text
LIB-PHILANX/
├── src/
│   └── UILibrary.lua
├── examples/
│   └── Example.lua
└── docs/
    └── API.md
```

File utama library berada di:

```text
src/UILibrary.lua
```

---

# Penggunaan Dasar

Struktur dasar penggunaan library:

```lua
local UILibrary = ...

local Window = UILibrary:CreateWindow({
    Title = "LIB-PHILANX",
    Subtitle = "UI Saya"
})

local Tab = Window:CreateTab({
    Name = "Player"
})

local Section = Tab:CreateSection("Testing")
```

Komponen UI kemudian dibuat di dalam `Section`.

---

# Window

## CreateWindow

Digunakan untuk membuat Window utama.

```lua
local Window = UILibrary:CreateWindow({
    Title = "LIB-PHILANX",
    Subtitle = "UI Saya",
    Size = UDim2.fromOffset(650, 450)
})
```

### Parameter

| Parameter | Tipe | Keterangan |
|---|---|---|
| `Title` | string | Judul Window |
| `Subtitle` | string | Subjudul Window |
| `Size` | UDim2 | Ukuran Window |

---

# Tab

## CreateTab

Membuat Tab baru.

```lua
local Tab = Window:CreateTab({
    Name = "Player"
})
```

### Tab dengan Icon

```lua
local Tab = Window:CreateTab({
    Name = "Player",
    Icon = "👤"
})
```

`Icon` bersifat opsional.

---

# Section

## CreateSection

Membuat Section di dalam Tab.

```lua
local Section = Tab:CreateSection("Player Settings")
```

Komponen seperti Button, Toggle, Slider, dan lainnya dapat dimasukkan ke dalam Section.

---

# Komponen

## Button

Membuat tombol.

```lua
Section:CreateButton({
    Name = "Test Button",

    Callback = function()
        print("Button ditekan")
    end
})
```

### Parameter

| Parameter | Tipe | Keterangan |
|---|---|---|
| `Name` | string | Nama/tulisan Button |
| `Callback` | function | Fungsi yang dijalankan saat Button ditekan |

---

## Toggle

Membuat tombol ON/OFF.

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

Mengubah nilai Toggle:

```lua
Toggle:Set(true)
Toggle:Set(false)
```

Mengambil nilai Toggle:

```lua
local value = Toggle:Get()
```

---

## Slider

Membuat Slider dengan nilai minimum dan maksimum.

```lua
local Slider = Section:CreateSlider({
    Name = "WalkSpeed",
    Min = 0,
    Max = 100,
    Default = 16,

    Callback = function(value)
        print("Nilai Slider:", value)
    end
})
```

### API

Mengubah nilai:

```lua
Slider:Set(50)
```

Mengambil nilai:

```lua
local value = Slider:Get()
```

---

## Dropdown

Membuat daftar pilihan.

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
        print("Pilihan:", value)
    end
})
```

### API

Mengubah pilihan:

```lua
Dropdown:Set("Debug")
```

Mengambil pilihan:

```lua
local value = Dropdown:Get()
```

---

## Input

Membuat kotak input teks.

```lua
Section:CreateInput({
    Placeholder = "Masukkan teks...",

    Callback = function(text, enterPressed)
        print("Teks:", text)
        print("Enter:", enterPressed)
    end
})
```

---

# Label

Digunakan untuk menampilkan teks sederhana.

```lua
Section:CreateLabel("Ini adalah sebuah label.")
```

---

# Paragraph

Digunakan untuk membuat kotak informasi yang memiliki judul dan isi.

```lua
local Paragraph = Section:CreateParagraph({
    Title = "Informasi",
    Content = "Ini adalah contoh isi paragraph."
})
```

### API

Mengubah judul:

```lua
Paragraph:SetTitle("Judul Baru")
```

Mengubah isi:

```lua
Paragraph:SetContent("Isi baru")
```

Atau:

```lua
Paragraph:Set("Isi baru")
```

---

# Divider

Membuat garis pemisah.

```lua
Section:CreateDivider()
```

---

# Status Box

Membuat kotak informasi dengan status tertentu.

Tipe yang tersedia:

- `info`
- `success`
- `warning`
- `error`

### Contoh

```lua
local Status = Section:CreateStatusBox({
    Type = "success",
    Title = "Berhasil",
    Content = "Operasi berhasil dilakukan."
})
```

### API

Mengubah judul:

```lua
Status:SetTitle("Judul Baru")
```

Mengubah isi:

```lua
Status:SetContent("Isi baru")
```

Mengubah tipe:

```lua
Status:SetType("warning")
```

---

# Notification

Membuat notifikasi.

```lua
Window:Notify({
    Title = "Berhasil",
    Content = "Operasi berhasil dilakukan.",
    Duration = 3
})
```

Beberapa Notification dapat ditampilkan secara bersamaan dan akan tersusun secara vertikal.

### Warna Notification

Warna dapat diubah menggunakan `Color`.

```lua
Window:Notify({
    Title = "Peringatan",
    Content = "Harap berhati-hati.",
    Duration = 3,
    Color = Color3.fromRGB(255, 190, 70)
})
```

---

# Kontrol Window

## SetVisible

Menampilkan atau menyembunyikan seluruh UI.

```lua
Window:SetVisible(true)
Window:SetVisible(false)
```

---

## Toggle

Mengubah status tampilan UI.

```lua
Window:Toggle()
```

---

## IsVisible

Mengambil status tampilan UI.

```lua
local visible = Window:IsVisible()

print(visible)
```

---

## Destroy

Menghapus UI.

```lua
Window:Destroy()
```

---

# Mengubah Title

Judul Window dapat diubah setelah Window dibuat.

```lua
Window:SetTitle("Judul Baru")
```

Mengambil judul saat ini:

```lua
local title = Window:GetTitle()

print(title)
```

---

# Mengubah Subtitle

Subtitle Window dapat diubah setelah Window dibuat.

```lua
Window:SetSubtitle("Subtitle Baru")
```

Mengambil subtitle saat ini:

```lua
local subtitle = Window:GetSubtitle()

print(subtitle)
```

---

# Versioning

LIB-PHILANX menggunakan format versi:

```text
MAJOR.MINOR.PATCH
```

Contoh:

```text
1.0.0
1.1.0
1.2.0
1.3.0
```

Riwayat versi:

### v1.0.0
Versi awal library.

### v1.1.0
Menambahkan:

- Keybind component
- Window visibility control
- Window destroy control

### v1.2.0
Menambahkan:

- Notification Stack
- Notification Progress Bar
- Tab Icon
- Tab Hover Animation

### v1.3.0
Menambahkan:

- Label
- Paragraph
- Divider
- Status Box
- Window Title API
- Window Subtitle API

---

# Roadmap

Fitur yang kemungkinan akan dikembangkan selanjutnya:

- Layout yang lebih responsif
- Komponen UI tambahan
- Sistem Theme yang lebih lengkap
- Perubahan Theme secara runtime
- Sistem cleanup yang lebih baik
- Dokumentasi yang lebih lengkap
- Optimasi performa
- Peningkatan tampilan dan animasi

Fitur yang tidak diperlukan tidak akan ditambahkan hanya untuk menaikkan nomor versi.

---

# Lisensi

Informasi lisensi akan ditambahkan setelah lisensi proyek ditentukan.

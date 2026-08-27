# LIB-PHILANX

> UI Library Roblox yang ringan, sederhana, dan mudah dikembangkan.

**Versi saat ini: `1.3.0`**

---

## 📖 Tentang

**LIB-PHILANX** adalah UI Library custom untuk Roblox yang dibuat dengan fokus pada:

- API yang sederhana
- Tampilan yang bersih
- Komponen yang dapat digunakan kembali
- Mudah dikembangkan
- Dokumentasi yang jelas
- Menjaga kompatibilitas API antar versi

Library ini dikembangkan secara bertahap sehingga fitur yang sudah stabil sebisa mungkin tidak diubah secara sembarangan.

> Global Keybind tidak digunakan dalam library ini.

---

## ✨ Fitur

Saat ini LIB-PHILANX mendukung:

- 🪟 Window
- 📑 Tab
- 🖼️ Tab Icon
- 📦 Section
- 🔘 Button
- 🔄 Toggle
- 🎚️ Slider
- 📋 Dropdown
- 📝 Input
- 🔤 Label
- 📄 Paragraph
- ➖ Divider
- ℹ️ Status Box
- 🔔 Notification
- 📚 Notification Stack
- 🎨 Theme dasar
- 👁️ Kontrol visibilitas Window
- 🏷️ Kontrol Title dan Subtitle Window
- 🗑️ Window Destroy API

---

## 📂 Struktur Repository

```text
LIB-PHILANX/
├── src/
│   └── UILibrary.lua
├── examples/
│   └── Example.lua
├── docs/
│   └── API.md
├── README.md
└── LICENSE
```

### `src/`

Berisi kode utama library.

### `examples/`

Berisi contoh penggunaan library.

### `docs/`

Berisi dokumentasi API.

---

## 🚀 Memulai

Library utama berada di:

```text
src/UILibrary.lua
```

Untuk pengujian melalui loader, gunakan file raw GitHub dari repository ini.

> Pastikan URL loader mengarah ke branch dan path file library yang benar.

---

## 🧩 Contoh Dasar

Struktur penggunaan library:

```lua
local UILibrary = ...

local Window = UILibrary:CreateWindow({
    Title = "LIB-PHILANX",
    Subtitle = "UI Saya",
    Size = UDim2.fromOffset(650, 450)
})

local Tab = Window:CreateTab({
    Name = "Player",
    Icon = "👤"
})

local Section = Tab:CreateSection("Testing")

Section:CreateButton({
    Name = "Test Button",

    Callback = function()
        print("Button ditekan")
    end
})
```

Untuk dokumentasi API lengkap, lihat:

```text
docs/API.md
```

---

## 🧱 Komponen

### Button

```lua
Section:CreateButton({
    Name = "Button",

    Callback = function()
        print("Klik!")
    end
})
```

### Toggle

```lua
Section:CreateToggle({
    Name = "Toggle",
    Default = false,

    Callback = function(value)
        print(value)
    end
})
```

### Slider

```lua
Section:CreateSlider({
    Name = "Slider",
    Min = 0,
    Max = 100,
    Default = 50,

    Callback = function(value)
        print(value)
    end
})
```

### Dropdown

```lua
Section:CreateDropdown({
    Name = "Mode",

    Values = {
        "Normal",
        "Testing",
        "Debug"
    },

    Default = "Normal",

    Callback = function(value)
        print(value)
    end
})
```

### Notification

```lua
Window:Notify({
    Title = "Berhasil",
    Content = "Operasi berhasil.",
    Duration = 3
})
```

---

## 📚 Dokumentasi

Dokumentasi API lengkap:

`docs/API.md`

Dokumentasi akan diperbarui setiap kali terdapat perubahan API yang signifikan.

---

## 🔄 Versi

### v1.0.0

Versi awal library.

Komponen dasar:

- Window
- Tab
- Section
- Button
- Toggle
- Slider
- Dropdown
- Input
- Notification

### v1.1.0

Menambahkan:

- Keybind Component
- Window Visibility API
- Window Destroy API

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

## 🛠️ Roadmap

Pengembangan berikutnya direncanakan mencakup:

- [ ] Theme System yang lebih lengkap
- [ ] Theme dapat diubah saat runtime
- [ ] Komponen UI tambahan
- [ ] Layout yang lebih responsif
- [ ] Sistem cleanup yang lebih baik
- [ ] Optimasi performa
- [ ] Dokumentasi API yang lebih lengkap
- [ ] Contoh penggunaan yang lebih lengkap

Roadmap dapat berubah mengikuti kebutuhan library.

---

## 🤝 Kontribusi

Jika repository ini nantinya dibuka untuk kontribusi, perubahan sebaiknya:

1. Tidak merusak API yang sudah ada.
2. Memperbaiki bug dengan perubahan seminimal mungkin.
3. Menambahkan dokumentasi untuk API baru.
4. Menggunakan penamaan fungsi yang konsisten.
5. Mengikuti struktur repository yang sudah ada.

---

## 📄 Lisensi

Lisensi proyek akan ditentukan secara terpisah.

Sebelum lisensi resmi ditambahkan, jangan menganggap repository ini memiliki izin penggunaan, distribusi, atau modifikasi yang berbeda dari hak yang diberikan oleh pemilik repository.

---

## 👤 LIB-PHILANX

Dibangun secara bertahap dengan fokus pada UI yang sederhana, rapi, dan mudah digunakan.

# Compact Desktop Indicator

> A sleek, minimalistic, and highly configurable virtual desktop pager widget for the KDE Plasma 6 desktop panel.

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![KDE Plasma](https://img.shields.io/badge/KDE-Plasma%206-brightgreen.svg)](https://kde.org/plasma-desktop/)
[![Platform](https://img.shields.io/badge/Platform-Wayland%20%2F%20X11-orange.svg)](#)

---

**Compact Desktop Indicator** is a modern virtual desktop pager designed for clean, aesthetic panel setups. It offers two customizable display types: classic minimalistic **Dots** and modern **Waybar-Style Rectangles** showing the active desktop numbers.

## ✨ Features

- 🎭 **Dual Display Styles:**
  - **Dots (Circles):** Subtle, modern indicator dots.
  - **Rectangles (Waybar Style):** Pill/box indicators displaying the desktop number.
- 📐 **Adaptive Orientation:** Dynamically adjusts its layout direction (horizontal vs. vertical) based on the panel's current form factor.
- 🎨 **Deep Color Customization:**
  - Auto-integrates with your current system active theme colors.
  - Toggle off system defaults to configure custom active/inactive background and text colors.
- 🌫️ **Adaptive/Transparent Background:** Blends seamlessly with your panel's current theme, or drops the background structure entirely for a clean floating appearance.
- ✨ **Premium Micro-Animations:** Fades colors and opacity transitions smoothly when switching virtual desktops (150ms).
- 🖱️ **Interactive Hover Feedback:** Inactive buttons/dots light up dynamically when hovered, giving clear interactive responses without changing your system cursor.
- 💬 **Desktop Names Tooltips:** Hovering over any indicator shows a tooltip with the desktop's configured name.

---

## 🛠️ Installation & Packaging

### Option 1: Local Installation (Development)
To install the widget to your local user directory (`~/.local/share/plasma/plasmoids/`):

```bash
# Clone the repository
git clone git@github.com:txmydev/kde-compact-desktop-indicator.git
cd kde-compact-desktop-indicator

# Install package
kpackagetool6 -t Plasma/Applet -i package/
```

### Option 2: Upgrading an Existing Installation
When making modifications or updating to the latest commit:

```bash
kpackagetool6 -t Plasma/Applet -u package/
```

> [!NOTE]
> If changes do not reflect in your panel immediately, restart the Plasma shell:
> `plasmashell --replace & disown`

### Option 3: Uninstalling
To completely remove the widget:

```bash
kpackagetool6 -t Plasma/Applet -r org.kde.plasma.minimaldesktopindicators
```

---

## ⚙️ Configuration Options

Open the **General Settings** panel from the widget's context menu to customize the following properties:

| Setting Group | Option Name | Type | Description |
| :--- | :--- | :--- | :--- |
| **Layout** | **Display Style** | Enum | Switch between `Dots (Circles)` and `Rectangles (Waybar Style)`. |
| | **Indicator Spacing** | Integer | Spacing in pixels between the indicators. |
| | **Background** | Boolean | Toggle whether to blend widget background with the panel theme. |
| **Colors** | **Use System Theme Colors** | Boolean | Fallback to KDE theme highlighted colors. |
| | **Active Desktop Background** | Color | Custom background color for the active desktop. |
| | **Inactive Desktop Background**| Color | Custom background color for inactive desktops. |
| | **Active Text Color** | Color | Custom number text color for active desktop (Rectangles mode). |
| | **Inactive Text Color** | Color | Custom number text color for inactive desktops (Rectangles mode). |
| **Sizing** | **Indicator Size** | Integer | Indicator diameter in pixels (Dots mode). |
| | **Button Width / Height** | Integer | Dimensions of the indicator box (Rectangles mode). |
| | **Border Radius** | Integer | Border roundness (Rectangles mode). |
| | **Font Size** | Integer | Workspace index text size (Rectangles mode). |

---

## 🧪 Testing in Standalone Window

If you are developing or testing tweaks, you can view the widget in a standalone test frame using `plasmoidviewer`:

```bash
plasmoidviewer -a package/
```
*(Requires `plasma-sdk` package in your distribution).*

---

## 🤝 Contributing

Contributions are welcome! Please open an issue or submit a pull request with any fixes, localization strings, or feature enhancements.

1. Fork the Repository.
2. Create your Feature Branch (`git checkout -b feature/amazing-feature`).
3. Commit your changes (`git commit -m 'Add some amazing feature'`).
4. Push to the branch (`git push origin feature/amazing-feature`).
5. Open a Pull Request.

## 📄 License

Distributed under the **GPL-3.0-or-later** License. See `LICENSE` for more information.

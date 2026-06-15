# Compact Desktop Indicator

A minimalistic Virtual Desktop indicator widget for KDE Plasma 6 (Frameworks 6) that displays a horizontal or vertical row of indicators representing your virtual desktops.

## Features

- **Responsive Orientation:** Automatically aligns horizontally in horizontal panels and vertically in vertical panels.
- **Custom Visuals:** Fully customizable colors, indicator size, and indicator spacing.
- **System Theme Integration:** Falls back to system highlight and text colors by default, but allows overriding.
- **Seamless Blending:** Adaptive background option that toggles between drawing the theme's default panel background and complete transparency/seamless blending.
- **Smooth Animations:** Fades color and opacity changes when switching virtual desktops.
- **Interactive Hover:** Visual micro-feedback on hovering over inactive indicators.
- **Tooltips:** Shows the virtual desktop name when hovering over a dot.

---

## File Structure

```text
kde-plasma-workspaces-widget/
├── README.md
└── package/
    ├── metadata.json              # Applet identity and Plasma 6 requirements
    └── contents/
        ├── config/
        │   ├── main.xml           # Configuration schema (types & defaults)
        │   └── config.qml         # Binds config pages to settings
        └── ui/
            ├── main.qml           # Widget main window
            └── configGeneral.qml  # Widget settings interface
```

---

## Installation & Packaging

### Local Installation
To install the widget for your current user, run the following command from the project root:

```bash
kpackagetool6 -t Plasma/Applet -i package/
```

### Upgrading an Existing Installation
If you modify the widget's code and want to apply the changes, run:

```bash
kpackagetool6 -t Plasma/Applet -u package/
```

### Uninstalling the Widget
To remove the widget from your system, run:

```bash
kpackagetool6 -t Plasma/Applet -r org.kde.plasma.minimaldesktopindicators
```

---

## Testing / Development

You can test the widget in a standalone test window without installing it or restarting your Plasma session by using `plasmoidviewer`:

```bash
plasmoidviewer -a package/
```

> [!NOTE]
> `plasmoidviewer` is part of the `plasma-sdk` package in most distributions (e.g., `sudo apt install plasma-sdk` on Debian/Ubuntu or `sudo pacman -S plasma-sdk` on Arch Linux).

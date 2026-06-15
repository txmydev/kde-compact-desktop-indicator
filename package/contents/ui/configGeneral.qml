import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.kquickcontrols as KQuickControls

Kirigami.FormLayout {
    id: formLayout

    // Bindings to plasmoid.configuration using property aliases with cfg_ prefix
    property string cfg_displayType: displayTypeCombo.currentValue
    property alias cfg_useSystemColors: useSystemColorsCheckbox.checked
    property alias cfg_activeColor: activeColorButton.color
    property alias cfg_inactiveColor: inactiveColorButton.color
    property alias cfg_activeTextColor: activeTextColorButton.color
    property alias cfg_inactiveTextColor: inactiveTextColorButton.color
    property alias cfg_indicatorSize: sizeSlider.value
    property alias cfg_indicatorSpacing: spacingSlider.value
    property alias cfg_buttonWidth: widthSlider.value
    property alias cfg_buttonHeight: heightSlider.value
    property alias cfg_borderRadius: radiusSlider.value
    property alias cfg_fontSize: fontSlider.value
    property alias cfg_backgroundBlending: blendingSwitch.checked

    // Safe model array for index searching on completed
    readonly property var displayTypesModel: [
        { text: i18n("Dots (Circles)"), value: "dots" },
        { text: i18n("Rectangles (Waybar Style)"), value: "rectangles" }
    ]

    // --- SECTION 1: DISPLAY & LAYOUT ---
    Kirigami.Separator {
        Kirigami.FormData.label: i18n("Layout Settings")
        Kirigami.FormData.isSection: true
    }

    ComboBox {
        id: displayTypeCombo
        Kirigami.FormData.label: i18n("Display Style:")
        textRole: "text"
        valueRole: "value"
        model: formLayout.displayTypesModel
        onActivated: {
            cfg_displayType = currentValue
        }
        Component.onCompleted: {
            for (var i = 0; i < formLayout.displayTypesModel.length; i++) {
                if (formLayout.displayTypesModel[i].value === plasmoid.configuration.displayType) {
                    currentIndex = i;
                    break;
                }
            }
        }
    }

    Slider {
        id: spacingSlider
        Kirigami.FormData.label: i18n("Indicator Spacing (px):")
        from: 2
        to: 32
        stepSize: 1

        Label {
            anchors.left: parent.left
            anchors.bottom: parent.top
            text: parent.value
            visible: parent.pressed
        }
    }

    Switch {
        id: blendingSwitch
        Kirigami.FormData.label: i18n("Background:")
        text: i18n("Blend widget background with panel theme")
    }

    // --- SECTION 2: COLORS ---
    Item {
        Kirigami.FormData.isSection: true
    }

    Kirigami.Separator {
        Kirigami.FormData.label: i18n("Color Customization")
        Kirigami.FormData.isSection: true
    }

    CheckBox {
        id: useSystemColorsCheckbox
        Kirigami.FormData.label: i18n("Colors:")
        text: i18n("Use system theme colors")
    }

    KQuickControls.ColorButton {
        id: activeColorButton
        Kirigami.FormData.label: i18n("Active Desktop Background:")
        enabled: !useSystemColorsCheckbox.checked
        color: enabled ? plasmoid.configuration.activeColor : Kirigami.Theme.highlightColor
    }

    KQuickControls.ColorButton {
        id: inactiveColorButton
        Kirigami.FormData.label: i18n("Inactive Desktop Background:")
        enabled: !useSystemColorsCheckbox.checked
        color: enabled ? plasmoid.configuration.inactiveColor : Kirigami.Theme.textColor
    }

    KQuickControls.ColorButton {
        id: activeTextColorButton
        Kirigami.FormData.label: i18n("Active Text Color:")
        visible: displayTypeCombo.currentValue === "rectangles"
        enabled: !useSystemColorsCheckbox.checked
        color: enabled ? plasmoid.configuration.activeTextColor : Kirigami.Theme.highlightedTextColor
    }

    KQuickControls.ColorButton {
        id: inactiveTextColorButton
        Kirigami.FormData.label: i18n("Inactive Text Color:")
        visible: displayTypeCombo.currentValue === "rectangles"
        enabled: !useSystemColorsCheckbox.checked
        color: enabled ? plasmoid.configuration.inactiveTextColor : Kirigami.Theme.textColor
    }

    // --- SECTION 3: SIZING & DIMENSIONS ---
    Item {
        Kirigami.FormData.isSection: true
    }

    Kirigami.Separator {
        Kirigami.FormData.label: i18n("Sizing & Dimensions")
        Kirigami.FormData.isSection: true
    }

    Slider {
        id: sizeSlider
        Kirigami.FormData.label: i18n("Indicator Size (px):")
        visible: displayTypeCombo.currentValue === "dots"
        from: 4
        to: 32
        stepSize: 1
        
        Label {
            anchors.left: parent.left
            anchors.bottom: parent.top
            text: parent.value
            visible: parent.pressed
        }
    }

    Slider {
        id: widthSlider
        Kirigami.FormData.label: i18n("Button Width (px):")
        visible: displayTypeCombo.currentValue === "rectangles"
        from: 8
        to: 120
        stepSize: 1
        
        Label {
            anchors.left: parent.left
            anchors.bottom: parent.top
            text: parent.value
            visible: parent.pressed
        }
    }

    Slider {
        id: heightSlider
        Kirigami.FormData.label: i18n("Button Height (px):")
        visible: displayTypeCombo.currentValue === "rectangles"
        from: 8
        to: 64
        stepSize: 1
        
        Label {
            anchors.left: parent.left
            anchors.bottom: parent.top
            text: parent.value
            visible: parent.pressed
        }
    }

    Slider {
        id: radiusSlider
        Kirigami.FormData.label: i18n("Border Radius (px):")
        visible: displayTypeCombo.currentValue === "rectangles"
        from: 0
        to: 32
        stepSize: 1
        
        Label {
            anchors.left: parent.left
            anchors.bottom: parent.top
            text: parent.value
            visible: parent.pressed
        }
    }

    Slider {
        id: fontSlider
        Kirigami.FormData.label: i18n("Font Size (pt):")
        visible: displayTypeCombo.currentValue === "rectangles"
        from: 6
        to: 24
        stepSize: 1
        
        Label {
            anchors.left: parent.left
            anchors.bottom: parent.top
            text: parent.value
            visible: parent.pressed
        }
    }
}

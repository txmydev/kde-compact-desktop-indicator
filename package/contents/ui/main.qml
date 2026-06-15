import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami as Kirigami
import org.kde.taskmanager as TaskManager

PlasmoidItem {
    id: root

    // Tell Plasmoid to show in Full Representation (always show the indicators row/col)
    preferredRepresentation: PlasmoidItem.FullRepresentation

    // Toggle background based on backgroundBlending configuration
    Plasmoid.backgroundHints: plasmoid.configuration.backgroundBlending 
        ? PlasmaCore.Types.DefaultBackground 
        : PlasmaCore.Types.NoBackground

    // Detect if we are in a vertical panel or vertical layout
    readonly property bool isVertical: plasmoid.formFactor === PlasmaCore.Types.Vertical

    // TaskManager's VirtualDesktopInfo retrieves virtual desktop state and handles switching
    TaskManager.VirtualDesktopInfo {
        id: desktopInfo
    }

    // Determine colors dynamically (custom override or fallback to system colors)
    readonly property color activeColor: plasmoid.configuration.useSystemColors || plasmoid.configuration.activeColor === ""
        ? Kirigami.Theme.highlightColor 
        : plasmoid.configuration.activeColor

    readonly property color inactiveColor: plasmoid.configuration.useSystemColors || plasmoid.configuration.inactiveColor === ""
        ? Kirigami.Theme.textColor
        : plasmoid.configuration.inactiveColor

    readonly property color activeTextColor: plasmoid.configuration.useSystemColors || plasmoid.configuration.activeTextColor === ""
        ? Kirigami.Theme.highlightedTextColor
        : plasmoid.configuration.activeTextColor

    readonly property color inactiveTextColor: plasmoid.configuration.useSystemColors || plasmoid.configuration.inactiveTextColor === ""
        ? Kirigami.Theme.textColor
        : plasmoid.configuration.inactiveTextColor

    // Sizing depends on displayType
    readonly property int elementWidth: plasmoid.configuration.displayType === "dots" 
        ? plasmoid.configuration.indicatorSize 
        : plasmoid.configuration.buttonWidth

    readonly property int elementHeight: plasmoid.configuration.displayType === "dots" 
        ? plasmoid.configuration.indicatorSize 
        : plasmoid.configuration.buttonHeight

    // Expose preferred size to the panel layout manager using Layout attached properties
    // This allows the panel to size the widget container exactly to fit the dots.
    Layout.preferredWidth: isVertical 
        ? elementWidth + 8
        : (elementWidth * desktopInfo.desktopIds.length) + 
          (plasmoid.configuration.indicatorSpacing * (desktopInfo.desktopIds.length - 1)) + 8

    Layout.preferredHeight: isVertical 
        ? (elementHeight * desktopInfo.desktopIds.length) + 
          (plasmoid.configuration.indicatorSpacing * (desktopInfo.desktopIds.length - 1)) + 8
        : elementHeight + 8

    // Main layout container
    Item {
        id: mainContainer
        anchors.fill: parent

        // Grid automatically scales and positions dots vertically or horizontally
        Grid {
            anchors.centerIn: parent
            columns: root.isVertical ? 1 : desktopInfo.desktopIds.length
            spacing: plasmoid.configuration.indicatorSpacing

            Repeater {
                model: desktopInfo.desktopIds

                delegate: Rectangle {
                    id: indicator
                    
                    readonly property bool isDots: plasmoid.configuration.displayType === "dots"
                    width: isDots ? plasmoid.configuration.indicatorSize : plasmoid.configuration.buttonWidth
                    height: isDots ? plasmoid.configuration.indicatorSize : plasmoid.configuration.buttonHeight
                    radius: isDots ? width / 2 : plasmoid.configuration.borderRadius

                    readonly property bool isActive: modelData === desktopInfo.currentDesktop

                    // Background color configuration
                    color: {
                        if (isActive) {
                            return root.activeColor;
                        }
                        if (isDots) {
                            return root.inactiveColor;
                        }
                        // Waybar-style inactive button background (subtle transparent gray/theme text color)
                        return mouseArea.containsMouse 
                            ? Qt.rgba(root.inactiveColor.r, root.inactiveColor.g, root.inactiveColor.b, 0.25) 
                            : Qt.rgba(root.inactiveColor.r, root.inactiveColor.g, root.inactiveColor.b, 0.1);
                    }

                    // Opacity configuration
                    opacity: {
                        if (isDots) {
                            return isActive ? 1.0 : (mouseArea.containsMouse ? 0.7 : 0.4);
                        }
                        return 1.0; // Rectangle opacity is handled by colors/child opacities
                    }

                    // Premium border styling for waybar rectangles (subtle outline for structure)
                    border.width: isDots ? 0 : 1
                    border.color: isActive 
                        ? "transparent"
                        : Qt.rgba(root.inactiveColor.r, root.inactiveColor.g, root.inactiveColor.b, 0.15)

                    // Text for numbers (only visible in "rectangles" mode)
                    Text {
                        id: numberText
                        anchors.centerIn: parent
                        visible: !indicator.isDots
                        text: (index + 1).toString()
                        font.pointSize: plasmoid.configuration.fontSize
                        font.bold: indicator.isActive
                        
                        color: indicator.isActive ? root.activeTextColor : root.inactiveTextColor
                        opacity: indicator.isActive ? 1.0 : (mouseArea.containsMouse ? 0.9 : 0.6)

                        Behavior on color {
                            ColorAnimation { duration: 150 }
                        }
                        Behavior on opacity {
                            NumberAnimation { duration: 150 }
                        }
                    }

                    // Premium smooth transitions for color/opacity changes
                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                    Behavior on opacity {
                        NumberAnimation { duration: 150 }
                    }

                    // Tooltip display
                    ToolTip.text: desktopInfo.desktopNames[index] || ""
                    ToolTip.delay: 500
                    ToolTip.visible: mouseArea.containsMouse

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        
                        onClicked: {
                            desktopInfo.requestActivate(modelData);
                        }
                    }
                }
            }
        }
    }
}

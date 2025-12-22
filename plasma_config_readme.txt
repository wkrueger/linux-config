KDE Plasma Configuration Export
================================

Date: $(date)
Location: /home/willian/setup/plasma_config_backup/

PANEL CONFIGURATION
-------------------
Panel ID: 2
Location: Bottom (location=4)
Form Factor: Horizontal Panel (formfactor=2)
Visibility: Auto-hide (panelVisibility=2)
Floating: Yes (floating=1)
Opacity: Adaptive (panelOpacity=2)
Thickness: 50px
Panel Length Mode: Fill width (panelLengthMode=1)

PANEL WIDGETS (Left to Right)
------------------------------
Order: 3;4;27;5;6;7;8;21

1. Application Launcher (Kickoff) - Applet 3
   - Plugin: org.kde.plasma.kickoff
   - Keyboard Shortcut: Alt+F1
   - Favorites: browser, dolphin, elisa, konsole, pamac manager, systemsettings

2. Icons-Only Task Manager - Applet 4
   - Plugin: org.kde.plasma.icontasks
   - Launchers: file manager, konsole, browser
   - Show on all desktops: Yes (showOnlyCurrentDesktop=false)

3. Panel Spacer - Applet 27
   - Plugin: org.kde.plasma.panelspacer
   - Fixed size: 20px (not expanding)

4. Margins Separator - Applet 5
   - Plugin: org.kde.plasma.marginsseparator

5. Show Desktop - Applet 6
   - Plugin: org.kde.plasma.showdesktop

6. Pager (Virtual Desktops) - Applet 7
   - Plugin: org.kde.plasma.pager

7. System Tray - Applet 8
   - Plugin: org.kde.plasma.systemtray
   - Popup size: 432x432

   System Tray Items:
   - KDE Connect
   - Display Configuration (KScreen)
   - Camera Indicator
   - Clipboard
   - Device Notifier
   - Keyboard Indicator
   - Keyboard Layout
   - Input Method Manager
   - Notifications
   - Print Manager
   - Volume Control
   - Weather
   - Brightness Control
   - Bluetooth
   - Network Management
   - Battery Monitor

   Hidden Items: MSM Notifier, Package Manager, Yakuake, Brightness, Bluetooth,
                 Device Notifier, KScreen, KDE Connect, Keyboard Layout,
                 Keyboard Indicator, Weather

8. Digital Clock - Applet 21
   - Plugin: org.kde.plasma.digitalclock
   - Font: Monospace, size 8, weight 400
   - Date format: Custom (dd/MMM)
   - Auto font/size: Disabled
   - Popup size: 560x400

DESKTOP CONFIGURATION
---------------------
Desktop ID: 1
Activity: 0061fbd9-1d40-45e9-b001-86d5922055bc
Plugin: org.kde.plasma.folder (Folder View)
Wallpaper: org.kde.image
Form Factor: Desktop (formfactor=0)
Screen: 0 (1920x1080)

FILES BACKED UP
---------------
- plasma-org.kde.plasma.desktop-appletsrc  (Main panel/widget configuration)
- plasmashellrc                            (Panel appearance settings)
- plasma-localerc                          (Locale settings)
- plasmanotifyrc                           (Notification settings)
- plasmarc                                 (General Plasma settings)

RESTORATION
-----------
To restore this configuration on a new system or after reset:

1. Copy the backup directory to /home/willian/setup/plasma_config_backup/
2. Run: ./plasma_restore.sh
3. Or manually copy files:
   cp plasma_config_backup/* ~/.config/
4. Restart Plasma: kquitapp6 plasmashell && kstart6 plasmashell

NOTES
-----
- Panel configuration is stored in plasma-org.kde.plasma.desktop-appletsrc
- Panel appearance (floating, opacity) is in plasmashellrc
- Widget settings are embedded in the applets configuration file
- Some widgets may require additional packages to be installed
- Screen-specific layouts may need adjustment for different resolutions

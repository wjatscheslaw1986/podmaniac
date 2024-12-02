#!/bin/bash
mkdir -p icons
# Store gwenview's icon for a shortcut in your system
curl -o icons/gwenview.png https://raw.githubusercontent.com/KDE/gwenview/refs/heads/master/logo.png#!/bin/bash
# Store okular's icon for a shortcut in your system
curl -o icons/okular.png https://raw.githubusercontent.com/KDE/okular/refs/heads/master/icons/310-apps-okular.png#!/bin/bash
# Store vsc's icon for a shortcut in your system
curl -o vscicons.zip https://code.visualstudio.com/assets/branding/visual-studio-code-icons.zip && unzip vscicons.zip -d icons/ 
# Store sayorana's icon for a shortcut in your system
curl -o icons/sayonara.png https://gitlab.com/luciocarreras/sayonara-player/-/raw/master/resources/logos/128x128/apps/sayonara.png
# Store vlc's icon for a shortcut in your system
curl -o icons/vlc.png https://raw.githubusercontent.com/videolan/vlc/refs/heads/master/share/icons/256x256/vlc.png

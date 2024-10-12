#!/bin/bash
# Store vsc's icon for a shortcut in your system
curl -o vscicons.zip https://code.visualstudio.com/assets/branding/visual-studio-code-icons.zip && unzip vscicons.zip && cp visual-studio-code-icons/vscode.svg /usr/share/icons/hicolor/scalable/vscode.svg
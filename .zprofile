[ -s ~/.custom-theme ] && source ~/.custom-theme

if uwsm check may-start; then
    exec uwsm start hyprland.desktop
fi

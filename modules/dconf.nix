# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{
  config,
  pkgs,
  lib,
  ...
}:
with lib.hm.gvariant;
let
  settings = {
    # Some bullshite that I have to do because VScode keybindings conflicts with some keys
    # that Ubuntu has set to manage moving between windows and workspaces.
    #
    # If all else fails and this does not work, just do the below in a terminal:
    #
    # dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-up "['disabled']"
    # dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-down "['disabled']"
    # dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-down "['disabled']"
    # dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-up "['disabled']"
    "org/gnome/desktop/wm/keybindings" = {
      "close" = ["<Super>q"];
      "move-to-workspace-down" = [ ];
      "move-to-workspace-left" = [
        "<Super><Shift>Page_Up"
        "<Super><Shift><Alt>Left"
        "<Control><Shift><Alt>Left"
      ];
      "move-to-workspace-right" = [
        "<Super><Shift>Page_Down"
        "<Super><Shift><Alt>Right"
        "<Control><Shift><Alt>Right"
      ];
      "move-to-workspace-up" = [ ];
      "switch-to-workspace-down" = [ ];
      "switch-to-workspace-left" = [
        "<Super>Page_Up"
        "<Super><Alt>Left"
        "<Control><Alt>Left"
      ];
      "switch-to-workspace-right" = [
        "<Super>Page_Down"
        "<Super><Alt>Right"
        "<Control><Alt>Right"
      ];
      "switch-to-workspace-up" = [ ];
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout= "appmenu:minimize,maximize,close";
      "num-workspaces" = 2;
    };
    "org/gnome/mutter" = {
      "auto-maximize" = true;
      "dynamic-workspaces" = false;
      "workspaces-only-on-primary" = true;
      "overlay-key" = "Super_L";
    };
    "org/gnome/desktop/input-sources" = {
      sources = [ (mkTuple [ "xkb" "gb" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" ];
    };
    "org/gnome/desktop/interface" = {
      "clock-show-seconds" = true;
      "clock-show-weekday" = true;
      "color-scheme" = "prefer-dark";
      "enable-hot-corners" = true;
      "gtk-enable-primary-paste" = true;
      "cursor-size" = 32;
      "locate-pointer" = true;
      "monospace-font-name" = "Iosevka 11";
      "toolkit-accessibility" = false;
      # "cursor-theme" = "oxy-yellow";
      # "gtk-theme" = "Yaru-dark";
      # "icon-theme" = "Yaru-dark";
    };
    "org/gtk/gtk4/settings/file-chooser" = {
      "show-hidden" = true;
      "sort-directories-first" = true;
    };
    "org/gnome/GPaste" = {
      "open-centered" = true;
    };
    "org/gnome/Ptyxis" = {
      "cursor-blink-mode" = "on";
      "default-profile-uuid" = "dbc54e16f7f83352e135295d6ad13be4";
      "profile-uuids" = "['dbc54e16f7f83352e135295d6ad13be4', '6fa7b044c2c831e3184750c36ad14020']";
      "window-size" = "(uint32 217, uint32 33)";
    };
    "org/gnome/Ptyxis/Profiles/6fa7b044c2c831e3184750c36ad14020" = {
      "label" = "default";
      "scrollback-lines" = 9999;
    };
    "org/gnome/Ptyxis/Profiles/dbc54e16f7f83352e135295d6ad13be4" = {
      "bold-is-bright" = true;
      "label" = "profile-00";
      "scrollback-lines" = 99999999;
    };
    "org/gnome/Ptyxis/Shortcuts" = {
      "reset" = "<Control>l";
      "reset-and-clear" = "<Shift><Control>l";
    };
    "org/gnome/shell/extensions/tiling-assistant" = {
      "enable-tiling-popup" = false;
    };
    "org/gnome/shell/extensions/dash-to-dock" = {
      "apply-custom-theme" = true;
      "background-opacity" = 0.80000000000000004;
      "dash-max-icon-size" = 48;
      "disable-overview-on-startup" = false;
      "dock-position" = "BOTTOM";
      "extend-height" = false;
      "height-fraction" = 0.90000000000000002;
      "hot-keys" = false;
      "multi-monitor" = true;
      "preferred-monitor" = -2;
      "preferred-monitor-by-connector" = "DP-2";
      "scroll-action" = "cycle-windows";
      "show-apps-at-top" = true;
      "show-mounts-only-mounted" = true;
    };
    "org/gnome/shell" = {
      "disable-user-extensions" = false;
       # "enabled-extensions" = ['GPaste@gnome-shell-extensions.gnome.org', 'ubuntu-dock@ubuntu.com', 'tiling-assistant@ubuntu.com', 'dash-to-dock@micxgx.gmail.com', 'appindicatorsupport@rgcjonas.gmail.com', 'launch-new-instance@gnome-shell-extensions.gcampax.github.com', 'tiling-assistant@leleat-on-github'];
      "enabled-extensions" = with pkgs.gnomeExtensions; [
        "GPaste@gnome-shell-extensions.gnome.org"
        dash-to-dock.extensionUuid
        appindicator.extensionUuid
        launch-new-instance.extensionUuid
        # pop-shell.extensionUuid
        tiling-assistant.extensionUuid
      ];
    };
  };
in
{
  dconf = {
    enable = true;
    settings = settings;
    databases."user" = settings;
  };

  programs.gnome-shell.enable = true;
}

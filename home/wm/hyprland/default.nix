{
  config,
  pkgs,
  ...
}: let
  nvidiaEnv =
    if config.nvidiaSupport
    then [
      "LIBVA_DRIVER_NAME,nvidia"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
    ]
    else [];

  nvidiaCursor =
    if config.nvidiaSupport
    then {
      no_hardware_cursors = true;
    }
    else {};

  inherit (config.lib.stylix) colors;

  rgb = color: "rgb(${color})";
in {
  imports = [
    ../../programs/rofi
    ../../programs/waybar

    ../../services/hyprpaper

    ../../shared
  ];

  home.packages = with pkgs; [
    flameshot # Screenshot program
    grim # Screenshots
    libnotify # Notifications
    loupe # Image viewer
    nemo # File explorer
    networkmanagerapplet
    wl-clipboard # Clipboard support
  ];

  services = {
    network-manager-applet.enable = true;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
    };
  };

  xdg.portal = {
    extraPortals = [pkgs.xdg-desktop-portal-wlr];
    config.hyprland = {
      default = ["wlr" "gtk"];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
    plugins = [];
    settings = {
      # Custom definitions
      "$menu" = "rofi";
      "$menu-rbw" = "rofi-rbw";
      "$mod" = "SUPER";
      "$terminal" = "alacritty";

      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 3, myBezier"
          "windowsOut, 1, 3, default, popin 80%"
          "border, 1, 4, default"
          "borderangle, 0, 8, default"
          "fade, 1, 3, default"
          "workspaces, 1, 4, default"
        ];
      };

      bind = [
        "$mod, D, togglefloating,"

        # Menu bindings
        "$mod, SPACE, exec, $menu -modes 'drun,calc,emoji' -show 'drun'"
        "$mod SHIFT, SPACE, exec, $menu-rbw"
        "$mod SHIFT, S, exec, $menu -modes 'power-menu:rofi-power-menu' -show 'power-menu'"
      ];

      cursor = {} // nvidiaCursor;

      decoration = {
        rounding = 2;
        active_opacity = 1.0;
        inactive_opacity = 0.8;

        blur = {
          enabled = true;
          size = 3;
        };

        shadow = {
          enabled = true;
          color = rgb colors.base00;
        };
      };

      dwindle = {
        force_split = 2;
        preserve_split = true;
      };

      env =
        [
          "XDG_DATA_DIRS,$HOME/.nix-profile/share"
          "XDG_SESSION_TYPE,wayland"
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
        ]
        ++ nvidiaEnv;

      exec = [
        "hyprctl setcursor ${config.gtk.cursorTheme.name} ${toString config.gtk.cursorTheme.size}"
      ];

      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "hyprpaper"
      ];

      general = {
        allow_tearing = false;
        border_size = 2;
        "col.active_border" = rgb colors.base05;
        "col.inactive_border" = rgb colors.base01;
        gaps_in = 3;
        gaps_out = 5;
        layout = "dwindle";
        resize_on_border = false;
      };

      misc = {
        disable_hyprland_logo = true;
        force_default_wallpaper = 1;
      };

      monitor = map (
        m: "${m.name},${
          if m.enabled
          then "${toString m.width}x${toString m.height}@${toString m.refreshRate},${m.position},1"
          else "disable"
        }"
      ) (config.monitors);
    };
    systemd = {
      enable = true;
      variables = ["--all"];
    };
    xwayland.enable = true;

    # Use packages from the NixOS module
    package = null;
    portalPackage = null;
  };
}

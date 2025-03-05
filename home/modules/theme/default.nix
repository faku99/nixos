{
  config,
  pkgs,
  ...
}: let
  opacity = 0.95;
  fontSize = 12;
in {
  stylix = {
    enable = true;
    polarity = "dark";
    autoEnable = false;

    image = config.wallpaper.path;

    base16Scheme = ./tokyo-night-storm.yaml;

    opacity = {
      terminal = opacity;
      popups = opacity;
    };

    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors";
      size = 24;
    };

    fonts = {
      serif = {
        package = pkgs.nerd-fonts.ubuntu;
        name = "Ubuntu Nerd Font";
      };

      sansSerif = {
        package = pkgs.nerd-fonts.ubuntu-sans;
        name = "Ubuntu Nerd Font Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.roboto-mono;
        name = "RobotoMono NerdFont Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = fontSize;
        desktop = fontSize;
        popups = fontSize;
        terminal = fontSize;
      };
    };
  };
}

{pkgs, ...}: {
  programs = {
    dconf.enable = true;
    hyprland.enable = true;
  };

  services = {
    blueman.enable = true;

    dbus = {
      enable = true;
      packages = [pkgs.dconf];
    };

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    gnome.gnome-keyring.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    xserver.exportConfiguration = true;
  };

  environment.systemPackages = with pkgs; [
    nwg-look
    pavucontrol
  ];
}

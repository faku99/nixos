{
  config,
  lib,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  inherit (config.lib.file) mkOutOfStoreSymlink;
  cfg = config.userConfig.programs.editor.neovim;
in
{
  options.userConfig.programs.editor.neovim = {
    enable = mkEnableOption "neovim";

    defaultEditor = mkOption {
      type = types.bool;
      default = false;
      description = "Use neovim as default editor.";
    };
  };

  config = mkIf cfg.enable {
    userConfig = {
      system.impermanence = {
        directories = [
          ".cache/nvim"
          ".local/share/nvim"
          ".local/state/nvim"
        ];
      };

      programs.editor = mkIf cfg.defaultEditor {
        enable = true;
        executable = "nvim";
      };
    };

    programs.neovim = {
      enable = true;
      extraConfig = ''
        lua require('init')
      '';
    };

    xdg.configFile."nvim/lua".source = mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/modules/home-manager/programs/editor/neovim/lua";

    home.sessionVariables = {
      MANPAGER = "nvim -c Man!";
      MANWIDTH = 1000000;
    };

    programs.git.extraConfig = {
      core.pager = "nvim -R";
      color.pager = false;
    };
  };
}

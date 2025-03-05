{pkgs, ...}:
{
    programs.neovim = {
        enable = true;
        extraPackages = with pkgs; [
            # General
            delta
            fd
            gnumake
            python3
            ripgrep
            wget

            # C/C++
            clang-tools
            gcc

            # Generic LSP / Formatter
            harper
            nodePackages.cspell
            nodePackages.prettier
            typos-lsp

            # Lua
            lua51Packages.lua
            lua-language-server
            luarocks
            stylua

            # Nix
            nil
            nixd
            nixfmt-rfc-style
        ];
    };

    xdg.configFile = {
        "nvim".source = ./.;
    };
}

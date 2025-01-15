{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      modus-themes-nvim
    ];
    extraLuaConfig = ''
      vim.cmd([[colorscheme modus]])
      vim.o.background = "dark"
    '';
  };
}

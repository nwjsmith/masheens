{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    neovim
  ];

  environment.variables = {
    EDITOR = "vim";
    MANWIDTH = "999";
  };
}

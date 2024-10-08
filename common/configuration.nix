{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    neovim
  ];

  environment.variables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
    MANWIDTH = "999";
    VISUAL = "nvim";
  };
}

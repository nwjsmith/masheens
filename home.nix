{ config, pkgs, ... }:

{
  home.username = "nwjsmith";
  home.homeDirectory = "/home/nwjsmith";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Nate Smith";
    userEmail = "nate@theinternate.com";
  };

  home.stateVersion = "23.05";
}

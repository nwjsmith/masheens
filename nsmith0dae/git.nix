{ config, ... }:

{
  xdg.configFile."git/wealthsimple.gitconfig".text = ''
    [user]
    email = nsmith@wealthsimple.com
  '';
  programs.git = {
    includes = [
      {
        path = "${config.xdg.configHome}/git/wealthsimple.gitconfig";
        condition = "gitdir:~/Code/wealthsimple/";
      }
    ];
  };
}

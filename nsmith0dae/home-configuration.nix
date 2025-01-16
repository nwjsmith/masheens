{
  config,
  pkgs,
  ...
}: {
  home.stateVersion = "22.05";

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

  home.packages = with pkgs; [
    amazon-ecr-credential-helper
    awscli2
    docker-client
    docker-compose
    docker-credential-helpers
    nodePackages.mermaid-cli
  ];
}

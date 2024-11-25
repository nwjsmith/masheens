{
  pkgs,
  ...
}:

{
  home.stateVersion = "22.05";

  imports = [
    ./git.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    amazon-ecr-credential-helper
    awscli2
    colima
    docker-client
    docker-compose
    docker-credential-helpers
    nodePackages.mermaid-cli
    libyaml
  ];

  programs.mise.enable = true;
}

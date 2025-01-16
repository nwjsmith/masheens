{pkgs, ...}: {
  services.gpg-agent.pinentryPackage = pkgs.pinentry_mac;
}

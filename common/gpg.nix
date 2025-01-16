{...}: {
  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 86400;
    enableSshSupport = true;
    maxCacheTtl = 86400;
  };
}

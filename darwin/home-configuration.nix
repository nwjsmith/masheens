{ lib, pkgs, ... }:

{
  programs.emacs.package = pkgs.emacs29-macport;
  programs.firefox = {
    enable = true;
    package =
      let
        # https://product-details.mozilla.org/1.0/firefox_versions.json
        version = "125.0.2";
      in
      pkgs.stdenv.mkDerivation {
        inherit version;

        name = "firefox-${version}";

        pname = "Firefox";

        src = pkgs.fetchurl {
          sha256 = "ol+eZw+gRivnTuBKws1t8jT/jZTPAy1blCcK+fcfo1U=";
          url = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${version}/mac/en-US/Firefox%20${version}.dmg";
          name = "Firefox.dmg";
        };

        buildInputs = [ pkgs.undmg ];

        # The dmg contains the app and a symlink, the default unpackPhase
        # tries to cd into the only directory produced so it fails.
        sourceRoot = ".";

        installPhase = ''
          mkdir -p $out/Applications
          mv Firefox.app $out/Applications
        '';

        meta = {
          description = "Mozilla Firefox, free web browser (binary package)";
          homepage = "http://www.mozilla.org/firefox/";
          license = {
            free = false;
            url = "http://www.mozilla.org/en-US/foundation/trademarks/policy/";
          };
          platforms = [
            "aarch64-darwin"
            "x86_64-darwin"
          ];
        };
      };
  };
}

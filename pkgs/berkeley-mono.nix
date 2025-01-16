{
  stdenv,
  unzip,
  lib,
}:
stdenv.mkDerivation {
  pname = "berkeley-mono";
  version = "1.009";

  src = ../secret/berkeley-mono-typeface.zip;

  buildInputs = [unzip];
  phases = [
    "unpackPhase"
    "installPhase"
  ];
  pathsToLink = ["/share/fonts/truetype/"];
  sourceRoot = ".";
  installPhase = ''
    install_path=$out/share/fonts/truetype
    mkdir -p $install_path
    find -name "BerkeleyMono*.ttf" -exec cp {} $install_path \;
  '';

  meta = with lib; {
    homepage = "https://berkeleygraphics.com/typefaces/berkeley-mono/";
    description = ''
      A love letter to the golden era of computing.
    '';
    platforms = platforms.all;
    licence = licences.unfree;
  };
}

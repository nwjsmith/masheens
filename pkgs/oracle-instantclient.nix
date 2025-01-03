{
  lib,
  stdenv,
  fetchurl,
  fixDarwinDylibNames,
  _7zz,
  ...
}:
stdenv.mkDerivation {
  pname = "oracle-instantclient";
  version = "23.3.0.23.09";
  srcs = [
    (fetchurl {
      url = "https://download.oracle.com/otn_software/mac/instantclient/233023/instantclient-basic-macos.arm64-23.3.0.23.09-1.dmg";
      sha256 = "sha256-G83bWDhw9wwjLVee24oy/VhJcCik7/GtKOzgOXuo1/4=";
    })
    (fetchurl {
      url = "https://download.oracle.com/otn_software/mac/instantclient/233023/instantclient-sqlplus-macos.arm64-23.3.0.23.09.dmg";
      sha256 = "sha256-khOjmaExAb3rzWEwJ/o4XvRMQruiMw+UgLFtsOGn1nY=";
    })
    (fetchurl {
      url = "https://download.oracle.com/otn_software/mac/instantclient/233023/instantclient-tools-macos.arm64-23.3.0.23.09-1.dmg";
      sha256 = "sha256-gA+SbgXXpY12TidpnjBzt0oWQ5zLJg6wUpzpSd/N5W4=";
    })
    (fetchurl {
      url = "https://download.oracle.com/otn_software/mac/instantclient/233023/instantclient-sdk-macos.arm64-23.3.0.23.09.dmg";
      sha256 = "sha256-PerfzgietrnAkbH9IT7XpmaFuyJkPHx0vl4FCtjPzLs=";
    })
  ];

  outputs = [
    "out"
    "dev"
    "lib"
  ];

  nativeBuildInputs = [
    _7zz
    fixDarwinDylibNames
  ];

  unpackCmd = "7zz x -aos $curSrc";

  sourceRoot = ".";

  installPhase = ''
    mkdir -p "$out/"{bin,include,lib,"share/java","share/oracle-instantclient-23.3.0.23.09/demo/"} $lib/lib
    install -Dm755 {exp,expdp,genezi,imp,impdp,sqlldr,sqlplus,uidrvci,wrc} $out/bin

    # cp to preserve symlinks
    cp -P *${stdenv.hostPlatform.extensions.sharedLibrary}* $lib/lib

    install -Dm644 *.jar $out/share/java
    install -Dm644 sdk/include/* $out/include
    install -Dm644 sdk/demo/* $out/share/oracle-instantclient-23.3.0.23.09/demo

    # provide alias
    ln -sfn $out/bin/sqlplus $out/bin/sqlplus64
  '';

  postFixup = ''
    for exe in "$out/bin/"* ; do
      if [ ! -L "$exe" ]; then
        install_name_tool -add_rpath "$lib/lib" "$exe"
      fi
    done
  '';

  meta = {
    description = "Oracle instant client libraries and sqlplus CLI";
    longDescription = ''
      Oracle instant client provides access to Oracle databases (OCI,
      OCCI, Pro*C, ODBC or JDBC). This package includes the sqlplus
      command line SQL client.
    '';
    sourceProvenance = [ lib.sourceTypes.binaryBytecode ];
    platforms = [ "aarch64-darwin" ];
  };
}

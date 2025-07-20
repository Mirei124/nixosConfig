{
  lib,
  pkgs,
  rustPlatform,
  fetchFromGitHub,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "wfhelper";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "Mirei124";
    repo = pname;
    rev = "19221c238c14638ffe6d5f40006e218c43403d47";
    sha256 = "sha256-cccGOLHuhZoIHmjpPK5Ni3NXKSmwmzXrTUMyHIkaXLo=";
  };

  nativeBuildInputs = with pkgs; [pkg-config];
  buildInputs = with pkgs; [atkmm dbus gdk-pixbuf glib gtk3 libayatana-appindicator-gtk3 pango];

  cargoHash = "sha256-WeHdztnlaf0qfRAq3TXYAeeZHML+em85CGv+rxRbdaY=";

  postInstall = ''
    patchelf $out/bin/wfhelper --add-needed \
      ${lib.getLib pkgs.libayatana-appindicator-gtk3}/lib/libayatana-appindicator3.so
  '';

  meta = {
    description = "wfhelper";
    homepage = "https://github.com/Mirei124/wfhelper";
    license = lib.licenses.mit;
    maintainers = [];
  };
}

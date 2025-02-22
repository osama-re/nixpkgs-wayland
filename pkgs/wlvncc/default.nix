{ stdenv, lib, fetchFromGitHub
, pkg-config, meson, ninja
, wayland, wayland-protocols
, libxkbcommon, libvncserver
, libpthreadstubs, lzo
, pixman, libuv, libglvnd, libjpeg, libpng
, neatvnc, libX11, libdrm
, aml, mesa
, ffmpeg
, openssl
}:

let
  metadata = import ./metadata.nix;
in
stdenv.mkDerivation rec {
  pname = "wlvncc";
  version = metadata.rev;

  src = fetchFromGitHub {
    owner = "any1";
    repo = "wlvncc";
    rev = metadata.rev;
    sha256 = metadata.sha256;
  };

  nativeBuildInputs = [ pkg-config meson ninja ];
  buildInputs = [
    wayland wayland-protocols
    libxkbcommon libvncserver
    libpthreadstubs lzo
    pixman libuv libglvnd libjpeg libpng
    neatvnc libX11 libdrm
    aml mesa
    ffmpeg
    openssl
  ];

  enableParallelBuilding = true;

  meta = with lib; {
    description = "A Wayland Native VNC Client";
    homepage    = "https://github.com/any1/wlvncc";
    license     = licenses.isc;
    platforms   = platforms.linux;
    maintainers = with maintainers; [ colemickens ];
  };
}

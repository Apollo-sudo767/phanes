{ lib
, stdenv
, fetchFromGitHub
, cmake
, pkg-config
, python3
, openblas
, openfst
, kaldi
}:

stdenv.mkDerivation rec {
  pname = "vosk-api";
  version = "0.3.45";

  src = fetchFromGitHub {
    owner = "alphacep";
    repo = "vosk-api";
    rev = "v${version}";
    sha256 = "sha256-bDx4FoAVeYdBagPEs/Kx3kiylkQCaS/X4JvZYcH5B5A=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
    python3
  ];

  buildInputs = [
    openblas
    openfst
    kaldi
  ];

  # Prevent using bundled libraries
  preConfigure = ''
    rm -rf src/kaldi
  '';

  cmakeFlags = [
    "-DKALDI_ROOT=${kaldi}"
    "-DVOSK_USE_SHARED=ON"
    "-DVOSK_STATIC=OFF"
  ];

  # Necessary to find libkaldi during build
  NIX_LDFLAGS = "-L${kaldi}/lib";

  # Make sure vosk can find the required libraries at runtime
  postFixup = ''
    patchelf --set-rpath "${lib.makeLibraryPath buildInputs}:$out/lib" $out/lib/libvosk.so
  '';

  meta = with lib; {
    description = "Speech recognition toolkit based on Kaldi and OpenFST";
    homepage = "https://alphacephei.com/vosk";
    license = licenses.asl20;
    maintainers = with maintainers; [ ];
    platforms = platforms.unix;
    mainProgram = "sample_vosk";
  };
}

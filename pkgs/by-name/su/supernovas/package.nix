{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  calceph,
  withCalceph ? false,
}:
stdenv.mkDerivation rec {
  pname = "supernovas";
  version = "dev";

  src = fetchFromGitHub {
    owner = "kiranshila";
    repo = "supernovas";
    rev = "5256ee95ef522432b9fb5c25f578d4cd27a8ec8f";
    hash = "sha256-2dtSBj3hZxioMt/+YyYiBzjv4XVWqaPQa3PuI7J6Evg=";
  };

  nativeBuildInputs = [cmake];

  buildInputs = lib.optionals withCalceph [calceph];

  cmakeFlags = [
    (lib.cmakeBool "ENABLE_CALCEPH" withCalceph)
  ];

  meta = {
    description = "High-performance astrometry library for C/C++";
    homepage = "https://smithsonian.github.io/SuperNOVAS/";
    license = lib.licenses.unlicense;
    maintainers = with lib.maintainers; [kiranshila];
    platforms = lib.platforms.all;
  };
}

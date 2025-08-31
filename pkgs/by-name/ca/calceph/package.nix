{
  lib,
  stdenv,
  fetchzip,
  cmake,
  gfortran,
}:
stdenv.mkDerivation rec {
  pname = "calceph";
  version = "4.0.5";
  src = fetchzip {
    url = "https://www.imcce.fr/content/medias/recherche/equipes/asd/${pname}/${pname}-${version}.tar.gz";
    sha256 = "sha256-s42PQd2LEN+zwglNDjhUoofv+RdVyvpD3Pk0EaNAFSM=";
  };

  nativeBuildInputs = [
    cmake
    gfortran
  ];

  cmakeFlags = [
    (lib.cmakeBool "BUILD_SHARED_LIBS" (!stdenv.hostPlatform.isStatic))
  ];

  meta = {
    homepage = "https://www.imcce.fr/inpop/calceph/";
    description = "C library for interacting with binary planetary ephemeris files, such INPOPxx, JPL DExxx and SPICE";
    license = with lib.licenses; [
      cecill21
      cecill-b
      cecill-c
    ];
    maintainers = with lib.maintainers; [kiranshila];
    platforms = lib.platforms.all;
  };
}

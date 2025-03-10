{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  basemap-data,
  cython,
  geos,
  numpy,
  matplotlib,
  pillow,
  pyproj,
  pyshp,
  python,
  setuptools,
}:

buildPythonPackage rec {
  pname = "basemap";
  version = "1.4.1";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "matplotlib";
    repo = "basemap";
    tag = "v${version}";
    hash = "sha256-0rTGsphwLy2yGvhO7bcmFqdgysIXXkDBmURwRVw3ZHY=";
  };

  sourceRoot = "${src.name}/packages/basemap";

  nativeBuildInputs = [
    cython
    geos
    setuptools
  ];

  pythonRelaxDeps = true;

  propagatedBuildInputs = [
    basemap-data
    numpy
    matplotlib
    pillow # undocumented optional dependency
    pyproj
    pyshp
  ];

  # Standard configurePhase from `buildPythonPackage` seems to break the setup.py script
  preBuild = ''
    export GEOS_DIR=${geos}
  '';

  # test have various problems including requiring internet connection, permissions issues, problems with latest version of pillow
  doCheck = false;

  checkPhase = ''
    cd ../../examples
    export HOME=$TEMPDIR
    ${python.interpreter} run_all.py
  '';

  meta = with lib; {
    homepage = "https://matplotlib.org/basemap/";
    description = "Plot data on map projections with matplotlib";
    longDescription = ''
      An add-on toolkit for matplotlib that lets you plot data on map projections with
      coastlines, lakes, rivers and political boundaries. See
      http://matplotlib.github.com/basemap/users/examples.html for examples of what it can do.
    '';
    maintainers = [ ];
    license = with licenses; [
      mit
      lgpl21
    ];
  };
}

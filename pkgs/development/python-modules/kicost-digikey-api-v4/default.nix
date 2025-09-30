{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  inflection,
  setuptools,
  requests,
  urllib3,
  six,
  certifi,
  pyopenssl,
  tldextract,
  python-dateutil,
}:
buildPythonPackage rec {
  pname = "kicost-digikey-api-v4";
  version = "0.1.3";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "set-soft";
    repo = "kicost-digikey-api-v4";
    tag = "v${version}";
    hash = "sha256-0IpimgrxguI8Y7mwrHpG42bvbWPR/dukFRicbz3Olow=";
  };

  build-system = [ setuptools ];

  dependencies = [
    inflection
    requests
    urllib3
    six
    certifi
    pyopenssl
    tldextract
    python-dateutil
  ];

  meta = {
    description = "KiCost plugin for the Digikey PartSearch API V4 ";
    homepage = "https://github.com/set-soft/kicost-digikey-api-v4";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ kiranshila ];
  };
}

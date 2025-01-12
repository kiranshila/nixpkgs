{
  lib,
  fetchFromGitHub,
  cmake,
  llvmPackages_16,
  git,
}:
llvmPackages_16.stdenv.mkDerivation rec {
  pname = "enzyme_16";
  version = "0.0.172";

  src = fetchFromGitHub {
    owner = "EnzymeAD";
    repo = "Enzyme";
    rev = "v${version}";
    hash = "sha256-/FxjXCML7hBNYOVf1PLG+VwCdaNGYwwirRJSQxIvLcg=";
  };

  postPatch = ''
    patchShebangs enzyme
  '';

  llvm = llvmPackages_16.llvm;
  clang = llvmPackages_16.clang-unwrapped;

  buildInputs = [
    cmake
    git
    llvm
    clang
  ];

  cmakeDir = "../enzyme";

  cmakeFlags = [
    "-DLLVM_DIR=${llvm.dev}"
    "-DClang_DIR=${clang.dev}"
  ];

  enableParallelBuilding = true;

  meta = {
    homepage = "https://enzyme.mit.edu/";
    description = "High-performance automatic differentiation of LLVM and MLIR";
    maintainers = with lib.maintainers; [ kiranshila ];
    platforms = lib.platforms.all;
    license = lib.licenses.asl20-llvm;
  };
}

{ lib
, buildPythonPackage
, callPackage
, fetchFromGitHub
, rustPlatform
}:

buildPythonPackage rec {
  pname = "lzallright";
  version = "0.2.2";

  src = fetchFromGitHub {
    owner = "vlaci";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-MOTIUC/G92tB2ZOp3OzgKq3d9zGN6bfv83vXOK3deFI=";
  };

  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit src;
    name = "${pname}-${version}";
    hash = "sha256-WSwIKJBtyorKg7hZgxwPd/ORujjyY0x/1R+TBbIxyWQ=";
  };

  format = "pyproject";

  nativeBuildInputs = with rustPlatform; [ cargoSetupHook maturinBuildHook ];

  pythonImportsCheck = [ "lzallright" ];

  doCheck = false;

  passthru.tests = {
    pytest = callPackage ./tests.nix { };
  };

  meta = with lib; {
    description = ''
      A Python 3.8+ binding for lzokay library which is an MIT licensed
      a minimal, C++14 implementation of the LZO compression format.
    '';
    homepage = "https://github.com/vlaci/lzallright";
    license = licenses.mit;
    maintainers = with maintainers; [ vlaci ];
  };
}

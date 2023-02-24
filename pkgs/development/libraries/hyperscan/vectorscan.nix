{ lib, callPackage, fetchFromGitHub, ... } @ args:

callPackage ./generic.nix args rec {
  pname = "vectorscan";
  version = "5.4.8";

  src = fetchFromGitHub {
    owner = "VectorCamp";
    repo = pname;
    sha256 = "sha256-RU5k4tK7gbgMTMn+Ms2WHntO6XLvncd/VyS10kawotk";
    rev = "vectorscan/${version}";
  };

  meta = with lib; {
    description = "A fork of Intel's Hyperscan, modified to run on more platforms";
    homepage = "https://github.com/VectorCamp/vectorscan";
    maintainers = with maintainers; [ vlaci ];
    platforms = with platforms; linux ++ darwin;
  };
}

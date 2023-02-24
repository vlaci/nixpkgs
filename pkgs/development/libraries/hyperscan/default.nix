{ lib, callPackage, fetchFromGitHub, fetchpatch, ... } @ args:

callPackage ./generic.nix args rec {
  pname = "hyperscan";
  version = "5.4.0";

  src = fetchFromGitHub {
    owner = "intel";
    repo = pname;
    sha256 = "sha256-AJAjaXVnGqIlMk+gb6lpTLUdZr8nxn2XSW4fj6j/cmk=";
    rev = "v${version}";
  };

  patches = [
    (fetchpatch {
      # part of https://github.com/intel/hyperscan/pull/336
      url = "https://github.com/intel/hyperscan/commit/e2c4010b1fc1272cab816ba543940b3586e68a0c.patch";
      sha256 = "sha256-doVNwROL6MTcgOW8jBwGTnxe0zvxjawiob/g6AvXLak=";
    })
  ];
}

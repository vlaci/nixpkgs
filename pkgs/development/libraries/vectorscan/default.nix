{ lib
, stdenv
, fetchFromGitHub
, cmake
, ragel
, python3
, util-linux
, fetchpatch
, boost
, withStatic ? false # build only shared libs by default, build static+shared if true
}:

stdenv.mkDerivation rec {
  pname = "vectorscan";
  version = "5.4.8";

  src = fetchFromGitHub {
    owner = "VectorCamp";
    repo = pname;
    sha256 = "sha256-RU5k4tK7gbgMTMn+Ms2WHntO6XLvncd/VyS10kawotk";
    rev = "vectorscan/${version}";
  };

  outputs = [ "out" "dev" ];

  buildInputs = [ boost ];
  nativeBuildInputs = [
    cmake
    ragel
    python3
    # Consider simply using busybox for these
    # Need at least: rev, sed, cut, nm
    util-linux
  ];

  cmakeFlags = lib.optionals (stdenv.isx86_64 && stdenv.isLinux) [
    "-DFAT_RUNTIME=ON"
    "-DBUILD_AVX512=ON"
  ]
  ++ lib.optional (withStatic) "-DBUILD_STATIC_AND_SHARED=ON"
  ++ lib.optional (!withStatic) "-DBUILD_SHARED_LIBS=ON";

  postPatch = ''
    sed -i '/examples/d' CMakeLists.txt
    substituteInPlace libhs.pc.in \
      --replace "libdir=@CMAKE_INSTALL_PREFIX@/@CMAKE_INSTALL_LIBDIR@" "libdir=@CMAKE_INSTALL_LIBDIR@" \
      --replace "includedir=@CMAKE_INSTALL_PREFIX@/@CMAKE_INSTALL_INCLUDEDIR@" "includedir=@CMAKE_INSTALL_INCLUDEDIR@"
  '';

  meta = with lib; {
    description = "A fork of Intel's Hyperscan, modified to run on more platforms.";
    homepage = "https://github.com/VectorCamp/vectorscan";
    maintainers = with maintainers; [ vlaci ];
    platforms = with platforms; linux ++ darwin;
    license = licenses.bsd3;
  };
}

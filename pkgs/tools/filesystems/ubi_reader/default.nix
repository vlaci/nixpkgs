{ lib
, python3
, fetchFromGitHub
}:

python3.pkgs.buildPythonApplication rec {
  pname = "ubi_reader";
  version = "0.8.8";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "onekey-sec";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-AaI/WbQDm5A2XNmeVttGjweA2yh7lySpyPmWk8yxzTU=";
  };

  nativeBuildInputs = with python3.pkgs; [ poetry-core ];

  # There are no tests in the source
  doCheck = false;

  meta = with lib; {
    description = "Collection of Python scripts for reading information about and extracting data from UBI and UBIFS images";
    homepage = "https://github.com/onekey-sec/ubi_reader";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ vlaci ];
  };
}

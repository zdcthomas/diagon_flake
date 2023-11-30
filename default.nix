{ lib
, stdenv
, fetchFromGitHub
, cmake
}:

stdenv.mkDerivation rec {
  pname = "diagon";
  version = "1.1.158";

  src = fetchFromGitHub {
    owner = "ArthurSonzogni";
    repo = "Diagon";
    rev = "v${version}";
    hash = "sha256-Qxk3+1T0IPmvB5v3jaqvBnESpss6L8bvoW+R1l5RXdQ=";
  };

  nativeBuildInputs = [
    cmake
  ];

  meta = with lib; {
    description = "Interactive ASCII art diagram generators. :star2";
    homepage = "https://github.com/ArthurSonzogni/Diagon";
    changelog = "https://github.com/ArthurSonzogni/Diagon/blob/${src.rev}/CHANGELOG";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}

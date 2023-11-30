{ lib
, stdenv
, fetchFromGitHub
, cmake
, meson
, ninja
}:

stdenv.mkDerivation rec {
  pname = "nlohmann-json-cmake-fetchcontent";
  version = "3.11.2";

  src = fetchFromGitHub {
    owner = "ArthurSonzogni";
    repo = "nlohmann_json_cmake_fetchcontent";
    rev = "v${version}";
    hash = "sha256-FiWmnfhXCFp9I58n7nb3NDhi9j8urNI0AiqvdTlUKxM=";
  };

  nativeBuildInputs = [
    cmake
    meson
    ninja
  ];

  meta = with lib; {
    description = "A lightweight Release-tracking repository for nlohmann/json. Suitable for CMake fetchcontent. Automatically upgraded every weeks";
    homepage = "https://github.com/ArthurSonzogni/nlohmann_json_cmake_fetchcontent";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}

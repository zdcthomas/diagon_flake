{
  description = "Diagon package";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # systems.url = "github:nix-systems/x86_64-linux";

    flake-utils.url = "github:numtide/flake-utils";
    # 2. Override the flake-utils default to your version
    # flake-utils.inputs.systems.follows = "systems";
  };

  outputs =
    { self
    , flake-utils
    , nixpkgs
    , ...
    }:
    # Now eachDefaultSystem is only using ["x86_64-linux"], but this list can also
    # further be changed by users of your flake.
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      antlr = pkgs.fetchFromGitHub {
        owner = "ArthurSonzogni";
        repo = "antlr4";
        rev = "remove-pthread";
        hash = "sha256-ohhj59+rBZBUvL9exURx4BHgeM+zUUvvcHkdh8hJLw0=";
      };
      json = pkgs.fetchFromGitHub {
        owner = "ArthurSonzogni";
        repo = "nlohmann_json_cmake_fetchcontent";
        rev = "v3.9.1";
        hash = "sha256-FiWmnfhXCFp9I58n7nb3NDhi9j8urNI0AiqvdTlUKxM=";
      };
      diagon =
        pkgs.stdenv.mkDerivation
          rec {
            pname = "diagon";
            version = "1.1.158";

            src = pkgs.fetchFromGitHub {
              owner = "ArthurSonzogni";
              repo = "Diagon";
              rev = "v${version}";
              hash = "sha256-Qxk3+1T0IPmvB5v3jaqvBnESpss6L8bvoW+R1l5RXdQ=";
            };

            nativeBuildInputs = [
              pkgs.cmake
              pkgs.git
              pkgs.libuuid
              # pkgs.libboost-graph-dev
              # pkgs.cmake
              # pkgs.default-jdk
            ];
            cmakeFlags = [
              # "-DFETCHCONTENT_FULLY_DISCONNECTED=ON"
              # "-DFETCHCONTENT_QUIET=OFF"
              # "DFETCHCONTENT_SOURCE_DIR_json=${json}"
              # "DFETCHCONTENT_SOURCE_DIR_antlr=${antlr}"
            ];

            # preConfigure = ''
            #   mkdir -p .third-party
            #   cp -r ${json} .third-party/json
            #   cp -r ${antlr} .third-party/antlr
            #   chmod -R +w .third-party/json
            #   chmod -R +w .third-party/antlr
            # '';

            patches = [
              ./remove-fetchcontent-usage.patch
            ];
            # patchPhase = ''
            #   ls -la
            #   # sed -i 's;https://github.com/ArthurSonzogni/nlohmann_json_cmake_fetchcontent;file://${json};g' CMakeLists.txt
            #   # cat CMakeLists.txt
            # '';
            preConfigure = ''
              ln -s ${json} json
              ln -s ${antlr} antlr
            '';

            meta = with pkgs.lib; {
              description = "Interactive ASCII art diagram generators. :star2";
              homepage = "https://github.com/ArthurSonzogni/Diagon";
              changelog = "https://github.com/ArthurSonzogni/Diagon/blob/${src.rev}/CHANGELOG";
              license = licenses.mit;
              maintainers = with maintainers; [ ];
            };
          };
    in
    {
      packages.default = diagon;
      # ...
    });
}

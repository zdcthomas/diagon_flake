{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "json-populate";
  version = "unstable-2017-09-18";

  src = fetchFromGitHub {
    owner = "eiriklv";
    repo = "json-populate";
    rev = "ddafbc4066a64b62ce8879fdc03c17e3ed177d19";
    hash = "sha256-iqvfH1buL79CQJyHG2gqTUaky6zOe8uMGAjAcIyeSv8=";
  };

  meta = with lib; {
    description = "Tool for populating JSON data with circular references. Sort of like Falcor and GraphQL, but for plain JSON with a transparent interface";
    homepage = "https://github.com/eiriklv/json-populate";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}

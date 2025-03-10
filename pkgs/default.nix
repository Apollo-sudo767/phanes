# Custom packages
{ pkgs ? import <nixpkgs> {} }:

{
  vosk-api = pkgs.callPackage ./vosk-api {};
  # Example custom package (uncomment and modify as needed)
  # customPackage = pkgs.callPackage ./customPackage {};
}

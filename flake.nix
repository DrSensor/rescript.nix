{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
        "i686-cygwin"
        "x86_64-cygwin"
        "x86_64-windows"
        "i686-windows"
      ];
      imports = [ inputs.devshell.flakeModule ];
      perSystem = part @ { pkgs, ... }: {
        devshells.default = {
          motd = "";
          packages = with pkgs; [ rescript rescript-analysis ];
        };
        packages = with pkgs; { inherit rescript rescript-analysis; };
        _module.args.pkgs = import inputs.nixpkgs {
          inherit (part) system;
          overlays = [ (import ./overlay.nix) ];
          config = { };
        };
      };
    };
}

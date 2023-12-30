{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    systems.url = "path:./systems.nix";
    systems.flake = false;

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
    };
  };
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import inputs.systems;
      imports = [inputs.devshell.flakeModule];
      perSystem = part @ {pkgs, ...}: {
        devshells.default = {
          motd = "";
          packages = with pkgs; [rescript rescript-analysis];
        };
        packages = with pkgs; {inherit rescript rescript-analysis;};
        _module.args.pkgs = import inputs.nixpkgs {
          inherit (part) system;
          overlays = [(import ./overlay.nix)];
          config = {};
        };
      };
    };
}

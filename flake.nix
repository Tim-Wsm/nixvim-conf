{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixvim,
    flake-parts,
    nixpkgs,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem = {system, ...}: let
        # bindings to access nixvim specific scripts
        nixvimLib = nixvim.lib.${system};
        nixvim' = nixvim.legacyPackages.${system};

        # use packages from flake input
        pkgs = nixpkgs.legacyPackages.${system};

        # define nixvim module based on the config in ./config
        nixvimModule = {
          inherit pkgs; # module inherits flake packages
          module = import ./config; # import the configuration
          extraSpecialArgs = {inherit inputs;}; # make flake inputs accessible in config
        };
        nvim = nixvim'.makeNixvimWithModule nixvimModule;

        # wrap nvim in script with dependencies in PATH
        dependencies = [
          # for telescope
          pkgs.ripgrep
          # for formatting .nix files
          pkgs.alejandra
        ];
        nvimWrapped = pkgs.symlinkJoin {
          name = "nvim";
          paths = [nvim] ++ dependencies;
          buildInputs = [pkgs.makeWrapper];
          postBuild = "wrapProgram $out/bin/nvim --prefix PATH : $out/bin";
        };
      in {
        # Run `nix flake check .` to verify that your config is not broken
        checks = {
          default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
        };

        # Lets you run `nix run .` to start nixvim
        packages = {
          default = nvimWrapped;
        };
      };
    };
}

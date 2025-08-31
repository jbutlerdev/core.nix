{
  description = "Opinionated Core Nix Configuration";

  outputs =
    { self, ... }:
    {
      darwinModule = ./darwin;
      homeManagerModule = ./home-manager;
    };
}
{ pkgs, nixvim, ... }: {
  home.packages = with pkgs; [
    gnumake
    wl-clipboard

    (nixvim.legacyPackages."${pkgs.stdenv.hostPlatform.system}".makeNixvimWithModule {
      inherit nixpkgs;
      module = import ./nvim;
    })
  ];
}

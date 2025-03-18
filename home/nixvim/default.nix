{ pkgs, nixvim, ... }: {
  home.packages = with pkgs; [
    gnumake
    wl-clipboard

    (nixvim.packages."${pkgs.stdenv.hostPlatform.system}".makeNixvimWithModule {
      inherit nixpkgs;
      module = import ./nvim;
    })
  ];
}

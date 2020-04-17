{ pkgs ?
  import (builtins.fetchTarball "https://github.com/nixos/nixpkgs/archive/ca2ba44cab47767c8127d1c8633e2b581644eb8f.tar.gz") {}
}:

with pkgs;
let ghc = haskell.packages.ghc802.ghcWithPackages (pkgs: [pkgs.gtk2hs-buildtools]);
in

stdenv.mkDerivation {
  name = "yi";

  buildInputs = [
      cairo
      pango
      gtk2
      ghc
      haskellPackages.gtk2hs-buildtools
      icu.out
      ncurses.out
      pkgconfig
      glibcLocales
      which
      xsel
      zlib.out
      cabal-install
  ];

  shellHook = ''
    export LC_ALL=en_US.UTF-8
    export PATH="${which}/bin:${xsel}/bin:${haskellPackages.gtk2hs-buildtools}/bin:$PATH"
    export CPATH="${icu.dev}/include:${ncurses.dev}/include:$CPATH"
    export LIBRARY_PATH="${icu.dev}/lib:${ncurses.dev}/lib:${zlib.out}/lib:$LIBRARY_PATH"
    export LD_LIBRARY_PATH="${icu.out}/lib:${ncurses.out}/lib:$LD_LIBRARY_PATH"
  '';
}

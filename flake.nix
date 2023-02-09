{
  description = "Nix development dependencies for crystal and gtk";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-22.11;
    flake-utils.url = github:numtide/flake-utils;
    crystal-flake.url = github:manveru/crystal-flake;
  };

  outputs = inputs:
    let
      utils = inputs.flake-utils.lib;
    in
    utils.eachSystem
      [
        "x86_64-linux"
      ]
      (system:
        let
          nixpkgs = import inputs.nixpkgs {
            inherit system;
          };

          crystalflake-pkg = inputs.crystal-flake.packages.${system};
        in
        {

          devShells.default = nixpkgs.pkgs.mkShell {
            buildInputs = with nixpkgs.pkgs; [

              #crystalflake-pkg.crystal
              crystal
              shards
              blueprint-compiler
              pcre2
              gtk4
              glib
              gobject-introspection
              libadwaita
              libffi
              desktop-file-utils
              cairo
              gdk-pixbuf
              graphene
              gtksourceview5
              libxml2
              meson
              ninja
              pango
              pkg-config
              wrapGAppsHook4
              cmake

            ];

            nativeBuildInputs = with nixpkgs.pkgs; [
              crystal
              shards
              blueprint-compiler
              pcre2
              gtk4
              glib
              gobject-introspection
              libadwaita
              libffi
              desktop-file-utils
              cairo
              gdk-pixbuf
              graphene
              gtksourceview5
              libxml2
              meson
              ninja
              pango
              pkg-config
              wrapGAppsHook4
              cmake
            ];
          };
        });
}


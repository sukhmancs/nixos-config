#
# When installing packages globally using "$ npm install -g <package>"
# the binary will be installed in $HOME/.npm-global and should be available in your PATH
#
# This also installs Android studio and Android sdk. This will result in ANDROID_HOME and ANDROID_SDK_ROOT being set in your environment.
#

{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

with pkgs;

let
  android-nixpkgs = callPackage (import (builtins.fetchGit {
    url = "https://github.com/tadfisher/android-nixpkgs.git";
  })) {
    # Default; can also choose "beta", "preview", or "canary".
    channel = "stable";
  };

  android-sdk = android-nixpkgs.sdk (sdkPkgs: with sdkPkgs; [
    cmdline-tools-latest
    build-tools-34-0-0
    platform-tools
    platforms-android-34
    emulator
    system-images-android-VanillaIceCream-google-apis-playstore-x86-64
  ]);

in
mkShell {
  name = "NPM-ANDROID-Shell";
  buildInputs = [
    nodejs
    nodePackages.npm
    android-studio
    android-sdk
  ];

  shellHook = ''
    npm set prefix ~/.npm-global
    export PATH="$HOME/.npm-global/bin:$PATH"
    echo "done"
  '';
}

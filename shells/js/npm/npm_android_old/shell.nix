{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

with pkgs;

mkShell {
  name = "NPM-ANDROID-Shell";
  buildInputs = [
    nodejs
    nodePackages.npm    
    androidenv.androidPkgs_9_0.androidsdk
  ];

  shellHook = ''
    npm set prefix ~/.npm-global            
    export PATH="$HOME/.npm-global/bin:$PATH"
    echo "done"
  '';

  # Use the same buildToolsVersion here
  # GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${ANDROID_SDK_ROOT}/build-tools/${buildToolsVersion}/aapt2";
}
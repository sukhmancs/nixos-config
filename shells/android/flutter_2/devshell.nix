{ pkgs }:

with pkgs;

let 
  buildToolsVersion = "30.0.2";
in

# Configure your development environment.
#
# Documentation: https://github.com/numtide/devshell
devshell.mkShell {
  name = "android-project";
  motd = ''
    Entered the Android app development environment.
  '';
  env = [
    {
      name = "ANDROID_HOME";
      value = "${android-sdk}/share/android-sdk";
    }
    {
      name = "ANDROID_SDK_ROOT";
      value = "${android-sdk}/share/android-sdk";
    }
    {
      name = "JAVA_HOME";
      value = jdk.home;
    }    
    {
      name = "GRADLE_OPTS";
      value = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${android-sdk}/share/android-sdk/build-tools/${buildToolsVersion}/aapt2";
    }      
  ];
  packages = [
    flutter
    android-studio
    android-sdk
    gradle
    jdk
  ];
}

{ pkgs ? import <nixpkgs> {} }:
(pkgs.buildFHSUserEnv {
  name = "pipzone";
  targetPkgs = pkgs: (with pkgs; [
    (pkgs.python3.withPackages (ps: [
      ps.pip
      ps.tkinter
      ps.virtualenv
    ]))
    cudaPackages.cudatoolkit
  ]);
  runScript = "bash";
}).env

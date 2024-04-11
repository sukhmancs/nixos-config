{ ... }:

{
    imports = [
      ./common/cpu/amd  # allow microcode updates to amd cpu from appropriate sources
      ./common/gpu/nvidia/prime.nix # enable nvidia driver, setup nvidia optimus prime offload mode (.i.e. it enables integration between amd integrated GPU and nvidia dedicated GPU)
#      ./common/pc/laptop
#      ./common/pc/ssd
    ];

    hardware.nvidia.prime = {
      amdgpuBusId = "PCI:5:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  }

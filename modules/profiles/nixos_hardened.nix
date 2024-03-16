# A profile with most (vanilla) hardening options enabled by default,
# potentially at the cost of stability, features and performance.
#
# This profile enables options that are known to affect system
# stability. If you experience any stability issues when using the
# profile, try disabling it. If you report an issue and use this
# profile, always mention that you do.

{ config, lib, pkgs, ... }:

with lib;

let 
  cfg = config.security.hardening;
in
{
  options.security.hardening = {
    enable = mkEnableOption "Enable system hardening options";

    linuxPackages_hardened = mkOption {
      default = false;
      description = "Use the hardened kernel instead of the default one";
    };

    enableScudo = mkOption {
      default = false;
      description = "Enable the Scudo memory allocator";
    };

    apparmor = mkOption {
      default = false;
      description = "Enable AppArmor support";      
    };

    securitymodules = mkOption {
      default = false;
      description = "Enable security modules (lockkernelModules, protectKernelImage, allowSimultaneousMultithreading, forcePageTableIsolation)";
    };

    kernelParams = mkOption {
      default = false;
      description = "Enable kernel parameters (slub_debug, page_poison, page_alloc.shuffle)";
    };

    blacklistedKernelModules = mkOption {
      default = false;
      description = "Blacklist kernel modules (ax25, netrom, rose, adfs, affs, bfs, befs, cramfs, efs, erofs, exofs, freevxfs, f2fs, hfs, hpfs, jfs, minix, nilfs2, ntfs, omfs, qnx4, qnx6, sysv, ufs)";
    };

    bpf_jit_enable = mkOption {
      default = false;
      description = "Disable bpf() JIT (to eliminate spray attacks)";
    };

    ftrace_enabled = mkOption {
      default = false;
      description = "Disable ftrace debugging";
    };

    rp_filter = mkOption {
      default = false;
      description = "Enable strict reverse path filtering";
    };

    icmp_echo_ignore_broadcasts = mkOption {
      default = false;
      description = "Ignore broadcast ICMP (mitigate SMURF)";
    };

    accept_redirects = mkOption {
      default = false;
      description = "Ignore incoming ICMP redirects";
    };

    secure_redirects = mkOption {
      default = false;
      description = "Ignore incoming ICMP redirects";
    };
  };

  config = mkIf cfg.enable {    

    boot.kernelPackages = mkIf cfg.linuxPackages_hardened pkgs.linuxPackages_hardened;

    nix.settings.allowed-users = mkDefault [ "@wheel" ];

    # Enable scudo memory allocator
    # This is required to prevent heap overflows i.e. when you write more data to a heap buffer than it can hold
    # eg, let's say you have a heap overflow, you can use scudo to prevent
    # heap overflows    
    environment.memoryAllocator.provider = mkIf cfg.enableScudo "scudo";
    environment.variables.SCUDO_OPTIONS = mkIf cfg.enableScudo "ZeroContents=1";

      # This is required by podman to run containers in rootless mode.
    security.unprivilegedUsernsClone = mkDefault config.virtualisation.containers.enable;
    security.virtualisation.flushL1DataCache = mkDefault "always";

    # Enable AppArmor support
    # This is required to prevent processes from doing things they shouldn't
    # eg, let's say you have a process that shouldn't be able to read a file
    # if you enable AppArmor, you can prevent the process from reading the file
    security.apparmor.enable = mkDefault cfg.apparmor;    
    
    security.lockKernelModules = mkDefault cfg.securitymodules;

    security.protectKernelImage = mkDefault cfg.securitymodules;

    security.allowSimultaneousMultithreading = mkDefault cfg.securitymodules;

    security.forcePageTableIsolation = mkDefault cfg.securitymodules;

    boot.kernelParams = mkIf cfg.kernelParams [
      # Slab/slub sanity checks, redzoning, and poisoning
      "slub_debug=FZP"

      # Overwrite free'd memory
      "page_poison=1"

      # Enable page allocator randomization
      "page_alloc.shuffle=1"
    ];

    boot.blacklistedKernelModules = mkIf cfg.blacklistedKernelModules [
      # Obscure network protocols
      "ax25"
      "netrom"
      "rose"

      # Old or rare or insufficiently audited filesystems
      "adfs"
      "affs"
      "bfs"
      "befs"
      "cramfs"
      "efs"
      "erofs"
      "exofs"
      "freevxfs"
      "f2fs"
      "hfs"
      "hpfs"
      "jfs"
      "minix"
      "nilfs2"
      "ntfs"
      "omfs"
      "qnx4"
      "qnx6"
      "sysv"
      "ufs"
    ];

    # Hide kptrs even for processes with CAP_SYSLOG which means that even if a process has CAP_SYSLOG, it can't read kernel memory
    # This is required to prevent leaking kernel addresses to userspace
    # eg, let's say you have a kernel bug that allows you to read kernel memory
    # if you have CAP_SYSLOG, you can read kernel memory, but if you don't have
    # CAP_SYSLOG, you can't read kernel memory
    # boot.kernel.sysctl."kernel.kptr_restrict" = mkOverride 500 2;

    # Disable bpf() JIT (to eliminate spray attacks)
    # This is required to prevent bpf() from being used to spray the kernel
    # with code and data
    # eg, let's say you have a kernel bug that allows you to write to kernel
    # memory, you can use bpf() to write to kernel memory
    # if you disable bpf() JIT, you can't write to kernel memory    
    boot.kernel.sysctl."net.core.bpf_jit_enable" = mkDefault cfg.bpf_jit_enable;

    # Disable ftrace debugging
    # This is required to prevent ftrace from being used to trace kernel
    # functions. Trace kernel functions means that you can see what kernel functions 
    # are being called and with what arguments and return values 
    # and you can also see the call stack of the kernel functions being called.
    # eg, let's say you have a kernel bug that allows you to trace kernel
    # functions, you can use ftrace to trace kernel functions
    # if you disable ftrace, you can't trace kernel functions
    # boot.kernel.sysctl."kernel.ftrace_enabled" = mkIf cfg.ftrace_enabled;

    # Enable strict reverse path filtering (that is, 
    # do not attempt to route packets that "obviously" do not belong 
    # to the iface's network; dropped packets are logged as martians).
    # This is required to prevent packets that don't belong to the network
    # from being routed to the network
    # eg, let's say you have a kernel bug that allows you to route packets
    # that don't belong to the network to the network
    # if you enable strict reverse path filtering, you can't route packets
    # that don't belong to the network to the network
    boot.kernel.sysctl."net.ipv4.conf.all.log_martians" = mkDefault cfg.rp_filter;
    boot.kernel.sysctl."net.ipv4.conf.all.rp_filter" = mkIf cfg.rp_filter "1";
    boot.kernel.sysctl."net.ipv4.conf.default.log_martians" = mkDefault cfg.rp_filter;
    boot.kernel.sysctl."net.ipv4.conf.default.rp_filter" = mkIf cfg.rp_filter "1";

    # Ignore broadcast ICMP (mitigate SMURF)
    # This is required to prevent broadcast ICMP from being processed
    # eg, let's say you have a kernel bug that allows you to process broadcast
    # ICMP, you can use broadcast ICMP to perform a SMURF attack
    # if you ignore broadcast ICMP, you can't process broadcast ICMP    
    boot.kernel.sysctl."net.ipv4.icmp_echo_ignore_broadcasts" = mkDefault cfg.icmp_echo_ignore_broadcasts;

    # Ignore incoming ICMP redirects (note: default is needed to ensure that the
    # setting is applied to interfaces added after the sysctls are set)
    # This is required to prevent incoming ICMP redirects from being processed
    # eg, let's say you have a kernel bug that allows you to process incoming
    # ICMP redirects, you can use incoming ICMP redirects to perform a redirect
    # attack
    # if you ignore incoming ICMP redirects, you can't process incoming ICMP
    # redirects
    boot.kernel.sysctl."net.ipv4.conf.all.accept_redirects" = mkDefault cfg.accept_redirects;
    boot.kernel.sysctl."net.ipv4.conf.all.secure_redirects" = mkDefault cfg.secure_redirects;
    boot.kernel.sysctl."net.ipv4.conf.default.accept_redirects" = mkDefault cfg.accept_redirects;
    boot.kernel.sysctl."net.ipv4.conf.default.secure_redirects" = mkDefault cfg.secure_redirects;
    boot.kernel.sysctl."net.ipv6.conf.all.accept_redirects" = mkDefault cfg.accept_redirects;
    boot.kernel.sysctl."net.ipv6.conf.default.accept_redirects" = mkDefault cfg.accept_redirects;

    # Ignore outgoing ICMP redirects (this is ipv4 only)
    # This is required to prevent outgoing ICMP redirects from being processed
    # eg, let's say you have a kernel bug that allows you to process outgoing
    # ICMP redirects, you can use outgoing ICMP redirects to perform a redirect
    # attack
    # if you ignore outgoing ICMP redirects, you can't process outgoing ICMP
    # redirects
    boot.kernel.sysctl."net.ipv4.conf.all.send_redirects" = mkDefault cfg.secure_redirects;
    boot.kernel.sysctl."net.ipv4.conf.default.send_redirects" = mkDefault cfg.secure_redirects;

  };
}

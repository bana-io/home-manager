{
  pkgs,
  config,
  ...
}:
let
  pkgsUnstable = import <nixpkgs-unstable> { inherit (config.nixpkgs) config; };
  # Workaround for vendored libbpf-sys 1.5.0 shadowing <linux/types.h> without
  # __u128/__s128, which breaks compilation against newer Linux aarch64 headers
  # (asm/sigcontext.h, asm/ptrace.h).
  bpftop =
    if pkgs.stdenv.hostPlatform.isAarch64 then
      let
        u128Header = pkgs.writeText "u128-fix.h" ''
          #ifdef __SIZEOF_INT128__
          typedef __signed__ __int128 __s128 __attribute__((aligned(16)));
          typedef unsigned __int128 __u128 __attribute__((aligned(16)));
          #endif
        '';
      in
      pkgs.bpftop.overrideAttrs (old: {
        LIBBPF_SYS_EXTRA_CFLAGS =
          (if old ? LIBBPF_SYS_EXTRA_CFLAGS then "${old.LIBBPF_SYS_EXTRA_CFLAGS} " else "")
          + "-include ${u128Header}";
      })
    else
      pkgs.bpftop;
in
{
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
    android_sdk.accept_license = true;
  };

  home.packages = with pkgs; [
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-history-substring-search
    zsh-fast-syntax-highlighting

    shfmt
    shellcheck
    asciinema
    git
    tmux
    zellij

    vim
    neovim
    micro
    fresh-editor

    coreutils
    findutils
    # binutils # conflicts with `clang` because both provide `ld.gold`.
    moreutils
    plocate
    # gnupg
    curl
    wget
    watch
    rclone
    rsync
    restic

    # Nix stuff:
    nix-zsh-completions
    statix
    nix-diff
    nixfmt
    nil
    dconf2nix
    # nix-locate
    # nix-index
    # comma

    # Rust tools/stuff:
    # https://zaiste.net/posts/shell-commands-rust/
    bat
    fd
    procs
    sd
    dust
    starship
    ripgrep
    tokei
    hyperfine
    bandwhich
    grex
    zoxide
    delta
    lsd
    atuin
    hexyl
    difftastic
    tealdeer
    duf
    watchexec
    just
    hgrep
    eza

    go
    gopls
    gofumpt
    delve
    golangci-lint

    nodejs
    # rustc
    # cargo
    # python3

    # Compiler cache
    ccache

    # Kubernetes:
    kubectl
    kubernetes-helm
    kind
    k9s
    stern
    # docker-compose

    sqlite

    gdb
    valgrind
    # lldb
    # llvm
    # clang
    strace

    jq
    yq

    bottom
    pstree
    tree
    htop
    btop
    # glances
    powertop

    # Networking stuff:
    nmap
    arp-scan
    tcpdump
    socat
    netcat
    traceroute
    tshark
    dnsutils
    unixtools.netstat
    gping
    mtr
    iftop
    # wireshark
    wireshark-cli
    sshpass
    tailscale

    rs-tftpd

    # System information tools:
    screenfetch
    fastfetch

    # Comrpession tools:
    zip
    unzip
    p7zip
    xz
    lz4
    zstd
    gzip
    bzip2

    # eBPF tools:
    bpf-linker
    bpftrace
    bpftools
    bpfmon
    bpftop
    bpftune
    libbpf
    bcc
    pwru

    # Git:
    gh

    # For https://blog.bana.io, otherwise we get the below error:
    # `WARN  Module "github.com/CaiJimmy/hugo-theme-stack/v4" is not compatible with this Hugo version: Min 0.157.0 extended; run "hugo mod graph" for more information.`
    pkgsUnstable.hugo

    # AI tools:
    # claude-code

    # Fonts:
    iosevka
    fira
    fira-sans
    # fira-sans # included by `google-fonts`
    # google-fonts
    cascadia-code
    corefonts
    vista-fonts
    # wineWow64Packages.fonts
    hanken-grotesk

    # Terminal:
    # wezterm
    tio
    wl-clipboard
    ghostty

    # # Window manager:
    # hyprland

    # Android:
    # android-tools
    # androidsdk
    # androidenv.androidPkgs.tools
    # androidenv.androidPkgs.ndk-bundle
    # androidenv.androidPkgs.androidsdk
    # androidenv.androidPkgs.platform-tools

    gnomeExtensions.dash-to-dock
    gnomeExtensions.appindicator
    gnomeExtensions.launch-new-instance
    gnomeExtensions.pop-shell
    gnomeExtensions.tiling-assistant

    # Cloud Computing:
    oci-cli
  ];
}

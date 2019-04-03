{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "lambda";
  networking.wireless.enable = true;

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Europe/Dublin";

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    #programming
    ghc
    idris
    cabal-install
    racket
    gcc

    #libs
    haskellPackages.product-profunctors
    glfw

    #editors
    neovim
    espeak
    kitty

    #net
    lynx
    surf
    firefox
    aria2
    git
    transmission
    matterbridge
    tdesktop
    wpa_supplicant
    openvpn

    #doc
    zathura
    groff

    #i3
    i3-gaps
    i3blocks-gaps

    #misc
    unzip
    zip
    gnuplot
    tree
    sxiv
    wget
    htop
    iftop
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  services.printing.enable = true;

  sound.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support
  services.xserver.libinput.enable = true;

  #i3
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.package = pkgs.i3-gaps;

  users.users.vagabond = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "networkmanager" ];
  };

  system.stateVersion = "18.09"; # Did you read the comment?

}

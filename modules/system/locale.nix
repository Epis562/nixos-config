{
  flake.modules.nixos.locale = {
    time.timeZone = "Europe/Paris";

    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "fr_FR.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "fr_FR.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
    };
    console.keyMap = "fr";
  };
}

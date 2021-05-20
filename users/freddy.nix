{

  allowUnfree = true;
  allowBroken = false;
  allowUnsupportedSystem = true;

  permittedInsecurePackages = [
    "openssl-1.0.2u"
  ];

  packageOverrides = pkgs: with pkgs; {
  };
}

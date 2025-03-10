{
  ##########################################################################################>
  #
  # NixOS Configuration
  #
  ##########################################################################################>
  users.users.hermes = {
    # Herme's authorizedKeys
    openssh.authorizedKeys.keys = [
      "SHA256:Ib5d4lKSIShSxgx02cOAsIi+vCeImZoBBMB2Ees3aGc fireshifter767@gmail.com"
    ];
  };

  users.users.apollo = {
    # Apollo's authorizedKeys
    openssh.authorizedKeys.keys = [
      "SHA256:Ib5d4lKSIShSxgx02cOAsIi+vCeImZoBBMB2Ees3aGc fireshifter767@gmail.com"
    ];
  };
}


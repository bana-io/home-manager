{
  ...
}:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        IdentityFile = "~/.ssh/id_ed25519";
        ForwardAgent = true;
        StrictHostKeyChecking = "no";
        UserKnownHostsFile = "/dev/null";
        AddKeysToAgent = "yes";
        # https://www.ucartz.com/clients/knowledgebase/1151/How-to-Stop-SSH-Session-Timeouts-ServerAliveInterval-ClientAliveInterval-and-Exit-Kill-or-Stop-SSH.html
        ServerAliveInterval = 60;
        ServerAliveCountMax = 3;
      };
    };
  };
}

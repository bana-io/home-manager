{
  ...
}:
{
  programs.git = {
    enable = true;
    lfs.enable = true;
    ignores = [
      ".ignore"
      ".ignore/"
      ".tmp"
      ".tmp/"
    ];
    signing = {
      format = "ssh";
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
    settings = {
      user = {
        name = "Mohamed Bana";
        email = "m@bana.io";
      };
      init = {
        defaultBranch = "main";
      };
      color = {
        ui = "true";
        advice = "true";
        status = "always";
      };
      core = {
        ignorecase = "false";
        hideDotFiles = "false";
        editor = "code --wait --new-window";
      };
      commit = {
        verbose = true;
      };
      url = {
        "git@github.com:" = {
          insteadOf = [
            "https://github.com/"
          ];
        };
        "git@gitlab.com:" = {
          insteadOf = [
            "https://gitlab.com/"
          ];
        };
      };
      alias = {
        c = "checkout";
        d = "diff";
        dc = "diff --cached";
        s = "status";
        ll = "log -n1";
        undo = "reset --soft HEAD~1";
        amend = "commit --amend -CHEAD --signoff";
        cm = "!git commit --verbose --signoff --file ''$(pwd)/.ignore/COMMIT_MESSAGE.md";
      };
    };
  };
}

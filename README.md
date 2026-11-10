# `home-manager`

Nix Home Manager configuration, see <https://nix-community.github.io/home-manager>.

## Install Nix and setup Home Manager

First step is not required on Fedora (45+) as we can simply do `sudo dnf install nix`:

```sh
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
# restart shell, reboot, logout an log back in or start a new shell.
exit
```

```sh
install -D <(printf '%s\n' "experimental-features = nix-command flakes") ~/.config/nix/nix.conf
install -D <(printf '%s\n' "{
  allowUnfree = true;
}") ~/.config/nixpkgs/config.nix
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixpkgs
sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --add https://github.com/nix-community/nix-index-database/archive/master.tar.gz nix-index-database
sudo nix-channel --add https://github.com/nix-community/comma/archive/master.tar.gz comma
sudo nix-channel --update
sudo systemctl restart nix-daemon.service
git clone https://github.com/bana-io/home-manager.git ~/.config/home-manager
nix run home-manager/master -- init --switch
sudo chsh --shell $(which zsh) $(whoami)
```

<!-- ```sh
install -D <(printf '%s\n' "experimental-features = nix-command flakes") ~/.config/nix/nix.conf
sudo systemctl restart nix-daemon.service
git clone https://github.com/bana-io/home-manager.git ~/.config/home-manager
nix run home-manager/master -- init --switch
sudo chsh --shell $(which zsh) $(whoami)
``` -->

Then start a new shell or optionally just reboot ☺. For shell history, do the below:

## Rust

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y
echo '. "${HOME}/.cargo/env"' | tee -a ~/.zprofile
```

## History

Replace `ATUIN_KEY` below with an actual valid key:

```sh
atuin login --username 'mbana' --key="${ATUIN_KEY}"
atuin sync
```

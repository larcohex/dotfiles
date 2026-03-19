#!/usr/bin/env fish

# OS - CachyOS (arch)
# WM - niri
# Shell - fish

# Run as root
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

# Environment variables
mkdir -p ~/.local/bin
fish_add_path ~/.local/bin

# Packages
pacman -S shelly
shelly sync --force
shelly upgrade --no-confirm
tldr --update
shelly install zen-browser-bin vivaldi flatpak ripgrep --no-confirm
shelly remove firefox --no-confirm
flatpak install com.bitwarden.desktop
# Rust
curl https://sh.rustup.rs -sSf | sh -s -- -y
cargo install --locked tree-sitter-cli
# Nerd fonts
curl -fsSL https://raw.githubusercontent.com/getnf/getnf/main/install.sh | bash
getnf -i FiraCode,JetBrainsMono
# asdf (node, uv)
git clone https://aur.archlinux.org/asdf-vm.git && cd asdf-vm && makepkg -si && cd .. && rm -rf asdf-vm
echo "# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims" >> ~/.config/fish/config.fish
asdf completion fish > ~/.config/fish/completions/asdf.fish
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf cmd nodejs update-nodebuild
asdf install nodejs "$(asdf cmd nodejs resolve lts)"
asdf set -u nodejs "$(asdf cmd nodejs resolve lts)"
asdf plugin add uv https://github.com/asdf-community/asdf-uv.git
asdf install uv latest
asdf set -u uv latest
uv python install
# pnpm
curl -fsSL https://get.pnpm.io/install.sh | sh -
# prompt
curl -sS https://starship.rs/install.sh | sh
starship init fish | source

# Neovim
cp -R ./nvim ~/.config/

# .bashrc
cp ./linux/.bashrc ~/.bashrc

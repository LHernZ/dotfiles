# Install order script WIP
We need to instal MesloLGS NF
Install neovim yay -S neovim-nightly-bin
Install pynvim sudo pacman -S python-pynvim | pip install pynvim
Install vimplug sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
Install termite sudo pacman -S termite
https://medium.com/tech-notes-and-geek-stuff/install-zsh-on-arch-linux-manjaro-and-make-it-your-default-shell-b0098b756a7a
sudo chsh -s $(which zsh)
Install tmux sudo pacman -S tmux
Install tmux tpm

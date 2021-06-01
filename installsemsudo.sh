#!/bin/bash
set -euxo pipefail
sudo pacman -Syyu curl git yay ;\
curl -o ~/gist/arch.pacmanity https://gist.githubusercontent.com/1mamute/df977bbcd3685fc75bca52f1ccc8b398/raw/768e1ccbddd2605344e25816d3e083e23b7408fc/arch.pacmanity ;\
mkdir ~/.config/Code ;\
mkdir ~/.config/Code/User ;\
mkdir ~/.config/nvim ;\
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' ;\
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended ;\
chsh -s "$(which zsh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k ;\
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions ;\
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting ;\
yay -S "$(tr '\n' ' ' < ~/gist/arch.pacmanity)" --cleanafter --answerclean a --answerdiff n --answeredit n --answerupgrade a ;\
curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh ;\
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0 ;\
asdf update ;\
asdf plugin add direnv  ;\
asdf plugin add flux2 ;\
asdf plugin add github-cli ;\
asdf plugin add golang ;\
asdf plugin add helm ;\
asdf plugin add nodejs ;\
asdf plugin add k9s ;\
asdf plugin add kubectl ;\
asdf plugin add packer ;\
asdf plugin add python ;\
asdf plugin add terraform ;\
asdf install direnv latest ;\
asdf install flux2 latest ;\
asdf install github-cli latest  ;\
asdf install golang latest ;\
asdf install helm latest ;\
asdf install nodejs lts ;\
asdf install k9s latest  ;\
asdf install kubectl latest ;\
asdf install packer latest ;\
asdf install python 3.9.5 ;\
asdf install terraform latest ;\

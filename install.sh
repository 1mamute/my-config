#!/bin/bash
sudo pacman -Syyu curl git yay
git clone https://gist.github.com/df977bbcd3685fc75bca52f1ccc8b398.git ~/gist
mkdir ~/.config/Code
mkdir ~/.config/Code/User
mkdir ~/.config/nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
yay -S $(tr '\n' ' ' < ~/gist/manjaro.xfce.pacmanity) --cleanafter --answerclean a --answerdiff n --answeredit n --answerupgrade a

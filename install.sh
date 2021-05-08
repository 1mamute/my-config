#!/bin/bash
sudo pacman -Syyu curl git yay
git clone https://gist.github.com/df977bbcd3685fc75bca52f1ccc8b398.git ~/gist
cd ~/gist
yay -S $(tr '\n' ' ' < manjaro.xfce.pacmanity)
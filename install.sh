if [ -d ~/.dotfiles ]
then
  echo "You already have .dotfiles installed. You'll need to remove ~/.dotfiles if you want to install"
  exit
fi

echo "Cloning dotfiles..."
/usr/bin/env git clone git://github.com/doke/dotfiles.git ~/.dotfiles

cd ~/.dotfiles

rake install

echo "Time to change your default shell to zsh!"
ZSH=`which zsh`
chsh -s $ZSH

echo "Hooray! dotfiles has been installed."
$ZSH
source ~/.zshrc
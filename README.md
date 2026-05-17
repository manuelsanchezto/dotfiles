# dotfiles
My own dotfiles repository to manage my standard configuration

## Currently moving it to manage it using GNU Stow
-- To link the emacs config:
stow emacs 

# TODO:
- Next steps:
  - [] Include Hyprconfig
  - [] Review the current config and delete unused files
  - [] Review completely the init script and adapt it for different machines
  - [] Add a mechanism to manage the configuration updates directly from emacs

##TODO: This has changed and is waiting a review
To execute run:
git clone git@github.com:manuelsanchezto/dotfiles.git
chmod +x ./dotfiles/init.sh
sh ./dotfiles/init.sh

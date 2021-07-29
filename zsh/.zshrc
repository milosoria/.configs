# compinit fix for slow startup
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# Path to your oh-my-zsh installation.
export ZSH="/home/camilo/.oh-my-zsh"

# Plugins with oh my zsh
plugins=(
    zshfl
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-nvm
)

source $ZSH/oh-my-zsh.sh
# Case sensitive search
CASE_SENSITIVE="true"

# Node lazy loading for faster shell startup 
export NVM_LAZY_LOAD=true
lazynvm() {
  unset -f nvm node npm
  export NVM_DIR=~/.nvm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
}

nvm() {
  lazynvm 
  nvm $@
}

node() {
  lazynvm
  node $@
}

npm() {
  lazynvm
  npm $@
}


#source Custom commands
source ~/custom_commands/custom_commands.sh

# Aliases 
# git
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gs='git status'
alias qpll='git pull'
# apt
alias update='sudo apt-get update -y'
alias upgrade='sudo apt-get upgrade -y'
alias install='sudo apt-get install'
#general
alias home='cd ~'
alias ex='exit'
alias open='xdg-open'
alias nv='nvim'
alias vimrc='cd ~/.config/nvim && vim init.vim'
alias kittyconf='cd ~/.config/kitty && vim kitty.conf'
alias ll='ls -la'
alias mine='cd ~/projects'
# cheat sheet
alias cheat='cht.sh'
# custom commands
alias create='project'
alias qpsh='qpsh'

# Path exports
export VISUAL=nvim
export EDITOR=$VISUAL
export PATH=/snap/bin:$PATH
export PATH=$PATH/neovim/build/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/.rvm/bin
export PATH=$PATH:/.yarn/bin

# fzf for shell 
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Starship prompt
# Path to starship
export STARSHIP_CONFIG=~/.config/starship/starship.toml
# load starship
eval "$(starship init zsh)"

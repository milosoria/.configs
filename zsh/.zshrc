source <(fzf --zsh)

eval "$(starship init zsh)"
# ZSH_THEME=021011
DISABLE_AUTO_TITLE=true # Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-vi-mode git dircycle nvm  zsh-autosuggestions zsh-syntax-highlighting zsh-z)

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
zstyle ':omz:update' mode auto # update automatically without asking

# User configuration
export GIT_EDITOR="nvim"
export VISUAL="nvim"
export EDITOR="nvim"
export editor="nvim"
export ZDOTDIR=$HOME/.config/zsh
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/Library/Python/3.9/bin
## Android Studio shit
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
## Add RUST VDHL
export PATH=$PATH:$HOME/.local/share/rust_hdl/target/release
## Add JAVA
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home
## pnpm
export PNPM_HOME="/Users/milosoria/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

## Hombrew api key
export HOMEBREW_GITHUB_API_TOKEN=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
## Dont use docker desktop tools
export DOCKER_BUILDKIT=0
export COMPOSE_DOCKER_CLI_BUILD=0
## NVM: loads nvm and sources nvm completion
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Source customs
source $HOME/.config/custom_commands/custom_commands.sh
source $HOME/.config/zsh/zsh-aliases

# Created by `pipx` on 2024-05-27 14:00:57
export PATH="$PATH:/Users/milosoria/.local/bin"
export no_proxy=*
source $HOME/.config/zsh/.zshsecrets

if [ -z "$TMUX" ] && [ "$TERM" = "xterm-kitty" ]; then
  tmux attach || exec tmux new-session && exit;
fi


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

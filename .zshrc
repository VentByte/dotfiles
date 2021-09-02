export ZSH="~/.oh-my-zsh"

ZSH_THEME="nicoulaj"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"

plugins=(
  sudo
  jump
  dotenv
  kubectl
  history
  terraform
  dirhistory
  zsh-interactive-cd
  zsh-autosuggestions
)

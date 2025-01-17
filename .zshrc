export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=emoji
DISABLE_LS_COLORS="true"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  command-not-found
)

eval $(thefuck --alias)

source $ZSH/oh-my-zsh.sh
export LANG=pt_BR.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
   export EDITOR='nvim'
 fi


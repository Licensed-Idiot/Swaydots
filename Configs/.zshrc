# oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# use powerlevel10k theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# extra plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Preferred editor
export EDITOR='nvim'

# helpful aliases
alias hcl="history -c" #clear history
alias gcl="git clone"
alias c="clear" # clear terminal
alias ls="eza --icons=auto"
alias  l="eza -lh  --icons=auto" # long list
alias ll="eza -lha --icons=auto --sort=name --group-directories-first" # long list all
alias ld="eza -lhD --icons=auto" # long list dirs
alias lt="eza --icons=auto --tree" # list folder as tree
alias vim="nvim"

# Custom exports for scripts 
export PATH=~/.local/share/bin/:$PATH
export XDG_SCREENSHOTS_DIR=$HOME/Pictures

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

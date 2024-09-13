# ---- Oh My Zsh ----
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# If you do not want any theme enabled, set ZSH_THEME to blank: ZSH_THEME=""
ZSH_THEME=""

# I've opted to obtain plugins using homebrew, and source them manually - except for git
plugins=(git)
source $ZSH/oh-my-zsh.sh

# ---- Homebrew installed plugins ----
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ---- fzf -----
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# fzf options
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi \
--height 50% \
--layout reverse \
--tmux center,80% \
--prompt '∷ ' \
--pointer ▶ \
--marker ⇒"

# fzf and git
source $HOME/fzf-git.sh/fzf-git.sh

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'" "$@" ;;
    ssh)          fzf --preview 'dig {}' "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# Aliases to use eza in place of ls
alias ls="eza --icons=always"
alias ll="ls -lah"
alias l="eza -a --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

# ---- Zoxide ----
eval "$(zoxide init zsh)"
alias cd="z"

# ---- direnv ----
eval "$(direnv hook zsh)"

# ---- Starship ----
eval "$(starship init zsh)"

# ---- Aliases -----
alias dotfiles="nvim ~/.dotfiles"
alias sb="cd ~/Documents/Second\ Brain/"
alias ep="echo ${PATH} | sed -e $'s/:/\\\n/g'"

# ---- Fastfetch ----
# Cute terminal splash screen. Keep this at the end of the config.
echo 
fastfetch

# If you come from bash you might have to change your $PATH.
#export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/Russel/.oh-my-zsh"

# This theme sets a lot of stuff
ZSH_THEME="agnoster"
# Your color_preset is different
# It is set to: Argonaut

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-syntax-highlighting
  )

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Key bindings & fuzzy completion for fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# $PATH stuff
export PYENV_ROOT="$HOME/.pyenv"
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$PYENV_ROOT/bin:$PATH"

# Add pyenv init to your shell to enable shims and autocompletion
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# for ycm
export PYTHON_CONFIGURE_OPTS="--enable-framework"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
 __conda_setup="$('/Users/Russel/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/Russel/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/Russel/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/Russel/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

alias py3.7.1="source ~/py3.7.1venv/bin/activate"

# See https://github.com/golang/go/wiki/SettingGOPATH#zsh
export GOPATH=$HOME/go

# Use exa instead of ls
alias ls=exa

# Rbenv stores data under ~/.rbenv by default. If you absolutely need to
# store everything under Homebrew's prefix, include this in your profile:
export RBENV_ROOT=/usr/local/var/rbenv

# Load rbenv automatically
eval "$(rbenv init -)"

[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"


# Aliases for compilers
# See: https://apple.stackexchange.com/questions/99077/how-to-set-gcc-4-8-as-default-gcc-compiler/99157#99157
alias gcc="gcc-9"
alias cc="gcc-9"
alias g++="g++-9"

# Colors for spacemacs
# See: https://github.com/syl20bnr/spacemacs/issues/1269#issuecomment-94319147
export TERM=xterm-256color


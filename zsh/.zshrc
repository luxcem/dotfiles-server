# zshrc
# Using oh-my-zsh : https://github.com/robbyrussell/oh-my-zsh

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

ZSH_CUSTOM=$HOME/.zsh-custom
ZSH_THEME="luxcem"
plugins=(git bower supervisor celery debian django npm pip pylint python wd)

source $ZSH/oh-my-zsh.sh

################
# 1. Les alias #
################

# Gestion du 'ls' : couleur & ne touche pas aux accents
#alias ls='ls --classify --tabsize=0 --literal --color=auto --show-control-chars --human-readable'

alias tree="find . -not -wholename '*/.git/*' -not -wholename '*/.bzr/*' -not -name '.bzr' -not -name '.git' -not -name '.DS_Store' -not -name '*.sw?' -not -name '*~' -print | sed -e 's;[^/]*/;|__;g;s;__|; |;g'"

# Demande confirmation avant d'écraser un fichier
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Raccourcis pour 'ls'
# List direcory contents
export LS_OPTIONS='--color'
if (( $+commands[dircolors] )) ; then
  alias l='ls $LS_OPTIONS'
  alias ls='ls $LS_OPTIONS'
  alias ll='ls $LS_OPTIONS -lh'
  alias la='ls $LS_OPTIONS -ah'
  alias lla='ls $LS_OPTIONS -alh'
  alias sl='ls $LS_OPTIONS' # often screw this up
fi

# Quelques alias pratiques
alias e='emacs'
alias less='less --quiet'
alias md='mkdir -p'
alias se='sudo -E'
alias bower='noglob bower'
alias scr='screen -Rd fabdev -c ~/.screenrc'

# Je ne veux JAMAIS de beeps
unsetopt beep
unsetopt hist_beep
unsetopt list_beep
# >| doit être utilisés pour pouvoir écraser un fichier déjà existant ;
# le fichier ne sera pas écrasé avec '>'
unsetopt clobber
# Ctrl+D est équivalent à 'logout'
unsetopt ignore_eof
# Affiche le code de sortie si différent de '0'
setopt print_exit_value
# Demande confirmation pour 'rm *'
unsetopt rm_star_silent

# Shema de completion
unsetopt list_ambiguous

# Options de complétion
# Quand le dernier caractère d'une complétion est '/' et que l'on
# tape 'espace' après, le '/' est effaçé
setopt auto_remove_slash

# Quand l'utilisateur commence sa commande par '!' pour faire de la
# complétion historique, il n'exécute pas la commande immédiatement
# mais il écrit la commande dans le prompt
setopt hist_verify
# Si la commande est invalide mais correspond au nom d'un sous-répertoire
# exécuter 'cd sous-répertoire'
setopt auto_cd
# L'exécution de "cd" met le répertoire d'où l'on vient sur la pile
setopt auto_pushd
# Ignore les doublons dans la pile
setopt pushd_ignore_dups
# N'affiche pas la pile après un "pushd" ou "popd"
setopt pushd_silent
# "pushd" sans argument = "pushd $HOME"
setopt pushd_to_home

# Les jobs qui tournent en tâche de fond sont nicé à '0'
unsetopt bg_nice
# N'envoie pas de "HUP" aux jobs qui tourent quand le shell se ferme
unsetopt hup

# Nombre d'entrées dans l'historique
export HISTORY=1000
export SAVEHIST=1000

#historique instantané
export HISTSIZE=500

# Fichier où est stocké l'historique
export HISTFILE=$HOME/.history

# Chaque ligne est ajoutée dans l'historique à mesure qu'elle est tapée
setopt inc_append_history

# Ne stocke pas  une ligne dans l'historique si elle  est identique à la
# précédente
setopt hist_ignore_dups

# Supprime les  répétitions dans le fichier  d'historique, ne conservant
# que la dernière occurrence ajoutée
setopt hist_ignore_all_dups

# La recherche dans  l'historique avec l'éditeur de commandes  de zsh ne
# montre  pas  une même  ligne  plus  d'une fois,  même  si  elle a  été
# enregistrée
setopt hist_find_no_dups

# Charge l'autocompletion
autoload -U compinit
compinit

# Color listing
if (( $+commands[dircolors] )) ; then
  eval $(dircolors ~/.dir_colors)
fi

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BDésolé, pas de résultats pour : %d%b'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}'
zstyle ':completion:*' max-errors 3 numeric
zstyle ':completion:*' use-compctl false

zstyle ':completion:*:rm:*' ignore-line yes
zstyle ':completion:*:mv:*' ignore-line yes
zstyle ':completion:*:cp:*' ignore-line yes

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_cache

zmodload zsh/complist
setopt extendedglob
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ':completion:*:processes' command 'ps -ax'
zstyle ':completion:*:processes-names' command 'ps -aeo comm='
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:killall:*:processes-names' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:killall:*' menu yes select

setopt correctall

# Adds .local/bin to $PATH
export PATH="$PATH:$HOME/.local/bin"

# Node packages without sudo (in local path)


# Stop zsh to correct aptitude to .aptitude
alias sudo="nocorrect sudo"
alias pip-upgrade-all="pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"


cless(){
 LESSOPEN='| source-highlight --failsafe --out-format=esc256 -o STDOUT -i %s 2>/dev/null ' less -R "$@"
}

# Make C-P behave exactly like up arrow
bindkey "^P" up-line-or-search

if [[ -a $HOME/.bash_profile ]]; then
    source $HOME/.bash_profile
fi


# Exemple of what can be found in bash profile.

# NPM_PACKAGES="${HOME}/.npm-packages"
# NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
# PATH="$NPM_PACKAGES/bin:$PATH"

# # Unset manpath so we can inherit from /etc/manpath via the `manpath`e
# # command
# unset MANPATH  # delete if you already modified MANPATH elsewhere in your config
# MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
# # added by Pew
# source $(pew shell_config)
# Workon HOME for virtualenvs
# export WORKON_HOME=/var/www/.virtualenvs

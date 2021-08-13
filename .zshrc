# Change this to 1 for profiling
_prof=0
if [ "$_prof" -eq 1 ]; then
  zmodload zsh/datetime
  setopt prompt_subst
  PS4='$EPOCHREALTIME %N:%i> '
  exec 3>&2 2>"/tmp/zsh_prof.$$"
  setopt xtrace
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="random"

ZSH_THEME_RANDOM_CANDIDATES=(
  "Soliah"
  "af-magic"
  "afowler"
  "agnoster"
  "alanpeabody"
  "amuse"
  "apple"
  "arrow"
  "aussiegeek"
  "avit"
  "awesomepanda"
  "bira"
  "blinks"
  "bureau"
  "candy"
  "clean"
  "cloud"
  "crcandy"
  "crunch"
  "cypher"
  "dallas"
  "darkblood"
  "daveverwer"
  "dieter"
  "dogenpunk"
  "dpoggi"
  "dst"
  "dstufft"
  "duellj"
  "eastwood"
  "edvardm"
  "essembeh"
  "evan"
  "fishy"
  "flazz"
  "fletcherm"
  "fox"
  "frisk"
  "funky"
  "fwalch"
  "gallifrey"
  "gallois"
  "garyblessington"
  "gentoo"
  "geoffgarside"
  "gianu"
  "gnzh"
  "gozilla"
  "half-life"
  "imajes"
  "intheloop"
  "jaischeema"
  "jbergantine"
  "jispwoso"
  "jnrowe"
  "jonathan"
  "josh"
  "jreese"
  "jtriley"
  "juanghurtado"
  "junkfood"
  "kafeitu"
  "kardan"
  "kennethreitz"
  "kolo"
  "kphoen"
  "lambda"
  "linuxonly"
  "lukerandall"
  "macovsky-ruby"
  "macovsky"
  "maran"
  "mgutz"
  "mh"
  "michelebologna"
  "mikeh"
  "miloshadzic"
  "minimal"
  "mortalscumbag"
  "mrtazz"
  "murilasso"
  "muse"
  "nanotech"
  "nebirhos"
  "nicoulaj"
  "norm"
  "obraun"
  "peepcode"
  "philips"
  "pmcgee"
  "pygmalion"
  "re5et"
  "refined"
  "rgm"
  "risto"
  "rixius"
  "robbyrussell"
  "sammy"
  "simonoff"
  "simple"
  "skaro"
  "smt"
  "sonicradish"
  "sorin"
  "sporty_256"
  "steeef"
  "strug"
  "sunaku"
  "sunrise"
  "superjarin"
  "suvash"
  "takashiyoshida"
  "terminalparty"
  "theunraveler"
  "tjkirch"
  "tjkirch_mod"
  "tonotdo"
  "wezm+"
  "wezm"
  "xiong-chiamiov-plus"
  "xiong-chiamiov"
  "ys"
  "zhann"
)

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git python docker docker-compose golang colored-man-pages kubectl terraform github aws minikube)
case "$(uname)" in
  (Darwin) plugins+=(osx brew) ;;
  (*) : ;;
esac

# User configuration
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/git/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# For zsh 5.4.x
setopt ALIAS_FUNC_DEF 2> /dev/null

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
#if [[ -n $SSH_CONNECTION ]]; then
#  export EDITOR='vim'
#else
#  export EDITOR='mvim'
#fi
if [ -f "/usr/local/bin/vim" ]; then
  alias vim='/usr/local/bin/vim'
fi
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ssh-nopubkey='ssh -o PubkeyAuthentication=no '

# Time format
TIMEFMT=$'=====\nJOB %J\n%P    cpu\n%E real\n%U user\n%S sys'

# Lua
export "PATH=$PATH:~/sources/lua-5.3.0/install/bin"

# Perl
export PERL_LOCAL_LIB_ROOT="$PERL_LOCAL_LIB_ROOT:$HOME/perl5"
export PERL_MB_OPT="--install_base $HOME/perl5"
export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"
export PERL5LIB="$HOME/perl5/lib/perl5:$PERL5LIB"
export PATH="$HOME/perl5/bin:$PATH"

# Cask
export PATH="$HOME/.cask/bin:$PATH"

# Stow
export STOW_DIR="/usr/local/stow"
alias sustow='sudo STOW_DIR="$STOW_DIR"'

# Go
export GOPATH="$HOME/go"
export PATH="$HOME/sources/go/bin:$PATH:$GOPATH/bin"

# Ansible hosts
export ANSIBLE_HOSTS=~/ansible_hosts

# Git
if [ -f "/usr/local/bin/git" ]; then
  alias git='/usr/local/bin/git'
fi

# Emacs
if [ -f "/Applications/Emacs.app/Contents/MacOS/Emacs" ]; then
  alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs"
fi

# Perl 6
export PATH="/usr/local/stow/perl6/share/perl6/site/bin:$PATH"

# Zsh
if [ -f "/usr/local/bin/zsh" ]; then
  alias zsh='/usr/local/bin/zsh'
fi

# Rust
export PATH="$PATH:$HOME/.cargo/bin"

# Perlbrew
if [ -f "$HOME/perl5/perlbrew/etc/bashrc" ]; then
  .  ~/perl5/perlbrew/etc/bashrc
fi

# Perlbrew
if [ -f "$HOME/perl5/perlbrew/etc/bashrc" ]; then
  . "$HOME/perl5/perlbrew/etc/bashrc"
fi

export PYTHONSTARTUP=~/.pythonrc

# Path for cabal
export PATH="$HOME/.cabal/bin:$PATH"

case "$(uname)" in
  "Linux")
    # set variables for ibus
    export XMODIFIERS=”@im=ibus”
    export GTK_IM_MODULE=ibus
    export QT4_IM_MODULE=ibus
    export QT_IM_MODULE=ibus

    export TERM=xterm-256color

    # /usr/bin/xinput set-prop 'ETPS/2 Elantech Touchpad' 'Device Enabled' 1

    dualmonitor() {
      xrandr --output VGA-0 --right-of LVDS
    }

    ptouch() {
      for p in "$@"; do
        _dir=${p%/*}
        [ -d "$_dir" ] || mkdir -p -- "$_dir"
        touch -- "$p"
      done
    }

    export VAGRANT_HOME=/home/cuonglm/.vagrant
    ;;
  "Darwin")
    # Homebrew
    export PATH="$PATH:/opt/homebrew/bin"

    unalias ipython
    ;;
esac

# Repetition input, http://unix.stackexchange.com/a/315462/38906
repeat-string() {
  REPLY=
  repeat $1 REPLY+=$2
}

expand-repeat() {
  emulate -L zsh
  set -o rematchpcre
  local match mbegin mend MATCH MBEGIN MEND REPLY
  if [[ $LBUFFER =~ '^(.*?)([[:alnum:]]+)(.)$' ]]; then
    repeat-string $((36#$match[2])) $match[3]
    LBUFFER=$match[1]$REPLY
  else
    return 1
  fi
}
zle -N expand-repeat
bindkey "$terminfo[kf8]" expand-repeat

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/cuonglm/google-cloud-sdk/path.zsh.inc' ]; then source '/home/cuonglm/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/cuonglm/google-cloud-sdk/completion.zsh.inc' ]; then source '/home/cuonglm/google-cloud-sdk/completion.zsh.inc'; fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# QT
export QT_VERSION=5.9.1
export QT_DIR="$HOME/Qt"

# direnv
eval "$(direnv hook zsh)"

# pipenv
#compdef pipenv
_pipenv() {
  eval $(env COMMANDLINE="${words[1,$CURRENT]}" _PIPENV_COMPLETE=complete-zsh  pipenv)
}
if [[ "$(basename ${(%):-%x})" != "_pipenv" ]]; then
  autoload -U compinit && compinit
  compdef _pipenv pipenv
fi

# ssh
alias ssh-wp='ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no '

# gccgo
alias go-gcc='LD_LIBRARY_PATH=/usr/local/stow/gccgo/lib64 go '

# Cleaning up after profiling
if [ "$_prof" -eq 1 ]; then
  zmodload -u zsh/datetime
  unsetopt xtrace
  exec 2>&3 3>&-
fi

# opam configuration
test -r /home/cuonglm/.opam/opam-init/init.zsh && . /home/cuonglm/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# nixos
if [ -e /Users/cuonglm/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/cuonglm/.nix-profile/etc/profile.d/nix.sh; fi

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
ZSH_THEME="random"

ZSH_THEME_RANDOM_CANDIDATES=(
  "Soliah"
  "af-magic"
  "afowler"
  "agnoster"
  "alanpeabody"
  "amuse"
  "apple"
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
export UPDATE_ZSH_DAYS=30

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
plugins=(
  git
  python pip
  docker docker-compose
  golang
  colored-man-pages
  kubectl minikube
  terraform
  aws
  gh
  npm
  rust
  flyctl
)
case "$(uname)" in
  (Darwin) plugins+=(macos brew) ;;
  (*) : ;;
esac

# User configuration
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# For zsh 5.4.x
setopt ALIAS_FUNC_DEF 2> /dev/null

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

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
    export PATH="/opt/homebrew/bin:$PATH"
    ;;
esac

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
if [ -n "$use_lua" ]; then
  export "PATH=$PATH:~/sources/lua-5.3.0/install/bin"
fi

# Perl
if [ -n "$use_perl" ]; then
  export PERL_LOCAL_LIB_ROOT="$PERL_LOCAL_LIB_ROOT:$HOME/perl5"
  export PERL_MB_OPT="--install_base $HOME/perl5"
  export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"
  export PERL5LIB="$HOME/perl5/lib/perl5:$PERL5LIB"
  export PATH="$HOME/perl5/bin:$PATH"

  # Perlbrew
  if [ -f "$HOME/perl5/perlbrew/etc/bashrc" ]; then
    . "$HOME/perl5/perlbrew/etc/bashrc"
  fi
fi

# Cask
export PATH="$HOME/.cask/bin:$PATH"

# Stow
if (( $+commands[stow] )); then
  export STOW_DIR="/usr/local/stow"
  alias sustow='sudo STOW_DIR="$STOW_DIR"'
fi

# Git
if [ -f "/usr/local/bin/git" ]; then
  alias git='/usr/local/bin/git'
fi

# Emacs
if [ -f "/Applications/Emacs.app/Contents/MacOS/Emacs" ]; then
  alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs"
fi

# Rakudo
if (( $+commands[raku] )); then
  export PATH="/usr/local/stow/rakudo/share/perl6/site/bin:$PATH"
fi

# Zsh
if [ -f "/usr/local/bin/zsh" ]; then
  alias zsh='/usr/local/bin/zsh'
fi

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

export PYTHONSTARTUP=~/.pythonrc

# Path for cabal
if (( $+commands[cabal] )); then
  export PATH="$HOME/.cabal/bin:$PATH"
fi

# hugo
if (( $+commands[hugo] )); then
  if [ ! -r "$ZSH_CACHE_DIR/hugo_version" ] || [ "$(hugo version)" != "$(< "$ZSH_CACHE_DIR/hugo_version")" ] || [ ! -f "$ZSH/completions/_hugo" ]; then
    [ ! -d "$ZSH/completions" ] && mkdir "$ZSH/completions"
    hugo gen autocomplete -t zsh > "$ZSH/completions/_hugo"
    hugo version > $ZSH_CACHE_DIR/hugo_version
  fi
  autoload -Uz _hugo
  _comps[hugo]=_hugo
fi

# Go
export GOPATH="$HOME/go"
export PATH="$HOME/sources/go/bin:$GOPATH/bin:$PATH"
compdef _golang -P 'go1.*' gotip

# flyctl
export FLYCTL_INSTALL="$HOME/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
compdef _flyctl flyctl

# Zig
export PATH="$HOME/sources/zig:$PATH"

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

# direnv
eval "$(direnv hook zsh)"

# ssh
alias ssh-wp='ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no '

# gccgo
alias go-gcc='LD_LIBRARY_PATH=/usr/local/stow/gccgo/lib64 go '

# wasmtime
export WASMTIME_HOME="$HOME/.wasmtime"
export PATH="$WASMTIME_HOME/bin:$PATH"

rnd() {
  </dev/urandom LC_ALL=C tr -dc '[:alnum:]_-' | head -c "$1"
}

# Cleaning up after profiling
if [ "$_prof" -eq 1 ]; then
  zmodload -u zsh/datetime
  unsetopt xtrace
  exec 2>&3 3>&-
fi

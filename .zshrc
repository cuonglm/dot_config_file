# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="random"

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
plugins=(git python)
case "$(uname)" in
  (Darwin) plugins+=osx ;;
  (*) : ;;
esac

# User configuration
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/git/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
#if [[ -n $SSH_CONNECTION ]]; then
#  export EDITOR='vim'
#else
#  export EDITOR='mvim'
#fi
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

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/codes
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
. /usr/local/bin/virtualenvwrapper_lazy.sh

if [ "$(uname)" != "Darwin" ]; then
  # set variables for ibus
  export XMODIFIERS=”@im=ibus”
  export GTK_IM_MODULE=ibus
  export QT4_IM_MODULE=ibus
  export QT_IM_MODULE=ibus

  export PERL_LOCAL_LIB_ROOT="$PERL_LOCAL_LIB_ROOT:/home/cuonglm/perl5";
  export PERL_MB_OPT="--install_base /home/cuonglm/perl5";
  export PERL_MM_OPT="INSTALL_BASE=/home/cuonglm/perl5";
  export PERL5LIB="/home/cuonglm/perl5/lib/perl5:$PERL5LIB";
  export PATH="/home/cuonglm/perl5/bin:$PATH";

  export TERM=xterm-256color

  export PYTHONSTARTUP=~/.pythonrc

  . ~/perl5/perlbrew/etc/bashrc

  export PATH="$HOME/.cask/bin:$PATH"

  /usr/bin/xinput set-prop 'ETPS/2 Elantech Touchpad' 'Device Enabled' 0
  #. /usr/local/rvm/scripts/rvm

  # Go workspace
  if [ ! -d "$HOME/go" ]; then
    mkdir "$HOME/go"
    mkdir -p $GOPATH/src/github.com/Gnouc
  fi

  export GOPATH=$HOME/go
  export PATH=$PATH:$GOPATH/bin

  export GOROOT=$HOME/sources/go
  export PATH=$PATH:$GOROOT/bin

  # Path for cabal
  PATH=$HOME/.cabal/bin:$PATH

  # Ansible hosts
  export ANSIBLE_HOSTS=~/ansible_hosts

  dualmonitor() {
    xrandr --output VGA-0 --right-of LVDS
  }

  ptouch() {
    for p in "$@"; do
      _dir="$(dirname "$p")"
      [ -d "$_dir" ] || mkdir -p -- "$_dir"
      touch -- "$p"
    done
  }

  export VAGRANT_HOME=/media/Data/vagrant

  if [ -n "$ZSH_VERSION" ]; then
    # The next line updates PATH for the Google Cloud SDK.
    . '/home/cuonglm/google-cloud-sdk/path.zsh.inc'

    # The next line enables bash completion for gcloud.
    . '/home/cuonglm/google-cloud-sdk/completion.zsh.inc'
  else
    # The next line updates PATH for the Google Cloud SDK.
    . '/home/cuonglm/google-cloud-sdk/path.bash.inc'

    # The next line enables bash completion for gcloud.
    . '/home/cuonglm/google-cloud-sdk/completion.bash.inc'
  fi
fi

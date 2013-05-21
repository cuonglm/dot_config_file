##########################################
# gnouc aka bino1810's .bashrc file.     #
##########################################

# Executed by bash for non-login shells. 
# If not running interactively, don't do anything
case $- in
    *i*) 
         ;;
      *) return
         ;;
esac

# Don't put duplicate lines/lines starting with space in the history.
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# Colours ANSI code
RS="\[\033[0m\]"    # reset
HC="\[\033[1m\]"    # hicolor
FGBLACK="\[\033[30m\]" # foreground black
FGRED="\[\033[31m\]" # foreground red
FGGREEN="\[\033[32m\]" # foreground green
FGYELLLOW="\[\033[33m\]" # foreground yellow
FGBLUE="\[\033[34m\]" # foreground blue
FGPURPLE="\[\033[35m\]" # foreground PURPLE
FGCYAN="\[\033[36m\]" # foreground cyan
FGWHITE="\[\033[37m\]" # foreground white
BGBLACK="\[\033[40m\]" # background black
BGRED="\[\033[41m\]" # background red
BGGREEN="\[\033[42m\]" # background green
BGYELLOW="\[\033[43m\]" # background yellow
BGBLUE="\[\033[44m\]" # background blue
BGPURPLE="\[\033[45m\]" # background purple 
BGCYAN="\[\033[46m\]" # background cyan
BGWHITE="\[\033[47m\]" # background white

# Setting history length 
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]
then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt
case "$TERM" in
    xterm-color) color_prompt=yes
    ;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]
then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null
then
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]
then
    PS1="${debian_chroot:+($debian_chroot)}${HC}${FGRED}\u${RS}:\$"
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also some other aliases
if [ -x /usr/bin/dircolors ]
then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# Can put alias in ,bash_aliases file
if [ -f ~/.bash_aliases ]
then
    . ~/.bash_aliases
fi

# enable programmable completion features
if ! shopt -oq posix
then
  if [ -f /usr/share/bash-completion/bash_completion ]
  then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]
  then
    . /etc/bash_completion
  fi
fi

# set variables for ibus
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# Start tmux when login ssh
if [[ "$TERM" != "screen" ]]
then
    ID=$(whoami)
    if tmux has-session -t $ID 2>/dev/null
    then
        tmux -2 attach-session -t $ID
    else
        tmux -2 new-session -s $ID
    fi
fi

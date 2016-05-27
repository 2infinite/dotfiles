### If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

### Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

### Some useful aliases
alias h='history 25';
alias j='jobs -l';
alias ls='ls $LS_OPTIONS';
alias la='ls -a';
alias lf='ls -FA';
alias ll='ls -lA';
alias l='ls -l';
alias md='mkdir';
alias rd='rmdir';
alias i='egrep -i';
alias less='less -M -R';
alias du0='du -h -s';
alias df='df -h';
alias q='exit'

### Search like csh
bind '"\e[A"':history-search-backward 
bind '"\e[B"':history-search-forward 
shopt -s cdspell 
shopt -s cmdhist 
shopt -s histappend 
# don't put duplicate lines in the history.
HISTCONTROL=ignoredups:ignorespace

### OS specific
OSNAMEU=`uname`
case $OSNAMEU in
 SunOS)
 alias p='ps -efl';
 alias pi='pgrep -fl';
 alias md5sum='digest -v -a md5';
 export LS_OPTIONS=' -F';
 ;;
 Linux)
 alias p='ps -efl';
 alias pi='pgrep -fl';
 export LS_OPTIONS=' -F --color=auto';
 alias apt='aptitude -F "%c %a%M %p %V %v %D %d %I"';
 alias eject='sudo eject';
 alias hibernate='sudo hibernate';
### Bash completion
 [ -f /etc/bash_completion ] && . /etc/bash_completion
 [ -f /etc/profile.d/bash-completion ] && . /etc/profile.d/bash-completion
 [ -f /usr/share/fortune/gentoo-dev ] && fortune /usr/share/fortune/gentoo-dev
 # 4  xfce4-terminal
 if [ "$TERM" = 'xterm'  ]; then 
 PROMPT_COMMAND='echo -ne "\033]0;"`hostname -s` "\007"'
 fi
 ;;
 FreeBSD)
 alias p='ps axuw';
 alias pi='pgrep -flS';
 alias sar='bsdsar';
 export LS_OPTIONS=' -F --color=auto';
 ;;
 AIX)
 alias p='ps -Af';
 alias pi='ps -Af | grep -w PPID |grep -v "grep -w PPID" && ps -Af | egrep -ie';
 alias df='df -g';
 alias top='topas';
 alias du0='du -ms';
 export LS_OPTIONS=' -F'
 ;;
 Darwin)
 alias p='ps -ef';
 alias pi='ps -Af | grep -w PPID |grep -v "grep -w PPID" && ps -Af | egrep -ie';
 alias df='df -g';
 export LS_OPTIONS=' -GO';
 export TERM=xterm;
 # For fink"
 test -r /sw/bin/init.sh && . /sw/bin/init.sh
 # For iterm:
 COMMAND_MODE=unix2003
 ;;
 HP-UX) 
 alias p='ps -ef';
 alias pi='pgrep -fl';
 alias less=more;
 alias df='df -Pk';
 ;;
 CYGWIN_NT-6.3)
 alias p='ps -aefl'
 alias pi='pgrep -fl'
 export LANG="ru_RU.UTF-8";
 export LC_MESSAGES="C"
 export TERM=xterm
 ### 4 XWin.exe
 export DISPLAY=:0.0
 ### 4 xfce terminal
 PROMPT_COMMAND='echo -ne "\033]0;"cygwin"\007"'
 ;;
esac

### Set PS1
# Do not set PS1 for dumb terminals
if [ "$TERM" != 'dumb'  ] && [ -n "$BASH" ]
   then
   WHOAMIU=`whoami`
   case $WHOAMIU in
	root)
        # for lightseagreen
        export PS1='[\[\033[36m\]\u@\h\[\033[33m\] \W \[\033[0m\]]\$ ';
	;;
	oracle)
	# for lightseagreen & navy
        export PS1='\[\033[36m\]\u@\h\[\033[33m\] \W \[\033[0m\]\[\033[34m\][${ORACLE_SID}]\[\033[0m\]\$ ';
	;;
	*)
		# for green
		export PS1='[\[\033[32m\]\u@\h\[\033[33m\] \W \[\033[0m\]]\$ ';
                # for lightseagreen
                # export PS1='[\[\033[36m\]\u@\h\[\033[33m\] \W \[\033[0m\]]\$ ';
                # for mediumvioletred
                # export PS1='[\[\033[35m\]\u@\h\[\033[33m\] \W \[\033[0m\]]\$ ';
                # for navy
                # export PS1='[\[\033[34m\]\u@\h\[\033[33m\] \W \[\033[0m\]]\$ ';
                # for red
                # export PS1='\[\033[01;31m\]\u@\h \[\033[01;34m\]\W \$ \[\033[00m\]';
	;;
	esac    
fi

### A righteous umask
umask 22

### Applications settings
export BLOCKSIZE=K;
export EDITOR=vi;
export PAGER='less -M -R';
export MAIL="/var/mail/${USER}"; 


### Manager for ssh-agent
[ -d $HOME/.keychain ] && keychain -q
host=`uname -n`
[ -f $HOME/.keychain/$host-sh ] && \
. $HOME/.keychain/$host-sh

#EOF

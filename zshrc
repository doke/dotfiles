# use vim
alias vi='vim'

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="doke"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

source $ZSH/oh-my-zsh.sh

# check the OS
case $(uname -s) in
	Darwin)
		export PATH=/Users/david/Dropbox/bin:/opt/local/bin:/usr/local/mysql/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin
		alias flushdns="dscacheutil -flushcache"
	;;
	*)
		export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin:/usr/X11/bin
	;;
esac

case $(uname -s) in
	FreeBSD)
		alias sudo='noglob do_sudo '
		function do_sudo
		{
			integer glob=1
			local -a run
			run=( command sudo )
			if [[ $# -gt 1 && $1 = -u ]]; then
				run+=($1 $2)
	        	shift ; shift
	    	fi
	    	(($# == 0)) && 1=/bin/zsh
	    	while (($#)); do
	        	case "$1" in
	        	command|exec|-) shift; break ;;
	        	nocorrect) shift ;;
	        	noglob) glob=0; shift ;;
	        	*) break ;;
	        	esac
	    	done
	    	if ((glob)); then
	        	PATH="/sbin:/usr/sbin:/usr/local/sbin:$PATH" $run $~==*
	    	else
	        	PATH="/sbin:/usr/sbin:/usr/local/sbin:$PATH" $run $==*
	    	fi
		}
	;;
esac

function title {
  if [[ $TERM == "screen" ]]; then
    # Use these two for GNU Screen:
    print -nR $'\033k'$1$'\033'\\

    print -nR $'\033]0;'$2$'\a'
  elif [[ $TERM == "xterm" || $TERM == "rxvt" ]]; then
    # Use this one instead for XTerms:
    print -nR $'\033]0;'$*$'\a'
  fi
}
  
function precmd {
  title zsh "$PWD"
}
  
function preexec {
  emulate -L zsh
  local -a cmd; cmd=(${(z)1})
  title $cmd[1]:t "$cmd[2,-1]"
}

source ~/.dotfiles/z.sh

function precmd () {
	z --add "$(pwd -P)"
}
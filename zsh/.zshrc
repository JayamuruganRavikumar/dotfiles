# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -v
export KEYTIMEOUT=1

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.config/zsh/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# changing the cursor in vim mode
# https://thevaluable.dev/zsh-install-configure-mouseless/
#
cursor_block='\e[2 q'
cursor_beam='\e[6 q'

function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] ||
		[[ $1 = 'block' ]]; then
		echo -ne $cursor_block
	elif [[ ${KEYMAP} == main ]] ||
		[[ ${KEYMAP} == viins ]] ||
		[[ ${KEYMAP} = '' ]] ||
		[[ $1 = 'beam' ]]; then
		echo -ne $cursor_beam
	fi
}

zle-line-init() {
	echo -ne $cursor_beam
}

zle -N zle-keymap-select
zle -N zle-line-init

# Mapping for completion

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Edit command in vim

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Using ci and di

autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done

# alias

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then

    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

export LS_COLORS="$(vivid generate dracula)"
#colors https://github.com/sharkdp/vivid/tree/master/themes

function take () { mkdir -p "$@" && eval cd "\"\$$#\""; }

function rosSources () { source /home/jay/Documents/ros_ws/install/setup.zsh; source /opt/ros/galactic/setup.zsh; export TURTLEBOT3_MODEL=burger; source  /usr/share/colcon_cd/function/colcon_cd.sh; }

function omnetppPath () { export OMNETPP_PATH=~/Documents/thesis/omnetpp-5.6.2 ; export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${OMNETPP_PATH}/lib; export PATH=${PATH}:${OMNETPP_PATH}/bin; }

#function gazeboPathPlugin () { export GAZEBO_PLUGIN_PATH=${GAZEBO_PLUGIN_PATH}:~/Documents/test/dynamic_obstacles_in_gazebo/build; }

function sshdock () { sudo docker exec -it $1 /bin/bash; }

function docCommit () { sduo docker commit -m $3 $1 $2; }

alias g='git'
alias dock='sudo docker'
alias ga='git add'
alias gs='git status'
alias b='cd ../'
alias bb='cd ../../'
alias gc='git commit -m'
alias cl='clear'
alias matlab='wmname LG3D && /home/jay/Programs/matlab/bin/matlab '
#alias mk='mkdir -p'
#alias xo='xdg-open'
#alias py="python3"
alias brigh='xrandr --output eDP-1 --brightness'
#alias matlabDriver='export MESA_LOADER_DRIVER_OVERRIDE=i965'
alias secondDisp='xrandr --output DP-3 --auto --right-of eDP-1'
alias notes='cd /home/jay/Documents/wise/Notes/Notes/vault'
alias vi='nvim'
alias tmux='tmux -f ~/.config/tmux/.tmux.conf'

#sources
#source "/etc/profile.d/rvm.sh"

#colcon
#source /usr/share/colcon_cd/function/colcon_cd.sh
#source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh
#ros
#source /opt/ros/galactic/setup.zsh
#source /home/jay/Documents/ros_ws/install/setup.zsh
#export OMNETPP_PATH=~/Programs/omnetpp-5.6.2/bin
#export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${OMNETPP_PATH}/lib
#export PATH=${PATH}:${OMNETPP_PATH}/bin

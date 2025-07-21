# Set up the prompt

autoload -Uz promptinit
promptinit
#prompt walters

#autoload -Uz vcs_info
#precmd_vcs_info() { vcs_info }
#precmd_functions+=( precmd_vcs_info )
#zstyle ':vcs_info:git:*' formats ' (%b)'
#setopt prompt_subst

#local GRUVBOX_BG0="#282828"
#local GRUVBOX_FG1="#ebdbb2"
#local GRUVBOX_YELLOW="#d79921"
#local GRUVBOX_BLUE="#458588"
#local GRUVBOX_AQUA="#689d6a" 
#local GRUVBOX_GREEN="#98971a"
#local GRUVBOX_RED="#cc241d"
#local GRUVBOX_ORANGE="#d65d0e"

PROMPT='%B%F{#d79921}%n@%m%f:%F{#d65d0e}%2~%f %F{#d65d0e}  ➜ %f%b '
#PROMPT='%B%F{#d79921}%n@%m%f>%F{#d65d0e}%2~%f%b%F{#458588}${vcs_info_msg_0_}%f %F{#d65d0e} %f%b '

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


# ---------------------
# Vim Settings
# ---------------------

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

# Mapping for going through history in visual mode

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

export LS_COLORS="$(vivid generate molokai)"
#colors https://github.com/sharkdp/vivid/tree/master/themes

# -----------------
#  Functions  
#  ----------------

# Cd to created folder
function take () { mkdir -p "$@" && eval cd "\"\$$#\""; }

#Intialize conda
function condaSetup ()
{
__conda_setup="$('/home/jay/Programs/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)";
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/jay/Programs/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/jay/Programs/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/jay/Programs/miniconda3/bin:$PATH"
    fi
fi;
unset __conda_setup;
}

# Attach docker container
#function attachDocker () { sudo docker exec -it $1 /bin/bash; }
#function gazeboPathPlugin () { export GAZEBO_PLUGIN_PATH=${GAZEBO_PLUGIN_PATH}:~/Documents/test/dynamic_obstacles_in_gazebo/build; } # if using custom models
#function rosSources () { source /home/jay/Documents/ros_ws/install/setup.zsh; source /opt/ros/galactic/setup.zsh; export TURTLEBOT3_MODEL=burger; source  /usr/share/colcon_cd/function/colcon_cd.sh; }
#
# Docker commands

#function docCommit () { sduo docker commit -m $3 $1 $2; }

# --------------------------
# Aliases
# --------------------------
 
alias g='git'
alias ga='git add'
#alias gs='git status'
alias b='cd ../'
alias gc='git commit -m'
alias nvidiaSmi='watch -d -n 1 nvidia-smi'
#setxkbmap -option ctrl:swap_ralt_rctl
#alias matlab='wmname LG3D && /home/jay/Programs/matlab/bin/matlab ' #fix rendering problem
#alias lsgrep='ls | grep -i'
alias brigh='xrandr --output eDP-1 --brightness'
#alias matlabDriver='export MESA_LOADER_DRIVER_OVERRIDE=i965' #fix rendering problem
alias secondDisp='xrandr --output DP-3 --auto --right-of eDP-1'
#alias swapMouse='xinput set-button-map $(xinput list | grep "USB Optical Mouse" | awk '{match($0, /[0-9]+/, m); print m[0]}') 3 2 1'
alias notes='cd /home/jay/Documents/notes/Notes'
alias vi='nvim'
alias tmux='tmux -f ~/.config/tmux/.tmux.conf'
alias launchDocker="zsh ~/Documents/ros2_containers/ros.sh"
alias robot_ws='cd /home/jay/Documents/docker_storage/ros-humble-nvidia/robot_ws'
source <(fzf --zsh)


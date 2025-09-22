################################################################################
#███████████████████████████████████
#█▄─▄─▀██▀▄─██─▄▄▄▄█─█─█▄─▄▄▀█─▄▄▄─█
#██─▄─▀██─▀─██▄▄▄▄─█─▄─██─▄─▄█─███▀█
#▀▄▄▄▄▀▀▄▄▀▄▄▀▄▄▄▄▄▀▄▀▄▀▄▄▀▄▄▀▄▄▄▄▄▀
################################################################################
# ~/.bashrc
# Main shell configuration file for interactive bash sessions
################################################################################

# Exit early if not running interactively
[[ $- != *i* ]] && return

################################################################################
# PROMPT
################################################################################
# Clean minimal prompt: username (cyan) + working directory (blue) + arrow
# Show [time date] user dir →
PS1="\[\e[1;32m\][\t \d]\[\e[0m\] \[\e[1;36m\]\u\[\e[0m\] \[\e[1;34m\]\w\[\e[0m\] → "
################################################################################
# -------------------------------
# Bash Completion
# -------------------------------
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

# -------------------------------
# FZF: completion + key bindings
# -------------------------------
if [ -f /usr/share/fzf/completion.bash ]; then
    source /usr/share/fzf/completion.bash
fi

if [ -f /usr/share/fzf/key-bindings.bash ]; then
    source /usr/share/fzf/key-bindings.bash
fi

# -------------------------------
# Completion usability tweaks
# -------------------------------

# Show all matches immediately instead of requiring double TAB
bind 'set show-all-if-ambiguous on'

# If fzf hasn't already grabbed TAB, fall back to menu-complete
if ! bind -s | grep -Fq 'C-i: fzf'; then
    bind '"\t":menu-complete'
fi
################################################################################
# ALIASES
# System info
alias usage="echo -e '\n📀 Disk Usage:' && df -h --total | grep -E 'Filesystem|total'; \
              echo -e '\n🖥️  Memory Usage:' && free -h"
alias cpuinfo="lscpu | grep 'Model name'"
alias sysup="uptime -p && uptime"

# File listing (using eza for better ls)
alias lls='eza --icons=always --color=always --group-directories-first \
            --all --long --no-permissions --no-filesize --no-user --no-time'

# Shortcuts alias
alias cln="clear"     #cleans contents in terminal  
alias tmx="tmux"      #opens tmux a sesh
alias rm="rm -i"      # safer rm (interactive)
alias x="exit"        #Closes terminal   
alias slp="systemctl suspend"  #Sleep
alias shut="poweroff" #Shutdowns pc
alias rbt="reboot"    #Restarts pc
alias fk="fk"	      #corrects your command 
# Colorized defaults
alias ls='ls --color=auto'
alias grep='grep --color=auto'

################################################################################
# FUNCTIONS
################################################################################
# Append quick notes with timestamps to ~/notes.txt
note() { 
    echo "$(date): $@" >> ~/notes.txt
}

# Safer shutdown with confirmation
shut() {
    read -p "Are you sure you want to power off? (y/n): " ans
    case "$ans" in
        [Yy]* ) command poweroff ;;
        * ) echo "Bruh what a showoff" ;;
    esac
}

################################################################################
# PATH & EXTERNAL TOOLS
################################################################################
# Add pipx binaries to PATH
export PATH="$PATH:/home/rohit/.local/bin"

# Enable `thefuck` (fix last command)
eval "$(thefuck --alias)"


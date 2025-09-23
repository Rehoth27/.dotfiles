# -------------------------
# Tmux Config by Rohith
# -------------------------

# Prefix key (use Ctrl+a instead of default Ctrl+b)
set -g prefix C-a
unbind C-b
bind C-a send-prefix

# Enable mouse support
set -g mouse on

# Clipboard (only works in tmux >= 3.2, safe fallback otherwise)
set -g set-clipboard on

# History limit
set -g history-limit 10000

# Status bar at bottom
set -g status-position bottom

# background with subtle text
set -g status-style bg=colour236,fg=colour250

# Left side: session + window
set -g status-left '#[fg=colour38,bold]#S #[fg=colour250]#I:#W#F '

# Right side: time + date
set -g status-right '#[fg=colour36,bold] %H:%M:%S #[fg=colour37] %d %b %Y '
set -g status-interval 1

# Window title styling
setw -g window-status-format '#[fg=colour244] #I:#W '
setw -g window-status-current-format '#[fg=colour46,bold] #I:#W '

# Pane border colors
set -g pane-border-style fg=colour238
set -g pane-active-border-style fg=colour39

# Message styling (like prompts)
set -g message-style bg=colour39,fg=black

# -------------------------
# Plugins (via TPM)
# -------------------------
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# Initialize TPM (keep this line at the very bottom of tmux.conf!)
run '~/.tmux/plugins/tpm/tpm'


#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '


export GPG_AGENT_INFO=$XDG_RUNTIME_DIR/keyring/gpg
export SESSION_MANAGER=$XDG_RUNTIME_DIR/keyring

export PATH=$PATH:~/.local/share/script
export PATH=$PATH:~/.config/wofi

#if [ -z "$SSH_AUTH_SOCK" ]; then
# eval "$(ssh-agent -s)"
# #fi
# Start GNOME Keyring if not running
# if ! pgrep -x "keyring-daemon" > /dev/null; then
#     /usr/bin/gnome-keyring-daemon --start --components=ssh
#     export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/keyring/ssh"
# fi

# Add SSH key if not already added
# if ! ssh-add -l &>/dev/null; then
#     ssh-add ~/.ssh/github
# fi

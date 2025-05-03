#~/.bashrc
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh
export GPG_AGENT_INFO=$XDG_RUNTIME_DIR/keyring/gpg
export SESSION_MANAGER=$XDG_RUNTIME_DIR/keyring

export PATH=$PATH:~/.local/share/script
export PATH=$PATH:~/.config/wofi
export PATH=$PATH:~/.dotnet/tools


export BLENDER_PYTHON_PATH=/usr/bin/python3.13
export BLENDER_PYTHON_LIB_PATH=/usr/share/blender/4.4/scripts/modules/
export BLENDER_PYTHON_BL_OPERATORS=/usr/share/blender/4.4/scripts/startup/

#export KITTY_LISTEN_ON=unix:/tmp/mykitty
echo "                 ##                 "
echo "                ####                "
echo "               ######               "
echo "              ########              "
echo "             ##########             "
echo "            ############            "
echo "           ##############           "
echo "          ################          "
echo "         ##################         "
echo "        ####################        "
echo "       ######################       "
echo "      #########      #########      "
echo "     ##########      ##########     "
echo "    ###########      ###########    "
echo "   ##########          ##########   "
echo "  #######                  #######  "
echo " ####                          #### "
echo "###                              ###"

PS1='\[\e[32m\]\w \[\e[33m\] \[\e[0m\]'

# config.nu
# Nushell configuration file

# ===== Config Settings =====
$env.config = {
    show_banner: false

    # Enable color by default
    use_ansi_coloring: true

    # Other useful defaults
    edit_mode: "vi" 

    # Cursor shape
    cursor_shape: {
      vi_insert: blink_line
      vi_normal: block
    }
}

# ===== Prompt Configuration =====
$env.PROMPT_COMMAND = {||
    let path = (pwd | path basename)
    $"(ansi green)($path) (ansi reset)"
}

$env.PROMPT_COMMAND_RIGHT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = {||
    $"(ansi blue)󰊠 (ansi reset)"
}
$env.PROMPT_INDICATOR_VI_INSERT = {||
    $"(ansi yellow)󰊠 (ansi reset)"
}
$env.PROMPT_MULTILINE_INDICATOR = {||
    $"(ansi grey) (ansi reset)"
}
# ===== Aliases =====
# ssh-key-add function (nushell doesn't support $1 in aliases, so we use a custom command)
def ssh-key-add [email: string] {
    ssh-keygen -t ed25519 -C $email
}
do --env {
    let ssh_agent_file = (
        "/tmp" | path join $"ssh-agent-(whoami).nuon"
    )

    if ($ssh_agent_file | path exists) {
        let ssh_agent_env = open ($ssh_agent_file)
        if ($"/proc/($ssh_agent_env.SSH_AGENT_PID)" | path exists) {
            load-env $ssh_agent_env
            return
        } else {
            rm $ssh_agent_file
        }
    }

    let ssh_agent_env = ^ssh-agent -c
        | lines
        | first 2
        | parse "setenv {name} {value};"
        | transpose --header-row
        | into record
    load-env $ssh_agent_env
    $ssh_agent_env | save --force $ssh_agent_file
}
keychain --eval --quiet /home/otto/.ssh/devops
    | lines
    | where not ($it | is-empty)
    | parse "{k}={v}; export {k2};"
    | select k v
    | transpose --header-row
    | into record
    | load-env

keychain --eval --quiet /home/otto/.ssh/github.otto.bus.dev
    | lines
    | where not ($it | is-empty)
    | parse "{k}={v}; export {k2};"
    | select k v
    | transpose --header-row
    | into record
    | load-env
# ===== SSH Agent Integration =====
# def ssh-connect [] {
#     let agent_file = ($env.HOME | path join ".ssh" "agent.env")
#
#     # Try to load existing agent info from file
#     let agent_running = (
#         if ($agent_file | path exists) {
#             let agent_info = (open $agent_file | from json)
#             # Check if the agent process is actually still running
#             if ($agent_info.SSH_AGENT_PID? | is-not-empty) {
#                 let pid_exists = (ps | where pid == $agent_info.SSH_AGENT_PID | length) > 0
#                 $pid_exists
#             } else {
#                 false
#             }
#         } else {
#             false
#         }
#     )
#
#     # Load agent env vars if agent is running
#     if $agent_running {
#         let agent_info = (open $agent_file | from json)
#         load-env $agent_info
#     }
#
#     if not $agent_running {
#         # Start ssh-agent and set environment variables
#         let agent_output = (ssh-agent -c
#             | lines
#             | parse "setenv {name} {value};"
#             | where name in ["SSH_AUTH_SOCK", "SSH_AGENT_PID"]
#             | transpose -r
#             | into record)
#
#         # Load into current environment
#         load-env $agent_output
#
#         # Save to file for other shells to use
#         $agent_output | to json | save -f $agent_file
#         chmod 600 $agent_file
#     }
#
#     # Check if keys are already loaded (works whether agent was just started or already running)
#     let loaded_keys = (ssh-add -l | complete)
#     let keys_loaded = $loaded_keys.exit_code == 0
#
#     if not $keys_loaded {
#         # Add SSH keys to the agent only if not already loaded
#         let keys = [
#             "~/.ssh/devops"
#             "~/.ssh/github.otto.bus.dev"
#         ]
#
#         for key in $keys {
#             let key_path = ($key | path expand)
#             if ($key_path | path exists) {
#                 # Ensure correct permissions (0600 for private keys)
#                 chmod 600 $key_path
#                 # Add key to agent (suppress output)
#                 ssh-add $key_path | complete | ignore
#             }
#         }
#     }
# }
#
# # Only run ssh-connect if not already in tmux
# ssh-connect

# # ===== Tmux Auto-attach =====
# Auto-attach to tmux session if not already in tmux
if (which tmux | is-not-empty) {
  # Check if we're not already in tmux and this is an interactive session
  if ($env.TMUX? | is-empty) and ($env.TERM != "dumb") {
    let sessions = (tmux list-sessions | complete)
    if $sessions.exit_code == 0 {
      tmux attach-session
    } else {
      tmux new-session
    }
  }
}


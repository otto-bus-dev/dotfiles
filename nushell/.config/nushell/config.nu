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
# ===== SSH Agent Integration =====
# Check if ssh-agent is already running, otherwise start it
let agent_running = (
    if ($env.SSH_AUTH_SOCK? | is-not-empty) and ($env.SSH_AGENT_PID? | is-not-empty) {
        # Check if the agent process is actually running
        (ps | where pid == $env.SSH_AGENT_PID | length) > 0
    } else {
        false
    }
)

if not $agent_running {
    # Start ssh-agent and set environment variables
    ssh-agent -c
    | lines
    | parse "setenv {name} {value};"
    | where name in ["SSH_AUTH_SOCK", "SSH_AGENT_PID"]
    | transpose -r
    | into record
    | load-env

    # Add SSH keys to the agent
    let keys = [
        "~/.ssh/devops"
        "~/.ssh/github.otto.bus.dev"
    ]

    for key in $keys {
        let key_path = ($key | path expand)
        if ($key_path | path exists) {
            # Ensure correct permissions (0600 for private keys)
            chmod 600 $key_path
            # Add key to agent (suppress output)
            ssh-add $key_path | complete | ignore
        }
    }
}

# Helper function to manually start/restart ssh-agent
def start-ssh-agent [] {
    ssh-agent -c
    | lines
    | parse "setenv {name} {value};"
    | where name in ["SSH_AUTH_SOCK", "SSH_AGENT_PID"]
    | transpose -r
    | into record
    | load-env
}
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


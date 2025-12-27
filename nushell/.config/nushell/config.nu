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
# ===== Keychain Integration =====
# Run keychain and load SSH keys
if (which keychain | is-not-empty) {


    # Load first key
    let keychain_output1 = (bash -c "keychain --eval ~/.ssh/devops 2>/dev/null")

    # Parse SSH_AUTH_SOCK from first key
    let auth_sock_line = ($keychain_output1 | lines | find "SSH_AUTH_SOCK" | first)
    if ($auth_sock_line | is-not-empty) {
        let auth_sock = ($auth_sock_line | parse 'SSH_AUTH_SOCK="{value}"' | get value.0? | default "")
        if ($auth_sock | is-not-empty) {
            $env.SSH_AUTH_SOCK = $auth_sock
        }
    }

    # Parse SSH_AGENT_PID from first key
    let agent_pid_line = ($keychain_output1 | lines | find "SSH_AGENT_PID" | first)
    if ($agent_pid_line | is-not-empty) {
        let agent_pid = ($agent_pid_line | parse 'SSH_AGENT_PID={value};' | get value.0? | default "")
        if ($agent_pid | is-not-empty) {
            $env.SSH_AGENT_PID = ($agent_pid | into int)
        }
    }

    # Load second key (reuses same agent)
    bash -c "keychain --eval ~/.ssh/github.otto.bus.dev 2>/dev/null" | ignore
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

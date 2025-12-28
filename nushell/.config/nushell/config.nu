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


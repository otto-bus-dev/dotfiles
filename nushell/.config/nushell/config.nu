# config.nu
# Nushell configuration file

# ===== Config Settings =====
$env.config.show_banner = false

# Enable color by default
$env.config.use_ansi_coloring = true

# Other useful defaults
$env.config.edit_mode = "vi" 
$env.config.buffer_editor = "nvim"

# Cursor shape
$env.config.cursor_shape = {
  vi_insert: blink_line
  vi_normal: block
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

def --env ff [] {
  let result = (^fzf --preview 'bat --style=numbers --color=always {}'
                     --layout reverse
                     --border
                     --tmux 80%,80%
                     --preview-window 'right:65%:wrap' 
                     --bind 'ctrl-/:toggle-preview'
                     --bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down'
                     --bind 'ctrl-o:become(echo "nvim:{}")'
                     --bind 'ctrl-e:become(echo "cd:{}")')

  if ($result | str starts-with "cd:") {
    cd ($result | str replace --all "'" "" | str replace "cd:" "" | path dirname)
  } else if ($result | str starts-with "nvim:") {
    nvim ($result | str replace --all "'" ""| str replace "nvim:" "" )
  } else if ($result != '') {
    return $result
  }
}

def --env fg [] {
  let result = (
    ^rg --color=always --line-number --no-heading --smart-case "" |
    ^fzf --ansi 
      --delimiter ':' 
      --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' 
      --preview-window '+{2}/2' 
      --layout reverse 
      --border --tmux 80%,80% 
      --bind 'alt-k:preview-up' --bind 'alt-j:preview-down'
      --bind 'ctrl-/:toggle-preview'
      --bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down'
      --bind 'ctrl-o:become(echo "nvim:{}")'
      --bind 'ctrl-e:become(echo "cd:{}")')

  if ($result | str starts-with "cd:") {
    cd ($result | str replace --all "'" "" | str replace "cd:" "" | path dirname)
  } else if ($result | str starts-with "nvim:") {
    let remove_decoration = $result | str replace --all "'" "" | str replace "nvim:" "" 
    let index_first_colon = ($remove_decoration | str index-of ":") - 1 
    let path = $remove_decoration | str substring 0..$index_first_colon  
    nvim $path
  } else if ($result != '') {
    return $result
  }
}

def pk [] {
  (ps | ^fzf --header-lines=1
                 --layout reverse
                 --border
                 --tmux 80%,80%
                 --preview 'echo {}'
                 --preview-window 'down:3:wrap'
                 --header 'Ctrl-D: kill | Ctrl-X: force kill'
                 --bind 'ctrl-d:execute(kill {2})+reload(ps)'
                 --bind 'ctrl-x:execute(kill -9 {2})+reload(ps)')
}

alias cat = bat

do --env {
    let ssh_agent_file = (
        "/tmp" | path join $"ssh-agent-(whoami).nuon"
    )

    if ($ssh_agent_file | path exists) {
        let ssh_agent_env = open ($ssh_agent_file)
        if ($"/proc/($ssh_agent_env.SSH_AGENT_PID)" | path exists) {
            # Agent is still running, reuse it
            load-env $ssh_agent_env
            return
        } else {
            # Agent is dead, clean up stale file
            rm $ssh_agent_file
        }
    }

    # Start a new ssh-agent
    let ssh_agent_env = ^ssh-agent -c
        | lines
        | first 2
        | parse "setenv {name} {value};"
        | transpose --header-row
        | into record
    load-env $ssh_agent_env
    $ssh_agent_env | save --force $ssh_agent_file
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


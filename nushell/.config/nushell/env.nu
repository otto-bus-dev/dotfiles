# env.nu
# Nushell environment configuration

# ===== Environment Variables =====
# SSH_AUTH_SOCK is set by ssh-agent in config.nu
$env.GPG_AGENT_INFO = $"($env.XDG_RUNTIME_DIR)/keyring/gpg"
$env.SESSION_MANAGER = $"($env.XDG_RUNTIME_DIR)/keyring"

$env.LC_ALL = "C.UTF-8"
$env.LANG = "C.UTF-8"

$env.MANPAGER = "bat -plman"

$env.NODE_OPTIONS = "--use-openssl-ca"
$env.NODE_EXTRA_CA_CERTS = "/etc/ssl/certs/ca-certificates.crt"

# Blender Python configuration (only if blender is installed)
if (which blender | is-not-empty) {
    let blender_ver = (ls /usr/share/blender/ | get name | first | path basename)
    $env.BLENDER_PYTHON_PATH = (which python3 | get 0.path)
    $env.BLENDER_PYTHON_LIB_PATH = $"/usr/share/blender/($blender_ver)/scripts/modules/"
    $env.BLENDER_PYTHON_BL_OPERATORS = $"/usr/share/blender/($blender_ver)/scripts/startup/"
}

# Wayland / desktop-only settings
if ($env.WAYLAND_DISPLAY? | is-not-empty) {
    $env.WLR_DRM_NO_ATOMIC = "1"
    $env.VBOX_VGPU = "1"
}

$env.FZF_DEFAULT_OPTS = "
	--color=fg:#908caa,bg:#232136,hl:#ea9a97
	--color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
	--color=border:#44415a,header:#3e8fb0,gutter:#232136
	--color=spinner:#f6c177,info:#9ccfd8
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

# Cursor theme (desktop only)
if ($env.WAYLAND_DISPLAY? | is-not-empty) {
    $env.XCURSOR_THEME = "BreezeX-RosePine-Linux"
    $env.XCURSOR_SIZE = "24"
}

# ===== PATH Configuration =====
$env.PATH = ($env.PATH | split row (char esep) | append [
    $"($env.HOME)/.config/wofi"
    $"($env.HOME)/.dotnet/tools"
    $"($env.HOME)/.config/tmux"
    $"($env.HOME)/.cargo/bin"
    $"($env.HOME)/.local/bin"
    $"($env.HOME)/bin"
    "/usr/share/scripts"
    "/opt/apache-spark/bin"
])

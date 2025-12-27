# env.nu
# Nushell environment configuration

# ===== Environment Variables =====
$env.SSH_AUTH_SOCK = $"($env.XDG_RUNTIME_DIR)/gcr/ssh"
$env.GPG_AGENT_INFO = $"($env.XDG_RUNTIME_DIR)/keyring/gpg"
$env.SESSION_MANAGER = $"($env.XDG_RUNTIME_DIR)/keyring"

$env.LC_ALL = "C.UTF-8"
$env.LANG = "C.UTF-8"

# Read API key from file
$env.ANTHROPIC_API_KEY = (open ~/claude_key.pub | str trim)

$env.NODE_OPTIONS = "--use-openssl-ca"
$env.NODE_EXTRA_CA_CERTS = "/etc/ssl/certs/ca-certificates.crt"

# Blender Python configuration
$env.BLENDER_PYTHON_PATH = "/usr/bin/python3.13"
$env.BLENDER_PYTHON_LIB_PATH = "/usr/share/blender/4.4/scripts/modules/"
$env.BLENDER_PYTHON_BL_OPERATORS = "/usr/share/blender/4.4/scripts/startup/"

# WLR and VirtualBox settings
$env.WLR_DRM_NO_ATOMIC = "1"
$env.VBOX_VGPU = "1"

# Cursor theme
$env.XCURSOR_THEME = "BreezeX-RosePine-Linux"
$env.XCURSOR_SIZE = "24"

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

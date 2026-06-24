local Icons = require "utils.class.icon"
local fs = require("utils.fn").fs

local Config = {}

if fs.platform().is_win then
  Config.default_prog = { "nu" }
  Config.default_cwd = "C:\\Dev"

  Config.launch_menu = {
    {
      label = " Nushell",
      args = { "nu" },
      cwd = "C:\\Dev",
    },
    {
      label = Icons.Progs["pwsh.exe"] .. " PowerShell V7",
      args = {
        "pwsh",
        "-NoLogo",
        "-ExecutionPolicy",
        "RemoteSigned",
        "-NoProfileLoadTime",
      },
      cwd = "C:\\Dev",
    },
    {
      label = Icons.Progs["pwsh.exe"] .. " PowerShell V5",
      args = { "powershell" },
      cwd = "~",
    },
    { label = "Command Prompt", args = { "cmd.exe" }, cwd = "~" },
    { label = Icons.Progs["git"] .. " Git bash", args = { "sh", "-l" }, cwd = "~" },
  }

  -- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
  Config.wsl_domains = {
    {
      name = "WSL:Ubuntu",
      distribution = "Ubuntu-22.04",
      username = "dawen",
      default_cwd = "~/dev",
      default_prog = { "fish" },
    },
  }
else
  Config.default_prog = { "/usr/local/bin/fish", "-l" }
  Config.default_cwd = "~/dev"
end

-- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
Config.ssh_domains = {}

-- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
Config.unix_domains = {}

return Config
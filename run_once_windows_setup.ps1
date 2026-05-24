# Creates directory junctions from Windows AppData paths to XDG-style ~/.config paths.
# chezmoi populates ~/.config/<app>; junctions make Windows apps find their configs there.
#
# To add a new app: append an entry to $Mappings.
# Source = where Windows looks for config  (AppData path)
# Target = where chezmoi places the files  (~/.config path)

$Mappings = @(
    @{
        Name   = "Zed"
        Source = "$env:APPDATA\Zed"
        Target = "$env:USERPROFILE\.config\zed"
    },
    @{
        Name   = "VSCode"
        Source = "$env:APPDATA\Code\User"
        Target = "$env:USERPROFILE\.config\Code\User"
    }
)

foreach ($m in $Mappings) {
    # Ensure the XDG target exists before creating a junction pointing at it
    if (-not (Test-Path $m.Target)) {
        New-Item -ItemType Directory -Path $m.Target -Force | Out-Null
    }

    $existing = Get-Item $m.Source -ErrorAction SilentlyContinue

    if ($existing -and $existing.LinkType -eq "Junction") {
        Write-Host "[$($m.Name)] Junction already exists, skipping."
        continue
    }

    if (Test-Path $m.Source) {
        Write-Warning "[$($m.Name)] $($m.Source) exists but is not a junction — skipping to avoid data loss."
        Write-Warning "  Move its contents to $($m.Target), delete $($m.Source), then re-run 'chezmoi apply'."
        continue
    }

    New-Item -ItemType Junction -Path $m.Source -Target $m.Target | Out-Null
    Write-Host "[$($m.Name)] Created junction: $($m.Source) -> $($m.Target)"
}

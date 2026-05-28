# Nushell configuration

$env.config = {
    show_banner: false

    ls: {
        use_ls_colors: true
        clickable_links: true
    }

    rm: {
        always_trash: true
    }

    table: {
        mode: rounded
        index_mode: always
        show_empty: true
        trim: {
            methodology: wrapping
            wrapping_try_keep_words: true
        }
    }

    cursor_shape: {
        emacs: blink_line
        vi_insert: blink_line
        vi_normal: blink_block
    }

    edit_mode: vi

    history: {
        max_size: 100_000
        sync_on_enter: true
        file_format: "sqlite"
        isolation: true
    }

    completions: {
        case_sensitive: false
        quick: true
        partial: true
        algorithm: "fuzzy"
    }
}

def starship-update [] {
    starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
}

# Chezmoi workflows
def czpush [msg: string] {
    chezmoi git -- add -A
    chezmoi git -- commit -m $msg
    chezmoi git -- push
}

alias cz = chezmoi
alias cza = chezmoi apply
alias czr = chezmoi re-add
alias czd = chezmoi diff
alias czs = chezmoi status

# Aliases
alias ll = ls -l
alias la = ls -a
alias g = git

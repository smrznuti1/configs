# -*- sh -*- vim:set ft=sh ai et sw=4 sts=4:
# It might be bash like, but I can't have my co-workers knowing I use zsh

function _git_prompt() {
    local gitbranch gitstatus gitcolor gitbranchView
    gitbranch=$(git symbolic-ref --short HEAD 2>/dev/null | tr -d '[:space:]')

    if [[ -n "$gitbranch" ]]; then
        gitstatus=$(git status --porcelain 2>/dev/null)
        if [[ "$gitstatus" =~ ^[MADRC] ]]; then
            gitcolor="%{$fg[yellow]%}"
        elif [[ -n "$gitstatus" ]]; then
            gitcolor="%{$fg[red]%}"
        else
            gitcolor="%{$fg[green]%}"
        fi
        gitbranchView=" %{$fg[blue]%}(${gitcolor}${gitbranch}%{$fg[blue]%})"
        echo "$gitbranchView"
    else
        echo ""
    fi
}

function _prompt_path() {
    local path_segments prefix result
    path_segments=("${(@s:/:)PWD}")
    if (( ${#path_segments[@]} > 3 )); then
        result="${path_segments[-2]}/${path_segments[-1]}"
        prefix=".../"
    else
        result="$PWD"
        prefix=""
    fi
    echo "${prefix}${result}"
}


function _dashes(){
    NEWCOLUMNS=$(($COLUMNS-4))
    printf '  '
    printf '-%0.s' {1..$NEWCOLUMNS}
    printf '  '
}

PROMPT='%{$fg[237]%}$(_dashes)
%{$fg[green]%}➜ %{$fg_bold[blue]%}$(_prompt_path)$(_git_prompt)%{$fg[green]%}>%{$reset_color%} '

# ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}‹"
# ZSH_THEME_GIT_PROMPT_SUFFIX="›%{$reset_color%}"

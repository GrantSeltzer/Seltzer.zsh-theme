# This theme will provide you with useful information for productivity and little
# bullshit by using color-coding and slight visual cues 
# When a command is exited the timestamp will be in red, exit code
# on the right. This was inspired by the theme called dieter

typeset -A host_repr

# local time, color coded by last return code
time_enabled="%(?.%{$fg[cyan]%}.%{$fg[red]%})%*%{$reset_color%}"
time_disabled="%{$fg[green]%}%*%{$reset_color%}"
time=$time_enabled

# user part, color coded by privileges
local user="%(!.%{$fg[blue]%}.%{$fg[blue]%})%n%{$reset_color%}"

# Compacted $PWD
local pwd="%{$fg[green]%}%c%{$reset_color%}"

PROMPT='${time} ${user} ${in} ${pwd} $(git_prompt_info)${pr}%{$fg[white]%} '

in="%{$fg[white]%}in ~>"
on="%{$fg[white]%}on ~>"
pr="%{$fg[white]%}~>"

# i would prefer 1 icon that shows the "most drastic" deviation from HEAD,
# but lets see how this works out
ZSH_THEME_GIT_PROMPT_PREFIX="${on}%{$fg[yellow]%} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%} %{$fg[green]%}%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"

# elaborate exitcode on the right when >0
return_code_enabled="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
return_code_disabled=
return_code=$return_code_enabled

RPS1='${return_code}'

function accept-line-or-clear-warning () {
	if [[ -z $BUFFER ]]; then
		time=$time_disabled
		return_code=$return_code_disabled
	else
		time=$time_enabled
		return_code=$return_code_enabled
	fi
	zle accept-line
}
zle -N accept-line-or-clear-warning
bindkey '^M' accept-line-or-clear-warning

# Read after .zprofile

# Source global shell files
[ -f "$XDG_CONFIG_HOME/shell/alias" ] && source "$XDG_CONFIG_HOME/shell/alias"
[ -f "$XDG_CONFIG_HOME/shell/vars" ] && source "$XDG_CONFIG_HOME/shell/vars"

# Zsh mods
zmodload zsh/complist
autoload -U compinit && compinit
autoload -U colors && colors
autoload -Uz vcs_info

# VCS info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git*' formats " (%b)"
precmd() {
	vcs_info
}

# Completion
zstyle ':completion:%' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33
# zstyle ':completion:*' file-list true # more detailed list if desired
zstyle ':completion:*' squeeze-slashes false

# General options
setopt append_history inc_append_history share_history
setopt auto_menu menu_complete
# setopt autocd # type a dir name to cd; not sure bout this one yet
setopt auto_param_slash
setopt no_case_glob no_case_match # case insensitive auto complete
setopt globdots
setopt extended_glob
setopt interactive_comments
unsetopt prompt_sp
stty stop undef

# History
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="$XDG_CACHE_HOME/zsh_history"
HISTCONTROL=ignoreboth

source <(fzf --zsh)

# Keybinds
bindkey -e # emacs
bindkey "^[[H" beginning-of-line	# home key
bindkey "^[[4~" end-of-line		# end key
bindkey "^[[P" delete-char		# delete key

# Prompt
# NOTES: top bracket = 0x23a1 or 0x250c; middle = | or 0x2502; bottom = 0x23a3 or 0x2514
setopt prompt_subst
DATETIME='%D{%b %d %Y} @ %D{%I:%M:%S %p}'
PS1='%B%(?.%{$fg[green]%}.%{$fg[red]%})┌ %{$fg[blue]%}%n%{$fg[yellow]%}@%{$fg[green]%}%M %{$fg[white]%}%$* ${DATETIME}
%(?.%{$fg[green]%}.%{$fg[red]%})│ %{$fg[blue]%}%~%{$fg[green]%}${vcs_info_msg_0_}
%(?.%{$fg[green]%}.%{$fg[red]%})└ %{$reset_color%}%#%b '

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# vim: ft=zsh

export FZF_DEFAULT_COMMAND="ag --follow --nocolor --nogroup -g ''"
if [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  source /usr/local/opt/fzf/shell/completion.zsh
fi

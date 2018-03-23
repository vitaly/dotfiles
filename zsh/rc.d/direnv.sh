# .env files autoloading
if which direnv > /dev/null; then
  eval "$(direnv hook zsh)"
  # make sure tmux doesn't load any of direnv stuff
  alias tmux='direnv exec / tmux'
fi

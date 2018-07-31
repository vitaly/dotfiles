function current_ruby() {
    local _ruby
    if which chruby > /dev/null; then
      _ruby="$(chruby |grep \* |tr -d '* ')"
      if [[ $(chruby |grep -c \*) -eq 1 ]]; then
        echo ${_ruby}
      else
        echo "system"
      fi
    fi
}

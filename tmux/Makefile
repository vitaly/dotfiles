install: config plugins
.PHONY: install

~/.tmux: .
	@rm -f $@
	@ln -svfn $(abspath $<) $@

~/.tmux.conf: tmux.conf
	@rm -f $@
	@ln -svfn $(abspath $<) $@

config: ~/.tmux ~/.tmux.conf
.PHONY: config

plugins/tpm:
	@mkdir -p plugins
	@git clone https://github.com/tmux-plugins/tpm $@

TMUX_DIR := /root/my/dotfiles/tmux

plugins: plugins/tpm
	plugins/tpm/bindings/install_plugins
	tmux wait -S install-tmux
.PHONY: plugins

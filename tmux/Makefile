install: ~/.tmux ~/.tmux.conf plugins/tpm
.PHONY: install

~/.tmux: .
	rm -f $@
	ln -svfn $(abspath $<) $@

~/.tmux.conf: tmux.conf
	rm -f $@
	ln -svfn $(abspath $<) $@

plugins/tpm:
	mkdir -p plugins
	git clone https://github.com/tmux-plugins/tpm $@

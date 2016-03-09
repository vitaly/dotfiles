help:
	@echo make install - install dotfiles
	@echo make clean   - remove installed files
	@echo
	@echo When running for the first time its recommended to run clean first to remove prior existing files


VIMRC_AFTER      = ~/.vimrc.after
VIMRC_BUNDLES    = ~/.vimrc.bundles
GVIMRC_AFTER     = ~/.gvimrc.after
ZSH_LOCAL        = ~/.zsh/local
SYSTEM_GITCONFIG = /usr/local/etc/gitconfig
USER_GITCONFIG   = ~/.gitconfig
GEMRC            = ~/.gemrc
RDEBUGRC         = ~/.rdebugrc
POWCONFIG        = ~/.powconfig
EDITRC           = ~/.editrc
INPUTRC          = ~/.inputrc
ETC_HOSTS        = /etc/hosts
HAMMERSPOON      = ~/.hammerspoon
TMUX             = ~/.tmux.conf

TARGETS := ${VIMRC_AFTER} ${VIMRC_BUNDLES} ${GVIMRC_AFTER} ${ZSH_LOCAL} ${SYSTEM_GITCONFIG} ${USER_GITCONFIG} ${RDEBUGRC} ${POWCONFIG} ${EDITRC} ${INPUTRC} ${GEMRC} ${ETC_HOSTS} ${HAMMERSPOON} ${TMUX}

${VIMRC_AFTER}: $(abspath vimrc.after)
	@rm -vf $@;ln -svfn $< $@

${VIMRC_BUNDLES}: $(abspath vimrc.bundles)
	@rm -vf $@;ln -svfn $< $@

${GVIMRC_AFTER}: $(abspath gvimrc.after)
	@rm -vf $@;ln -svfn $< $@

${ZSH_LOCAL}: $(abspath zsh-local)
	@rm -vf $@;ln -svfn $< $@

${SYSTEM_GITCONFIG}: $(abspath system-gitconfig)
	@rm -vf $@;sudo ln -svfn $< $@

${USER_GITCONFIG}: $(abspath user-gitconfig)
	@if grep CHANGE user-gitconfig; then echo EDIT user-gitconfig; false; else ln -svfn $< $@; fi

${GEMRC}: $(abspath gemrc)
	@rm -vf $@;ln -svfn $< $@

${RDEBUGRC}: $(abspath rdebugrc)
	@rm -vf $@;ln -svfn $< $@

${POWCONFIG}: $(abspath powconfig)
	@rm -vf $@;ln -svfn $< $@

${EDITRC}: $(abspath editrc)
	@rm -vf $@;ln -svfn $< $@

${INPUTRC}: $(abspath inputrc)
	@rm -vf $@;ln -svfn $< $@

${ETC_HOSTS}: $(abspath hosts)
	@sudo cp -v $< $@
	@chmod 0644 $@
	@chown root:wheel $@

${HAMMERSPOON}: $(abspath hammerspoon)
	@ln -svfn $< $@

${TMUX}: $(abspath tmux.conf)
	@ln -svfn $< $@

install: ${TARGETS}

clean:
	sudo rm -vf ${SYSTEM_GITCONFIG}
	rm -vf ${TARGETS}

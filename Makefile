foo::
help:
	@cat HELP
.PHONY: help

EUID := $(shell id -u -r)
ifeq (0,${EUID})
	SUDO=
else
	SUDO=sudo
endif

TARGETS =

${HOME}/% : home/%
	rm -f $@
	ln -svfn $(abspath $<) $@
HOMELINK_TARGETS := $(patsubst home/%,${HOME}/%,$(shell find home -maxdepth 1))
TARGETS += ${HOMELINK_TARGETS}


${HOME}/.zsh/% : zsh/%
	rm -f $@
	mkdir -p $(dir $@)
	ln -svfn $(abspath $<) $@
ZSH_TARGETS := $(patsubst zsh/%,${HOME}/.zsh/%,$(shell find zsh -type f))
TARGETS += ${ZSH_TARGETS}


ETC_DIRS := $(patsubst etc/%,/etc/%,$(shell find etc -type d -mindepth 1))
${ETC_DIRS}:
	sudo mkdir $@
	sudo chown root:wheel $@
	sudo chmod 0755 $@

# dependency for profiel.d files on /etc/profile.d directory creation
$(patsubst etc/%,/etc/%,$(wildcard etc/profile.d/*)): /etc/profile.d

/etc/% : etc/%
	${SUDO} cp $< $@
	${SUDO} chown root:wheel $@
	${SUDO} chmod 0644 $@
ETC_TARGETS := $(patsubst etc/%,/etc/%,$(shell find etc -type f))
TARGETS += ${ETC_TARGETS}


/etc/hosts: hosts.local hosts
	cat $^ | ${SUDO} tee $@ > /dev/null
	chmod 0644 $@
	chown root:wheel $@
TARGETS += /etc/hosts


DIFF_HIGHLIGHT ?= $(firstword $(wildcard /usr/share/doc/git/contrib/diff-highlight/diff-highlight /usr/local/opt/git/share/git-core/contrib/diff-highlight/diff-highlight))
ifeq (,${DIFF_HIGHLIGHT})
  $(error diff-highlight not found, please pass DIFF_HIGHLIGHT)
endif

SYSTEM_GITCONFIG ?= /usr/local/etc/gitconfig
${SYSTEM_GITCONFIG}: git/system-gitconfig
	${SUDO} rm -vf $@
	${SUDO} chmod +x ${DIFF_HIGHLIGHT}
	cat $< | sed -e "s,%DIFF_HIGHLIGHT%,${DIFF_HIGHLIGHT}," | ${SUDO} tee $@ > /dev/null
TARGETS += ${SYSTEM_GITCONFIG}

USER_GITCONFIG   ?= ~/.gitconfig
${USER_GITCONFIG}: git/user-gitconfig
	@if grep CHANGE $<; then echo EDIT user-gitconfig; false; else ln -svfn $(abspath $<) $@; fi
TARGETS += ${USER_GITCONFIG}

~/.tmux: tmux
	rm -f $@
	ln -svfn $(abspath $<) $@
~/.tmux.conf: tmux/tmux.conf
	rm -f $@
	ln -svfn $(abspath $<) $@
tmux/plugins:
	mkdir $@
tmux/plugins/tpm: tmux/plugins
	git clone https://github.com/tmux-plugins/tpm $@

TARGETS += ~/.tmux ~/.tmux.conf tmux/plugins/tpm

install: ${TARGETS}

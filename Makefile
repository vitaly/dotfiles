help:
	@cat HELP
.PHONY: help

EUID := $(shell id -u -r)
ifeq (0,${EUID})
	SUDO=
else
	SUDO=sudo
endif

HOMELINK_TARGETS := $(patsubst home/%,${HOME}/.%,$(wildcard home/*))
${HOME}/.% : home/%
	@rm -f $@
	@ln -svfn $(abspath $<) $@

DIFF_HIGHLIGHT ?= $(firstword $(wildcard /usr/share/doc/git/contrib/diff-highlight/diff-highlight /usr/local/opt/git/share/git-core/contrib/diff-highlight/diff-highlight))
ifeq (,${DIFF_HIGHLIGHT})
  $(error diff-highlight not found, please pass DIFF_HIGHLIGHT)
endif

ZSH_LOCAL        ?= ~/.zsh/config.d/local
${ZSH_LOCAL}: $(abspath zsh-local)
	@rm -vf $@;ln -svfn $< $@

SYSTEM_GITCONFIG ?= /usr/local/etc/gitconfig
${SYSTEM_GITCONFIG}: $(abspath system-gitconfig)
	${SUDO} rm -vf $@
	${SUDO} chmod +x ${DIFF_HIGHLIGHT}
	cat $< | sed -e "s,%DIFF_HIGHLIGHT%,${DIFF_HIGHLIGHT}," | ${SUDO} tee $@ > /dev/null

USER_GITCONFIG   ?= ~/.gitconfig
${USER_GITCONFIG}: $(abspath user-gitconfig)
	@if grep CHANGE user-gitconfig; then echo EDIT user-gitconfig; false; else ln -svfn $< $@; fi

ETC_HOSTS        ?= /etc/hosts
${ETC_HOSTS}: $(abspath hosts)
	${SUDO} cp -v $< $@
	@chmod 0644 $@
	@chown root:wheel $@

TARGETS := ${HOMELINK_TARGETS} ${ZSH_LOCAL} ${SYSTEM_GITCONFIG} ${USER_GITCONFIG} ${ETC_HOSTS}
install: ${TARGETS}

clean:
	${SUDO} rm -vf ${SYSTEM_GITCONFIG} ${ETC_HOSTS}
	rm -vf ${TARGETS}

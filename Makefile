help:
	@cat HELP
.PHONY: help

EUID := $(shell id -u -r)

map = $(foreach a,$(2),$(call $(1),$(a)))

ifeq (0,${EUID})
	SUDO=
else
	SUDO=sudo
endif

dottarget = $(subst /__,/_,$(subst /dot,/.,$1))
dotsource = $(subst /.,/dot,$(subst /dot,/_dot,$(subst /_,/__,$1)))

homelinktarget = $(patsubst $1%,${HOME}/%,$(call dottarget, $2))
homelinksource = $(patsubst ${HOME}/%,$(abspath $1)/%,$(call dotsource,$2))

HOMELINK_TARGETS := $(call homelinktarget,home/,$(wildcard home/*))
${HOMELINK_TARGETS}:
	@rm -f $@
	@ln -svfn $(call homelinksource,home/,$@) $@

ZSH_LOCAL        = ~/.zsh/local
SYSTEM_GITCONFIG = /usr/local/etc/gitconfig
USER_GITCONFIG   = ~/.gitconfig
ETC_HOSTS        = /etc/hosts

TARGETS := ${ZSH_LOCAL} ${SYSTEM_GITCONFIG} ${USER_GITCONFIG} ${ETC_HOSTS}

${ZSH_LOCAL}: $(abspath zsh-local)
	@rm -vf $@;ln -svfn $< $@

${SYSTEM_GITCONFIG}: $(abspath system-gitconfig)
	@${SUDO} rm -vf $@;${SUDO} ln -svfn $< $@

${USER_GITCONFIG}: $(abspath user-gitconfig)
	@if grep CHANGE user-gitconfig; then echo EDIT user-gitconfig; false; else ln -svfn $< $@; fi

${ETC_HOSTS}: $(abspath hosts)
	@${SUDO} cp -v $< $@
	@chmod 0644 $@
	@chown root:wheel $@

install: ${HOMELINK_TARGETS} ${TARGETS}

clean:
	${SUDO} rm -vf ${SYSTEM_GITCONFIG}
	rm -vf ${TARGETS} ${HOMELINK_TARGETS}

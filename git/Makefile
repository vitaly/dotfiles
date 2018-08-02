default: install
.PHONY: default

DIFF_HIGHLIGHT ?= $(firstword $(wildcard /usr/share/doc/git/contrib/diff-highlight/diff-highlight /usr/local/opt/git/share/git-core/contrib/diff-highlight/diff-highlight))
ifeq (,${DIFF_HIGHLIGHT})
  $(error diff-highlight not found, please pass DIFF_HIGHLIGHT)
endif

SYSTEM_GITCONFIG ?= /usr/local/etc/gitconfig
${SYSTEM_GITCONFIG}: system-gitconfig
	${SUDO} rm -vf $@
	${SUDO} chmod +x ${DIFF_HIGHLIGHT}
	cat $< | sed -e "s,%DIFF_HIGHLIGHT%,${DIFF_HIGHLIGHT}," | ${SUDO} tee $@ > /dev/null

USER_GITCONFIG   ?= ~/.gitconfig
${USER_GITCONFIG}: user-gitconfig
	@if grep CHANGE $<; then echo EDIT user-gitconfig; false; else ln -svfn $(abspath $<) $@; fi

install: ${SYSTEM_GITCONFIG} ${USER_GITCONFIG}

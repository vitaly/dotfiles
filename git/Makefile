default: install
.PHONY: default

SYSTEM_GITCONFIG ?= /usr/local/etc/gitconfig
${SYSTEM_GITCONFIG}: system-gitconfig
	${SUDO} rm -vf $@
	${SUDO} chmod +x ${DIFF_HIGHLIGHT}
	cat $< | sed -e "s,%DIFF_HIGHLIGHT%,${DIFF_HIGHLIGHT}," | ${SUDO} tee $@ > /dev/null

USER_GITCONFIG   ?= ~/.gitconfig
${USER_GITCONFIG}: user-gitconfig
	@if grep CHANGE $<; then echo EDIT user-gitconfig; false; else ln -svfn $(abspath $<) $@; fi

install: ${ SYSTEM_GITCONFIG } ${USER_GITCONFIG}

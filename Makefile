elp:
	@cat HELP
.PHONY: help

EUID := $(shell id -u -r)
ifeq (0,${EUID})
	SUDO=
else
	SUDO=sudo
endif

TARGETS =

${HOME}/.% : home/%
	rm -f $@
	ln -svfn $(abspath $<) $@
HOMELINK_TARGETS := $(patsubst home/%,${HOME}/.%,$(shell find home -maxdepth 1))
TARGETS += ${HOMELINK_TARGETS}

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

install: ${TARGETS}

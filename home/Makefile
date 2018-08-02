default: install
.PHONY: default

# TARGETS := $(filter-out Makefile,$(patsubst ./%,${HOME}/.%,$(shell /bin/ls)))
TARGETS := $(patsubst ./%,${HOME}/.%,$(filter-out ./Makefile, $(shell find . -maxdepth 1)))

${HOME}/.% : ./%
	@rm -f $@
	@ln -svfn $(abspath $<) $@

install: ${TARGETS}
.PHONY: install

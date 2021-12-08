SHELL := bash
MAKEFLAGS += --warn-undefined-variables
.SHELLFLAGS := -euo pipefail -c
SUBMAKE_OPTS := -s

.PHONY: all
all:

.PHONY: dry
dry:
	@echo '---(i) INFO: Dry running apply'
	chezmoi apply --dry-run --verbose

.PHONY: reset
reset:
	@echo '---(i) INFO: Clearing chezmoi state'
	chezmoi state reset

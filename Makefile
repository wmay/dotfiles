## Options available for make:	
##
## help       : Display available make commands
.PHONY : help
help : Makefile
	@sed -n 's/^##//p' $<

## emacs      : Set up emacs
.PHONY: emacs
emacs: 
	bash scripts/setup_emacs.sh

## R          : Set up R
.PHONY: R
R: spatial
	bash scripts/setup_R.sh

## python     : Set up python
.PHONY: python
python: spatial
	bash scripts/setup_python.sh

## firefox    : Set up firefox
.PHONY: firefox
firefox: 
	bash scripts/setup_firefox.sh

## coding     : Set up code tools
.PHONY: coding
coding:
	bash scripts/setup_coding.sh

## spatial    : Install spatial packages
.INTERMEDIATE: spatial
spatial:
	bash scripts/setup_spatial.sh

## research   : Install research packages
.PHONY: research
research:
	bash scripts/setup_research.sh

## utils      : Set up miscellaneous tools
.PHONY: utils
utils:
	bash scripts/setup_utils.sh

## kubernetes : Set up kubernetes
.PHONY: kubernetes
kubernetes:
	bash scripts/setup_kubernetes.sh

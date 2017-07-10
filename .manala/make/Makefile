##########
# Debian #
##########

%.wheezy:  DEBIAN_DISTRIBUTION = wheezy
%.jessie:  DEBIAN_DISTRIBUTION = jessie
%.stretch: DEBIAN_DISTRIBUTION = stretch

##########
# Manala #
##########

MANALA_DIR = $(abspath $(patsubst %/make/Makefile,%,$(firstword $(filter %manala/make/Makefile,$(MAKEFILE_LIST)))))

include \
	$(MANALA_DIR)/make/Makefile.manala

-include \
	Makefile.local

########
# Help #
########

MANALA_HELP += $(call help_section,Packages)

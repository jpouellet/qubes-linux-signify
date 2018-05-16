#
# Common Makefile for building RPMs
#

# the pathnames are relative to the subproject directory (e.g. signify/)
# so that e.g. this file is: ../Makefile
#

SPECFILE := signify.spec

WORKDIR := $(CURDIR)
SPECDIR ?= $(WORKDIR)
SRCRPMDIR ?= $(WORKDIR)/srpm
BUILDDIR ?= $(WORKDIR)
RPMDIR ?= $(WORKDIR)/rpm
SOURCEDIR := $(WORKDIR)


RPM_DEFINES := --define "_sourcedir $(SOURCEDIR)" \
               --define "_specdir $(SPECDIR)" \
               --define "_builddir $(BUILDDIR)" \
               --define "_srcrpmdir $(SRCRPMDIR)" \
               --define "_rpmdir $(RPMDIR)"

help:
	@echo "make rpms        -- generate binary rpm packages"
	@echo "make srpms       -- generate source rpm packages"

VER_REL := $(shell rpm $(RPM_DEFINES) -q --qf "%{VERSION}-%{RELEASE}\n" --specfile $(SPECFILE)| head -1|sed -e 's/fc../$(DIST_DOM0)/')
NAME := $(shell rpm $(RPM_DEFINES) -q --qf "%{NAME}\n" --specfile $(SPECFILE)| head -1)

get-sources:
	git submodule update

.PHONY: verify-sources
verify-sources:
	@true

.PHONY: clean-sources
clean-sources:
	git submodule foreach sh -c 'rm -rf $$PWD'

rpms: rpms-dom0

rpms-vm:

rpms-dom0:
	rpmbuild $(RPM_DEFINES) -bb $(SPECFILE)

srpms:
	rpmbuild $(RPM_DEFINES) -bs $(SPECFILE)

clean:


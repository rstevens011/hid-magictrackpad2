#!/usr/bin/make -f

PKG_NAME=hid-magictrackpad2-dkms
PKG_VERSION=1.1.0
PKG_DESCRIPTION="Magic Trackpad 2 Support via HID Layer"

MAINTAINER="claudio <linux@ponyfleisch.ch>"
HOMEPAGE="https://github.com/ponyfleisch/hid-magictrackpad2-dkms"

all:
	test -d build || mkdir build
	fpm -f -s dir -t deb -n $(PKG_NAME) -v $(PKG_VERSION) -a all -p build/ \
		-d dkms -d build-essential -d linux-headers-generic \
		-m $(MAINTAINER) --vendor ponyfleisch --license GPLv2 --description $(PKG_DESCRIPTION) \
		--url $(HOMEPAGE) --deb-changelog CHANGELOG \
		--post-install scripts/post-install.sh --pre-uninstall scripts/pre-uninstall.sh \
		--exclude '.git*' usr/

rpm:
	test -d build || mkdir build
	frpm -f -s dir -t rpm -n $(PKG_NAME) -v $(PKG_VERSION) -a all -p build \
		-d dkms -d make -d automake -d gcc -d gcc-c++ -d kernel-devel -d kernel-headers \
		-m $(MAINTAINER) --vendor ponyfleisch --license GPLv2 --description $(PKG_DESCRIPTION) \
		--url $(HOMEPAGE) --rpm-changelog CHANGELOG \
		--post-install scripts/post-install-fedora.sh \
		--pre-uninstall scripts/pre-uninstall--fedora.sh \
		--exclude '.git*' usr/

clean:
	rm -f build/$(PKG_NAME)_$(PKG_VERSION)_all.deb

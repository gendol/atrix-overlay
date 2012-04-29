# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libdrm/Attic/libdrm-2.4.9.ebuild,v 1.2 2009/06/24 12:23:17 klausman Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org libdrm library"
HOMEPAGE="http://dri.freedesktop.org/"
SRC_URI="http://dri.freedesktop.org/libdrm/${P}.tar.gz"

KEYWORDS="alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""
RESTRICT="test" # see bug #236845

RDEPEND="dev-libs/libpthread-stubs"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${PV}-0001-nouveau-store-bo-handle-in-public-struct-in-bo_ref_.patch
	"${FILESDIR}"/${PV}-0002-nouveau-write-posting-got-lost-somewhere-bring-it.patch
	"${FILESDIR}"/${PV}-0003-libdrm-mode-align-subpixel-results.patch
	"${FILESDIR}"/${PV}-0004-intel-NULL-fake-bo-block-when-freeing-in-evict_all.patch
)

# FIXME, we should try to see how we can fit the --enable-udev configure flag

pkg_postinst() {
	x-modular_pkg_postinst

	ewarn "libdrm's ABI may have changed without change in library name"
	ewarn "Please rebuild media-libs/mesa, x11-base/xorg-server and"
	ewarn "your video drivers in x11-drivers/*."
}

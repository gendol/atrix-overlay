# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libdrm/Attic/libdrm-2.4.15.ebuild,v 1.6 2009/12/27 18:19:06 josejx Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

EGIT_REPO_URI="git://anongit.freedesktop.org/git/mesa/drm"

DESCRIPTION="X.Org libdrm library"
HOMEPAGE="http://dri.freedesktop.org/"
if [[ ${PV} = 9999* ]]; then
	SRC_URI=""
else
	SRC_URI="http://dri.freedesktop.org/${PN}/${P}.tar.bz2"
fi

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""
RESTRICT="test" # see bug #236845

RDEPEND="dev-libs/libpthread-stubs"
DEPEND="${RDEPEND}"

CONFIGURE_OPTIONS="--enable-udev --enable-nouveau-experimental-api --enable-radeon-experimental-api"

PATCHES=(
"${FILESDIR}/2.4.15-0001-configure-Conditionally-build-libdrm_intel.patch"
"${FILESDIR}/2.4.15-0002-configure-Typo-in-error-message.patch"
"${FILESDIR}/2.4.15-0003-intel-Fallback-to-atomic-ops.h-libatomic-ops-dev.patch"
)

pkg_postinst() {
	x-modular_pkg_postinst

	ewarn "libdrm's ABI may have changed without change in library name"
	ewarn "Please rebuild media-libs/mesa, x11-base/xorg-server and"
	ewarn "your video drivers in x11-drivers/*."
}

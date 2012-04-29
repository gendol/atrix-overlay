# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xcb-util/xcb-util-0.3.6.ebuild,v 1.9 2009/12/31 17:39:43 ranger Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X C-language Bindings sample implementations"
HOMEPAGE="http://xcb.freedesktop.org/"
SRC_URI="http://xcb.freedesktop.org/dist/${P}.tar.bz2"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="test"

RDEPEND=">=x11-libs/libxcb-1.4"
DEPEND="${RDEPEND}
	>=dev-util/gperf-3.0.1
	dev-util/pkgconfig
	>=x11-proto/xproto-7.0.8
	>=x11-proto/xcb-proto-1.5
	test? ( >=dev-libs/check-0.9.4 )"

pkg_postinst() {
	x-modular_pkg_postinst

	echo
	ewarn "Library names have changed since earlier versions of xcb-util;"
	ewarn "you must rebuild packages that have linked against <xcb-util-0.3.0."
	einfo "Using 'revdep-rebuild' from app-portage/gentoolkit is highly"
	einfo "recommended."
	epause 5
}

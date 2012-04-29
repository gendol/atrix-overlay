# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXdamage/Attic/libXdamage-1.1.1.ebuild,v 1.12 2009/05/05 07:05:11 ssuominen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org Xdamage library"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXfixes
	>=x11-proto/damageproto-1.1
	x11-proto/xproto"
DEPEND="${RDEPEND}"

pkg_postinst() {
	x-modular_pkg_postinst

	ewarn "Compositing managers may stop working."
	ewarn "To fix them, recompile xorg-server."
}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXext/Attic/libXext-1.0.5.ebuild,v 1.10 2009/12/15 19:36:12 ranger Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org Xext library"

KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/libX11-1.2"
DEPEND="${RDEPEND}
	>=x11-proto/xproto-7.0.15
	>=x11-proto/xextproto-7.0.5
"

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXcomposite/Attic/libXcomposite-0.4.0.ebuild,v 1.11 2009/05/15 15:08:59 armin76 Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org Xcomposite library"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXfixes
	x11-libs/libXext
	>=x11-proto/compositeproto-0.4
	x11-proto/xproto"
DEPEND="${RDEPEND}"

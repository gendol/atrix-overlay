# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXxf86dga/Attic/libXxf86dga-1.1.1.ebuild,v 1.1 2009/10/14 14:13:00 remi Exp $

inherit x-modular

DESCRIPTION="X.Org Xxf86dga library"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-proto/xproto
	>=x11-proto/xf86dgaproto-2.0.99.2"
DEPEND="${RDEPEND}"

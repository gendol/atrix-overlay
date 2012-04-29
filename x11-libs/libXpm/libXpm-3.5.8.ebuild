# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXpm/Attic/libXpm-3.5.8.ebuild,v 1.7 2009/12/27 18:08:03 josejx Exp $

inherit x-modular

DESCRIPTION="X.Org Xpm library"

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE="nls"

RDEPEND="x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXext"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	x11-proto/xproto"

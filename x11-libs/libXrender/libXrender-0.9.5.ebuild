# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXrender/Attic/libXrender-0.9.5.ebuild,v 1.6 2009/12/27 18:08:26 josejx Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org Xrender library"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libX11
	>=x11-proto/renderproto-0.9.3
	x11-proto/xproto"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/0001-Make-libXrender-use-docdir-for-documentation-placeme.patch"
)

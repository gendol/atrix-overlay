# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-proto/xextproto/Attic/xextproto-7.0.4.ebuild,v 1.10 2009/06/23 19:21:32 klausman Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org XExt protocol headers"

KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"

IUSE=""
DEPEND="x11-proto/inputproto"
RDEPEND="${DEPEND}"

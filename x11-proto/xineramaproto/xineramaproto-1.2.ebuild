# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-proto/xineramaproto/Attic/xineramaproto-1.2.ebuild,v 1.3 2009/10/26 12:30:32 remi Exp $

inherit x-modular

DESCRIPTION="X.Org Xinerama protocol headers"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="!<x11-libs/libXinerama-1.0.99.1"
DEPEND="${RDEPEND}"

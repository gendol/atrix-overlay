# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xkeyboard-config/Attic/xkeyboard-config-1.6.ebuild,v 1.11 2009/12/03 16:54:00 ranger Exp $

inherit eutils

DESCRIPTION="X keyboard configuration database"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/XKeyboardConfig"
SRC_URI="http://xlibs.freedesktop.org/xkbdesc/${P}.tar.bz2"

LICENSE="xkeyboard-config"
SLOT="0"

IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.30
	dev-perl/XML-Parser
	x11-apps/xkbcomp"

src_compile() {
	econf \
		--with-xkb-base=/usr/share/X11/xkb \
		--enable-compat-rules \
		--disable-xkbcomp-symlink \
		--with-xkb-rules-symlink=xorg \
		|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc ChangeLog NEWS README
}

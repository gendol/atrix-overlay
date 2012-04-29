# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xkeyboard-config/Attic/xkeyboard-config-1.5.ebuild,v 1.12 2009/06/23 21:23:43 remi Exp $

inherit eutils multilib

DESCRIPTION="X keyboard configuration database"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/XKeyboardConfig"
SRC_URI="http://xlibs.freedesktop.org/xkbdesc/${P}.tar.bz2"

LICENSE="xkeyboard-config"
SLOT="0"

IUSE=""
RDEPEND="!x11-misc/xkbdata"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.30
	dev-perl/XML-Parser
	x11-apps/xkbcomp"

pkg_setup() {
	# (#130590) The old XKB directory can screw stuff up
	local DIR="${ROOT}usr/$(get_libdir)/X11/xkb"
	if [[ -d ${DIR} ]] ; then
		eerror "Directory ${DIR} should be"
		eerror "manually deleted/renamed/relocated before installing!"
		die "Manually remove ${DIR}"
	fi

	# The old xkbdata 'pc' directory can screw stuff up, because portage won't
	# let us overwrite a directory with a file
	local PC="${ROOT}usr/share/X11/xkb/symbols/pc"
	if [[ -d ${PC} ]] ; then
		eerror "Directory ${PC} should be"
		eerror "manually deleted/renamed/relocated before installing!"
		die "Manually remove ${PC}"
	fi
}

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

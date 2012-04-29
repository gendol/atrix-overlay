# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xkeyboard-config/Attic/xkeyboard-config-1.7.ebuild,v 1.7 2009/12/27 18:13:37 josejx Exp $

EAPI="2"

if [[ ${PV} = 9999* ]]; then
	GIT_ECLASS="git"
	EGIT_REPO_URI="git://anongit.freedesktop.org/git/xkeyboard-config"
else
	SRC_URI="http://xlibs.freedesktop.org/xkbdesc/${P}.tar.bz2"
fi

inherit ${GIT_ECLASS} autotools

DESCRIPTION="X keyboard configuration database"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/XKeyboardConfig"

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

LICENSE="MIT"
SLOT="0"

RDEPEND="x11-apps/xkbcomp"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.30
	dev-perl/XML-Parser"

src_prepare() {
	if [[ ${PV} = 9999* ]]; then
		intltoolize
		eautoreconf
	fi
}

src_configure() {
	econf \
		--with-xkb-base=/usr/share/X11/xkb \
		--enable-compat-rules \
		--disable-xkbcomp-symlink \
		--with-xkb-rules-symlink=xorg \
		|| die "configure failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	echo "CONFIG_PROTECT=\"/usr/share/X11/xkb\"" > "${T}"/10xkeyboard-config
	doenvd "${T}"/10xkeyboard-config
}

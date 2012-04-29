# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libxcb/Attic/libxcb-1.4-r1.ebuild,v 1.10 2009/12/15 19:52:48 ranger Exp $

EAPI="2"

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X C-language Bindings library"
HOMEPAGE="http://xcb.freedesktop.org/"
SRC_URI="http://xcb.freedesktop.org/dist/${P}.tar.bz2"

KEYWORDS="alpha amd64 arm hppa ia64 ~m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="doc selinux"

RDEPEND="x11-libs/libXau
	x11-libs/libXdmcp
	dev-libs/libpthread-stubs"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	dev-libs/libxslt
	>=x11-proto/xcb-proto-1.5
	>=dev-lang/python-2.5[xml]"

pkg_setup() {
	CONFIGURE_OPTIONS="$(use_enable doc build-docs)
		$(use_enable selinux)
		--enable-xinput"
}

src_install() {
	x-modular_src_install
	dobin "${FILESDIR}"/xcb-rebuilder.sh || die
}

pkg_preinst() {
	x-modular_pkg_preinst
	preserve_old_lib "${ROOT}"/usr/$(get_libdir)/libxcb-xlib.so.0.0.0
}

pkg_postinst() {
	x-modular_pkg_postinst

	if [[ -e "${ROOT}"/usr/$(get_libdir)/libxcb-xlib.so.0.0.0 ]]; then
		echo
		ewarn "libxcb-xlib.so is no longer shipped by ${PN} but was kept on your system"
		ewarn
		ewarn "While your system will still work, emerging new packages or updates"
		ewarn "will likely fail. You can fix broken libtool .la files by running :"
		ewarn
		ewarn "  ${FILESDIR}/xcb-rebuilder.sh"
		ewarn
		ewarn "To completely get rid of libxcb-xlib.so references, please read :"
		ewarn "http://www.gentoo.org/proj/en/desktop/x/x11/libxcb-1.4-upgrade-guide.xml"
		ebeep 5
		epause 5
	fi
}

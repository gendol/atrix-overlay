# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-settings/xfce4-settings-4.8.3.ebuild,v 1.8 2012/01/06 10:43:33 ssuominen Exp $

EAPI=4
inherit xfconf

DESCRIPTION="Configuration system for the Xfce desktop environment"
HOMEPAGE="http://www.xfce.org/projects/xfce4-settings/"
SRC_URI="mirror://xfce/src/xfce/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="debug libcanberra libnotify +xklavier"

RDEPEND=">=dev-libs/dbus-glib-0.90
	>=dev-libs/glib-2.16
	>=gnome-base/libglade-2
	>=x11-libs/gtk+-2.14:2
	x11-libs/libX11
	>=x11-libs/libXcursor-1.1
	x11-libs/libXi
	>=x11-libs/libXrandr-1.2
	>=xfce-base/exo-0.6
	>=xfce-base/libxfce4ui-4.8
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/xfconf-4.8
	libcanberra? ( >=media-libs/libcanberra-0.25[sound] )
	libnotify? ( >=x11-libs/libnotify-0.7 )
	xklavier? ( x11-libs/libxklavier )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext
	>=x11-proto/inputproto-1.4
	x11-proto/xproto"

pkg_setup() {
	XFCONF=(
		--disable-static
		$(use_enable libnotify)
		$(use_enable xklavier libxklavier)
		$(use_enable libcanberra sound-settings)
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog NEWS TODO )
}

src_prepare() {
	local theme=Hicolor
	has_version x11-themes/tango-icon-theme && theme=Tango
	has_version x11-themes/gnome-icon-theme && theme=GNOME
	has_version x11-themes/faenza-icon-theme && theme=Faenza
	sed -i -e "/IconThemeName/s:Rodent:${theme}:" xfsettingsd/xsettings.xml || die

	xfconf_src_prepare
}

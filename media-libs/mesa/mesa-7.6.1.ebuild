# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/mesa/Attic/mesa-7.6.1.ebuild,v 1.1 2009/12/22 13:50:33 nirbheek Exp $

EAPI="2"

EGIT_REPO_URI="git://anongit.freedesktop.org/mesa/mesa"

if [[ ${PV} = 9999* ]]; then
	GIT_ECLASS="git"
	EXPERIMENTAL="true"
	IUSE_VIDEO_CARDS_UNSTABLE="video_cards_nouveau"
fi

inherit autotools multilib flag-o-matic ${GIT_ECLASS} portability

OPENGL_DIR="xorg-x11"

MY_PN="${PN/m/M}"
MY_P="${MY_PN}-${PV/_*/}"
MY_SRC_P="${MY_PN}Lib-${PV/_/-}"
DESCRIPTION="OpenGL-like graphic library for Linux"
HOMEPAGE="http://mesa3d.sourceforge.net/"

#SRC_PATCHES="mirror://gentoo/${P}-gentoo-patches-01.tar.bz2"
if [[ $PV = 9999* ]]; then
	SRC_URI="${SRC_PATCHES}"
else
	SRC_URI="ftp://ftp.freedesktop.org/pub/mesa/${PV/_rc*/}/${MY_SRC_P}.tar.bz2
		${SRC_PATCHES}"
fi

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"

IUSE_VIDEO_CARDS="${IUSE_VIDEO_CARDS_UNSTABLE}
	video_cards_intel
	video_cards_mach64
	video_cards_mga
	video_cards_none
	video_cards_r128
	video_cards_radeon
	video_cards_radeonhd
	video_cards_s3virge
	video_cards_savage
	video_cards_sis
	video_cards_sunffb
	video_cards_tdfx
	video_cards_trident
	video_cards_via"
IUSE="${IUSE_VIDEO_CARDS}
	debug gallium motif +nptl pic +xcb kernel_FreeBSD"

# keep correct libdrm and dri2proto dep
# keep blocks in rdepend for binpkg
RDEPEND="!<x11-base/xorg-server-1.7
	!<=x11-proto/xf86driproto-2.0.3
	>=app-admin/eselect-opengl-1.1.1-r2
	dev-libs/expat
	>=x11-libs/libdrm-2.4.17
	x11-libs/libICE
	x11-libs/libX11[xcb?]
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXmu
	x11-libs/libXxf86vm
	motif? ( x11-libs/openmotif )
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-misc/makedepend
	>=x11-proto/dri2proto-1.99.3
	>=x11-proto/glproto-1.4.8
	x11-proto/inputproto
	>=x11-proto/xextproto-7.0.99.1
	x11-proto/xf86driproto
	x11-proto/xf86vidmodeproto
"

S="${WORKDIR}/${MY_P}"

# Think about: ggi, svga, fbcon, no-X configs

pkg_setup() {
	# gcc 4.2 has buggy ivopts
	if [[ $(gcc-version) = "4.2" ]]; then
		append-flags -fno-ivopts
	fi

	# recommended by upstream
	append-flags -ffast-math
}

src_unpack() {
	[[ $PV = 9999* ]] && git_src_unpack || unpack ${A}
}

src_prepare() {
	# apply patches
	if [[ ${PV} != 9999* && -n ${SRC_PATCHES} ]]; then
		EPATCH_FORCE="yes" \
		EPATCH_SOURCE="${WORKDIR}/patches" \
		EPATCH_SUFFIX="patch" \
		epatch
	fi

	# The drmClip interface changed with libdrm-2.4.17
	# bug 297891 (patch from upstream git)
	epatch "${FILESDIR}/0001-st-xorg-Adopt-to-new-dirty-clip-rect-type.patch"

	# FreeBSD 6.* doesn't have posix_memalign().
	[[ ${CHOST} == *-freebsd6.* ]] && \
		sed -i -e "s/-DHAVE_POSIX_MEMALIGN//" configure.ac

	eautoreconf
}

src_configure() {
	local myconf r600

	# Configurable DRI drivers
	driver_enable swrast
	driver_enable video_cards_intel i810 i915 i965
	driver_enable video_cards_mach64 mach64
	driver_enable video_cards_mga mga
	driver_enable video_cards_r128 r128
	# ATI has two implementations as video_cards
	driver_enable video_cards_radeon radeon r200 r300 r600
	driver_enable video_cards_radeonhd r300 r600
	driver_enable video_cards_s3virge s3v
	driver_enable video_cards_savage savage
	driver_enable video_cards_sis sis
	driver_enable video_cards_sunffb ffb
	driver_enable video_cards_tdfx tdfx
	driver_enable video_cards_trident trident
	driver_enable video_cards_via unichrome

	# all live (experimental) stuff is wrapped around with experimental variable
	# so the users cant get to this parts even with enabled useflags (downgrade
	# from live to stable for example)
	if [[ -n ${EXPERIMENTAL} ]]; then
		# nouveau works only with gallium
		use gallium && myconf="${myconf} $(use_enable video_cards_nouveau gallium-nouveau)"
		if use video_cards_nouveau && ! use gallium ; then
			elog "Nouveau driver is available only via gallium interface."
			elog "Enable gallium useflag if you want to use nouveau."
			echo
		fi
	fi

	myconf="${myconf} $(use_enable gallium)"
	if use gallium; then
		elog "Warning gallium interface is highly experimental so use"
		elog "it only if you feel really really brave."
		elog
		elog "Intel: works only i915."
		elog "Nouveau: only available implementation, so no other choice"
		elog "Radeon: implementation up to the r500."
		echo
		myconf="${myconf}
			--with-state-trackers=glx,dri,egl,xorg
			$(use_enable video_cards_nouveau gallium-nouveau)
			$(use_enable video_cards_intel gallium-intel)"
		if ! use video_cards_radeon && ! use video_cards_radeonhd; then
			myconf="${myconf} --disable-gallium-radeon"
		else
			myconf="${myconf} --enable-gallium-radeon"
		fi
	fi

	# Deactivate assembly code for pic build
	myconf="${myconf} $(use_enable !pic asm)"

	# --with-driver=dri|xlib|osmesa ; might get changed later to something
	# else than dri
	econf \
		--with-driver=dri \
		--disable-glut \
		--without-demos \
		$(use_enable debug) \
		$(use_enable motif glw) \
		$(use_enable motif) \
		$(use_enable nptl glx-tls) \
		$(use_enable xcb) \
		--with-dri-drivers=${DRI_DRIVERS} \
		${myconf}
}

src_install() {
	dodir /usr
	emake DESTDIR="${D}" install || die "Installation failed"

	# Remove redundant headers
	# GLUT thing
	rm -f "${D}"/usr/include/GL/glut*.h || die "Removing glut include failed."
	# Glew includes
	rm -f "${D}"/usr/include/GL/{glew,glxew,wglew}.h \
		|| die "Removing glew includes failed."

	# Move libGL and others from /usr/lib to /usr/lib/opengl/blah/lib
	# because user can eselect desired GL provider.
	ebegin "Moving libGL and friends for dynamic switching"
		dodir /usr/$(get_libdir)/opengl/${OPENGL_DIR}/{lib,extensions,include}
		local x
		for x in "${D}"/usr/$(get_libdir)/libGL.{la,a,so*}; do
			if [ -f ${x} -o -L ${x} ]; then
				mv -f ${x} "${D}"/usr/$(get_libdir)/opengl/${OPENGL_DIR}/lib \
					|| die "Failed to move ${x}"
			fi
		done
		for x in "${D}"/usr/include/GL/{gl.h,glx.h,glext.h,glxext.h}; do
			if [ -f ${x} -o -L ${x} ]; then
				mv -f ${x} "${D}"/usr/$(get_libdir)/opengl/${OPENGL_DIR}/include \
					|| die "Failed to move ${x}"
			fi
		done
	eend $?
}

pkg_postinst() {
	# Switch to the xorg implementation.
	echo
	eselect opengl set --use-old ${OPENGL_DIR}
}

# $1 - VIDEO_CARDS flag
# other args - names of DRI drivers to enable
driver_enable() {
	case $# in
		# for enabling unconditionally
		1)
			DRI_DRIVERS="${DRI_DRIVERS},$1"
			;;
		*)
			if use $1; then
				shift
				for i in $@; do
					DRI_DRIVERS="${DRI_DRIVERS},${i}"
				done
			fi
			;;
	esac
}

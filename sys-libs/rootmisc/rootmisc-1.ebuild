# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Miscellaneous Binaries"

SLOT="0"
KEYWORDS="arm"

IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"
RESTRICT="strip mirror"

src_unpack() {
	#unpack "${FILESDIR}"/initramfs-tools.tar.gz
	tar xzf "${FILESDIR}"/rootfs.tar.gz
}

src_install() {
	exeinto /usr/lib/initramfs-tools/bin/
	doexe "${FILESDIR}"/busybox

	exeinto /sbin/
	doexe "${FILESDIR}"/adbd
	doexe "${FILESDIR}"/ueventd

	exeinto /usr/lib/
	doexe rootfs/usr/lib/*.so

	exeinto /usr/lib/xorg/modules/drivers/
	doexe rootfs/usr/lib/xorg/modules/drivers/*.so
}

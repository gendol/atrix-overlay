#!/bin/sh
# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xinit/files/startDM.sh,v 1.4 2007/04/05 15:30:19 uberlord Exp $

# We need to source /etc/profile for stuff like $LANG to work
# bug #10190.
. /etc/profile

. /etc/init.d/functions.sh

# baselayout-1 compat
if ! type get_options >/dev/null 2>/dev/null ; then
	[ -r "${svclib}"/sh/rc-services.sh ] && . "${svclib}"/sh/rc-services.sh
fi

# Great new Gnome2 feature, AA
# We enable this by default
export GDK_USE_XFT=1

export SVCNAME=xdm
EXEC="$(get_options service)"
NAME="$(get_options name)"
PIDFILE="$(get_options pidfile)"

start-stop-daemon --start --exec ${EXEC} \
${NAME:+--name} ${NAME} ${PIDFILE:+--pidfile} ${PIDFILE} || \
eerror "ERROR: could not start the Display Manager"

# vim:ts=4
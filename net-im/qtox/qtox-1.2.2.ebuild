# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit eutils qmake-utils

DESCRIPTION="Powerful Qt5 chat client for net-libs/tox that follows the Tox design guidelines"
HOMEPAGE="https://github.com/tux3/qtox"
SRC_URI="https://github.com/tux3/qTox/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+filter_audio gtk X"

DEPEND="
	dev-db/sqlcipher

	dev-qt/linguist-tools:5
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5[gif,jpeg,png,xcb]
	dev-qt/qtnetwork:5
	dev-qt/qtopengl:5
	dev-qt/qtsql:5
	dev-qt/qtsvg:5
	dev-qt/qtxml:5

	media-gfx/qrencode

	media-libs/openal

	>=media-video/ffmpeg-2.6.3[webp,v4l]

	net-libs/tox[av]

	filter_audio? ( media-libs/libfilteraudio )

	gtk? (
		dev-libs/atk
		dev-libs/glib:2

		x11-libs/cairo[X]
		x11-libs/gdk-pixbuf[X]
		x11-libs/gtk+:2
		x11-libs/pango[X]
	)

	X? (
		x11-libs/libX11
		x11-libs/libXScrnSaver
	)
"

RDEPEND="${DEPEND}"

S="${WORKDIR}/qTox-${PV}"

pkg_pretend() {
	if [[ ${MERGE_TYPE} != binary ]]; then
		if [[ $(tc-getCXX) == *g++ ]] ; then
			if [[ $(gcc-major-version) == 4 && $(gcc-minor-version) -lt 8 || $(gcc-major-version) -lt 4 ]] ; then
				eerror "You need at least sys-devel/gcc-4.8.3"
				die "You need at least sys-devel/gcc-4.8.3"
			fi
		fi
	fi
}

src_prepare() {
	epatch_user
}

src_configure() {
	use filter_audio || NO_FILTER_AUDIO="DISABLE_FILTER_AUDIO=YES"

	use gtk || NO_GTK_SUPPORT="ENABLE_SYSTRAY_STATUSNOTIFIER_BACKEND=NO ENABLE_SYSTRAY_GTK_BACKEND=NO"

	use X || NO_X_SUPPORT="DISABLE_PLATFORM_EXT=YES"

	eqmake5 \
			${NO_FILTER_AUDIO} \
			${NO_GTK_SUPPORT} \
			${NO_X_SUPPORT}
}

src_install() {
	dobin "${S}/qtox"
	doicon -s scalable "${S}/img/icons/qtox.svg"
	domenu "${S}/qTox.desktop"
}

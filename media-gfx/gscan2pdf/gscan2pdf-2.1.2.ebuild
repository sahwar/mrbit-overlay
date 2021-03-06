# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils perl-module

DESCRIPTION="Scan documents, perform OCR, produce PDFs and DjVus"
HOMEPAGE="http://gscan2pdf.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="+gocr +tesseract -cuneiform" 
# OCR tests fail with tesseract[opencl], not fixed by addpredict
# and others on Wayland and the console
RESTRICT="test"

RDEPEND="
    dev-perl/Cairo-GObject
    dev-perl/Gtk3
    dev-perl/Gtk3-SimpleList
    dev-perl/GooCanvas2
	dev-perl/Config-General
	dev-perl/Date-Calc
	dev-perl/Data-UUID
	dev-perl/Filesys-Df
	dev-perl/glib-perl
	dev-perl/Goo-Canvas
	dev-perl/Gtk2-Ex-PodViewer
	dev-perl/Gtk2-Ex-Simple-List
	dev-perl/Gtk2-ImageView
	dev-perl/Gtk2
	dev-perl/HTML-Parser
	dev-perl/Image-Sane
	dev-perl/Locale-gettext
	dev-perl/List-MoreUtils
	dev-perl/Log-Log4perl
	dev-perl/PDF-API2
	dev-perl/Proc-ProcessTable
	dev-perl/Readonly
	dev-perl/Sane
	dev-perl/Set-IntSpan
	dev-perl/Try-Tiny
	virtual/perl-Archive-Tar
	virtual/perl-Carp
	virtual/perl-Data-Dumper
	virtual/perl-File-Temp
	virtual/perl-Getopt-Long
	virtual/perl-threads
	virtual/perl-threads-shared
	media-gfx/gtkimageview
	media-gfx/imagemagick[png,tiff,perl]
	media-gfx/sane-backends
tesseract? ( app-text/tesseract[osd,tiff] )
gocr? (	app-text/gocr )
cuneiform? ( app-text/cuneiform )
	media-libs/tiff"

mydoc="History"

pkg_postinst() {
	optfeature "DjVu file support" "app-text/djvu[tiff] media-gfx/imagemagick[djvu]"
	optfeature "Optical Character Recognition" app-text/tesseract[osd,tiff]
	optfeature "scan post-processing" app-text/unpaper
	optfeature "automatic document feeder support" media-gfx/sane-frontends
	optfeature "sending PDFs as email attachments" x11-misc/xdg-utils
}

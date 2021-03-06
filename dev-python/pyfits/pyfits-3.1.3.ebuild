# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyfits/pyfits-3.1.2.ebuild,v 1.2 2013/09/05 18:46:59 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )
inherit distutils-r1 eutils

DESCRIPTION="Provides an interface to FITS formatted files under python"
HOMEPAGE="http://www.stsci.edu/resources/software_hardware/pyfits"
SRC_URI="mirror://pypi/p/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	!dev-python/astropy"
DEPEND="${RDEPEND}
	dev-python/stsci-distutils[${PYTHON_USEDEP}]
	dev-python/d2to1[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}"/${PN}-3.0.8-debundle_zlib.patch ) || die

python_test() {
	cd "${BUILD_DIR}"/lib* || die
	nosetests || die
}


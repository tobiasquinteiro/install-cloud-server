#!/bin/bash
#
# Set up additional php modules, ffmpeg and imagemagick for the use with nextcloud.
#
# Copyright (C) 2017-2019 Rainer Emrich, <rainer@emrich-ebersheim.de>
#
# This file is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; see the file LICENSE.  If not see
# <http://www.gnu.org/licenses/>.
#

setup_nextcloud_prerequisites () {

	if [ "${NEXTCLOUD_PREREQUISITES_INSTALLED}" != "1" ] ; then

		echo
		echo "#######################################################################################"
		echo "#"
		echo "# Install nextcloud prerequisites."
		echo "#"
		echo "# Additional php modules, ffmpeg and imagemagick."
		echo "#"
		echo "# To finish the installation we reboot the system!"
		echo "#"
		echo "#######################################################################################"
		echo

		ask_to_continue

		echo "#######################################################################################"
		echo "#"
		echo "# Install additional php modules."
		echo "#"
		echo "#######################################################################################"

		apt-get install php7.0-gmp php7.0-imap php7.0-intl php7.0-ldap php7.0-pgsql php7.0-sqlite3 \
				php7.1-gmp php7.1-imap php7.1-intl php7.1-ldap php7.1-pgsql php7.1-sqlite3 \
				php7.2-gmp php7.2-imap php7.2-intl php7.2-ldap php7.2-pgsql php7.2-sqlite3 \
				php-apcu php-apcu-bc php-igbinary php-imagick php-memcached php-msgpack \
				php-redis php-smbclient -y

		systemctl restart php7.0-fpm
		systemctl restart php7.1-fpm
		systemctl restart php7.2-fpm

		echo "#######################################################################################"
		echo "#"
		echo "# Install ffmpeg."
		echo "#"
		echo "#######################################################################################"

		apt-get install ffmpeg ffmpeg-doc -y

		echo "#######################################################################################"
		echo "#"
		echo "# Install imagemagick."
		echo "#"
		echo "#######################################################################################"

		apt-get install imagemagick imagemagick-doc -y

		touch ${STAMP_DIR}/nextcloud_prerequisites_installed

		echo
		echo "#######################################################################################"
		echo "#"
		echo "# A system reboot is required to finish the software installation, rebooting..."
		echo "#"
		echo "#######################################################################################"
		echo

		reboot
	else
		echo
		echo "#######################################################################################"
		echo "#"
		echo "# INFO: Nextcloud prerequisites installed already, skipping..."
		echo "#"
		echo "#######################################################################################"
		echo
	fi

}

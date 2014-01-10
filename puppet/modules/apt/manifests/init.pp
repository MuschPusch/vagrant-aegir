# == Class: apt
#
# Make sure package repositories are up to date.
#
# === Example
#
# include apt
#
# === Authors
#
# Caleb Thorne <caleb@calebthorne.com>
#
# === Copyright
#
# Copyright 2012 Caleb Thorne <http://www.calebthorne.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

class apt {
  exec{'apt_update':
    command => '/usr/bin/apt-get update',
  }

  Exec['apt_update'] -> Package <| |>
}

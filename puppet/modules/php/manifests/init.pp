# == Class: drush
#
# Install and configures php.
#
# === Parameters
#
# *version*: The php version to install. Defaults to latest.
#
# === Example
#
#  include php
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

class php(
    $version = 'latest',
    $modules = [],
  ){

  include apt

  $ubuntu_version = $version ? {
    'latest' => 'latest',
    '5.2'    => '5.2.4-2ubuntu5.25',
    '5.2.4'  => '5.2.4-2ubuntu5.25',
    '5.3'    => '5.3.10-1ubuntu3.2',
    '5.3.2'  => '5.3.2-1ubuntu4.17',
    '5.3.5'  => '5.3.5-1ubuntu7.10',
    '5.3.6'  => '5.3.6-13ubuntu3.8',
    '5.3.10' => '5.3.10-1ubuntu3.2',
    '5.4'    => '5.4.6-1ubuntu1',
    '5.4.6'  => '5.4.6-1ubuntu1',
    default  => undef,
  }

  $ubuntu_release = $version ? {
    'latest' => 'precise',
    '5.2'    => 'hardy',
    '5.2.4'  => 'hardy',
    '5.3'    => 'precise',
    '5.3.2'  => 'lucid',
    '5.3.5'  => 'natty',
    '5.3.6'  => 'oneiric',
    '5.3.10' => 'precise',
    '5.4'    => 'quantal',
    '5.4.6'  => 'quantal',
    default  => undef,
  }

  if $ubuntu_release == undef {
    fail("The specified version '${version}' could not be found.")
  }

  if $ubuntu_version != 'latest' {
    # Add repositories for the release.
    apt::sources{'php5 ${ubuntu_release}':
      release => $ubuntu_release,
    }

    # Add a preferences file so that apt-get upgrade does not overwrite the
    # selected version.
    apt::preferences{'php5':
      release  => $ubuntu_release,
      packages => ['php5-common', 'php5', 'php5-cli', 'libapache2-mod-php5'],
    }
    apt::preferences{'php5-custom':
      release  => $ubuntu_release,
      packages => $modules,
    }
  }

  # Install the default php packages.
  package {['php5', 'php5-common', 'php5-cli', 'libapache2-mod-php5', 'php5-mysql', "php5-gd", "php5-curl"]:
    ensure => $ubuntu_version,
  }

  # Setup some dependencies.
  Package['php5-common'] -> Package['libapache2-mod-php5'] -> Package['php5-cli'] -> Package['php5']

  if $modules != [] {
    # Install other requested packages.
    package {$modules:
      ensure => $ubuntu_version,
      require => Package['php5'],
    }
  }

  file {"/etc/php5/apache2/php.ini":
    ensure  => present,
    source  => 'puppet:///modules/php/php.ini',
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    notify  => Service['apache2'],
    require => [Package['apache2'], Package['php5']],
  }

  file {"/etc/php5/cli/php.ini":
    ensure  => present,
    source  => 'puppet:///modules/php/php-cli.ini',
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    notify  => Service['apache2'],
    require => [Package['apache2'], Package['php5']],
  }
}

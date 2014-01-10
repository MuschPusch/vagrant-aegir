# == Define: git::config
#
# Manage git configuration options.
#
# === Parameters
#
# *key*: (namevar) The name of the configuration option to set.
# *ensure*:
#   - present: Set the configuration.
#   - absent:  Remove the configuration.
# *user*: The user the configuration belongs to. Settings will be saved to
#         /home/[user]/.gitconfig. Defaults to root.
# *path*: The path to the configuration file. Do not include trailing /.
# *content*: The configuration value. Required if ensure => present.
# *scope*: The configuration scope. Use 'system' for system wide configurations
#          usually stored in /etc/gitconfig. Defaults to 'custom'.
#
# === Examples
#
# git::config {'color.ui':
#   scope   => 'system',
#   content => true,
# }
#
# git::config {'user.name',
#   content => 'Caleb Thorne',
# }
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

define git::config(
    $key     = $name,
    $ensure  = present,
    $user    = 'root',
    $path    = $user ? {
      root    => '/root',
      default => "/home/${user}",
    },
    $content = '',
    $scope = 'custom',
  ){

  $git = '/usr/bin/git'

  # We have to use the --file option instead of --global or --system due to
  # the odd way puppet handles environments for exec.
  $file = $scope ? {
    system  => '/etc/gitconfig',
    default => "${path}/.gitconfig",
  }

  if $ensure == present {
    if $content == '' {
      fail('git::config - content is required for ensure => present.')
    }

    exec {"git::config set ${file} ${key}":
      command   => "${git} config --file ${file} \"${key}\" \"${content}\"",
      unless    => "${git} config --file ${file} --get \"${key}\" \"{$content}\"",
      logoutput => true,
    }
  }

  if $ensure == absent {
    exec {"git::config unset ${file} ${key}":
      command   => "${git} config --file ${file} --unset \"${key}\"",
      onlyif    => "${git} config --file ${file} \"${key}\"",
      logoutput => true,
    }
  }
}

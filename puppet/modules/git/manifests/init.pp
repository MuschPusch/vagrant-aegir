# == Class: git
#
# Install and configure git.
#
# === Example
#
# include git
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

class git {
  include apt

  package {'git-core':
    ensure => latest,
  }

  file {'/etc/gitconfig':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => 0644,
  }

  # Add some useful aliases.
  git::config {'alias.st':
    scope   => 'system',
    content => 'status',
  }

  git::config {'alias.ci':
    scope   => 'system',
    content => 'commit',
  }

  git::config {'alias.co':
    scope   => 'system',
    content => 'checkout',
  }

  git::config {'alias.br':
    scope   => 'system',
    content => 'branch',
  }

  # Colorized output by default.
  git::config {'color.ui':
    scope   => 'system',
    content => true,
  }

  Package['git-core'] -> Git::Config <| |>
}

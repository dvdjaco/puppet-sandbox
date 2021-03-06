# == Class: openvpn
#
# This module installs the openvpn service, configures vpn endpoints, generates
# client certificates, and generates client config files
#
#
# === Examples
#
# This class should not be directly invoked
#
#
# === Authors
#
# * Raffael Schmid <mailto:raffael@yux.ch>
# * John Kinsella <mailto:jlkinsel@gmail.com>
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
# === License
#
# Copyright 2013 Raffael Schmid, <raffael@yux.ch>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
class openvpn::install inherits ::openvpn::params {

  ensure_packages(['openvpn'])
  if $::openvpn::params::additional_packages != undef {
    ensure_packages( any2array($::openvpn::params::additional_packages) )
  }

  file {
    [ '/etc/openvpn', '/etc/openvpn/keys', '/var/log/openvpn', ]:
      ensure  => directory,
      require => Package['openvpn'];
  }

  # Modify pkitool script to accept private key password as shell variable
  file_line { 'Explanatory comment':
    path  => "${openvpn::params::easyrsa_source}/pkitool",
    line  => '# This file has been modified by Puppet, see openvpn::install.',
    after => '#!/bin/sh',
  }
  file_line { 'Non-interactive private key password input - echo':
    path  => "${openvpn::params::easyrsa_source}/pkitool",
    line  => '    echo "  --passout  : encrypt private key with password in $KEY_PASS"',
    match => '^\s*echo "\s*--pass\s*',
  }
  file_line { 'Non-interactive private key password input - option':
      path  => "${openvpn::params::easyrsa_source}/pkitool",
      line  => '        --passout  ) NODES_REQ="-passout env:KEY_PASS" ;;',
      match => '^\s*--pass\s*\) NODES_REQ=\"\" ;;$',
    }
}

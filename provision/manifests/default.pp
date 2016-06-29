#
# site.pp - defines defaults for vagrant provisioning
#

# use run stages for minor vagrant environment fixes
stage { 'pre': before => Stage['main'] }

class { 'repos':   stage => 'pre' }
class { 'vagrant': stage => 'pre' }

class { 'puppet':
  ensure => '3.6.2-1puppetlabs1',
}
class { 'networking': }

if $hostname == 'master' {
  class { 'puppet::server':
    ensure => '3.6.2-1puppetlabs1'
  }
}

# == Class: helloworld
#
# This class is a bare bones example to ensure puppet master/clients are
# talking to each other.
#
# === Parameters
#
# === Actions
#
# === Requires
#
# === Sample Usage
#
# class { 'helloworld': }
#
class helloworld (
  $msg = $helloworld::params::message
  ) inherits helloworld::params {
  notify { $msg: }
}

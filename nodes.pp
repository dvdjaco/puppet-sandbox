#
# nodes.pp - defines all puppet nodes
#

node /^client1.*/ {
  class { 'openvpn': }
}

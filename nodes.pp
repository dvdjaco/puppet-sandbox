#
# nodes.pp - defines all puppet nodes
#

# self-manage the puppet master server
node 'puppet' { }

##### CLIENTS

node 'client1' {
  class { 'helloworld':
    $message => 'this comes from nodes.pp',
  }
}


node 'client2' { }

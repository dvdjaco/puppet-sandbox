#
# nodes.pp - defines all puppet nodes
#

# self-manage the puppet master server
node 'puppet' { }

##### CLIENTS

node 'client1' {

  class { 'accounts':
    ssh_keys       => hiera_hash('accounts::ssh_keys', {}),
    users          => hiera_hash('accounts::users', {}),
    usergroups     => hiera_hash('accounts::usergroups', {}),
    purge_ssh_keys => true,
  }

  accounts::account {'ubuntu':
    authorized_keys => ['@ops']
  }

}


node 'client2' { }

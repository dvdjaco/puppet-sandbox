#
# nodes.pp - defines all puppet nodes
#

node /^client*/ {
  include 'erlang'
  package { 'erlang-base':
  ensure => 'latest',
  }
  class { '::rabbitmq':
    service_manage           => true,
    port                     => '5672',
    delete_guest_user        => true,
    default_user             => 'qustodio',
    default_pass             => '1234',
    admin_enable             => true,
    config_cluster           => true,
    cluster_nodes            => ['client1','client2'],
    cluster_node_type        => 'disc',
    erlang_cookie            => 'A_SECRET_STRING',
    wipe_db_on_cookie_change => true,
    config_variables         => {
      queue_master_locator => '<<"min-masters">>',
    }
  }

  rabbitmq_user { 'qustodio':
  admin    => true,
  password => '1234',
  }

  rabbitmq_policy { 'ha-all@/':
    pattern    => '^ha\.',
    priority   => 0,
    definition => {
      'ha-mode'      => 'all',
      'ha-sync-mode' => 'automatic',
    }
  }
}

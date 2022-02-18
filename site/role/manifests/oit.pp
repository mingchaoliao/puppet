class role::oit {
  contain profile::oit::dcvpn_split_tunnel
  contain profile::skaffold
  contain profile::oit::dcvpn
  contain profile::oit::keep_mouse_moving
  contain profile::oit::run_node_resource

  package {[
    'teams'
  ]:
    provider => snap
  }
}

class role::oit {
  contain profile::oit::dcvpn_split_tunnel
  contain profile::skaffold
  contain profile::oit::dcvpn
  contain profile::oit::keep_mouse_moving

  package {[
    'teams'
  ]:
    provider => snap
  }
}
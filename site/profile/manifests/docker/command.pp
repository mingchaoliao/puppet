define profile::docker::command(
  $ensure = 'present',
  $commandName   = $title,
  $image,
  $imageTag    = 'latest',
  $cmd
) {
  file {"/opt/docker_cmds/${commandName}":
    ensure => $ensure,
    content => sprintf('docker run --rm -it --user="$(id -u):$(id -g)" -v "/etc/passwd:/etc/passwd:ro" -v "${HOME}:${HOME}" --workdir="/src" -v "$(pwd):/src" %s:%s %s $@', $image, $imageTag, $cmd),
    mode => '0755'
  }
}
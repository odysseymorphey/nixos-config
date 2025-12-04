{ ... }: {
  systemd.tmpfiles.rules = [
    "d /var/lib/portainer 0755 root root"
  ];

  virtualisation.oci-containers = {
    backend = "docker";

    containers.portainer = {
      image = "portainer/portainer-ce:latest";
      autoStart = true;

      ports = [
        "9000:9000"
      ];

      volumes = [
        "/var/run/docker.sock:/var/run/docker.sock"
        "/var/lib/portainer:/data"
      ];

      extraOptions = [
        "--restart=always"
      ];
    };
  };
}
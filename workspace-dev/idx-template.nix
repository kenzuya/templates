{pkgs, ...}: {
    packages = [
        pkgs.curl
        pkgs.gnutar
        pkgs.xz
        pkgs.git
        pkgs.busybox
        pkgs.tailscale
        pkgs.fuse3
    ];
    bootstrap = ''
        mkdir -p "$out"/.idx/
        cp ${./dev.nix} "$out"/.idx/dev.nix
        cp ${./Dockerfile} "$out"/Dockerfile
        cp ${./docker-compose.yaml} "$out"/docker-compose.yaml
        # Export TS_AUTHKEY and TS_HOSTNAME as environment variables
        export TS_AUTHKEY=${TS_AUTHKEY}
        export TS_HOSTNAME=${TS_HOSTNAME}
        # Replace placeholders in docker-compose.yaml with environment variables
        sed -i "s|{{TS_AUTHKEY}}|$TS_AUTHKEY|g" "$out"/docker-compose.yaml
        sed -i "s|{{TS_HOSTNAME}}|$TS_HOSTNAME|g" "$out"/docker-compose.yaml
    '';
}

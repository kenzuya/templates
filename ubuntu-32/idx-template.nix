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
        cp ${./docker-compose.yaml} "$out"/docker-compose.yaml
        echo "user_allow_other" > /etc/fuse.conf
    '';
}

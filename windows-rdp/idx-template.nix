{pkgs, ...}: {
    packages = [
        pkgs.curl
        pkgs.gnutar
        pkgs.xz
        pkgs.git
        pkgs.busybox
        pkgs.tailscale
    ];
    bootstrap = ''
        mkdir -p "$out"/.idx/
        cp ${./dev.nix} "$out"/.idx/dev.nix
    '';
}
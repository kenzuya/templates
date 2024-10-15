{pkgs, ...}: {
    packages = [
        pkgs.tailscale
    ];
    bootstrap = ''
        mkdir "$out"/.idx
        cp ${./dev.nix} "$out"/.idx/dev.nix
    '';
}
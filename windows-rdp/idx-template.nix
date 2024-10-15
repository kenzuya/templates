# idx-template.nix
{pkgs}: {
  packages = [
    # Note, this is NOT the list of packages available to the workspace once
    # it's created. Those go in .idx/dev.nix
    pkgs.nodejs
    pkgs.tailscale
    pkgs.curl
  ];

  bootstrap = ''
    mkdir "$out"
    # We can now use "npm"
   
  ''
}
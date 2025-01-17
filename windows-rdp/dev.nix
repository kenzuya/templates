{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-23.11"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.unzip
    pkgs.tailscale
    pkgs.openssh
  ];
  # Sets environment variables in the workspace
  env = {};
  services.docker.enable = true;
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      "njzy.stats-bar"
      "redhat.vscode-yaml"
    ];
    workspace = {
      # Runs when a workspace is first created with this `dev.nix` file
      onCreate = {
        remove-files = "rm -rf $HOME/.android/ $HOME/.dart-tool/ $HOME/.emu/ $HOME/.flutter $HOME/flutter $HOME/.gradle $HOME/.java $HOME/.kotlin $HOME/myapp $HOME/.pub-cache";
      };
      # To run something each time the workspace is (re)started, use the `onStart` hook
    };
    # Enable previews and customize configuration
    previews = {
      enable = false;
     
    };

  };
}

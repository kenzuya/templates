FROM ubuntu:22.04

RUN apt-get update && apt-get install -y curl gnupg lsb-release

RUN curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.noarmor.gpg | tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null

RUN curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.tailscale-keyring.list | tee /etc/apt/sources.list.d/tailscale.list

RUN apt-get update

RUN apt-get install -y tailscale zsh git 

RUN curl -fsSL https://bun.sh/install | bash

ENTRYPOINT ["/usr/sbin/tailscaled"]

# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

RUN apt-get update && apt-get install -y curl gnupg lsb-release

RUN curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.noarmor.gpg | tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null

RUN curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.tailscale-keyring.list | tee /etc/apt/sources.list.d/tailscale.list

RUN apt-get update

# Install required packages including tailscale, zsh, git, unzip, zsh plugins, and exa
RUN apt-get install -y tailscale zsh git unzip zsh-autosuggestions zsh-syntax-highlighting exa

# Install Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Change default shell to zsh
RUN chsh -s $(which zsh)

# Set ZSH_CUSTOM environment variable for plugin/theme installation
ENV ZSH_CUSTOM=/root/.oh-my-zsh/custom

# Clone zsh plugins
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
RUN git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
RUN git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
RUN git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use

# Clone powerlevel10k theme
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# Update .zshrc plugins and theme configuration
RUN sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete you-should-use)/' ~/.zshrc
RUN sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' ~/.zshrc

# Copy powerlevel10k config to root
COPY .p10k.zsh /root/.p10k.zsh
RUN echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc

# Add alias for exa as ls replacement
RUN echo 'alias ls="exa -lah --icons --color=always"' >> ~/.zshrc

# Install Bun JavaScript runtime
RUN curl -fsSL https://bun.sh/install | bash

# Install NVM and Node.js
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash && \
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
    nvm install 24

# Start tailscaled as entrypoint
ENTRYPOINT ["/usr/sbin/tailscaled"]

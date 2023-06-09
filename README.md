# .dotfiles

I manage my dotfiles with nix now.

## Additional Steps

```sh
# Install paq for nvim package management
git clone --depth=1 https://github.com/savq/paq-nvim.git \
    "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim
```

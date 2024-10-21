# nvim-config

## Brief

Custom *NeoVim* configuration that makes NeoVim the best IDE.

## Features

- *Lazy* package manager
- Notification system
- LSP completions, actions and refactoring

You can see all plugins listed in [plugins](/lua/plugins) directory.

## Configuration

You can find

- auto-switches in [switches.lua](/lua/config/switches.lua) file
- vim options in [vimopts.lua](/lua/config/vimopts.lua) file
- some key mappings in [remap.lua](/lua/config/remap.lua) file
- plugins configuration in [plugins](/lua/plugins) directory

## Installation

### 1. Make a backup of your existing configuration

```shell
# Required
mv ~/.config/nvim ~/.config/nvim.bak

# Optional but recomended
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

### 2. Clone repo

```shell
git clone https://github.com/hack3rmann/nvim-config.git ~/.config/nvim
```

### 3. Use your NeoVim!

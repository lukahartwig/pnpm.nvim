# pnpm.nvim

neovim plugin that make working with pnpm monorepos easier.

## Features

* Use Telescope to switch between workspace packages

## Getting started

### Required dependencies

* [pnpm](https://pnpm.io/)
* [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

### Installation

Using [packer](https://github.com/wbthomason/packer.nvim)

```lua
use 'lukahartwig/pnpm.nvim'
```

### Setup

This is technically optional but makes tab completion work right away.

```lua
require('telescope').load_extension('pnpm')
```

## Usage

```
:Telescope pnpm workspace
```
## Key Mappings

Using lua:

```lua
local telescope = require('telescope')
vim.keymap.set('n', '<leader>fw', telescope.extensions.pnpm.workspace, {})
```

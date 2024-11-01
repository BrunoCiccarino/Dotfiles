vim.cmd [[
  call plug#begin('~/.local/share/nvim/plugged')
    Plug 'neovim/nvim-lspconfig',
    Plug 'ellisonleao/gruvbox.nvim',
    Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
    Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  call plug#end()
]]

vim.o.number = true
vim.o.mouse = "a"

vim.o.background = "dark" 
vim.cmd([[colorscheme gruvbox]])

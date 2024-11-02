vim.cmd [[
call plug#begin('~/.local/share/nvim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'MunifTanjim/nui.nvim'         
Plug 'rcarriga/nvim-notify'          
Plug 'folke/noice.nvim'              
Plug 'folke/tokyonight.nvim'
Plug 'LukasPietzschmann/telescope-tabs'
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/go.nvim'
Plug 'ray-x/guihua.lua'

call plug#end()
]]

require('go-nvim')
require('telescope-nv')
require('noice').setup({
    cmdline = {
        enabled = true,
        view = "cmdline_popup",  
        format = {
            cmdline = { icon = ">" },
        },
    },
    popupmenu = {
        enabled = true,
    },
    messages = {
        enabled = false,
    },
})


vim.o.number = true
vim.o.mouse = "a"
vim.opt.scrolloff = 10

-- local themes = { 'gruvbox', 'tokyonight-night', 'tokyonight-moon' }

vim.o.background = "dark"
vim.cmd([[colorscheme tokyonight-moon]])

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "go" }, 
  highlight = {
    enable = true,              
    additional_vim_regex_highlighting = false,
  },
}


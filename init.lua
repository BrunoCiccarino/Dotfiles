vim.cmd [[
call plug#begin('~/.local/share/nvim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'MunifTanjim/nui.nvim'         
Plug 'rcarriga/nvim-notify'          
Plug 'folke/noice.nvim'              

call plug#end()
]]


require("noice").setup({
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

vim.o.background = "dark" 
vim.cmd([[colorscheme gruvbox]])

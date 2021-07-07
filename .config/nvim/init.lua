-- Aliases
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

cmd 'set nocompatible'
cmd 'filetype plugin indent on'
cmd 'syntax on'
cmd 'set nobackup'
cmd 'set nowritebackup'
cmd 'set noswapfile'
cmd 'set background=light'

-- Package Manager
cmd 'packadd paq-nvim'
local paq = require('paq-nvim').paq

paq {'savq/paq-nvim', opt = true}
paq {'nvim-treesitter/nvim-treesitter'}
paq {'neovim/nvim-lspconfig'}
paq {'nvim-lua/popup.nvim'}
paq {'nvim-lua/plenary.nvim'}
paq {'nvim-telescope/telescope.nvim'}
paq {'tpope/vim-fugitive'}
paq {'simrat39/rust-tools.nvim'}
paq {'tpope/vim-surround'}
paq {'terrortylor/nvim-comment'}

---- Package Settings
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    use_languagetree = true,
  },
}

local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<ESC>"] = actions.close,
      },
    },
  }
}

local lsp = require('lspconfig')

lsp.rls.setup{}
lsp.rust_analyzer.setup{}
lsp.ccls.setup{}

require('nvim_comment').setup()

-- Options and Settings
opt.hidden = true
opt.number = true
opt.updatetime = 300
opt.shortmess = 'c'
opt.hlsearch = true
opt.incsearch = true
opt.smartcase = true
opt.showcmd = true
opt.so = 5
opt.smarttab = true
opt.ai = true
opt.si = true
opt.wildmenu = true
opt.guicursor = ""
opt.cursorline = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.splitbelow = true
opt.splitright = true
opt.linebreak = true
opt.textwidth = 80
opt.fo = 'c'

-- Mappings
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('', '<C-n>', ':Telescope git_files<CR>')
map('', '<C-p>', ':Telescope git_files<CR>')
map('', '<C-b>', ':Telescope buffers<CR>')
map('i', '<C-BS>', '<C-W>')
map('', '<C-h>', '<C-W><C-H>')
map('', '<C-j>', '<C-W><C-J>')
map('', '<C-k>', '<C-W><C-K>')
map('', '<C-l>', '<C-W><C-L>')
map('v', '<Tab>', '>gv')
map('v', '<S-Tab>', '<gv')
map('n', '<ESC>', ':noh<CR>')
map('v', '<C-C>', '"+y')
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')

-- Colorscheme
cmd('hi LineNr guifg=darkgray ctermfg=gray')
cmd('hi CursorLineNr guifg=black cterm=bold ctermfg=black')
cmd('hi Comment gui=italic cterm=italic ctermfg=lightgray')
cmd('hi MatchParen guibg=lightgray ctermbg=250')
cmd('hi NonText guifg=white ctermfg=255')
cmd('hi StatusLine guibg=bg guifg=black gui=reverse ctermbg=0 ctermfg=252')
cmd('hi StatusLineNC guibg=bg guifg=black gui=reverse ctermbg=0 ctermfg=254')
cmd('hi VertSplit guifg=white guibg=black cterm=NONE ctermbg=0 ctermfg=15')
cmd('hi Visual ctermbg=253')
cmd('hi ActiveWindow ctermbg=15')
cmd('hi InactiveWindow ctermbg=254')

vim.api.nvim_exec([[
augroup WindowManagement
  autocmd!
  autocmd WinEnter * call Handle_Win_Enter()
augroup END

function! Handle_Win_Enter()
  setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
endfunction
]], true)

-- Don't highlight when sourcing this file
cmd('noh')

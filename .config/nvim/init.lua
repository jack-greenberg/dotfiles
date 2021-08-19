-- Aliases
local cmd = vim.cmd local fn = vim.fn
local g = vim.g
local opt = vim.opt

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
cmd 'set nobackup'
cmd 'set nowritebackup'
cmd 'set noswapfile'
opt.background = 'light'
opt.hidden = true
opt.number = true
opt.updatetime = 300
opt.shortmess = 'c'
opt.smartcase = true
opt.showcmd = true
opt.so = 5
opt.smarttab = true
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
opt.cino = 'l1'

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

-- Colorscheme
cmd('hi LineNr guifg=darkgray ctermfg=darkgray')
cmd('hi CursorLineNr guifg=black cterm=bold ctermfg=white')
cmd('hi Comment gui=italic cterm=italic ctermfg=lightgray')
cmd('hi MatchParen guibg=lightgray ctermbg=darkgray')
cmd('hi NonText guifg=bg ctermfg=0')
cmd('hi StatusLine guibg=bg guifg=black gui=reverse ctermbg=0 ctermfg=15')
cmd('hi StatusLineNC guibg=bg guifg=black gui=reverse ctermbg=0 ctermfg=darkgray')
cmd('hi VertSplit guifg=white guibg=black cterm=NONE ctermbg=0 ctermfg=15')
cmd('hi Visual ctermbg=240')
cmd('hi ActiveWindow ctermbg=0')

vim.api.nvim_exec([[
augroup WindowManagement
  autocmd!
  autocmd WinEnter * call Handle_Win_Enter()
augroup END

function! Handle_Win_Enter()
  setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
endfunction


" when you enter a (new) buffer
augroup set-commentstring-ag
autocmd!
autocmd BufEnter *.cpp,*.h,*.c :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
autocmd BufFilePost *.cpp,*.h,*.c :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")

autocmd BufEnter *.pu,*.puml,*.plantuml :lua vim.api.nvim_buf_set_option(0, "commentstring", "' %s")
autocmd BufFilePost *.pu,*.puml,*.plantuml :lua vim.api.nvim_buf_set_option(0, "commentstring", "' %s")
augroup END
]], true)

-- Don't highlight when sourcing this file
cmd('noh')

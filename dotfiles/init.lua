-- Aliases
local cmd = vim.cmd local fn = vim.fn
local g = vim.g
local opt = vim.opt

vim.api.nvim_exec([[
filetype plugin indent on
]], true)

-- Package Manager
require "paq" {
    'savq/paq-nvim';
    'nvim-treesitter/nvim-treesitter';

    'neovim/nvim-lspconfig';
    'hrsh7th/cmp-nvim-lsp';
    'hrsh7th/cmp-buffer';
    'hrsh7th/cmp-path';
    'hrsh7th/cmp-cmdline';
    'hrsh7th/nvim-cmp';

    'RishabhRD/popfix';
    'RishabhRD/nvim-lsputils';

    'nvim-lua/popup.nvim';
    'nvim-lua/plenary.nvim';
    'nvim-telescope/telescope.nvim';
    'tpope/vim-fugitive';
    'simrat39/rust-tools.nvim';
    'tpope/vim-surround';
    'terrortylor/nvim-comment';
    'ledger/vim-ledger';
    'dracula/vim';

    'ggandor/leap.nvim';

    -- PlantUML
    'aklt/plantuml-syntax';
}

require'leap'.set_default_keymaps()

---- Package Settings
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  textobjects = {
    lsp_interop = {
      enable = true,
      peek_definition_code = {
        ["<C-f>"] = "@function.outer",
      },
    }
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },

}

local actions = require'telescope.actions'
require'telescope'.setup {
  defaults = {
    mappings = {
      i = {
        ["<ESC>"] = actions.close,
      },
    },
  }
}

local lsp = require'lspconfig'

lsp.rust_analyzer.setup{}
lsp.bashls.setup{}

require('nvim_comment').setup({
  hook = function()
    if vim.api.nvim_buf_get_option(0, "filetype") == "c" then
      vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
    end

    if vim.api.nvim_buf_get_option(0, "filetype") == "cpp" then
      vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
    end
  end
})

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

g.mapleader = '\\'
g.tex_flavor = 'latex'
g.vimtex_view_method='zathura'
g.vimtex_quickfix_mode=0
opt.conceallevel = 1
g.tex_conceal='abdmg'
g.vimtex_compiler_method = 'latexmk'
g.vimtex_compiler_latexmk = { 
    build_dir = 'build',
    executable = 'latexmk',
    options = { 
        '-pdf',
        '-shell-escape',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
    },
}

vim.api.nvim_exec([[
augroup set-commentstring-ag

autocmd!
    autocmd FileType tex setlocal fo+=t
augroup END

au BufNewFile,BufRead,BufReadPost *.h set filetype=c

command! Todo vimgrep /TODO/ `git ls-files` | cope

au FileType tex :UltiSnipsAddFiletypes tex
]], true)

-- Don't highlight when sourcing this file
cmd('noh')

cmd("colorscheme dracula")
cmd('hi VertSplit cterm=None ctermbg=NONE guifg=NONE guibg=NONE')
cmd('hi Normal guibg=NONE ctermbg=NONE')
cmd('hi Comment ctermfg=30')
cmd('command! WQ wq')
cmd('command! Wq wq')
cmd('command! W w')
cmd('command! Q q')

-- cmp

vim.api.nvim_exec([[
set completeopt-=preview,menu,noselect,menuone
]], true)
  -- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
snippet = {
  expand = function(args)
    vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
  end,
},
mapping = {
  ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
  ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
  ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
  ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
  ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
  ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
  ['<C-e>'] = cmp.mapping({
    i = cmp.mapping.abort(),
    c = cmp.mapping.close(),
  }),
  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
},
sources = cmp.config.sources({
  { name = 'nvim_lsp' },
  { name = 'ultisnips' }, -- For ultisnips users.
}, {
  { name = 'buffer' },
})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
sources = cmp.config.sources({
  { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
}, {
  { name = 'buffer' },
})
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
sources = {
  { name = 'buffer' }
}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
sources = cmp.config.sources({
  { name = 'path' }
}, {
  { name = 'cmdline' }
})
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- require('lspconfig')['ccls'].setup {
--     capabilities = capabilities
-- }

g.UltiSnipsExpandTrigger = '<tab>'
g.UltiSnipsJumpForwardTrigger = '<c-j>'
g.UltiSnipsJumpBackwardTrigger = '<c-k>'
g.UltiSnipsSnippetDirectories = {'~/.config/nvim/ultisnips'}

if vim.fn.has('nvim-0.5.1') == 1 then
    vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
    vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
    vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
    vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
    vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
    vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
    vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
    vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
else
    local bufnr = vim.api.nvim_buf_get_number(0)

    vim.lsp.handlers['textDocument/codeAction'] = function(_, _, actions)
        require('lsputil.codeAction').code_action_handler(nil, actions, nil, nil, nil)
    end

    vim.lsp.handlers['textDocument/references'] = function(_, _, result)
        require('lsputil.locations').references_handler(nil, result, { bufnr = bufnr }, nil)
    end

    vim.lsp.handlers['textDocument/definition'] = function(_, method, result)
        require('lsputil.locations').definition_handler(nil, result, { bufnr = bufnr, method = method }, nil)
    end

    vim.lsp.handlers['textDocument/declaration'] = function(_, method, result)
        require('lsputil.locations').declaration_handler(nil, result, { bufnr = bufnr, method = method }, nil)
    end

    vim.lsp.handlers['textDocument/typeDefinition'] = function(_, method, result)
        require('lsputil.locations').typeDefinition_handler(nil, result, { bufnr = bufnr, method = method }, nil)
    end

    vim.lsp.handlers['textDocument/implementation'] = function(_, method, result)
        require('lsputil.locations').implementation_handler(nil, result, { bufnr = bufnr, method = method }, nil)
    end

    vim.lsp.handlers['textDocument/documentSymbol'] = function(_, _, result, _, bufn)
        require('lsputil.symbols').document_handler(nil, result, { bufnr = bufn }, nil)
    end

    vim.lsp.handlers['textDocument/symbol'] = function(_, _, result, _, bufn)
        require('lsputil.symbols').workspace_handler(nil, result, { bufnr = bufn }, nil)
    end
end

-- Mappings
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<C-n>', ':Telescope find_files<CR>')
map('n', '<C-p>', ':Telescope git_files<CR>')
map('n', '<C-b>', ':Telescope buffers<CR>')
map('i', '<C-BS>', '<C-W>')
map('', '<C-h>', '<C-W><C-H>')
map('', '<C-j>', '<C-W><C-J>')
map('', '<C-k>', '<C-W><C-K>')
map('', '<C-l>', '<C-W><C-L>')
map('n', '<ESC>', ':noh<CR>')
map('v', '<C-C>', '"+y')
map('n', 'HL', ':HopLineStart<CR>')
map('n', 'HW', ':HopWord<CR>')
map('n', '<C-d>', ':bd<CR>')
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('v', '<Tab>', '>gv')
map('v', '<S-Tab>', '<gv')

opt.foldmethod= 'expr'
opt.foldexpr='nvim_treesitter#foldexpr()'
opt.foldlevel = 20

opt.mouse=''

vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]

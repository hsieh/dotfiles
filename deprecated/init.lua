-------------------- PACKAGE MANAGER -----------------------
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd[[packadd packer.nvim]]
end
-------------------- PLUGINS -------------------------------
require'packer'.startup(function()
  use 'wbthomason/packer.nvim'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'elixir-editors/vim-elixir'
  -- use 'jnurmine/zenburn'
  -- use 'junegunn/seoul256.vim'
  use 'kassio/neoterm'
  use 'morhetz/gruvbox'
  use 'neovim/nvim-lspconfig'
  use 'mhinz/vim-startify'
  use {
    'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'},
    config = function() require('gitsigns').setup() end
  }
  use 'hrsh7th/nvim-compe'
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
end)

-------------------- OPTIONS -------------------------------
vim.o.compatible = false
vim.o.number = true
vim.o.autochdir = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.colorcolumn='80,120'
vim.o.cursorline = false
vim.o.cursorcolumn = false
vim.o.showcmd = true
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 0
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.autoindent = true
vim.o.scrolloff = 0
vim.o.textwidth = 0
vim.o.ttyfast = true
vim.o.lazyredraw = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.encoding = 'UTF-8'
vim.o.timeout = false
vim.o.ttimeout = false
vim.o.showtabline = 0
vim.o.showmode = true
vim.o.hidden = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.updatetime = 300
vim.o.signcolumn='yes'
-- vim.o.completeopt = "menuone,noselect"
-- set shortmess+=c

--
vim.cmd[[colorscheme gruvbox]]
vim.g.colors_name = 'gruvbox'
-- vim.g.airline_theme = 'seoul256'
vim.g.maplocalleader = ','

vim.api.nvim_set_keymap('n', '<localleader>f', ':Telescope find_files theme=get_ivy<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<localleader>r', ':Telescope live_grep theme=get_ivy<cr>',  {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<localleader>g', ':Telescope current_buffer_fuzzy_find theme=get_ivy<cr>',  {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<localleader>b', ':Telescope buffers theme=get_ivy<cr>',    {noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '__',    ':bp<cr>',       {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<c-p>', ':wincmd k<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<c-n>', ':wincmd j<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<c-k>', ':wincmd c<cr>', {noremap = true, silent = true})

vim.api.nvim_set_keymap('v', 'w', 'vvw', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', 'b', 'vvb', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', 'e', 'vve', {noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<space>q', 'q:i', {noremap = true, silent = true})

-- telescope
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

-- lsp
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gK', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

require'lspconfig'.elixirls.setup{
  cmd = {"/home/yatung/w/elixir-ls/release/language_server.sh"};
  on_attach = on_attach
}

require'lspconfig'.gopls.setup{ on_attach = on_attach }

require'lspconfig'.rust_analyzer.setup{ on_attach = on_attach }

-- compe
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}

-- gitsigns
require('gitsigns').setup()

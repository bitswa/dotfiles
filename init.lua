-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8

-- Identation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Search settings
vim.opt.ignorecase = true     -- Case insensitive search
vim.opt.smartcase = true      -- Case sensitive if uppercase in search
vim.opt.hlsearch = true       -- Don't highlight search result
vim.opt.incsearch = true      -- Show matches as you type

-- Visual settings
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "100"
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.cmdheight = 1
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.showmode = true


vim.opt.textwidth = 80
vim.o.laststatus = 2
vim.diagnostic.config({ virtual_text = true })


-- KEYMAPS
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", {silent = true})

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- New Tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- DIAGNOSTICS (TROUBLE)
keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>")
keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>")
keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>")
keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>")
keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>")
keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>")

-- PACKAGES 
local base = "https://github.com/"

vim.pack.add({
  base .. "nvim-tree/nvim-web-devicons",
  base .. "nvim-lualine/lualine.nvim",
  base .. "projekt0n/github-nvim-theme",
  base .. "datsfilipe/vesper.nvim",
  base .. "nvim-treesitter/nvim-treesitter",
  base .. "rafamadriz/friendly-snippets",
  base .. "saghen/blink.cmp",
  base .. "neovim/nvim-lspconfig",
  base .. "mason-org/mason.nvim",
  base .. "mason-org/mason-lspconfig.nvim",
  base .. "WhoIsSethDaniel/mason-tool-installer.nvim",
  base .. "nvim-mini/mini.move",
  base .. "L3MON4D3/LuaSnip",
  base .. "rafamadriz/friendly-snippets",
  base .. "nvim-lua/plenary.nvim",
  base .. "nvim-telescope/telescope-file-browser.nvim",
  -- base .. "akinsho/bufferline.nvim",
  base .. "alvarosevilla95/luatab.nvim",
  --{ src = base .. "nvim-telescope/telescope-fzf-native.nvim", build = "make"},
  base .. "nvim-telescope/telescope.nvim",
  base .. "folke/trouble.nvim",
  base .. "folke/which-key.nvim",
  base .. "ya2s/nvim-cursorline"

}, { confirm = false })

-- Cursorline

require('nvim-cursorline').setup {
  disable_filetypes = {},
  disable_buftypes = {},
  cursorline = {
    enable = true,
    timeout = 1000,
    number = false
  },
  cursorword = {
    enable = true,
    min_length = 3,
    hl = { underline = true }
  }
}

require("nvim-treesitter.install").update("all")
require("nvim-treesitter.config").setup({ auto_install = true })

-- WHICH-KEY

-- TROUBLE
require("trouble").setup({})

-- COLORSCHEME
--vim.cmd("colorscheme github_dark_colorblind")
vim.cmd("colorscheme vesper")

require("vesper").setup({
  transparent = false,
})

-- Luatab
--require("luatab").setup({})

-- BUFFERLINE
-- require("bufferline").setup{
--   highlights = require("vesper").bufferline.highlights
-- }
--
-- local bufferline = require('bufferline')
-- bufferline.setup({
--     options = {
--         style_preset = {
--             bufferline.style_preset.minimal,
--             bufferline.style_preset.no_italic,
--             bufferline.style_preset.no_bold
--         },
--     }
-- })

-- LUALINE
require("configs.lualine")

-- BLINK
require("blink.cmp").setup({
  fuzzy = { implementation = "lua" },
  keymap = {
    preset = "default",
    ["<Up>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_prev", "fallback" },
    ["<C-space>"] = { function(cmp) cmp.show({ providers = { "snippets" } }) end },
  },
  completion = {
    accept = {
      dot_repeat = true,
      auto_brackets = {
        enabled = true,
        semantic_token_resolution = {
          enabled = true,
          timeout_ms = 400,
        },
      },
    },
  },
})

require("mini.move").setup()
require("luasnip.loaders.from_vscode").lazy_load()

-- TELESCOPE
local builtin = require('telescope.builtin')
--vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set("n", "<leader>ff", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")

local fb_actions = require "telescope".extensions.file_browser.actions

require("telescope").setup {
  defaults = {},
  extensions = {
    file_browser = {
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          ["<C-h>"] = fb_actions.goto_home_dir,
          ["<C-a>"] = fb_actions.create,
        },
      },
    },
    --[[
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    ]]
  },
  pickers = {
    find_files = {
      theme = "dropdown",
    },
  },
}
--require("telescope").load_extension("fzf")


-- MASON & LSP
-- local lsp_servers = {
--   lua_ls = { Lua = { workspace = { library = vim.api.nvim_get_runtime_file("lua", true) } }, },
-- }

require("mason").setup()
require("mason-lspconfig").setup({
  automatic_enable = true
})
--require("mason-tool-installer").setup({
--  ensure_installed = vim.tbl_keys(lsp_servers),
--})
--
-- for server, config in pairs(lsp_servers) do
--   vim.lsp.config(server, {
--     settings = config,
--
--     on_attach = function(_, bufnr)
--       vim.keymap.set("n", "grd", vim.lsp.buf.definition, { buffer = bufnr })
--     end,
--   })
-- end

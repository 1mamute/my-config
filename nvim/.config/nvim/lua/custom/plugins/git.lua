local gitsigns = {
  -- https://www.lazyvim.org/plugins/editor#gitsignsnvim
  -- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
  "lewis6991/gitsigns.nvim",
  lazy = false, -- dont lazy load important ui elements
  branch = "main",
  opts = {
    signs = {
      add          = { text = '│' },
      change       = { text = '│' },
      delete       = { text = '│' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
    },
    numhl = true, -- highlight changed lines numbers
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

      -- -- stylua: ignore start
      -- map("n", "]h", gs.next_hunk, "next [h]unk")
      -- map("n", "[h", gs.prev_hunk, "prev [h]unk")
      -- map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", "[g]it [h]unk [s]tage hunk")
      -- map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", "[g]it [h]unk [r]eset hunk")
      -- map("n", "<leader>hS", gs.stage_buffer, "[g]it [h]unks [S]tage buffer")
      -- map("n", "<leader>hu", gs.undo_stage_hunk, "[g]it [h]unks [u]ndo stage hunk")
      -- map("n", "<leader>hR", gs.reset_buffer, "[g]it [h]unk [R]eset buffer")
      -- map("n", "<leader>hp", gs.preview_hunk_inline, "[g]it [h]unk [p]review hunk inline")
      -- map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "[g]it [h]unk [b]lame line")
      -- map("n", "<leader>hd", gs.diffthis, "[g]it [h]unk [d]iff this")
      -- map("n", "<leader>hD", function() gs.diffthis("~") end, "[g]it [h]unk [D]iff this ~")
    end,
  },
}

local neogit = {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- Diff integration
    "nvim-telescope/telescope.nvim", -- optional
  },
  keys = {
    { "<leader>tg", "<cmd>Neogit<cr>", desc = "Neogit", mode = "n" },
  },
  config = function()
    require('neogit').setup()
  end
}

return {
  neogit,
  gitsigns,
}

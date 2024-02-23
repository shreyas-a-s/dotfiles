return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    -- document existing key chains
    require("which-key").register({
      ["<leader>c"] = { name = "Code", _ = "which_key_ignore" },
      ["<leader>d"] = { name = "Document", _ = "which_key_ignore" },
      ["<leader>g"] = { name = "Git", _ = "which_key_ignore" },
      ["<leader>h"] = { name = "Git Hunk", _ = "which_key_ignore" },
      ["<leader>r"] = { name = "Rename", _ = "which_key_ignore" },
      ["<leader>f"] = { name = "Find", _ = "which_key_ignore" },
      ["<leader>t"] = { name = "Toggle", _ = "which_key_ignore" },
      ["<leader>w"] = { name = "Workspace", _ = "which_key_ignore" },
    })
    -- register which-key VISUAL mode
    -- required for visual <leader>hs (hunk stage) to work
    require("which-key").register({
      ["<leader>"] = { name = "VISUAL <leader>" },
      ["<leader>h"] = { "Git hunk" },
    }, { mode = "v" })
  end,
}

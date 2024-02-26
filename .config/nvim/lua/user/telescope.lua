local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
    { "nvim-telescope/telescope-ui-select.nvim",  lazy = true },
  },
}

function M.config()
  require("which-key").register({
    ["<leader>bb"] = { "<CMD>Telescope buffers<CR>", "Buffers" },
    ["<leader>fb"] = { "<CMD>Telescope git_branches<CR>", "Checkout branch" },
    ["<leader>ff"] = { "<CMD>Telescope find_files<CR>", "Find files" },
    ["<leader>fp"] = { "<CMD>Telescope projects theme=dropdown<CR>", "Projects" },
    ["<leader>ft"] = { "<CMD>Telescope live_grep<CR>", "Find Text" },
    ["<leader>fh"] = { "<CMD>Telescope help_tags<CR>", "Help" },
    ["<leader>fc"] = { "<CMD>Telescope colorscheme<CR>", "Colorscheme" },
    ["<leader>fr"] = { "<CMD>Telescope oldfiles<CR>", "Recent Files" },
  })

  local icons = require("user.icons")

  require("telescope").setup({
    defaults = {
      prompt_prefix = " " .. icons.ui.ChevronRight .. " ",
      selection_caret = " " .. icons.ui.ChevronRight .. " ",
      entry_prefix = "   ",
      initial_mode = "insert",
      selection_strategy = "reset",
      path_display = { "smart" },
      color_devicons = true,
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
      },
    },
    pickers = {
      find_files = {
        theme = "dropdown",
        previewer = false,
        find_command = {
          "rg",
          "--hidden",
          "--files",
          "--glob=!.git/",
        },
      },

      oldfiles = {
        theme = "dropdown",
        previewer = false,
      },

      live_grep = {
        theme = "dropdown",
        previewer = false,
      },

      git_branches = {
        theme = "dropdown",
        previewer = false,
      },

      buffers = {
        theme = "dropdown",
        previewer = false,
        mappings = {
          i = {
            ["dd"] = require("telescope.actions").delete_buffer,
          },
        },
      },

      colorscheme = {
        theme = "dropdown",
        enable_preview = true,
      },

      lsp_references = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_definitions = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_declarations = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_implementations = {
        theme = "dropdown",
        initial_mode = "normal",
      },
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({}),
      },
    },
  })

  pcall(require("telescope").load_extension, "ui-select")
  pcall(require("telescope").load_extension, "fzf")
  pcall(require("telescope").load_extension, "projects")
end

return M

local M = {
	"catgoose/nvim-colorizer.lua",
	event = { "BufReadPre" },
}

function M.config()
  require("colorizer").setup({
    filetypes = {
      "typescript",
      "typescriptreact",
      "javascript",
      "javascriptreact",
      "css",
      "html",
      "astro",
      "lua",
    },
    user_default_options = {
      rgb_fn = true,
      hsl_fn = true,
    },
  })
end

return M

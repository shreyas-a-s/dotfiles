local M = {
  "kevinhwang91/nvim-bqf",
  event = "VeryLazy",
}

function M.config()
  require("bqf").setup({
    func_map = {
      tab = "t",
      openc = "o",
      drop = "O",
      split = "s",
      vsplit = "v",
      stoggleup = "M",
      stoggledown = "m",
      stogglevm = "m",
      filterr = "f",
      filter = "F",
      prevhist = "<",
      nexthist = ">",
      sclear = "c",
      ptoggleitem = "p",
      ptoggleauto = "a",
      ptogglemode = "P",
    },
  })
end

return M

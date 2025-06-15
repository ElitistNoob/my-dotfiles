return {
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        config = function()
          vim.notify = require("notify")
          vim.keymap.set("n", "<leader>nh", function()
            require("notify").history()
          end, { desc = "View notification history" })
        end,
      },
    },
    opts = {},
  },
}

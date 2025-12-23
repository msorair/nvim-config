return {
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = 'light',
        colors = {
          yellow = '#ffb662',
          bg0 = '#F7F7F7'
        },
      }
      require('onedark').load()
    end
  },
  {
    "mvllow/modes.nvim",
    event = "VeryLazy",
    opts = {
      colors = {
        insert = "#c3e88d",
        replace = "#ff757f",
        visual = "#c099ff",
      },
      line_opacity = 0.15,
    },
  },
}

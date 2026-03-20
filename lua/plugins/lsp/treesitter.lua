return {
  {
    "nvim-treesitter/nvim-treesitter",
    commit = "42fc28ba918343ebfd5565147a42a26580579482",
    pin = true,
    build = ":TSUpdate",
    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      require "nvim-treesitter.query_predicates"
    end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
      { "<c-space>", desc = "Increment Selection", mode = { "n", "x" } },
      { "<bs>", desc = "Decrement Selection", mode = "x" },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    commit = "5ca4aaa6efdcc59be46b95a3e876300cfead05ef",
    pin = true,
    event = { "LazyFile", "BufAdd" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      ---@type TSConfig
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup {
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = "<TAB>",
            node_decremental = "<bs>",
          },
        },
        ensure_installed = require("config.language").treesitter,
        textobjects = {
          swap = {
            enable = true,
            swap_next = {
              [">a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<a"] = "@parameter.inner",
            },
          },
          select = {
            enable = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
              ["]a"] = "@parameter.inner",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]C"] = "@class.outer",
              ["]A"] = "@parameter.inner",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
              ["[a"] = "@parameter.inner",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[C"] = "@class.outer",
              ["[A"] = "@parameter.inner",
            },
          },
        },
      }
    end,
  },
}

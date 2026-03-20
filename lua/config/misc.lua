local toggles = require("utils.format")

toggles.format:map("<leader>uf")
toggles.format_global:map("<leader>uF")

require("utils.cliapend").setup({ keymap = { paste_prefix = "g" } })

vim.api.nvim_set_hl(0, "DapStopped", { fg = "#ff9d1c" })

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpointCondition" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpointRejected" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped" })

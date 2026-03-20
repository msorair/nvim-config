return {
  formatter = "clang-format",
  plugins = { "p00f/clangd_extensions.nvim", lazy = true },
  lsp = "clangd",
  dap = {
    adapters = {
      cppdbg = {
        type = 'executable',
        command = '/usr/bin/lldb-dap',
        options = { detached = false }
      }
    },
    configurations = {
      cpp = {
        {
          name = "Launch file",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopAtEntry = true,
          args = {},
          -- runInTerminal = true,
        },
      }
    }
  }
}

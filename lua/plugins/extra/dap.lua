return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      local ui = require "dapui"

      dap.listeners.before.attach.dapui_config = function() ui.open() end
      dap.listeners.before.launch.dapui_config = function() ui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() ui.close() end
      dap.listeners.before.event_exited.dapui_config = function() ui.close() end

      dap.defaults.fallback.external_terminal = {
        command = "/usr/bin/kitty",
        args = {
          "--class",
          "kitty-dap",
          "--hold",
          "--detach",
          "nvim-dap",
          "-c",
          "DAP",
        },
      }

      dap.adapters.lldb = {
        type = "executable",
        command = "lldb-dap",
        name = "lldb",
      }
      dap.configurations.cpp = {
        {
          name = "Launch",
          type = "lldb",
          request = "launch",
          program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = function()
            local args_string = vim.fn.input "Arguments: "
            return vim.split(args_string, " ")
          end,
        },
      }

      ---@diagnostic disable-next-line: undefined-field
      require("overseer").enable_dap(true)
    end,
    keys = {
      {
        "<F5>",
        function() require("dap").continue() end,
        desc = "Debug: Continue",
      },
      {
        "<S-F5>",
        function() require("dap").terminate() end,
        desc = "Debug: Terminate",
      },
      {
        "<F10>",
        function() require("dap").step_over() end,
        desc = "Debug: Step over",
      },
      {
        "<F11>",
        function() require("dap").step_into() end,
        desc = "Debug: Step into",
      },
      {
        "<S-F11>",
        function() require("dap").step_out() end,
        desc = "Debug: Step out",
      },
      {
        "<F9>",
        function() require("dap").toggle_breakpoint() end,
        desc = "Debug: Toggle breakpoint",
      },
      {
        "<leader>dp",
        function()
          local condition = vim.fn.input "Breakpoint condition: "
          if condition == "" then return end
          require("dap").set_breakpoint(condition)
        end,
        desc = "Set Condition Breakpoint",
      },
      {
        "<leader>dP",
        function() require("dap").repl.toggle() end,
        desc = "Toggle REPL",
      },
      {
        "<leader>dl",
        function() require("dap").run_last() end,
        desc = "Run last",
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function() require("dapui").setup() end,
    keys = {
      {
        "<C-S-d>",
        function() require("dapui").toggle() end,
        desc = "toggle dap ui",
      },
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      local opts = {
        enable = true,
        enable_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        clear_on_continue = false,
        --- A callback that determines how a variable is displayed or whether it should be omitted
        --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
        --- @param buf number
        --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
        --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
        --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
        --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
        display_callback = function(variable, buf, stackframe, node, options)
          -- by default, strip out new line characters
          if options.virt_text_pos == "inline" then
            return " = " .. variable.value:gsub("%s+", " ")
          else
            return variable.name .. " = " .. variable.value:gsub("%s+", " ")
          end
        end,
        -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
        virt_text_pos = "inline",

        -- experimental features:
        all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
        virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
        -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
      }
      require("nvim-dap-virtual-text").setup(opts)
    end,
  },
}

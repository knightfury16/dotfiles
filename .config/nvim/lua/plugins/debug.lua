return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    require("dapui").setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = { "/Users/suhaibknight/.config/nvim/lua/debugadapters/node/js-debug/src/dapDebugServer.js", "${port}" },
      },
    }

    dap.adapters.coreclr = {
      type = "executable",
      command = "/Users/suhaibknight/.config/nvim/lua/debugadapters/netcoredbg/netcoredbg",
      args = { "--interpreter=vscode" },
    }

    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch -netcoredbg",
        request = "launch",
        program = function()
          -- Get path from env variable or use a default
          local dll_path = os.getenv("DOTNET_DEBUG_DLL")
          print("DOTNET_DEBUG_DLL:", dll_path)

          if not dll_path or dll_path == "" then
            -- If env variable is not set, use project structure to find the DLL
            local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            local default_path = vim.fn.getcwd() .. "/bin/Debug/net8.0/" .. project_name .. ".dll"
            print("DOTNET_DEBUG_DLL From second:", default_path)

            -- Check if the default path exists
            if vim.fn.filereadable(default_path) == 1 then
              return default_path
            else
              -- Fall back to prompting if we can't find it automatically
              return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
            end
          else
            return dll_path
          end
        end,
        env = {
          ASPNETCORE_ENVIRONMENT = "Development",
          DOTNET_URLS = "http://localhost:5151",
        },
      },
    }

    dap.configurations.javascript = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch File",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
    }
  end,
}

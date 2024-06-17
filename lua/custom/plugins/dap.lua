return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
    },
    config = function()
      local dap = require 'dap'
      local ui = require 'dapui'

      require('dapui').setup()

      -- require('nvim-dap-virtual-text').setup {
      --   -- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
      --   display_callback = function(variable)
      --     local name = string.lower(variable.name)
      --     local value = string.lower(variable.value)
      --     if name:match 'secret' or name:match 'api' or value:match 'secret' or value:match 'api' then
      --       return '*****'
      --     end
      --
      --     if #variable.value > 15 then
      --       return ' ' .. string.sub(variable.value, 1, 15) .. '... '
      --     end
      --
      --     return ' ' .. variable.value
      --   end,
      -- }

      -- Handled by nvim-dap-go
      -- dap.adapters.go = {
      --   type = "server",
      --   port = "${port}",
      --   executable = {
      --     command = "dlv",
      --     args = { "dap", "-l", "127.0.0.1:${port}" },
      --   },
      -- }
      --
      dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
          command = '/home/dev/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb', -- Adjust the path to your lldb-vscode
          args = { '--port', '${port}' },
        },
        name = 'codelldb',
      }

      dap.configurations.cpp = {
        {
          name = 'Launch',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
          env = {
            DS4_PATH = function()
              return '$(pwd)/../home'
            end,
            DS4_APPLICATION_DIRECTORY = function()
              return '$(pwd)/build/bin/Debug'
            end,
            USAGE_STATISTIC_ACTIVE = function()
              return 'false'
            end,
            DS_OPENTELEMETRY_TRACES_URL = function()
              return 'https://otelcol.ds4.damp.local/v1/traces'
            end,
            DS_OPENTELEMETRY_METRICS_URL = function()
              return 'https://otelcol.ds4.damp.local/v1/metrics'
            end,
            PGHOST = function()
              return 'localhost'
            end,
            PGDATABASE = function()
              return 'ds4'
            end,
            PGUSER = function()
              return 'postgres'
            end,
            PGPASSWORD = function()
              return 'test'
            end,
            DS_UPDATE_ACCEPT_DEV_KEYS = function()
              return '1'
            end,
            DS_MFA_SERVER_URL = function()
              return 'https://ds4-dev-local.damp.local:443'
            end,
            OPENSSL_MODULES = function()
              return '$(pwd)/build/bin/ossl-modules'
            end,
            EASYTI_HOST = function()
              return 'ds4-dev-local-easyti.damp.local'
            end,
            DISABLE_SOLVI_JOB = function()
              return '1'
            end,
            LICENSE_SETUP_TOKEN = function()
              return ''
            end,
            LICENSE_SERVER_HOST = function()
              return 'ds4-lizenz.ds4.damp.local'
            end,
            DS_WIREGUARD_URL = function()
              return 'https://localhost'
            end,
            DS_EASYTI_MANAGER_URL = function()
              return 'https://ds4-dev-local.damp.local'
            end,
            IMPORT_TRANSFER_DISABLE_BACKUP = function()
              return '1'
            end,
            IMPORT_TRANSFER_SIMULATE_SHUTDOWN = function()
              return '1'
            end,
            DS_SOLR_URL = function()
              return 'http://localhost:8983/solr'
            end,
            DS_USE_LOW_AUTH_SECURITY_SETTINGS = function()
              return 'true'
            end,
            HTML_SANITIZER = function()
              return ''
            end,
            DS_SKIP_HILFE_INDEX = function()
              return '1'
            end,
            -- Add more environment variables as needed
          },
          -- Additional configurations to avoid breaking on exceptions
          -- setupCommands = {
          --   {
          --     text = '-interpreter-exec console "catch throw"',
          --   },
          --   {
          --     text = '-interpreter-exec console "catch throw enable no"',
          --   },
          -- },
        },
      }

      -- local elixir_ls_debugger = vim.fn.exepath 'elixir-ls-debugger'
      -- if elixir_ls_debugger ~= '' then
      --   dap.adapters.mix_task = {
      --     type = 'executable',
      --     command = elixir_ls_debugger,
      --   }
      --
      --   dap.configurations.elixir = {
      --     {
      --       type = 'mix_task',
      --       name = 'phoenix server',
      --       task = 'phx.server',
      --       request = 'launch',
      --       projectDir = '${workspaceFolder}',
      --       exitAfterTaskReturns = false,
      --       debugAutoInterpretAllModules = false,
      --     },
      --   }
      -- end

      vim.keymap.set('n', '<space>b', dap.toggle_breakpoint)
      vim.keymap.set('n', '<space>gb', dap.run_to_cursor)

      -- Eval var under cursor
      vim.keymap.set('n', '<space>?', function()
        require('dapui').eval(nil, { enter = true })
      end)

      vim.keymap.set('n', '<F1>', dap.continue)
      vim.keymap.set('n', '<F2>', dap.step_into)
      vim.keymap.set('n', '<F3>', dap.step_over)
      vim.keymap.set('n', '<F4>', dap.step_out)
      vim.keymap.set('n', '<F5>', dap.step_back)
      vim.keymap.set('n', '<F13>', dap.restart)

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}

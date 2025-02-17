-- return {
--   'mfussenegger/nvim-dap',
--   dependencies = {
--     'rcarriga/nvim-dap-ui',
--     'theHamsta/nvim-dap-virtual-text',
--     'nvim-neotest/nvim-nio',
--     'williamboman/mason.nvim',
--   },
--   config = function()
--     local dap = require 'dap'
--     local dapui = require 'dapui'
--
--     -- DAP UI setup
--     dapui.setup {
--       layouts = {
--         {
--           elements = {
--             { id = 'scopes', size = 0.25 },
--             { id = 'breakpoints', size = 0.25 },
--             { id = 'stacks', size = 0.25 },
--             { id = 'watches', size = 0.25 },
--           },
--           position = 'left',
--           size = 60,
--         },
--         {
--           elements = {
--             { id = 'repl', size = 0.25 },
--             { id = 'console', size = 0.75 },
--           },
--           position = 'bottom',
--           size = 30,
--         },
--       },
--       mappings = {
--         expand = { '<CR>', '<2-LeftMouse>' },
--         open = 'o',
--         remove = 'd',
--         edit = 's',
--         repl = 'r',
--         toggle = 't',
--       },
--     }
--
--     -- Automatically open dapui when debugging starts
--     dap.listeners.after.event_initialized['dapui_config'] = function()
--       dapui.open()
--     end
--     dap.listeners.before.event_terminated['dapui_config'] = function()
--       local current_config = dap.session().config
--       if current_config.name ~= 'DS4 Tests' then
--         dapui.close()
--       end
--     end
--     -- dap.listeners.before.event_exited['dapui_config'] = function()
--     --   dapui.close()
--     -- end
--
--     -- Configure cpp adapter
--     dap.adapters.codelldb = {
--       type = 'server',
--       port = '${port}',
--       executable = {
--         command = vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension/adapter/codelldb',
--         args = { '--port', '${port}' },
--       },
--     }
--
--     -- Configure cpp debugging
--     dap.configurations.cpp = {
--       {
--         name = 'Launch file',
--         type = 'codelldb',
--         request = 'launch',
--         program = function()
--           return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--         end,
--         cwd = '${workspaceFolder}',
--         stopOnEntry = false,
--         -- args = function()
--         --   local args_string = vim.fn.input 'Arguments: '
--         --   return vim.split(args_string, ' ')
--         -- end,
--         env = {
--           DS4_PATH = '/home/dev/ds4/ds4/home',
--           DS4_APPLICATION_DIRECTORY = '/home/dev/ds4/ds4/git/build/bin/Debug',
--           USAGE_STATISTIC_ACTIVE = 'false',
--           DS_OPENTELEMETRY_TRACES_URL = 'https://otelcol.ds4.damp.local/v1/traces',
--           DS_OPENTELEMETRY_METRICS_URL = 'https://otelcol.ds4.damp.local/v1/metrics',
--           PGHOST = 'localhost',
--           PGDATABASE = 'ds4',
--           PGUSER = 'postgres',
--           PGPASSWORD = 'test',
--           DS_UPDATE_ACCEPT_DEV_KEYS = '1',
--           DS_MFA_SERVER_URL = 'https://ds4-dev-local.damp.local:443',
--           OPENSSL_MODULES = '/home/dev/ds4/ds4/git/build/bin/ossl-modules',
--           EASYTI_HOST = 'ds4-dev-local-easyti.damp.local',
--           DISABLE_SOLVI_JOB = '1',
--           LICENSE_SETUP_TOKEN = '',
--           LICENSE_SERVER_HOST = 'ds4-lizenz.ds4.damp.local',
--           DS_WIREGUARD_URL = 'https://localhost',
--           DS_EASYTI_MANAGER_URL = 'https://ds4-dev-local.damp.local',
--           IMPORT_TRANSFER_DISABLE_BACKUP = '1',
--           IMPORT_TRANSFER_SIMULATE_SHUTDOWN = '1',
--           DS_SOLR_URL = 'http://localhost:8983/solr',
--           DS_USE_LOW_AUTH_SECURITY_SETTINGS = 'true',
--           HTML_SANITIZER = '',
--           DS_SKIP_HILFE_INDEX = '1',
--         },
--       },
--       {
--         name = 'DS4 Tests',
--         type = 'codelldb',
--         request = 'launch',
--         program = '/home/dev/ds4/ds4/git/build/bin/ds4b-tests-app-ds4',
--         cwd = '${workspaceFolder}',
--         stopOnEntry = false,
--         args = function()
--           local test_pattern = vim.fn.input 'Test pattern (--only=): '
--           if test_pattern ~= '' then
--             return { '--only=' .. test_pattern, '--reporter=singleline' }
--           else
--             return { '--reporter=singleline' }
--           end
--         end,
--         env = {
--           DS4_PATH = '/home/dev/ds4/ds4/home',
--           DS4_APPLICATION_DIRECTORY = '/home/dev/ds4/ds4/git/build/bin/Debug',
--           USAGE_STATISTIC_ACTIVE = 'false',
--           DS_OPENTELEMETRY_TRACES_URL = 'https://otelcol.ds4.damp.local/v1/traces',
--           DS_OPENTELEMETRY_METRICS_URL = 'https://otelcol.ds4.damp.local/v1/metrics',
--           PGHOST = 'localhost',
--           PGDATABASE = 'ds4',
--           PGUSER = 'postgres',
--           PGPASSWORD = 'test',
--           DS_UPDATE_ACCEPT_DEV_KEYS = '1',
--           DS_MFA_SERVER_URL = 'https://ds4-dev-local.damp.local:443',
--           OPENSSL_MODULES = '/home/dev/ds4/ds4/git/build/bin/ossl-modules',
--           EASYTI_HOST = 'ds4-dev-local-easyti.damp.local',
--           DISABLE_SOLVI_JOB = '1',
--           LICENSE_SETUP_TOKEN = '',
--           LICENSE_SERVER_HOST = 'ds4-lizenz.ds4.damp.local',
--           DS_WIREGUARD_URL = 'https://localhost',
--           DS_EASYTI_MANAGER_URL = 'https://ds4-dev-local.damp.local',
--           IMPORT_TRANSFER_DISABLE_BACKUP = '1',
--           IMPORT_TRANSFER_SIMULATE_SHUTDOWN = '1',
--           DS_SOLR_URL = 'http://localhost:8983/solr',
--           DS_USE_LOW_AUTH_SECURITY_SETTINGS = 'true',
--           HTML_SANITIZER = '',
--           DS_SKIP_HILFE_INDEX = '1',
--         },
--       },
--     }
--
--     -- Keymaps
--     vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Toggle [b]reakpoint' })
--     vim.keymap.set('n', '<leader>gb', dap.run_to_cursor, { desc = 'Run to cursor' })
--     vim.keymap.set('n', '<leader>gp', dap.up, { desc = '[G]o stack u[p]' })
--     vim.keymap.set('n', '<leader>gn', dap.down, { desc = '[G]o stack dow[n]' })
--     vim.keymap.set('n', '<space>?', function()
--       require('dapui').eval(nil, { enter = true })
--     end)
--     vim.keymap.set('n', '<F1>', dap.continue)
--     vim.keymap.set('n', '<F2>', dap.step_into)
--     vim.keymap.set('n', '<F3>', dap.step_over)
--     vim.keymap.set('n', '<F4>', dap.step_out)
--     vim.keymap.set('n', '<F5>', dap.step_back)
--     vim.keymap.set('n', '<F7>', dap.restart)
--
--     -- Additional helpful keymaps
--     vim.keymap.set('n', '<leader>dt', dapui.toggle, { desc = '[D]ebug UI [T]oggle' })
--     vim.keymap.set('n', '<leader>dx', function()
--       dap.terminate()
--       dapui.close()
--     end, { desc = '[D]ebug Stop/[X]it' })
--   end,
-- }

local function define_colors()
  vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#b91c1c' })
  vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef' })
  vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bold = true })

  vim.fn.sign_define('DapBreakpoint', {
    text = '🔴',
    numhl = 'DapBreakpoint',
  })
  vim.fn.sign_define('DapBreakpointCondition', {
    text = '🔴',
    linehl = 'DapBreakpoint',
    numhl = 'DapBreakpoint',
  })
  vim.fn.sign_define('DapBreakpointRejected', {
    text = '🔘',
    linehl = 'DapBreakpoint',
    numhl = 'DapBreakpoint',
  })
  vim.fn.sign_define('DapStopped', {
    text = '🟢',
    linehl = 'DapStopped',
    numhl = 'DapStopped',
  })
  vim.fn.sign_define('DapLogPoint', {
    text = '🟣',
    linehl = 'DapLogPoint',
    numhl = 'DapLogPoint',
  })
end

local function setup_default_configurations()
  local dap = require 'dap'
  local default_lldb_config = {
    name = 'Launch file',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    env = {
      DS4_PATH = '/home/dev/ds4/ds4/home',
      DS4_APPLICATION_DIRECTORY = '/home/dev/ds4/ds4/git/build/bin/Debug',
      USAGE_STATISTIC_ACTIVE = 'false',
      DS_OPENTELEMETRY_TRACES_URL = 'https://otelcol.ds4.damp.local/v1/traces',
      DS_OPENTELEMETRY_METRICS_URL = 'https://otelcol.ds4.damp.local/v1/metrics',
      PGHOST = 'localhost',
      PGDATABASE = 'ds4',
      PGUSER = 'postgres',
      PGPASSWORD = 'test',
      DS_UPDATE_ACCEPT_DEV_KEYS = '1',
      DS_MFA_SERVER_URL = 'https://ds4-dev-local.damp.local:443',
      OPENSSL_MODULES = '/home/dev/ds4/ds4/git/build/bin/ossl-modules',
      EASYTI_HOST = 'ds4-dev-local-easyti.damp.local',
      DISABLE_SOLVI_JOB = '1',
      LICENSE_SETUP_TOKEN = '',
      LICENSE_SERVER_HOST = 'ds4-lizenz.ds4.damp.local',
      DS_WIREGUARD_URL = 'https://localhost',
      DS_EASYTI_MANAGER_URL = 'https://ds4-dev-local.damp.local',
      IMPORT_TRANSFER_DISABLE_BACKUP = '1',
      IMPORT_TRANSFER_SIMULATE_SHUTDOWN = '1',
      DS_SOLR_URL = 'http://localhost:8983/solr',
      DS_USE_LOW_AUTH_SECURITY_SETTINGS = 'true',
      HTML_SANITIZER = '',
      DS_SKIP_HILFE_INDEX = '1',
    },
  }
  local ds4_test_lldb_config = {
    name = 'DS4 Tests',
    type = 'codelldb',
    request = 'launch',
    program = '/home/dev/ds4/ds4/git/build/bin/ds4b-tests-app-ds4',
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = function()
      local test_pattern = vim.fn.input 'Test pattern (--only=): '
      if test_pattern ~= '' then
        return { '--only=' .. test_pattern, '--reporter=singleline' }
      else
        return { '--reporter=singleline' }
      end
    end,
    env = {
      DS4_PATH = '/home/dev/ds4/ds4/home',
      DS4_APPLICATION_DIRECTORY = '/home/dev/ds4/ds4/git/build/bin/Debug',
      USAGE_STATISTIC_ACTIVE = 'false',
      DS_OPENTELEMETRY_TRACES_URL = 'https://otelcol.ds4.damp.local/v1/traces',
      DS_OPENTELEMETRY_METRICS_URL = 'https://otelcol.ds4.damp.local/v1/metrics',
      PGHOST = 'localhost',
      PGDATABASE = 'ds4',
      PGUSER = 'postgres',
      PGPASSWORD = 'test',
      DS_UPDATE_ACCEPT_DEV_KEYS = '1',
      DS_MFA_SERVER_URL = 'https://ds4-dev-local.damp.local:443',
      OPENSSL_MODULES = '/home/dev/ds4/ds4/git/build/bin/ossl-modules',
      EASYTI_HOST = 'ds4-dev-local-easyti.damp.local',
      DISABLE_SOLVI_JOB = '1',
      LICENSE_SETUP_TOKEN = '',
      LICENSE_SERVER_HOST = 'ds4-lizenz.ds4.damp.local',
      DS_WIREGUARD_URL = 'https://localhost',
      DS_EASYTI_MANAGER_URL = 'https://ds4-dev-local.damp.local',
      IMPORT_TRANSFER_DISABLE_BACKUP = '1',
      IMPORT_TRANSFER_SIMULATE_SHUTDOWN = '1',
      DS_SOLR_URL = 'http://localhost:8983/solr',
      DS_USE_LOW_AUTH_SECURITY_SETTINGS = 'true',
      HTML_SANITIZER = '',
      DS_SKIP_HILFE_INDEX = '1',
    },
  }

  dap.configurations.c = default_lldb_config
  dap.configurations.cpp = { default_lldb_config, ds4_test_lldb_config }
  dap.configurations.rust = default_lldb_config
  dap.configurations.asm = default_lldb_config
end

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    {
      'nvim-telescope/telescope-dap.nvim',
      config = function()
        require('telescope').load_extension 'dap'
      end,
    },
    {
      'rcarriga/nvim-dap-ui',
      types = true,
    },
    'nvim-neotest/nvim-nio',
    {
      'theHamsta/nvim-dap-virtual-text',
      opts = {
        enabled = true,
      },
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- dapui setup
    dapui.setup {
      layouts = {
        {
          elements = {
            { id = 'scopes', size = 0.25 },
            { id = 'breakpoints', size = 0.25 },
            { id = 'stacks', size = 0.25 },
            { id = 'watches', size = 0.25 },
          },
          position = 'left',
          size = 60,
        },
        {
          elements = {
            { id = 'repl', size = 0.25 },
            { id = 'console', size = 0.75 },
          },
          position = 'bottom',
          size = 30,
        },
      },
      mappings = {
        expand = { '<CR>', '<2-LeftMouse>' },
        open = 'o',
        remove = 'd',
        edit = 's',
        repl = 'r',
        toggle = 't',
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
      -- require('edgy').close()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end

    -- dap.listeners.before.event_exited['dapui_config'] = function()
    --   dapui.close()
    -- end

    define_colors()
    vim.keymap.set('n', '<F6>', function()
      dap.step_over()
    end)
    vim.keymap.set('n', '<F7>', function()
      dap.step_into()
    end)
    vim.keymap.set('n', '<F8>', function()
      dap.step_out()
    end)
    vim.keymap.set('n', '<leader>b', function()
      dap.toggle_breakpoint()
    end)
    vim.keymap.set('n', '<F10>', function()
      dap.terminate()
    end)

    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension/adapter/codelldb',
        args = { '--port', '${port}' },
      },
    }

    vim.keymap.set('n', '<F5>', function()
      setup_default_configurations()
      -- when debug is called firstly try to read and/or update launch.json configuration
      -- from the local project which will override all the default configurations
      -- if vim.fn.filereadable '.vscode/launch.json' then
      --   require('dap.ext.vscode').load_launchjs(nil, { lldb = { 'rust', 'c', 'cpp' } })
      -- else
      -- If not possible stick to the default prebuilt configurations
      setup_default_configurations()
      -- end

      require('dap').continue()
    end)

    -- Keymaps
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Toggle [b]reakpoint' })
    vim.keymap.set('n', '<leader>gb', dap.run_to_cursor, { desc = 'Run to cursor' })
    vim.keymap.set('n', '<leader>gp', dap.up, { desc = '[G]o stack u[p]' })
    vim.keymap.set('n', '<leader>gn', dap.down, { desc = '[G]o stack dow[n]' })
    vim.keymap.set('n', '<space>?', function()
      require('dapui').eval(nil, { enter = true })
    end)
    -- vim.keymap.set('n', '<F1>', dap.continue)
    -- vim.keymap.set('n', '<F2>', dap.step_into)
    -- vim.keymap.set('n', '<F3>', dap.step_over)
    -- vim.keymap.set('n', '<F4>', dap.step_out)
    -- vim.keymap.set('n', '<F5>', dap.step_back)
    -- vim.keymap.set('n', '<F7>', dap.restart)

    -- Additional helpful keymaps
    vim.keymap.set('n', '<leader>dt', dapui.toggle, { desc = '[D]ebug UI [T]oggle' })
    vim.keymap.set('n', '<leader>dx', function()
      dap.terminate()
      dapui.close()
    end, { desc = '[D]ebug Stop/[X]it' })
  end,
}

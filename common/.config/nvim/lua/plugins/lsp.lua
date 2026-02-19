return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { 'vim' } },
              workspace = { checkThirdParty = false },
              completion = { callSnippet = 'Replace' },
            },
          },
        },
        ts_ls = {
          on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },

        eslint = {
          settings = {
            format = false,
          },
        },

        tailwindcss = {},
        html = {},
        cssls = {},
        jsonls = {},
        angularls = {},
        emmet_ls = {
          filetypes = {
            'html',
            'css',
            'javascriptreact',
            'typescriptreact',
            'less',
            'scss',
            'svelte',
            'vue',
          },
        },
      },
      extra_tools = {
        'stylua',
        'prettierd',
        'eslint_d',
        'biome',
      },
    },
    config = function(_, opts)
      local mason = require 'mason'
      local mason_lsp = require 'mason-lspconfig'
      local mason_tools = require 'mason-tool-installer'
      local cmp_caps = require('cmp_nvim_lsp').default_capabilities()

      mason.setup()

      -- Configure all LSP servers (including lua_ls)
      for name, conf in pairs(opts.servers) do
        conf.capabilities = vim.tbl_deep_extend('force', {}, cmp_caps, conf.capabilities or {})
        vim.lsp.config[name] = conf
      end

      -- Filter out lua_ls from Mason management (using system package)
      local ensure_all = vim.tbl_keys(opts.servers)
      ensure_all = vim.tbl_filter(function(name)
        return name ~= 'lua_ls'
      end, ensure_all)
      vim.list_extend(ensure_all, opts.extra_tools)
      mason_tools.setup { ensure_installed = ensure_all }

      -- Enable LSP servers
      mason_lsp.setup {
        handlers = {
          function(server_name)
            vim.lsp.enable(server_name)
          end,
        },
      }

      -- Enable lua_ls manually (system package)
      vim.lsp.enable 'lua_ls'

      -- LspAttach keymaps
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('minimal-lsp', { clear = true }),
        callback = function(ev)
          local map = function(keys, fn, desc)
            vim.keymap.set('n', keys, fn, { buffer = ev.buf, desc = desc })
          end
          map('gd', vim.lsp.buf.definition, 'Go to definition')
          map('gD', vim.lsp.buf.declaration, 'Go to declaration')
          map('gI', vim.lsp.buf.implementation, 'Go to implementation')
          map('gr', vim.lsp.buf.references, 'References')
          map('<leader>D', vim.lsp.buf.type_definition, 'Type definition')
          map('<leader>rn', vim.lsp.buf.rename, 'Rename')
          map('<leader>ca', vim.lsp.buf.code_action, 'Code action')
          map('K', vim.lsp.buf.hover, 'Hover')
          map('<leader>ds', vim.lsp.buf.document_symbol, 'Document symbols')
          map('<leader>ws', vim.lsp.buf.workspace_symbol, 'Workspace symbols')

          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = ev.buf,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = ev.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })
    end,
  },
}

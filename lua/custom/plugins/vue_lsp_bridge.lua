return {
  {
    "neovim/nvim-lspconfig",
    -- load after your base LSP setup if you have one
    event = "VeryLazy",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      -- optional, only used to inherit completion capabilities if present
      "saghen/blink.cmp",
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- Try to inherit capabilities from blink.cmp (safe if not installed)
      local ok_caps, blink = pcall(require, "blink.cmp")
      local capabilities = ok_caps and blink.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()

      -- Where Mason installs @vue/language-server (adjust if you vendor it yourself)
      local mason_root = vim.fn.stdpath("data") .. "/mason"
      local volar_plugin_dir = mason_root .. "/packages/vue-language-server/node_modules/@vue/language-server"

      -- Typescript plugin that teaches TS about .vue files
      local vue_ts_plugin = {
        name = "@vue/typescript-plugin",
        location = volar_plugin_dir,
        languages = { "vue" },
        configNamespace = "typescript",
      }

      local ts_filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }

      -----------------------------------------------------------------------
      -- 1) TYPESCRIPT SIDE (pick one: vtsls recommended, ts_ls alternative)
      -----------------------------------------------------------------------

      -- vtsls (recommended)
      if lspconfig.vtsls then
        lspconfig.vtsls.setup {
          capabilities = capabilities,
          filetypes = ts_filetypes,
          settings = {
            vtsls = {
              tsserver = {
                globalPlugins = { vue_ts_plugin },
              },
            },
          },
        }
      end

      -- If you prefer typescript-language-server instead of vtsls, uncomment:
      -- if lspconfig.ts_ls then
      --   lspconfig.ts_ls.setup {
      --     capabilities = capabilities,
      --     filetypes = ts_filetypes,
      --     init_options = {
      --       plugins = { vue_ts_plugin },
      --     },
      --   }
      -- end

      -----------------------------------------------------------------------
      -- 2) VUE SIDE (forward Vue's tsserver requests to vtsls/ts_ls)
      -----------------------------------------------------------------------
      lspconfig.volar.setup {
        capabilities = capabilities,
        on_init = function(client)
          client.handlers["tsserver/request"] = function(_, result, context)
            -- Prefer vtsls, fallback to ts_ls if that's what you use
            local vts = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })[1]
            local ts  = vts or vim.lsp.get_clients({ bufnr = context.bufnr, name = "ts_ls" })[1]
            if not ts then
              vim.notify("volar: no vtsls/ts_ls client attached; TS-powered Vue features will be limited.", vim.log.levels.WARN)
              return
            end

            local param = unpack(result)
            local id, command, payload = unpack(param)

            ts:exec_cmd({
              title = "vue_request_forward",
              command = "typescript.tsserverRequest",
              arguments = { command, payload },
            }, { bufnr = context.bufnr }, function(_, r)
              local body = r and r.body
              client:notify("tsserver/response", { { id, body } })
            end)
          end
        end,
      }
    end,
  },
}


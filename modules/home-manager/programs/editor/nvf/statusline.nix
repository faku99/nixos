{
  programs.nvf.settings.vim = {
    statusline.lualine = {
      enable = true;

      activeSection = {
        a = [ # lua
          ''
          {
            'mode',
            icons_enabled = true,
          }
          ''
        ];
        b = [
          # lua
          ''
          {
            'filetype',
            icon = { align = 'left' },
          }
          ''
          # lua
          ''
          {
            'filename',
            path = 1,
            symbols = {
              modified = '[M]',
              readonly = '[RO]',
              unnamed = '[NO NAME]',
              newfile = '[NEW]',
            },
          }
          ''
        ];
        c = [
          # lua
          ''
          {
            'diff',
            colored = false,
            diff_color = {
              added    = 'DiffAdd',
              modified = 'DiffChange',
              removed  = 'DiffDelete',
            },
            symbols = {added = '+', modified = '~', removed = '-'},
          }
          ''
        ];

        x = [
          # lua
          ''
            {
              -- Lsp server name
              function()
                local buf_ft = vim.bo.filetype
                local excluded_buf_ft = { toggleterm = true, NvimTree = true, ["neo-tree"] = true, TelescopePrompt = true }

                if excluded_buf_ft[buf_ft] then
                  return ""
                  end

                local bufnr = vim.api.nvim_get_current_buf()
                local clients = vim.lsp.get_clients({ bufnr = bufnr })

                if vim.tbl_isempty(clients) then
                  return "No Active LSP"
                end

                local active_clients = {}
                for _, client in ipairs(clients) do
                  table.insert(active_clients, client.name)
                end

                return table.concat(active_clients, ", ")
              end,
            }
          ''
          # lua
          ''
            {
              'diagnostics',
              sources = {'nvim_lsp', 'nvim_diagnostic', 'nvim_diagnostic', 'vim_lsp', 'coc'},
              symbols = {error = '󰅙  ', warn = '  ', info = '  ', hint = '󰌵 '},
              colored = true,
              update_in_insert = false,
              always_visible = false,
              diagnostics_color = {
                color_error = { fg = 'red' },
                color_warn = { fg = 'yellow' },
                color_info = { fg = 'cyan' },
              },
            }
          ''
        ];

        y = [
          # lua
          ''
            {
              'searchcount',
              maxcount = 999,
              timeout = 120,
            }
          ''
          # lua
          ''
            {
              'branch',
              icon = '',
            }
          ''
        ];

        z = [
          # lua
          ''
            {
              '%{&expandtab?"󱁐 ":"󰌒 "}%{&tabstop}',
            }
          ''
          # lua
          ''
            {
              'progress',
            }
          ''
          # lua
          ''
            {
              'location',
            }
          ''
          # lua
          ''
            {
              'fileformat',
              symbols = {
                unix = 'LF',
                dos = 'CRLF',
                mac = 'CR',
              }
            }
          ''
        ];
      };
    };
  };
}

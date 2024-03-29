-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map

    -- navigate buffer tabs with `H` and `L`
    -- L = {
    --   function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
    --   desc = "Next buffer",
    -- },
    -- H = {
    --   function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
    --   desc = "Previous buffer",
    -- },

    -- mappings seen under group name "Buffer"
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    ["<leader>b;"] = { ':let @+ = expand("%:p")<cr>', desc = "Copy Name" },
    ["<leader>t;"] = { ":tc %:p:h<cr>", desc = "Change Directory to file path" },
    ["<leader>tr"] = { ":tc <C-r>+<cr>", desc = "Change Directory to file path" },

    ["<leader>be"] = { ":tabe %<cr>", desc = "Open in New Tab" },
    ["<leader>td"] = { '<cmd>TermExec cmd="ddgr"<cr>', desc = "DuckDuckGo Browse" },
    ["<leader>-"] = { ":tc -<cr>:pwd<cr>", desc = "Cd -" },
    ["<leader>Q"] = { ":bd! %<cr>", desc = "Quit buffer" },
    ["<leader>L"] = { ":!ls<cr>", desc = "List Items" },
    ["<leader>D"] = { ":!ri -Force %<cr>", desc = "Delete Item" },
    ["gd"] = { ":lua vim.lsp.buf.definition()<cr>", desc = "Goto Definition" },
    ["gv"] = { ":vs | lua vim.lsp.buf.definition()<cr>", desc = "Goto Definition split vertical" },
    ["gs"] = { ":sp | lua vim.lsp.buf.definition()<cr>", desc = "Goto Definition split horizontal" },

    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}

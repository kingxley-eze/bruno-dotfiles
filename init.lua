local opt = vim.opt
local autocmd = vim.api.nvim_create_autocmd

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

opt.backup = false
opt.swapfile = false

opt.scrolloff = 10
opt.relativenumber = false
opt.wrap = false

-- Avoid conflict with nvim-cmp's tab fallback
-- vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
-- vim.g.copilot_tab_fallback = ''
-- vim.keymap.set('i', '<Tab>', [[copilot#Accept('')]], { noremap = true, silent = true, expr = true })

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- disable underline in diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = false,
  signs = true,
  update_in_insert = false,
})

vim.g.bookmark_sign = ""
vim.g.bookmark_highlight = "DevIconErb"

vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldcolumn = "0"

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

-- autocmd BufEnter * silent! lcd %:p:h
-- the same as autochdir but better for nvim-tree and other plugins.
autocmd("BufEnter", {
  pattern = "*",
  command = "silent! lcd %:p:h",
})

-- Auto format on save
autocmd("BufWritePre", {
  pattern = { "*.js", "*.java", "*.lua" },
  callback = function()
    vim.lsp.buf.format { async = false }
  end,
})

-- autocmd({ "ModeChanged" }, {
--   callback = function()
--     local current_mode = vim.fn.mode()
--     if current_mode == "n" then
--       vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#f8f8f2" })
--       -- vim.fn.sign_define("smoothcursor", { text = "" })
--     elseif current_mode == "v" then
--       vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#62d6e8" })
--       -- vim.fn.sign_define("smoothcursor", { text = "" })
--     elseif current_mode == "V" then
--       vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#62d6e8" })
--       -- vim.fn.sign_define("smoothcursor", { text = "" })
--     elseif current_mode == "�" then
--       vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#62d6e8" })
--       -- vim.fn.sign_define("smoothcursor", { text = "" })
--     elseif current_mode == "i" then
--       vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#50fa7b" })
--       -- vim.fn.sign_define("smoothcursor", { text = "" })
--     end
--   end,
-- })

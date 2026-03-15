vim.loader.enable()

vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.opt.shortmess:append("I")
vim.opt.cmdheight = 0

vim.opt.number         = true
vim.opt.relativenumber = true

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function() vim.opt.relativenumber = false end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function() vim.opt.relativenumber = true end,
})

local function set_transparent_hls()
  vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksNormal", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksNormalNC", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerBorder", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerBoxBorder", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerInputBorder", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "SnacksPickerTitle", { bg = "NONE" })
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = set_transparent_hls })
vim.api.nvim_create_autocmd("VimEnter",    { callback = set_transparent_hls, once = true })

vim.g.mapleader = ","

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>")
require("lazy").setup({
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>f", function() Snacks.picker.files() end, desc = "Find files" },
      { "<leader>e", function() Snacks.picker.explorer() end, desc = "Explorer" },
    },
    config = function()
      require("snacks").setup({
        picker = {
          enabled = true,
          show_delay = 0,
          auto_confirm = true,
          matcher = { frecency = true },
          icons = {
            files = { enabled = false },
            git   = { enabled = false },
          },
          sources = {
            files = { show_empty = true },
          },
          win = {
            input = {
              keys = {
                ["<Esc>"] = { "close", mode = { "n", "i" } },
              },
            },
          },
        },
      })
    end,
  },
})

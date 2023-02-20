-- Path to this configuration file
CONFIG_PATH = debug.getinfo(1)["source"]:sub(2)

-- NeoVim command to reload configuration
RELOAD_CONFIG_COMMAND = string.format(':source %s | echo "[+] Reloaded NeoVim config"<cr>', CONFIG_PATH);

vim.g.mapleader = ';'

-- Keymap to manually reload configuration
vim.keymap.set('n', '<leader>r', RELOAD_CONFIG_COMMAND, {silent = true})

-- Mappings for commenting out lines of code in different Vim modes
vim.keymap.set('n', 'gcc', '<Plug>VSCodeCommentaryLine', {silent = true})
vim.keymap.set('n', 'gc', '<Plug>VSCodeCommentary', {silent = true})
vim.keymap.set('o', 'gc', '<Plug>VSCodeCommentary', {silent = true})
vim.keymap.set('x', 'gc', '<Plug>VSCodeCommentary', {silent = true})

-- Use system's clipboard by default on all platforms
{{ if eq .chezmoi.os "darwin" }}
vim.opt.clipboard = "unnamed"
{{ else }}
vim.opt.clipboard = "unnamedplus"
{{ end }}

-- Slightly customised cursor styles
vim.opt.guicursor = 'n-v-c-sm:hor20,i-ci-ve:hor20,r-cr-o:hor20'


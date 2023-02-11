CONFIG_PATH = debug.getinfo(1)["source"]:sub(2)

RELOAD_CONFIG_COMMAND = string.format(
    ':source %s | echo "[+] Reloaded NeoVim config"<cr>',
    CONFIG_PATH
);

vim.g.mapleader = ';'

vim.keymap.set('n', '<leader>r', RELOAD_CONFIG_COMMAND, {silent = true})

{{ if eq .chezmoi.os "darwin" }}
vim.opt.clipboard = "unnamed"
{{ else }}
vim.opt.clipboard = "unnamedplus"
{{ end }}

vim.opt.guicursor = 'n-v-c-sm:hor20,i-ci-ve:hor20,r-cr-o:hor20'


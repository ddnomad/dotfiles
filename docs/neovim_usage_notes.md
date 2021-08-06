NeoVim Usage Notes
==================
> This was partially moved from `dotfiles.mac` repository `README.md`. Mostly needed to remember what "new" plugin
> / features were added so  I can get used to them.

Plugins You Don't Use
---------------------
- Added [ctrlp.vom](https://github.com/ctrlpvim/ctrlp.vim). Binding was added to search for buffers (see
  [Shortcuts You Forgot](#shortcuts-you-forgot). Probably worth adding a similar binding for searching files
  (currently it is only possible by executing `:CtrlP` and maybe by using `<C-P>` binding.
- Added [SimpylFold](https://github.com/tmhedberg/SimpylFold). Use `zc` to
  fold all, `zi` to unfold all, `za` to toggle fold of a selected fold,
  `zA` to toggle fold and all nested folds.

Shortcuts You Forgot
--------------------
- `<C-Q>` - Close a current buffer
- `gd` - Jump to definition with `coc.nvim`
- `;;` - Search for a buffer with `CtrlP`
- `;NUM` - Switch to buffer with number `NUM`
- `ene` - Open a new empty buffer
- `e PATH` - Open a file under `PATH` in a new buffer
- `<C-H>` - Go to a split on the left
- `<C-L>` - Go to a split on the right
- `<C-J>` - Go to a next buffer
- `<C-K>` - Go to a previous buffer
- https://github.com/tpope/vim-surround - all of it, specifically `yss'`. Also need a plugin for:
  * Visual selection
  * Surround each line with quotes
  * Or surround each line with `'<line>',`
  * `Ctrl+O` is neat

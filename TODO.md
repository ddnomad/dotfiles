TODO
====

Post-Migration Cleanups
-----------------------
* Move `~/.fehbg` into `~/.config/i3/config` using `chezmoi` templating for
  handling laptop VS desktop (VM) differences.

* Finish integrating stuff in `~/.xinitrc` (or discard).

* Implement whole screen / specific window screenshot functionality in
  `.scripts/i3wm_make_screenshot`.

* Add support for data from STDIN in `.scripts/jqless`.

* Prettify and handle exceptions in `.scripts/ts2dt`.

* Write a wrapper around `docs/` files to expose them in a usable way on CLI.

* Integrate `ripgrep` as a standard `grep` replacement?

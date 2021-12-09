Useful Commands
===============
jq
--
Format and show JSON object in a pager:
```
cat data.json | jq --color-output | less -R
```

Note that on Debian, there is a bug in `jq` that prevents the command above
from working. There is a less obvious equivalent that achieves the same result
and works fine on Debian / Ubuntu:
```
jq -C . data.json | less -R
```

On hosts where dotfiles are properly integrated, `jqless data.json` can be used
to achive the same, though as of 2021-12-09 it does not support input from
STDIN.

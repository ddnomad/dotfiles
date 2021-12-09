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

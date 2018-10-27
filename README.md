# vim-terminal-manager
vim-terminal-manager adds the command T.  The first time you call T, a
new neovim terminal is added to your current tab and any input is sent 
to this terminal.  Additional calls to T will send keys to this terminal.

If you call T from a new tab, your new tab will get its own new terminal.

## Example usage:
```
T ls -l
```

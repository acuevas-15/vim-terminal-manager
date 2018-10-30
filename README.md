# vim-terminal-manager
vim-terminal-manager adds the commands T, and At.  **T** is used to manage
a terminal that stays commented to the tab.  **At** is used to run an adhoc
terminal command in a new split.  

## T (tab-terminal) Command:
The first time you call T, a new neovim terminal is added to your current tab
in a horizontal split and any input is sent to this terminal.  Additional 
calls to T will send keys to this terminal.

If you call T from a new tab, your new tab will get its own new terminal.
Unlike **T** the **Tv** command will create your new split in a veritically
aligned window rather than a horizontally aligned window.

### Example usage:
* Run a command in a new horizontal split.  If a terminal has already been bound
to the tab, use the old terminal.
```
:T ls -l
```
* Run a command in a new vertical split.  If a terminal has already been bound
to the tab, use the old terminal.
```
:Tv git status
```
## At (adhoc-terminal) Command:
**At** and **Atv** can be used to run an adhoc terminal command in a new split.
These commands are useful for starting a long-running process such as tailing a
file, or running a server.

### Example usage:
```
:At htop
```

## TODO
- [ ] refactor tab terminal buffer to use buffer variable rather than tab
      variable.  This should allow users to save their connection to an interactive
      terminal between sessions using **locationoptions**.

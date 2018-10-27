command! -nargs=+ T :call InsertLineInTabTerminal(<q-args>)

function! InsertLineInTabTerminal(line) abort
    if !exists("t:tab_terminal_number") || bufwinnr(t:tab_terminal_number) == -1
        let t:tab_terminal_number = CreateTabTerminalSP()
    endif
    call InsertLineInTerminal(t:tab_terminal_number, a:line)
endfunction

function! CreateTabTerminalSP() abort
    if exists("t:tab_terminal_number") && bufwinnr(t:tab_terminal_number) != -1
        echom "CreateTabTerminalSP: A terminal is already bound to this tab.  Terminal: " . t:tab_terminal_number
        return
    endif
    let current_buffer = buffer_number('%')

    execute "sp"
    redraw
    execute "terminal"
    normal G
    let t:tab_terminal_number = buffer_number('%')

    execute "normal! " . bufwinnr(current_buffer) . "\<c-w>\<c-w>"
    return t:tab_terminal_number
endfunction

function! InsertLineInTerminal(buffer_number, line) abort
    if bufwinnr(a:buffer_number) == -1
        call CreateTabTerminalSP()
    endif
    let current_buffer = buffer_number('%')
    let current_position = Mark()

    execute "b " . a:buffer_number

    let initial_register = @t
    let @t = a:line . "\r"
    normal! "tp
    let @t = initial_register
    
    execute "b " . current_buffer
    execute current_position
endfunction

" Shamelessly stolen from Benji Fisher https://www.vim.org/scripts/script.php?script_id=72
" Usage:  :let ma = Mark() ... execute ma
" has the same effect as  :normal ma ... :normal 'a
" without affecting global marks.
" You can also use Mark(17) to refer to the start of line 17 and Mark(17,34)
" to refer to the 34'th (screen) column of the line 17.  The functions
" Line() and Virtcol() extract the line or (screen) column from a "mark"
" constructed from Mark() and default to line() and virtcol() if they do not
" recognize the pattern.
" Update:  :execute Mark() now restores screen position as well as the cursor.
fun! Mark(...)
  if a:0 == 0
    let mark = line(".") . "G" . virtcol(".") . "|"
    normal! H
    let mark = "normal!" . line(".") . "Gzt" . mark
    execute mark
    return mark
  elseif a:0 == 1
    return "normal!" . a:1 . "G1|"
  else
    return "normal!" . a:1 . "G" . a:2 . "|"
  endif
endfun

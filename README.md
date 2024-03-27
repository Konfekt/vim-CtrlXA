With this Vim plug-in, the key bindings `<Ctrl-X/A>` (and `g<Ctrl-X/A>`) additionally cycle through lists of keywords such as `true/false`, `yes/no`, `yesterday/today/tomorrow` or roman numerals `I`, `II`, `III`...
Useful, for example,

- for toggling settings in a configuration file,
- for toggling language modifiers such as `public/private`,
- for switching between `pick`, `squash`, `reword`, ... a `git` commit when rebasing, ...

Repetition of the last command by hitting `.` (see `:help .`) is achieved

- in normal mode by [vim-repeat](https://github.com/tpope/vim-repeat), and
- in visual mode by [vim-visualrepeat](https://github.com/inkarkat/vim-visualrepeat).

# Global Setup

These keywords are configurable by the variable `g:CtrlXA_Toggles` which is a long list of keyword lists in [`plugin/ctrlxa.vim`](https://github.com/Konfekt/vim-CtrlXA/blob/master/plugin/CtrlXA/toggles.vim)

If you want to add a cycle, say the pair `['sweet', 'bitter']`, to the default list of cycles, then

- either put

    ```vim
    let g:CtrlXA_Toggles = [
        \ ['sweet', 'bitter'],
        \ ] + g:CtrlXA_Toggles
    ```

    into a file `~/.vim/after/plugin/CtrlXA.vim` on Linux (respectively `%USERPROFILE%\vimfiles\after\plugin\CtrlXA.vim` on Microsoft Windows), or
- put into your `vimrc` the lines

    ```vim
    augroup VimAfter
        autocmd!
        autocmd VimEnter let g:CtrlXA_Toggles = [
        \ ['sweet', 'bitter'],
        \ ] + g:CtrlXA_Toggles
    augroup END
    ```

Keywords consist of the keyword characters determined by the global variable `g:CtrlXA_iskeyword`.
By default, this variable takes the same value as `&g:iskeyword` (see `:help iskeyword`) with the exception of the underscore `_` which is removed from `g:CtrlXA_iskeyword`.

If you want the cursor to move to the keyword (among `g:CtrlXA_Toggles`) that was changed after hitting a key (mapped to `<Plug>(CtrlXA-CtrlA)` or `<Plug>(CtrlXA-CtrlX)`), then set the global variable `g:CtrlXA_move` to `1`.
By default, the cursor only moves to a changed number, as Vim does by default.

If you prefer `i`, `v` and `I`, `V` to run through the letters of the Latin
alphabet instead of the Roman numerals, move these letters from the pair of
arrays containing the roman numerals to that containing the Latin alphabet.

There are also localized keyword cycle lists for common (spell) languages;
these can be disabled by `let g:CtrlXA_localization = 0`.

# Buffer-Local Setup

There is also the buffer-local list of keyword cycles `b:CtrlXA_iskeyword`, which allows for file-type specific keyword cycles.
For example, as included by default:

```vim
autocmd FileType gitrebase
            \ let b:CtrlXA_Toggles = [
            \ ['pick', 'fixup', 'squash', 'break', 'reword', 'edit', 'drop'],
            \ ] + get(b:, 'CtrlXA_Toggles', g:CtrlXA_Toggles)
```

This will

- include all keyword cycles of the global variable, and
- add (buffer-)local keyword cycles which have precedence over the global cycles.

To add keyword cycles for other file types, add

- either the four lines above to `~/.vimrc` on Linux or MacOS (respectively `%USERPROFILE%\_vimrc` on Microsoft Windows), or
- the last three lines above to `~/.vim/after/ftplugin/gitrebase.vim` on Linux (respectively `%USERPROFILE%\vimfiles\after\ftplugin\gitrebase.vim` on Microsoft Windows).

# Related Plug-ins

This plugin integrates with Tim Pope's [vim-speeddating](https://github.com/tpope/vim-speeddating) by adding to your `.vimrc` the lines

```vim
nmap <Plug>SpeedDatingFallbackUp   <Plug>(CtrlXA-CtrlA)
nmap <Plug>SpeedDatingFallbackDown <Plug>(CtrlXA-CtrlX)
```

# Alternative Plug-ins

Vim plug-ins that provide similar functionality and more are

- Andrew Radev's [switch.vim](https://github.com/AndrewRadev/switch.vim#more-complicated-mappings) which can cycle between expressions containing spaces;
- @bootleq's [vim-cycle](https://github.com/bootleq/vim-cycle/) which

    - supports pairs in `LaTeX`, for example, cycles between `\big( a + b \big)` and `\Big( a +b \Big)`, and
    - preserves upper and lower case by options such as `match_case`, `hard_case` and `match_word`;
- M.J. Brownie's [swapit](https://github.com/mjbrownie/swapit)

See @kiryph's [compilation](https://github.com/Konfekt/vim-CtrlXA/issues/1#issuecomment-325425550) for further alternatives.

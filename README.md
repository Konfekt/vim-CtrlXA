This Vim plug-in makes the key bindings `<Ctrl-X/A>` (and `g<Ctrl-X/A>`) additionally cycle through lists of keywords such as `true/false`, `yes/no`, `set/unset`, `yesterday/today/tomorrow` or roman numerals `I`, `II`, `III`...
Useful, for example,

- for toggling settings in a configuration file, or
- for switching between `pick`, `squash`, `reword`, ... a `git` commit when rebasing.

Repetition of the last command by hitting `.` (see `:help .`)

- in normal mode is made possible by [vim-repeat](https://github.com/tpope/vim-repeat), and
- in visual mode by [vim-visualrepeat](https://github.com/inkarkat/vim-visualrepeat).

# Setup

These keywords are configurable by the variable `g:CtrlXA_Toggles` which is a long list of keyword lists in [`plugin/ctrlxa.vim`](https://github.com/Konfekt/vim-CtrlXA/blob/6821041f17848c02bd3c0ed13422d6ee6422a6a4/plugin/CtrlXA.vim#L32)

If you prefer the letters `i`, `v` and `I`, `V` to run through the Latin alphabet instead of the Roman numerals, move these letters from the pair of arrays containing the roman numerals to that containing the Latin alphabet.

## Global Configuration Options

If you want the cursor to move to the keyword (among `g:CtrlXA_Toggles`) that was changed after hitting a key (mapped to `<Plug>(CtrlXA-CtrlA)` or `<Plug>(CtrlXA-CtrlX)`), then set the global variable `g:CtrlXA_move` to 1.
By default the cursor only moves to a changed number, as Vim does by default.

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

Keywords are separated by all non-keyword characters.
Keyword characters are determined by the global variable `g:CtrlXA_iskeyword`.
By default, this variable takes the same value as `&g:iskeyword`, see `:help iskeyword`, so keywords as detected by CtrlXA are the same as Vim's default keyword.
To customize, add or remove characters from `g:CtrlXA_iskeyword`.
For example, the underscore `_` is removed from `g:CtrlXA_iskeyword` by default to toggle `max` and `x` in `max_x`.

## Buffer-Local Configuration Options

There is also its buffer-local analogue, which allows for file-type specific
keyword cycles by, for example, as included by default,

```vim
    autocmd FileType gitrebase
                \ let b:CtrlXA_Toggles = [
                \ ['pick', 'fixup', 'squash', 'break', 'reword', 'edit', 'drop'],
                \ ] + g:CtrlXA_Toggles
    autocmd FileType vim
                \ let b:CtrlXA_Toggles = [
                \ ['if', 'else', 'elseif', 'endif'],
                \ ] + g:CtrlXA_Toggles
    autocmd FileType sh
                \ let b:CtrlXA_Toggles = [
                \ ['if', 'elif', 'else', 'fi'],
                \ ] + g:CtrlXA_Toggles
```

This will

- include all keyword cycles of the global variable, and
- add (buffer-)local keyword cycles which have precedence over the global cycles.

There are many more toggles that could be useful, for example, to switch between the draft and final version of a `TeX` document, add:

```vim
    autocmd FileType tex
                \ let b:CtrlXA_Toggles = [
                \ ['final', 'draft'],
                \ ] + g:CtrlXA_Toggles
```

When there are already default cycles for a file type, say for `TeX`, replace the latter `g:CtrlXA_Toggles` by its buffer-local analogue `b:CtrlXA_Toggles` and add the line

```vim
    \ let b:CtrlXA_Toggles = [
    \ ['final', 'draft'],
                \ ] + get(b:, 'CtrlXA_Toggles', g:CtrlXA_Toggles)
```

to the file `~/.vim/after/ftplugin/tex.vim` on Linux (respectively `%USERPROFILE%\vimfiles\after\ftplugin\tex.vim` on Microsoft Windows).

The buffer-local variable `b:CtrlXA_iskeyword` can be used instead of the global `g:CtrlXA_iskeyword` to separate keywords.
Useful to define keywords based on file type.
For example, set `b:CtrlXA_iskeyword` in `~/.vim/ftplugin/python.vim` to define keywords in Python.

# Related Plug-ins

This plugin integrates with Tim Pope's [vim-speeddating](https://github.com/tpope/vim-speeddating) by adding to your `.vimrc` the lines

```vim
nmap <Plug>SpeedDatingFallbackUp   <Plug>(CtrlXA-CtrlA)
nmap <Plug>SpeedDatingFallbackDown <Plug>(CtrlXA-CtrlX)
```

---

Vim plug-ins that provide similar functionality and more are

- Andrew Radev's [switch.vim](https://github.com/AndrewRadev/switch.vim#more-complicated-mappings) which can cycle between expressions containing spaces;
- @bootleq's [vim-cycle](https://github.com/bootleq/vim-cycle/) which

    - supports pairs in `LaTeX`, for example, cycles between `\big( a + b \big)` and `\Big( a +b \Big)`, and
    - preserves upper and lower case by options such as `match_case`, `hard_case` and `match_word`.

See @kiryph's [compilation](https://github.com/Konfekt/vim-CtrlXA/issues/1#issuecomment-325425550) for further alternatives.

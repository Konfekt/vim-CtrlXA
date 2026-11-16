#!/bin/sh
# Run the headless test suite with each given editor (default: vim and nvim,
# whichever are installed). Exits non-zero if any run fails.
set -u
cd "$(dirname "$0")/.." || exit 1
[ $# -gt 0 ] || set -- vim nvim
status=0
log=$(mktemp) || exit 1
trap 'rm -f "$log"' EXIT
export CTRLXA_TEST_LOG="$log"
for editor in "$@"; do
  if ! command -v "$editor" >/dev/null 2>&1; then
    echo "skip: $editor not found"
    continue
  fi
  echo "== $editor"
  : >"$log"
  if [ "$(basename "$editor")" = nvim ]; then
    "$editor" --cmd 'let g:loaded_spellfile_plugin = 1' --headless --clean -u NONE -i NONE -S test/test.vim 2>&1 || status=1
  else
    "$editor" --cmd 'let g:loaded_spellfile_plugin = 1' -Nu NONE -i NONE -es -S test/test.vim 2>&1 || status=1
  fi
  cat "$log"
  echo
done
exit "$status"

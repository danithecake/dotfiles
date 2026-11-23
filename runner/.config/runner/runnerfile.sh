# https://github.com/stylemistake/runner
source ~/.config/bash/funcs.sh

parsefiles() {
  sed -n 's/--files=//p' <<<"$@" | tr ' ' '\n'
}

task_prettier() {
  test -n "$files" || files=$(parsefiles $@ | grep -E "\.([tj]s(x|on)?|svelte)$")
  test -n "$files" || return
  npx -q prettier --write $files 1>&2 1>/dev/null 2>/dev/null
}

task_eslint() {
  test -n "$files" || files=$(parsefiles $@ | grep -E "\.([tj]s(x|on)?|svelte)$")
  test -n "$files" || return
  npx -q eslint --format=unix $files 2>&1 | grep -v "[0-9]\+ problem" 1>&2 2>/dev/null || return
}

task_tsc() {
  files=$(parsefiles $@ | grep "\.tsx\?$")
  test -n "$files" || return
  npx -q tsc --outDir ./tsbuild @<(cat ./tsc.params <(echo $files)) 1>&2 2>/dev/null
}

task_javascript() {
  runner_sequence prettier eslint
}

task_typescript() {
  runner_sequence javascript tsc
}

task_svelte() {
  files=$(parsefiles $@ | grep -E "\.([tj]sx?|svelte)$")
  test -n "$files" || return

  check=$(npx -q svelte-check --tsconfig ./tsconfig.json --output human)

  for f in $files; do
    (grep -A 1 "$f" <<<"$check" | grep -v "^--") 1>&2
  done || return
}


.PHONY: prettier eslint javascript typescript

SHELL = bash

prettier:
	@grep "\.[tj]sx\?$$" <<<"$$FILES" | ( \
	  read -d '' FILES; \
	  test -z "$$FILES" && exit 0; \
	  npx -q prettier --write $$FILES 2>&1 1>/dev/null \
	)

eslint:
	@grep "\.[tj]sx\?$$" <<<"$$FILES" | ( \
	  read -d '' FILES; \
	  test -z "$$FILES" && exit 0; \
	  npx -q eslint --format=unix $$FILES 2>&1 | grep -v "[0-9]\+ problem" || exit 0 \
	)

javascript: | prettier eslint

typescript: javascript

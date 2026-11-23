" Customization of tvix plugin
" Maintainer: Daniel Golovachev <danithecake@gmail.com>

if !get(g:, 'loaded_tvix', 0)
 finish
endif

cabbrev txe TvixExec
cabbrev txeb TvixExec!
cabbrev txs TvixSelPane

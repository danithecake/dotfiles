if exists("b:did_ftplugin")
  finish
endif

silent! compiler prettier

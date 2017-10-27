let configs = [
\  "general",
\  "ui",
\  "commands",
\  "plugins",
\  "plugin-settings",
\]
for file in configs
  let x = expand("~/.vim/settings/".file.".vim")
  if filereadable(x)
    execute 'source' x
  endif
endfor

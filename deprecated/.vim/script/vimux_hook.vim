let t = VimuxOption('VimuxRunnerType')
let views = split(VimuxTmux('list-'.t."s -F '#{".t.'_active}:#{'.t."_id}'"), '\n')
for view in views
  if match(view, '1:') != -1
    let g:VimuxRunnerIndex=split(view, ':')[1]
  endif
endfor

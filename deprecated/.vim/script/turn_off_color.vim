function! TurnOffColors()
   :set t_Co=0
   :highlight LineNr NONE
   :highlight CursorLine NONE
   " Add any other necessary highlight lines here
 endfunction
 
 command! TurnOffColors call TurnOffColors()

let &errorformat =''

" let &errorformat.='%-G'

" let &errorformat.='%-E== Starting tests'
" let &errorformat.=',%-C%.%#'
" let &errorformat.=',%-Z[   START ]'


" let &errorformat.=',%+GFailed to Load "%f"'


" let &errorformat.='%-G'
" let &errorformat.=',%+GFailed to Load "%f"'
"
" "
" "let &errorformat.=',%E  [%n] %#%f:%l: %.%#'
" "let &errorformat.=',%C%m'
"
" let &errorformat.=',%E  [%n] %#%f:%l: %m'
" "let &errorformat.=',%C%.%#'
" let &errorformat.=',%Z%p^'
"
" "let &errorformat.=',%-Gmake%[:[]%.%#'


let &errorformat='%-G'
let &errorformat.=',%-GLoading %.%#'
let &errorformat.=',%-G-%#'
let &errorformat.=',%-G[ %.%.%.%.%.%.%. ]%.%#'



let &errorformat.=',%E: %f: %m'


" let &errorformat.=',%E >  Error: %m'
let &errorformat.=',%+E  [%n] %#%f:%l: %.%#'
" let &errorformat.=',%C%.%#'
" let &errorformat.=',%C%.%#'
let &errorformat.=',%Z%p^'

" let &errorformat.=',%E  [%n] %#%f:%l: %m'
" let &errorformat.=',%Z%p^'

let &errorformat.=',%E  - %f: %m'

" let &errorformat.=',%E  [%n] %#%f:%l: %m'
" let &errorformat.=',%C%.%#'
" let &errorformat.=',%C%p^'
" let &errorformat.=',%-Z%.%#'



nmap <buffer> <localleader>m :make<cr>


nmap <buffer> <localleader>x ix<esc>[Lif<esc>:w<cr>
nmap <buffer> <localleader>X x[Lx:w<cr>



" echo &errorformat
" make

function! StripTrailingWhitespace()
    if !&binary && &filetype != 'diff'
        normal mz
        normal Hmy
        %s/\s\+$//e
        normal 'yz<CR>
        normal `z
    endif   
endfunction

" GetCommentString function ------------------------------------------------ {{{
function! GetCommentString()
    let line = getline('.')
    " Save the original state of the line so we can fix it later
    let original_line = l:line

    " NERDCommenter won't add a comment if the line is blank, so add a dummy
    " word if there's nothing on the line right now
    if l:line == ''
        let line = 'foo'
        call setline('.', l:line)
    endif

    " The amount of space between the left margin and the start of the actual
    " text
    let gap = strlen(matchstr(l:line, '^\s\+'))
    " The length of the original line
    let line_length = strlen(l:line)

    " Get NERDCommenter to toggle a comment
    exe 'normal ,cc'

    " Grab the commented line and find out how long it is
    let commented_line = getline('.')
    let commented_length = strlen(l:commented_line)

    " Extract the comment string from the commented line
    let comment_string = l:commented_line[l:gap:l:gap + l:commented_length - l:line_length - 1]

    " Put the line back how it was
    call setline('.', l:original_line)

    return l:comment_string
endfunction
" }}}

" MarkFold function -------------------------------------------------------- {{{
function! MarkFold(description)
    let start = line("'<")
    let end = line("'>")
    let first_line = getline(l:start)
    let tab = matchstr(l:first_line, '^\s\+')
    let tab_length = strlen(l:tab)
    let comment_string = GetCommentString()

    let description_length = strlen(a:description)
    let padding = repeat('-', 73 - l:description_length - l:tab_length)

    let top_comment = l:tab . l:comment_string . ' ' . a:description . ' ' . l:padding . ' {{{'
    let bottom_comment = l:tab . l:comment_string . ' }}}'

    call append(l:end, l:bottom_comment)
    call append(l:start - 1, top_comment)
endfunction

command! -nargs=1 MarkFold :call MarkFold(<f-args>)
" }}}

" Header function ---------------------------------------------------------- {{{
function! Header()
    " The character to pad the header with
    let char = '-'
    let comment_string = GetCommentString()
    let line = getline('.')
    " Get the words to use in the header
    let pre_header = getline('.')
    let gap = matchstr(l:pre_header, '^\s\+')
    let gap_size = strlen(gap)
    " Add spaces around the words
    let header = ' ' . matchstr(l:pre_header, '\S.\+') . ' '
    " How wide the header should be
    let width = 80 - l:gap_size

    " Find the lengths of the header text and the comment strings
    let word_width = strlen(l:header)
    let comment_string_width = strlen(l:comment_string)

    " Find out how much padding needs to be added
    let length_before = (l:width - l:word_width) / 2 - l:comment_string_width
    
    " Create the strings that will padd either side of the header
    let chars_before = repeat(l:char, l:length_before)
    let chars_after = repeat(l:char, l:width - (l:word_width + l:length_before))
    " Create the line of just padding
    let char_line = l:gap . l:comment_string . repeat(l:char, l:width) . l:comment_string
    " Create the line with the header
    let word_line = l:gap . l:comment_string . l:chars_before . l:header . l:chars_after . l:comment_string

    " Replace the existing line with a padding line
    call setline('.', l:char_line)
    " Print out the next two lines after
    :put =l:word_line
    :put =l:char_line
endfunction
" }}}

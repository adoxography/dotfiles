" Adapted from nord vim

if version > 580
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif

let g:colors_name = "moss"
set background=dark

let s:moss0_gui  = "#2a3830"
let s:moss1_gui  = "#35473c"
let s:moss2_gui  = "#3d5245"
let s:moss3_gui  = "#465c4f"
let s:moss3_gui_bright = "#587664"
let s:moss4_gui  = "#d5e1da"
let s:moss5_gui  = "#e3ebe6"
let s:moss6_gui  = "#ebf0ed"
let s:moss7_gui  = "#a9b898"
let s:moss8_gui  = "#9ac1a1"
let s:moss9_gui  = "#73aaa1"
let s:moss10_gui = "#3d8d8e"
let s:moss11_gui = "#c29e9b"
let s:moss12_gui = "#cf9b71"
let s:moss13_gui = "#cabc75"
let s:moss14_gui = "#87b278"
let s:moss15_gui = "#9d9bc2"

let s:moss1_term  = "0"
let s:moss2_term  = "0"
let s:moss3_term  = "0"
let s:moss4_term  = "0"
let s:moss5_term  = "0"
let s:moss6_term  = "0"
let s:moss7_term  = "0"
let s:moss8_term  = "0"
let s:moss9_term  = "0"
let s:moss10_term = "0"
let s:moss11_term = "0"
let s:moss12_term = "0"
let s:moss13_term = "0"
let s:moss14_term = "0"
let s:moss15_term = "0"

let g:moss_bold = get(g:, "moss_bold", 1)
let s:bold = (g:moss_bold == 0) ? "" : "bold,"

let g:moss_underline = get(g:, "moss_underline", 1)
let s:underline = (g:moss_underline == 0) ? "NONE," : "underline,"

let g:moss_italic = get(g:, "moss_italic", (has("gui_running") || $TERM_ITALICS == "true"))
let s:italic = (g:moss_italic == 0) ? "" : "italic,"

let g:moss_italic_comments = get(g:, "moss_italic_comments", 0)
let s:italic_comments = (g:moss_italic_comments == 0) ? "" : get(s:, "italic")
let g:moss_uniform_status_lines = get(g:, "moss_uniform_status_lines", 0)
let g:moss_bold_vertical_split_line = get(g:, "moss_bold_vertical_split_line", 0)
let g:moss_cursor_line_number_background = get(g:, "moss_cursor_line_number_background", 0)
let g:moss_uniform_diff_background = get(g:, "moss_uniform_diff_background", 0)

function! s:hi(group, guifg, guibg, ctermfg, ctermbg, attr, guisp)
  let cmd = ""
  if a:guifg != ""
    let cmd = cmd . " guifg=" . a:guifg
  endif
  if a:guibg != ""
    let cmd = cmd . " guibg=" . a:guibg
  endif
  if a:ctermfg != ""
    let cmd = cmd . " ctermfg=" . a:ctermfg
  endif
  if a:ctermbg != ""
    let cmd = cmd . " ctermbg=" . a:ctermbg
  endif
  if a:attr != ""
    let cmd = cmd . " gui=" . a:attr . " cterm=" . substitute(a:attr, "undercurl", s:underline, "")
  endif
  if a:guisp != ""
    let cmd = cmd . " guisp=" . a:guisp
  endif
  if cmd != ""
    exec "hi " . a:group . cmd
  endif
endfunction

" UI Components
call s:hi("Bold", "", "", "", "", s:bold, "")
call s:hi("Italic", "", "", "", "", s:italic, "")
call s:hi("Underline", "", "", "", "", s:underline, "")

" Editor
call s:hi("ColorColumn", "",          s:moss1_gui,  "NONE",       s:moss1_term,  "",     "")
call s:hi("Cursor",      s:moss0_gui, s:moss4_gui,  "",           "NONE",        "",     "")
call s:hi("CursorLine",  "",          s:moss1_gui,  "NONE",       s:moss1_term,  "NONE", "")
call s:hi("Error",       s:moss4_gui, s:moss11_gui, "",           s:moss11_term, "",     "")
call s:hi("iCursor",     s:moss0_gui, s:moss4_gui,  "",           "NONE",        "",     "")
call s:hi("LineNr",      s:moss3_gui, "NONE",       s:moss3_term, "NONE",        "",     "")
call s:hi("MatchParen",  s:moss8_gui, s:moss3_gui,  s:moss8_term, s:moss3_term,  "",     "")
call s:hi("NonText",     s:moss2_gui, "",           s:moss3_term, "",            "",     "")
call s:hi("Normal",      s:moss4_gui, s:moss0_gui,  "NONE",       "NONE",        "",     "")
call s:hi("PMenu",       s:moss4_gui, s:moss2_gui,  "NONE",       s:moss1_term,  "NONE", "")
call s:hi("PmenuSbar", s:moss4_gui, s:moss2_gui, "NONE", s:moss1_term, "", "")
call s:hi("PmenuSel", s:moss8_gui, s:moss3_gui, s:moss8_term, s:moss3_term, "", "")
call s:hi("PmenuThumb", s:moss8_gui, s:moss3_gui, "NONE", s:moss3_term, "", "")
call s:hi("SpecialKey", s:moss3_gui, "", s:moss3_term, "", "", "")
call s:hi("SpellBad", s:moss11_gui, s:moss0_gui, s:moss11_term, "NONE", "undercurl", s:moss11_gui)
call s:hi("SpellCap", s:moss13_gui, s:moss0_gui, s:moss13_term, "NONE", "undercurl", s:moss13_gui)
call s:hi("SpellLocal", s:moss5_gui, s:moss0_gui, s:moss5_term, "NONE", "undercurl", s:moss5_gui)
call s:hi("SpellRare", s:moss6_gui, s:moss0_gui, s:moss6_term, "NONE", "undercurl", s:moss6_gui)
call s:hi("Visual", "", s:moss2_gui, "", s:moss1_term, "", "")
call s:hi("VisualNOS", "", s:moss2_gui, "", s:moss1_term, "", "")

if has('terminal')
    let g:terminal_ansi_colors = [s:moss1_gui, s:moss11_gui, s:moss14_gui, s:moss13_gui, s:moss9_gui, s:moss15_gui, s:moss8_gui, s:moss5_gui, s:moss3_gui, s:moss11_gui, s:moss14_gui, s:moss13_gui, s:moss9_gui, s:moss15_gui, s:moss7_gui, s:moss6_gui]
endif

" Gutter
call s:hi("CursorColumn", "", s:moss1_gui, "NONE", s:moss1_term, "", "")
if g:moss_cursor_line_number_background == 0
  call s:hi("CursorLineNr", s:moss4_gui, "", "NONE", "", "NONE", "")
else
  call s:hi("CursorLineNr", s:moss4_gui, s:moss1_gui, "NONE", s:moss1_term, "NONE", "")
endif
call s:hi("Folded", s:moss3_gui, s:moss1_gui, s:moss3_term, s:moss1_term, s:bold, "")
call s:hi("FoldColumn", s:moss3_gui, s:moss0_gui, s:moss3_term, "NONE", "", "")
call s:hi("SignColumn", s:moss1_gui, s:moss0_gui, s:moss1_term, "NONE", "", "")

" Navigation
call s:hi("Directory", s:moss8_gui, "", s:moss8_term, "NONE", "", "")

" Prompt/Status
call s:hi("EndOfBuffer", s:moss1_gui, "", s:moss1_term, "NONE", "", "")
call s:hi("ErrorMsg", s:moss4_gui, s:moss11_gui, "NONE", s:moss11_term, "", "")
call s:hi("ModeMsg", s:moss4_gui, "", "", "", "", "")
call s:hi("MoreMsg", s:moss8_gui, "", s:moss8_term, "", "", "")
call s:hi("Question", s:moss4_gui, "", "NONE", "", "", "")
if g:moss_uniform_status_lines == 0
  call s:hi("StatusLine", s:moss8_gui, s:moss3_gui, s:moss8_term, s:moss3_term, "NONE", "")
  call s:hi("StatusLineNC", s:moss4_gui, s:moss1_gui, "NONE", s:moss1_term, "NONE", "")
  call s:hi("StatusLineTerm", s:moss8_gui, s:moss3_gui, s:moss8_term, s:moss3_term, "NONE", "")
  call s:hi("StatusLineTermNC", s:moss4_gui, s:moss1_gui, "NONE", s:moss1_term, "NONE", "")
else
  call s:hi("StatusLine", s:moss8_gui, s:moss3_gui, s:moss8_term, s:moss3_term, "NONE", "")
  call s:hi("StatusLineNC", s:moss4_gui, s:moss3_gui, "NONE", s:moss3_term, "NONE", "")
  call s:hi("StatusLineTerm", s:moss8_gui, s:moss3_gui, s:moss8_term, s:moss3_term, "NONE", "")
  call s:hi("StatusLineTermNC", s:moss4_gui, s:moss3_gui, "NONE", s:moss3_term, "NONE", "")
endif
call s:hi("WarningMsg", s:moss0_gui, s:moss13_gui, s:moss1_term, s:moss13_term, "", "")
call s:hi("WildMenu", s:moss8_gui, s:moss1_gui, s:moss8_term, s:moss1_term, "", "")

" Search
call s:hi("IncSearch", s:moss6_gui, s:moss10_gui, s:moss6_term, s:moss10_term, s:underline, "")
call s:hi("Search", s:moss1_gui, s:moss8_gui, s:moss1_term, s:moss8_term, "NONE", "")

" Tabs
call s:hi("TabLine", s:moss4_gui, s:moss1_gui, "NONE", s:moss1_term, "NONE", "")
call s:hi("TabLineFill", s:moss4_gui, s:moss1_gui, "NONE", s:moss1_term, "NONE", "")
call s:hi("TabLineSel", s:moss8_gui, s:moss3_gui, s:moss8_term, s:moss3_term, "NONE", "")

" Window
call s:hi("Title", s:moss4_gui, "", "NONE", "", "NONE", "")

if g:moss_bold_vertical_split_line == 0
  call s:hi("VertSplit", s:moss2_gui, s:moss0_gui, s:moss3_term, "NONE", "NONE", "")
else
  call s:hi("VertSplit", s:moss2_gui, s:moss1_gui, s:moss3_term, s:moss1_term, "NONE", "")
endif

" Language Base Groups
call s:hi("Boolean",        s:moss9_gui,        "",     s:moss9_term,  "",     "",                "")
call s:hi("Character",      s:moss14_gui,       "",     s:moss14_term, "",     "",                "")
call s:hi("Comment",        s:moss3_gui_bright, "",     s:moss3_term,  "",     s:italic_comments, "")
call s:hi("Conceal",        "",                 "NONE", "",            "NONE", "",                "")
call s:hi("Conditional",    s:moss9_gui,        "",     s:moss9_term,  "",     "",                "")
call s:hi("Constant",       s:moss4_gui,        "",     "NONE",        "",     "",                "")
call s:hi("Decorator",      s:moss12_gui,       "",     s:moss12_term, "",     "",                "")
call s:hi("Define",         s:moss9_gui,        "",     s:moss9_term,  "",     "",                "")
call s:hi("Delimiter",      s:moss6_gui,        "",     s:moss6_term,  "",     "",                "")
call s:hi("Exception",      s:moss9_gui,        "",     s:moss9_term,  "",     "",                "")
call s:hi("Float",          s:moss15_gui,       "",     s:moss15_term, "",     "",                "")
call s:hi("Function",       s:moss8_gui,        "",     s:moss8_term,  "",     "",                "")
call s:hi("Identifier",     s:moss4_gui,        "",     "NONE",        "",     "NONE",            "")
call s:hi("Include",        s:moss9_gui,        "",     s:moss9_term,  "",     "",                "")
call s:hi("Keyword",        s:moss9_gui,        "",     s:moss9_term,  "",     "",                "")
call s:hi("Label",          s:moss9_gui,        "",     s:moss9_term,  "",     "",                "")
call s:hi("Number",         s:moss15_gui,       "",     s:moss15_term, "",     "",                "")
call s:hi("Operator",       s:moss9_gui,        "",     s:moss9_term,  "",     "NONE",            "")
call s:hi("PreProc",        s:moss9_gui,        "",     s:moss9_term,  "",     "NONE",            "")
call s:hi("Repeat",         s:moss9_gui,        "",     s:moss9_term,  "",     "",                "")
call s:hi("Special",        s:moss4_gui,        "",     "NONE",        "",     "",                "")
call s:hi("SpecialChar",    s:moss13_gui,       "",     s:moss13_term, "",     "",                "")
call s:hi("SpecialComment", s:moss8_gui,        "",     s:moss8_term,  "",     s:italic_comments, "")
call s:hi("Statement",      s:moss9_gui,        "",     s:moss9_term,  "",     "",                "")
call s:hi("StorageClass",   s:moss9_gui,        "",     s:moss9_term,  "",     "",                "")
call s:hi("String",         s:moss14_gui,       "",     s:moss14_term, "",     "",                "")
call s:hi("Structure",      s:moss9_gui,        "",     s:moss9_term,  "",     "",                "")
call s:hi("Tag",            s:moss4_gui,        "",     "",            "",     "",                "")
call s:hi("Todo",           s:moss13_gui,       "NONE", s:moss13_term, "NONE", "",                "")
call s:hi("Type",           s:moss9_gui,        "",     s:moss9_term,  "",     "",                "")
call s:hi("Typedef",        s:moss9_gui,        "",     s:moss9_term,  "",     "",                "")
hi! link Annotation Decorator
hi! link Macro Define
hi! link PreCondit PreProc
hi! link Variable Identifier

" ascii
call s:hi("asciidocAttributeEntry", s:moss10_gui, "", s:moss10_term, "", "", "")
call s:hi("asciidocAttributeList", s:moss10_gui, "", s:moss10_term, "", "", "")
call s:hi("asciidocAttributeRef", s:moss10_gui, "", s:moss10_term, "", "", "")
call s:hi("asciidocHLabel", s:moss9_gui, "", s:moss9_term, "", "", "")
call s:hi("asciidocListingBlock", s:moss7_gui, "", s:moss7_term, "", "", "")
call s:hi("asciidocMacroAttributes", s:moss8_gui, "", s:moss8_term, "", "", "")
call s:hi("asciidocOneLineTitle", s:moss8_gui, "", s:moss8_term, "", "", "")
call s:hi("asciidocPassthroughBlock", s:moss9_gui, "", s:moss9_term, "", "", "")
call s:hi("asciidocQuotedMonospaced", s:moss7_gui, "", s:moss7_term, "", "", "")
call s:hi("asciidocTriplePlusPassthrough", s:moss7_gui, "", s:moss7_term, "", "", "")
hi! link asciidocAdmonition Keyword
hi! link asciidocAttributeRef markdownH1
hi! link asciidocBackslash Keyword
hi! link asciidocMacro Keyword
hi! link asciidocQuotedBold Bold
hi! link asciidocQuotedEmphasized Italic
hi! link asciidocQuotedMonospaced2 asciidocQuotedMonospaced
hi! link asciidocQuotedUnconstrainedBold asciidocQuotedBold
hi! link asciidocQuotedUnconstrainedEmphasized asciidocQuotedEmphasized
hi! link asciidocURL markdownLinkText

" awk
call s:hi("awkCharClass", s:moss7_gui, "", s:moss7_term, "", "", "")
call s:hi("awkPatterns", s:moss9_gui, "", s:moss9_term, "", s:bold, "")
hi! link awkArrayElement Identifier
hi! link awkBoolLogic Keyword
hi! link awkBrktRegExp SpecialChar
hi! link awkComma Delimiter
hi! link awkExpression Keyword
hi! link awkFieldVars Identifier
hi! link awkLineSkip Keyword
hi! link awkOperator Operator
hi! link awkRegExp SpecialChar
hi! link awkSearch Keyword
hi! link awkSemicolon Delimiter
hi! link awkSpecialCharacter SpecialChar
hi! link awkSpecialPrintf SpecialChar
hi! link awkVariables Identifier

" c
call s:hi("cIncluded", s:moss7_gui, "", s:moss7_term, "", "", "")
hi! link cOperator Operator
hi! link cPreCondit PreCondit
hi! link cConstant Type

" cmake
call s:hi("cmakeGeneratorExpression", s:moss10_gui, "", s:moss10_term, "", "", "")

hi! link csPreCondit PreCondit
hi! link csType Type
hi! link csXmlTag SpecialComment

" css
call s:hi("cssAttributeSelector", s:moss7_gui, "", s:moss7_term, "", "", "")
call s:hi("cssDefinition", s:moss7_gui, "", s:moss7_term, "", "NONE", "")
call s:hi("cssIdentifier", s:moss7_gui, "", s:moss7_term, "", s:underline, "")
call s:hi("cssStringQ", s:moss7_gui, "", s:moss7_term, "", "", "")
hi! link cssAttr Keyword
hi! link cssBraces Delimiter
hi! link cssClassName cssDefinition
hi! link cssColor Number
hi! link cssProp cssDefinition
hi! link cssPseudoClass cssDefinition
hi! link cssPseudoClassId cssPseudoClass
hi! link cssVendor Keyword

" dt
call s:hi("dtBooleanKey", s:moss7_gui, "", s:moss7_term, "", "", "")
call s:hi("dtExecKey", s:moss7_gui, "", s:moss7_term, "", "", "")
call s:hi("dtLocaleKey", s:moss7_gui, "", s:moss7_term, "", "", "")
call s:hi("dtNumericKey", s:moss7_gui, "", s:moss7_term, "", "", "")
call s:hi("dtTypeKey", s:moss7_gui, "", s:moss7_term, "", "", "")
hi! link dtDelim Delimiter
hi! link dtLocaleValue Keyword
hi! link dtTypeValue Keyword

" diff
if g:moss_uniform_diff_background == 0
  call s:hi("DiffAdd", s:moss14_gui, s:moss0_gui, s:moss14_term, "NONE", "inverse", "")
  call s:hi("DiffChange", s:moss13_gui, s:moss0_gui, s:moss13_term, "NONE", "inverse", "")
  call s:hi("DiffDelete", s:moss11_gui, s:moss0_gui, s:moss11_term, "NONE", "inverse", "")
  call s:hi("DiffText", s:moss9_gui, s:moss0_gui, s:moss9_term, "NONE", "inverse", "")
else
  call s:hi("DiffAdd", s:moss14_gui, s:moss1_gui, s:moss14_term, s:moss1_term, "", "")
  call s:hi("DiffChange", s:moss13_gui, s:moss1_gui, s:moss13_term, s:moss1_term, "", "")
  call s:hi("DiffDelete", s:moss11_gui, s:moss1_gui, s:moss11_term, s:moss1_term, "", "")
  call s:hi("DiffText", s:moss9_gui, s:moss1_gui, s:moss9_term, s:moss1_term, "", "")
endif
" Legacy groups for official git.vim and diff.vim syntax
hi! link diffAdded DiffAdd
hi! link diffChanged DiffChange
hi! link diffRemoved DiffDelete

" git
call s:hi("gitconfigVariable", s:moss7_gui, "", s:moss7_term, "", "", "")

" go
call s:hi("goBuiltins", s:moss7_gui, "", s:moss7_term, "", "", "")
hi! link goConstants Keyword
call s:hi("gomodVersion", s:moss7_gui, "", s:moss7_term, "", "", "")
call s:hi("gomodGoVersion", s:moss8_gui, "", s:moss8_term, "", "", "")

" ?
call s:hi("helpBar", s:moss3_gui, "", s:moss3_term, "", "", "")
call s:hi("helpHyperTextJump", s:moss8_gui, "", s:moss8_term, "", s:underline, "")

" html
call s:hi("htmlArg", s:moss7_gui, "", s:moss7_term, "", "", "")
call s:hi("htmlLink", s:moss4_gui, "", "", "", "NONE", "NONE")
hi! link htmlBold Bold
hi! link htmlEndTag htmlTag
hi! link htmlItalic Italic
hi! link htmlH1 markdownH1
hi! link htmlH2 markdownH1
hi! link htmlH3 markdownH1
hi! link htmlH4 markdownH1
hi! link htmlH5 markdownH1
hi! link htmlH6 markdownH1
hi! link htmlSpecialChar SpecialChar
hi! link htmlTag Keyword
hi! link htmlTagN htmlTag

" java
call s:hi("javaDocTags", s:moss7_gui, "", s:moss7_term, "", "", "")
hi! link javaCommentTitle Comment

" javascript
hi! link javaScriptBraces Delimiter
hi! link javaScriptIdentifier Keyword
hi! link javaScriptNumber Number
call s:hi("jsGlobalNodeObjects", s:moss8_gui, "", s:moss8_term, "", s:italic, "")
hi! link jsBrackets Delimiter
hi! link jsFuncCall Function
hi! link jsFuncParens Delimiter
hi! link jsThis Keyword
hi! link jsNoise Delimiter
hi! link jsPrototype Keyword
hi! link jsRegexpString SpecialChar

" typescript
call s:hi("typescriptBOMWindowMethod", s:moss8_gui, "", s:moss8_term, "", s:italic, "")
call s:hi("typescriptClassName", s:moss7_gui, "", s:moss7_term, "", "", "")
call s:hi("typescriptDecorator", s:moss12_gui, "", s:moss12_term, "", "", "")
call s:hi("typescriptInterfaceName", s:moss7_gui, "", s:moss7_term, "", s:bold, "")
call s:hi("typescriptRegexpString", s:moss13_gui, "", s:moss13_term, "", "", "")
" TypeScript JSX
 call s:hi("tsxAttrib", s:moss7_gui, "", s:moss7_term, "", "", "")
hi! link typescriptOperator Operator
hi! link typescriptBinaryOp Operator
hi! link typescriptAssign Operator
hi! link typescriptMember Identifier
hi! link typescriptDOMStorageMethod Identifier
hi! link typescriptArrowFuncArg Identifier
hi! link typescriptGlobal typescriptClassName
hi! link typescriptBOMWindowProp Function
hi! link typescriptArrowFuncDef Function
hi! link typescriptAliasDeclaration Function
hi! link typescriptPredefinedType Type
hi! link typescriptTypeReference typescriptClassName
hi! link typescriptTypeAnnotation Structure
hi! link typescriptDocNamedParamType SpecialComment
hi! link typescriptDocNotation Keyword
hi! link typescriptDocTags Keyword
hi! link typescriptImport Keyword
hi! link typescriptExport Keyword
hi! link typescriptTry Keyword
hi! link typescriptVariable Keyword
hi! link typescriptBraces Normal
hi! link typescriptObjectLabel Normal
hi! link typescriptCall Normal
hi! link typescriptClassHeritage typescriptClassName
hi! link typescriptFuncTypeArrow Structure
hi! link typescriptMemberOptionality Structure
hi! link typescriptNodeGlobal typescriptGlobal
hi! link typescriptTypeBrackets Structure
hi! link tsxEqual Operator
hi! link tsxIntrinsicTagName htmlTag
hi! link tsxTagName tsxIntrinsicTagName

" json
call s:hi("jsonKeyword", s:moss7_gui, "", s:moss7_term, "", "", "")

" markdown
call s:hi("markdownBlockquote", s:moss7_gui, "", s:moss7_term, "", "", "")
call s:hi("markdownCode", s:moss7_gui, "", s:moss7_term, "", "", "")
call s:hi("markdownCodeDelimiter", s:moss7_gui, "", s:moss7_term, "", "", "")
call s:hi("markdownFootnote", s:moss7_gui, "", s:moss7_term, "", "", "")
call s:hi("markdownId", s:moss7_gui, "", s:moss7_term, "", "", "")
call s:hi("markdownIdDeclaration", s:moss7_gui, "", s:moss7_term, "", "", "")
call s:hi("markdownH1", s:moss8_gui, "", s:moss8_term, "", "", "")
call s:hi("markdownLinkText", s:moss8_gui, "", s:moss8_term, "", "", "")
call s:hi("markdownUrl", s:moss4_gui, "", "NONE", "", "NONE", "")
hi! link markdownBold Bold
hi! link markdownBoldDelimiter Keyword
hi! link markdownFootnoteDefinition markdownFootnote
hi! link markdownH2 markdownH1
hi! link markdownH3 markdownH1
hi! link markdownH4 markdownH1
hi! link markdownH5 markdownH1
hi! link markdownH6 markdownH1
hi! link markdownIdDelimiter Keyword
hi! link markdownItalic Italic
hi! link markdownItalicDelimiter Keyword
hi! link markdownLinkDelimiter Keyword
hi! link markdownLinkTextDelimiter Keyword
hi! link markdownListMarker Keyword
hi! link markdownRule Keyword
hi! link markdownHeadingDelimiter Keyword

call s:hi("mkdCode", s:moss7_gui, "", s:moss7_term, "", "", "")
call s:hi("mkdFootnote", s:moss8_gui, "", s:moss8_term, "", "", "")
call s:hi("mkdRule", s:moss10_gui, "", s:moss10_term, "", "", "")
call s:hi("mkdLineBreak", s:moss9_gui, "", s:moss9_term, "", "", "")
hi! link mkdBold Bold
hi! link mkdItalic Italic
hi! link mkdString Keyword
hi! link mkdCodeStart mkdCode
hi! link mkdCodeEnd mkdCode
hi! link mkdBlockquote Comment
hi! link mkdListItem Keyword
hi! link mkdListItemLine Normal
hi! link mkdFootnotes mkdFootnote
hi! link mkdLink markdownLinkText
hi! link mkdURL markdownUrl
hi! link mkdInlineURL mkdURL
hi! link mkdID Identifier
hi! link mkdLinkDef mkdLink
hi! link mkdLinkDefTarget mkdURL
hi! link mkdLinkTitle mkdInlineURL
hi! link mkdDelimiter Keyword

" php
call s:hi("phpClasses", s:moss7_gui, "", s:moss7_term, "", "", "")
call s:hi("phpClassImplements", s:moss7_gui, "", s:moss7_term, "", s:bold, "")
call s:hi("phpDocTags", s:moss7_gui, "", s:moss7_term, "", "", "")
hi! link phpDocCustomTags phpDocTags
hi! link phpMemberSelector Keyword
hi! link phpClassExtends phpClass
hi! link phpFunction Function
hi! link phpMethod Function
hi! link phpUseClass phpClass

" python
hi! link pythonBuiltin Type
hi! link pythonEscape SpecialChar

" ruby
call s:hi("rubyConstant", s:moss7_gui, "", s:moss7_term, "", "", "")
call s:hi("rubySymbol", s:moss6_gui, "", s:moss6_term, "", s:bold, "")
hi! link rubyAttribute Identifier
hi! link rubyBlockParameterList Operator
hi! link rubyInterpolationDelimiter Keyword
hi! link rubyKeywordAsMethod Function
hi! link rubyLocalVariableOrMethod Function
hi! link rubyPseudoVariable Keyword
hi! link rubyRegexp SpecialChar

" rust
call s:hi("rustAttribute", s:moss10_gui, "", s:moss10_term, "", "", "")
call s:hi("rustEnum", s:moss7_gui, "", s:moss7_term, "", s:bold, "")
call s:hi("rustMacro", s:moss8_gui, "", s:moss8_term, "", s:bold, "")
call s:hi("rustModPath", s:moss7_gui, "", s:moss7_term, "", "", "")
call s:hi("rustPanic", s:moss9_gui, "", s:moss9_term, "", s:bold, "")
call s:hi("rustTrait", s:moss7_gui, "", s:moss7_term, "", s:italic, "")
hi! link rustCommentLineDoc Comment
hi! link rustDerive rustAttribute
hi! link rustEnumVariant rustEnum
hi! link rustEscape SpecialChar
hi! link rustQuestionMark Keyword

" sass
call s:hi("sassClass", s:moss7_gui, "", s:moss7_term, "", "", "")
call s:hi("sassId", s:moss7_gui, "", s:moss7_term, "", s:underline, "")
hi! link sassAmpersand Keyword
hi! link sassClassChar Delimiter
hi! link sassControl Keyword
hi! link sassControlLine Keyword
hi! link sassExtend Keyword
hi! link sassFor Keyword
hi! link sassFunctionDecl Keyword
hi! link sassFunctionName Function
hi! link sassidChar sassId
hi! link sassInclude SpecialChar
hi! link sassMixinName Function
hi! link sassMixing SpecialChar
hi! link sassReturn Keyword

" sh
hi! link shCmdParenRegion Delimiter
hi! link shCmdSubRegion Delimiter
hi! link shDerefSimple Identifier
hi! link shDerefVar Identifier

" sql
hi! link sqlKeyword Keyword
hi! link sqlSpecial Keyword

" xml
call s:hi("xmlAttrib", s:moss7_gui, "", s:moss7_term, "", "", "")
call s:hi("xmlCdataStart", s:moss3_gui_bright, "", s:moss3_term, "", s:bold, "")
call s:hi("xmlNamespace", s:moss7_gui, "", s:moss7_term, "", "", "")
hi! link xmlAttribPunct Delimiter
hi! link xmlCdata Comment
hi! link xmlCdataCdata xmlCdataStart
hi! link xmlCdataEnd xmlCdataStart
hi! link xmlEndTag xmlTagName
hi! link xmlProcessingDelim Keyword
hi! link xmlTagName Keyword

" yaml
call s:hi("yamlBlockMappingKey", s:moss7_gui, "", s:moss7_term, "", "", "")
hi! link yamlBool Keyword
hi! link yamlDocumentStart Keyword

" Vim
call s:hi("vimAugroup", s:moss7_gui, "", s:moss7_term, "", "", "")
call s:hi("vimMapRhs", s:moss7_gui, "", s:moss7_term, "", "", "")
call s:hi("vimNotation", s:moss7_gui, "", s:moss7_term, "", "", "")
hi! link vimFunc Function
hi! link vimFunction Function
hi! link vimUserFunc Function

" ALE
call s:hi("ALEWarningSign", s:moss13_gui, "", s:moss13_term, "", "", "")
call s:hi("ALEErrorSign" , s:moss11_gui, "", s:moss11_term, "", "", "")
call s:hi("ALEWarning" , s:moss13_gui, "", s:moss13_term, "", "undercurl", "")
call s:hi("ALEError" , s:moss11_gui, "", s:moss11_term, "", "undercurl", "")

" Coc
call s:hi("CocWarningHighlight" , s:moss13_gui, "", s:moss13_term, "", "undercurl", "")
call s:hi("CocErrorHighlight" , s:moss1_gui, "", s:moss1_term, "", "undercurl", "")
" call s:hi("CocErrorHighlight" , s:moss11_gui, "", s:moss11_term, "", "undercurl", "")
call s:hi("CocWarningSign", s:moss13_gui, "", s:moss13_term, "", "", "")
call s:hi("CocErrorSign" , s:moss11_gui, "", s:moss11_term, "", "", "")
call s:hi("CocInfoSign" , s:moss8_gui, "", s:moss8_term, "", "", "")
call s:hi("CocHintSign" , s:moss10_gui, "", s:moss10_term, "", "", "")

" Gitgutter
call s:hi("GitGutterAdd", s:moss14_gui, "", s:moss14_term, "", "", "")
call s:hi("GitGutterChange", s:moss13_gui, "", s:moss13_term, "", "", "")
call s:hi("GitGutterChangeDelete", s:moss11_gui, "", s:moss11_term, "", "", "")
call s:hi("GitGutterDelete", s:moss11_gui, "", s:moss11_term, "", "", "")

" Fugitive
call s:hi("gitcommitDiscardedFile", s:moss11_gui, "", s:moss11_term, "", "", "")
call s:hi("gitcommitUntrackedFile", s:moss11_gui, "", s:moss11_term, "", "", "")
call s:hi("gitcommitSelectedFile", s:moss14_gui, "", s:moss14_term, "", "", "")

" NERDTree
call s:hi("NERDTreeExecFile", s:moss7_gui, "", s:moss7_term, "", "", "")
hi! link NERDTreeDirSlash Keyword
hi! link NERDTreeHelp Comment

" CtrlP
hi! link CtrlPMatch Keyword
hi! link CtrlPBufferHid Normal

" vim-plug
call s:hi("plugDeleted", s:moss11_gui, "", "", s:moss11_term, "", "")

" yaml
call s:hi("yamlKey", s:moss7_gui, "", s:moss7_term, "", "", "")

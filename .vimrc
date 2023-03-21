colorscheme pablo
syntax on
" ベル音を消去 & フラッシュ抑制
set visualbell t_vb=
" 行番号を表示する
set number
" ルーラーを表示
set ruler
" タイトルを表示
set title
" 折り返し禁止
set nowrap
" 折り返し許可時に単語の途中で折り返さないようにする
set linebreak
" Tabキーをスペースに変換
set expandtab
" Tabキーの幅
set tabstop=4
" インデント機能の幅
set shiftwidth=4
" 制御文字の可視化
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
" 循環検索の禁止
set nowrapscan
" 検索キーワードをハイライト
set hlsearch
" 大小文字の違いを無視 + スマート検索
set ignorecase smartcase
" タブを常に表示させる
set showtabline=2
" タブに表示する内容を設定 (自作関数で制御している)
set tabline=%!MyTabLine()
" バックアップの類のファイルを作らないように設定
set nobackup
set noswapfile
set noundofile
" オリジナルファイルを残す
"set patchmode=.orig
" ステータスラインを表示
set laststatus=2
" ステータスラインの前背面の色を設定
hi StatusLine guifg=#ffffff guibg=#000000 ctermfg=white ctermbg=black
" ステータスラインに表示する内容を設定
set statusline=%F  " ファイル名表示
set statusline+=%m " 変更チェック表示
set statusline+=%r " 読み込み専用かどうか表示
set statusline+=%h " ヘルプページなら[HELP]と表示
set statusline+=%w " プレビューウインドウなら[Prevew]と表示
set statusline+=%= " これ以降は右寄せ
set statusline+=[Encode:%{&fileencoding}] " 文字コードを表示
set statusline+=[Format:%{&fileformat}]   " 改行コードを表示
set statusline+=[Line:%l,%L] " 現在行数,全行数を表示
set statusline+=[Col:%c]     " 列番号を表示
" コマンドの補完を可視化
set wildmenu
" 自動インデントを禁止
set noautoindent
" マウスを無効化
set mouse=
" クリップボード連携を可能にする
set clipboard+=unnamed
" 単語の区切り文字を追加
set iskeyword+=-


" 全角スペースと不要な半角スペースをハイライトさせる
augroup HighlightSpaces
    autocmd!
    " ハイライトカラーを設定↲
    autocmd VimEnter,WinEnter,ColorScheme * highlight Spaces term=reverse ctermfg=15 ctermbg=9 guifg=White guibg=Red
    " 全角スペースと不要な半角スペースを正規表現で定義
    autocmd VimEnter,WinEnter * match Spaces /\(　\|\s\+$\)/
augroup END


" ----- 自作関数を定義 ----- "
function! MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    return fnamemodify(bufname(buflist[winnr - 1]), ":t")
endfunction

function! MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        " ラベルは MyTabLabel() で作成する
        let my_tab_label = '%{MyTabLabel(' . (i + 1) . ')}'
        " 強調表示グループの選択
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif
        " タブ番号 : [ファイル名] のフォーマットになるように設定
        let s .= (i + 1) . ':[' . my_tab_label . '] '
    endfor

    " 最後のタブページの後は TabLineFill で埋め、タブページ番号をリセットする
    let s .= '%#TabLineFill#%T'

    return s
endfunction



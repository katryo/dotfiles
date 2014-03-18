#----------------------------------------------------------#
#                                                          #
#                         $$\                              #
#                         $$ |                             #
#     $$$$$$$$\  $$$$$$$\ $$$$$$$\   $$$$$$\   $$$$$$$\    #
#     \____$$  |$$  _____|$$  __$$\ $$  __$$\ $$  _____|   #
#       $$$$ _/ \$$$$$$\  $$ |  $$ |$$ |  \__|$$ /         #
#      $$  _/    \____$$\ $$ |  $$ |$$ |      $$ |         #
#     $$$$$$$$\ $$$$$$$  |$$ |  $$ |$$ |      \$$$$$$$\    #
#     \________|\_______/ \__|  \__|\__|       \_______|   #
#                                                          #
#----------------------------------------------------------#

# Locale settings {{{1
export LC_ALL=ja_JP.UTF-8
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8
export OUTPUT_CHARSET=utf-8

# Environment variables {{{1
export PATH=$HOME/bin:$PATH
export DOTFILES=$HOME/work/dotfiles
# 20120612 info_desisn_java Kyoto University class
export CATALINA_HOME=$HOME/work/codes/info_system_design_1/20120612/tomcat_activebpel_ht

# Alias {{{1

# expand aliases before completing
setopt complete_aliases

## General
alias ps='ps aux'
#alias where='command -v'

alias ls='ls -hF'
alias ll='ls -l'
alias lla='ls -lA'
alias la='ls -A'
alias df='df -h'
alias du='du -h'
alias sudo='env PATH=${PATH}:/sbin:/usr/sbin:/usr/local/sbin \sudo'
alias gcc='gcc -Wall -lstdc++'

## Git
#function git(){hub "$@"}
alias g="git"
alias gad="git add"
alias gb="git branch -v"
alias gba="git branch -a"
alias gbr="git branch -r"
alias gc="git commit -v"
alias gco="git checkout"
alias gd="git diff"
alias gdc="git diff --cached"
alias gf="git fetch"
alias gg="git grep -n"
alias ggi="git grep -ni"
alias gl="git log --stat"
alias gll="git log --oneline"
alias glp="git log -p"
alias gls="git ls-files"
alias gm="git merge"
alias gst="git status"
alias gs="git show"
alias gsp="git stash pop"
alias gss="git stash save"
alias gssh="git stash show"
alias gsl="git stash list"
alias gPull="git pull"
# cd to current repo's root dir
alias up='cd ./$(git rev-parse --show-cdup)'
# Show current branch
alias gcb="git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1 /'"

## Other {{{2
## Hg
alias hg="hg --encoding=utf-8"

## Java
alias javac='javac -J-Dfile.encoding=UTF-8'
alias java='java -Dfile.encoding=UTF-8'

## tmux
alias tmux='tmux -u'

# Backspace key {{{1
bindkey "^?" backward-delete-char


# Prompt configuration {{{1
autoload -U colors; colors  # use colors

#
# Color
#
DEFAULT=$'%{\e[1;0m%}'
RESET="%{${reset_color}%}"
GREEN="%{${fg[green]}%}"
BLUE="%{${fg[blue]}%}"
RED="%{${fg[red]}%}"
CYAN="%{${fg[cyan]}%}"
YELLOW="%{${fg[yellow]}%}"
WHITE="%{${fg[white]}%}"
GRAY="%{${fg[GRAY]}%}"

RPROMPT="%T"
setopt transient_rprompt
precmd () {
    PROMPT="${GREEN}%n${RESET}@${BLUE}%m${YELLOW} %~${RESET}" 
    st=`git status 2>/dev/null`
    if [[ -n `echo "$st" | grep "^nothing to"` ]]
    then
        color=${fg[cyan]}
    elif [[ -n `echo "$st" | grep "^nothing added"` ]]
    then
        color=${fg[blue]}
    elif [[ -n `echo "$st" | grep "^# Untracked"` ]]
    then
        color=${fg_bold[red]}
    else
        color=${fg[red]}
    fi
    PROMPT+="
%{$color%}$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1 /')%b${RESET}"
}

# No beep
setopt nobeep

# Use escape sequences
setopt prompt_subst

# Ignore commands following # in cui
setopt interactive_comments

# Disable C-s and C-q
setopt no_flow_control

# Enable Japanese file name
setopt print_eight_bit

# C-w deletes the caractor next to the /
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Show direcotry in water color
export LS_COLORS='di=01;36'

# Automatically escape URL string
autoload -Uz url-quote-magic; zle -N self-insert url-quote-magic

# Colorize
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Don't automatically remove / on the tail
setopt noautoremoveslash


#----------------------------------------------------------
# Move
#----------------------------------------------------------
# Change direcroty with it's name
#
setopt auto_cd
# Execute pushd command when current directory is changed by cd command
#
setopt auto_pushd
setopt pushd_ignore_dups

# History {{{1
# 履歴の保存先
HISTFILE=$HOME/.zsh-history
# メモリに展開する履歴の数
HISTSIZE=10000
# 保存する履歴の数
SAVEHIST=10000
# ヒストリ全体でのコマンドの重複を禁止する
setopt hist_ignore_dups
# コマンドの空白をけずる
setopt hist_reduce_blanks
# historyコマンドはログに記述しない
setopt hist_no_store
# 先頭が空白だった場合はログに残さない
setopt hist_ignore_space
# 履歴ファイルに時刻を記録
setopt extended_history
# シェルのプロセスごとに履歴を共有
setopt share_history
# 複数のzshを同時に使うときなどhistoryファイルに上書きせず追加
setopt append_history
# 履歴をインクリメンタルに追加
setopt inc_append_history
# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify
# 履歴検索機能のショートカット設定
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
# インクリメンタルサーチの設定
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward
# 全履歴の一覧を出力する
history-all () {
    history -E 1
}

# Other {{{1
# ログアウト時にバックグラウンドジョブをkillしない
setopt no_hup
# ログアウト時にバックグラウンドジョブを確認しない
setopt no_checkjobs
# バックグラウンドジョブが終了したら(プロンプトの表示を待たずに)すぐに知らせる
setopt notify

# makeのエラー出力に色付け
e_normal=`echo -e "\033[0;30m"`
e_RED=`echo -e "\033[1;31m"`
e_BLUE=`echo -e "\033[1;36m"`
make () {
    LANG=C command make "$@" 2>&1 | sed -e "s@[Ee]rror:.*@$e_RED&$e_normal@g" -e "s@cannot\sfind.*@$e_RED&$e_normal@g" -e "s@[Ww]arning:.*@$e_BLUE&$e_normal@g"
}


# source-highlight による less の色付け
if [ -x "${HOME}/.source-highlight/src-hilite-lesspipe.sh" ]; then
    export LESS='-R'
    export LESSOPEN="| $HOME/.source-highlight/src-hilite-lesspipe.sh %s"
fi

export GREP_OPTIONS='--color=auto'

# Completion {{{1

# options
# Use full complement functionality
autoload -Uz compinit
compinit
# Toggle complement candidates using TAB
setopt auto_menu
# Show all candidates
setopt auto_list
# Can use Emacs style keybind to select candidates
zstyle ':completion:*:default' menu select=1
# Even option args are complemented
setopt magic_equal_subst
# Insert / after a complemented directory name
setopt auto_param_slash
# Use compackt style candidates viewer mode
setopt list_packed
# Show kinds of file using marks
setopt list_types
# Do spell check
setopt correct
# Complement process name with kill command
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin/bin

## custom {{{2

# cake
_cake () {
    if [ -f Cakefile ]; then
        compadd `cake | grep '^cake ' | sed -e "s/cake \([^ ]*\) .*/\1/" | grep -v '^$'`
    fi
}
compdef _cake cake

# study
study () {
    cd ~/code/study/$1
}
_study () {
    local -a langs
    langs=( $( find ~/code/study/* -type d -maxdepth 0 -exec basename '{}' ';') )
    compadd $langs
    return 1;
}
compdef _study study

# Language specific configuration {{{1

## Python
[ -s /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper.sh
export NOSE_REDNOSE=1
export PYTHONPATH=$HOME/.pythonpath:$PYTHONPATH
export PYTHONSTARTUP=$HOME/.pythonrc.py

## Ruby
[ -s "${HOME}/.rvm/scripts/rvm" ] && source $HOME/.rvm/scripts/rvm
# refe
[ -s "${HOME}/.refe/refe" ] && export PATH=$PATH:$HOME/.refe

## Perl
export PERLBREW_ROOT=$HOME/.perl5/perlbrew
[[ -s "${HOME}/.perl5/perlbrew/etc/bashrc" ]] && source $HOME/.perl5/perlbrew/etc/bashrc
export PERL_BADLANG=0

## Node
[ -s "${HOME}/.nvm/nvm.sh" ] && source $HOME/.nvm/nvm.sh

# Extra zshrc files {{{1

# os depending settings
case ${OSTYPE} in
darwin*) # Mac OS X
    [ -f ~/.zshrc.osx ] && source ~/.zshrc.osx
    ;;
linux*)
    [ -f ~/.zshrc.linux ] && source ~/.zshrc.linux
    ;;
esac

# local settings
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# vimを香り屋にする.
# vim: set foldmethod=marker :
#export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
#alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
#alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'

# http://qiita.com/yaotti/items/157ff0a46736ec793a91
setopt AUTO_CD
cdpath=(.. ~ ~/src)



PATH=/Users/katouryou/bin:/Users/katouryou/bin/osx:/opt/local/bin:/opt/local/sbin:/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources:/Users/katouryou/.rvm/gems/ruby-1.9.3-p125/bin:/Users/katouryou/.rvm/gems/ruby-1.9.3-p125@global/bin:/Users/katouryou/.rvm/rubies/ruby-1.9.3-p125/bin:/Users/katouryou/.rvm/bin:/Users/katouryou/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/usr/local/git/bin:/usr/texbin:/Users/katouryou/bin/osx:/opt/local/bin:/opt/local/sbin:/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources:/Users/katouryou/.rvm/gems/ruby-1.9.3-p125/bin:/Users/katouryou/.rvm/gems/ruby-1.9.3-p125@global/bin:/Users/katouryou/.rvm/rubies/ruby-1.9.3-p125/bin:/Users/katouryou/.rvm/bin:/Users/katouryou/bin

eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/shims:$PATH"
#export PATH="$HOME/.pyenv/shims:$PATH"
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
export PATH=/Applications/Postgres.app/Contents/MacOS/bin:$PATH
export PGDATA=/usr/local/var/postgres
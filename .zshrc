########################################
# 環境変数
typeset -U path PATH
path=(
    /opt/homebrew/bin(N-/)
    /usr/local/bin(N-/)
    $path
)

export LANG=ja_JP.UTF-8

# 色を使用出来るようにする
autoload -Uz colors
colors

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000


# プロンプト
# 1行表示
# PROMPT="%~ %# "
# 2行表示

## git-promptの読み込み
if [ -e ~/.zsh/git-prompt.sh ]; then
else
    mkdir -p ~/.zsh
    pushd ~/.zsh
    curl -o git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
    popd
fi
source ~/.zsh/git-prompt.sh

## プロンプトのオプション表示設定
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

setopt PROMPT_SUBST ; PS1='%F{green}%n@%m%f: %F{cyan}%~%f %F{red}$(__git_ps1 "(%s)")%f
%% '

########################################
# 補完
# 補完機能を有効にする
autoload -Uz compinit
compinit

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


########################################
# Options

setopt print_eight_bit  # 日本語ファイル名を表示可能にする
setopt no_flow_control  # フローコントロールを無効にする
setopt interactive_comments  # '#' 以降をコメントとして扱う
setopt auto_cd  # ディレクトリ名だけでcdする
setopt share_history  # 同時に起動したzshの間でヒストリを共有する
setopt hist_ignore_all_dups  # 同じコマンドをヒストリに残さない
setopt hist_ignore_space  # スペースから始まるコマンド行はヒストリに残さない
setopt hist_reduce_blanks  # ヒストリに保存するときに余分なスペースを削除する


########################################
# Aliases

alias ls='eza'
alias ll='eza -hl --git'
alias la='eza -ahl --git'

# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

# Easier navigation: .., ..., ...., .....
alias ..="cd .."

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# グローバルエイリアス
alias -g ...="cd ../.."
alias -g C='| wc -l'
alias -g G='| egrep'
alias -g L='| less'
alias -g S='| sort'
alias -g T='| tail'
alias -g X='| xargs'


########################################
# OS 別の設定
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        #Linux用の設定
        alias ls='ls -F --color=auto'
        ;;
esac

# aws cli

autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws

# golang - goenv

export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
export GOENV_DISABLE_GOPATH=1
eval "$(goenv init -)"
export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"

# kubernetes
source <(kubectl completion zsh)
alias k=kubectl
complete -o default -F __start_kubectl k

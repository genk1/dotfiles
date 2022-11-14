# autoload
autoload -Uz add-zsh-hook
autoload -Uz colors && colors
autoload -Uz compinit && compinit
autoload -Uz vcs_info

# PATH
if [ -e /etc/profile ]; then
  export PATH="/usr/bin:/bin"
  . /etc/profile
fi
export PATH="/usr/local/sbin:$PATH"

if [ -d "$HOME/github.com" ]; then
  export CDPATH="$HOME/github.com"
fi

# fpath
if [ -d "/usr/local/share/zsh/site-functions" ]; then
  fpath=("/usr/local/share/zsh/site-functions" $fpath)
fi
if [ -d "/usr/local/share/zsh-completions" ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi
if [ -d "${HOME}/.zsh/zsh-completions" ]; then
  fpath=("${HOME}/.zsh/zsh-completions" $fpath)
fi

# include
. ~/.zsh/alias.zsh
. ~/.zsh/prompt.zsh
. ~/.zsh/env.zsh
. ~/.zsh/misc.zsh
. ~/.zsh/docker.zsh
. ~/.zsh/kubectl.zsh
. ~/.zsh/gcloud.zsh
. ~/.zsh/ruby.zsh
. ~/.zsh/node.zsh

# override with zshrc.local
if [ -e ~/.zshrc.local ] ; then
  . ~/.zshrc.local
fi

export PATH=/opt/homebrew/bin:$PATH

function select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle -R -c
}
zle -N select-history
bindkey '^r' select-history

alias g='cd $(ghq root)/$(ghq list | peco)'

alias -g lb='`git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'

export GOPATH=$(go env GOPATH)
export PATH="$GOPATH/bin:$PATH"

eval "$(direnv hook bash)"
export PATH="/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home/bin:$PATH"

alias gi='github .'

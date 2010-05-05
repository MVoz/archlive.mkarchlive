if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
#export PS1='\[\e[1;31m\][\t]\[\e[1;34m\][\u@\h:\w]\[\e[0m\]\$ '
export PS1='\[\e[1;31m\][\t]\[\e[1;34m\]\[\033[01;32m\][\u\[\033[01;34m\]@\[\033[01;33m\]\h \[\033[01;34m\]\W] \$ \[\033[00m\]'
## 针对同时打开多个控制台时 bash 命令历史记录覆盖问题
## 将命令追加到 history 中
#shopt -s histappend
## 在显示命令提示符时保存 history
#PROMPT_COMMAND='history -a'
if [ -e ~/.bash_profile ] ; then
    source ~/.bash_profile
fi
if [ -e /etc/profile.d/bash-completion.sh ] ; then
    . /etc/profile.d/bash-completion.sh
fi

if [[ -f /usr/share/cdargs/cdargs-bash.sh ]] ; then
    source /usr/share/cdargs/cdargs-bash.sh
else
    :
    #echo "/usr/share/cdargs/cdargs-bash.sh not found!"
fi



alias ls='ls --color=auto'
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias ll='ls --color=auto -lh'
alias tee='tee -a'

echo -e "[1;33mWelcome to Archlive!"

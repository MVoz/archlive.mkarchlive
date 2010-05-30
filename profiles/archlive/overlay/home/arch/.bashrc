if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
export PS1='\[\e[1;31m\][\t]\[\e[1;34m\][\u@\h:\w]\[\e[0m\]\$ '
## 针对同时打开多个控制台时 bash 命令历史记录覆盖问题
## 将命令追加到 history 中
#shopt -s histappend
## 在显示命令提示符时保存 history
#PROMPT_COMMAND='history -a'

alias ls='ls --color=auto'
echo -e "\033[1;33mWelcome to Archlive!\033[1;0m"
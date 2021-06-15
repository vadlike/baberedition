HOSTNAME="`cat /etc/hostname`"

INPUT_COLOR="\[\033[0m\]"
DIR_COLOR="\[\033[0;33m\]"
DIR="\w"

LINE_VERTICAL="\342\224\200"
LINE_CORNER_1="\342\224\214"
LINE_CORNER_2="\342\224\224"
LINE_COLOR="\[\033[1;32m\]"

USER_NAME="\[\e[1;32m\]\u\[\e[m\]"
SYMBOL="\[\033[0;32m\]$"

if [[ ${EUID} == 0 ]]; then
    USER_NAME="\[\e[1;32m\]\u\[\e[m\]"
    SYMBOL="\[\033[1;32m\]#"
fi

alias grep='grep --color=always'
alias ls='ls --color=always'
alias md='mkdir -p'
alias mtr='mtr -o "LRSD NBAWV"'
alias dmesg='dmesg --color=always'
alias gcc='gcc -fdiagnostics-color=always'
alias dir='dir --color=always'
alias diff='diff --color=always'
alias nan='nano -c -K -H -Y sh'
alias tcpd='tcpdump -i'
alias tcpdn='tcpdump -nn -i'
alias tcpd6='tcpdump -vv ip6 -i'
alias tcpdn6='tcpdump -nnvv ip6 -i'
alias rcp='rsync -avP'
alias rcpd='rsync -avP --delete-excluded'

alias sys='systemctl'
alias sysg='systemctl list-unit-files | grep'
alias syse='systemctl enable'
alias sysd='systemctl disable'
alias sysr='systemctl restart'
alias pacman='pacman --color=always'

PS1="$LINE_COLOR$LINE_CORNER_1$LINE_VERTICAL $DIR_COLOR$HOSTNAME $LINE_COLOR$USER_NAME $DIR_COLOR$DIR \n$LINE_COLOR$LINE_CORNER_2$LINE_VERTICAL\>$SYMBOL $INPUT_COLOR"

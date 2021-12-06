alias e='emacsclient -n'
alias ta='tmux attach -t'
alias t='tmux new -s'
alias ts='tmux switch -t'
alias cdw='cd ~/vyoma/vmc/ && workon vyoma'
alias peerfind='nmap -sP 192.168.1.0/24; arp-scan --localnet | grep "192.168.1.[0-9]* *ether"'
alias mkvirtualenv3='mkvirtualenv --python=$(which python3.8)'
alias findport="netstat -tulpn|grep "

if [ `type -p go` = "" ]; then
    export PATH=$PATH:/usr/local/go/bin
fi
export GOPATH=$PWD
export PATH=$PATH:$PWD/bin

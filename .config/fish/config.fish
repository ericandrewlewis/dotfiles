# Initialize rbenv
status --is-interactive; and source (rbenv init -|psub)

# Some environment variables
bass source ~/.cc_env

set NVM_DIR "$HOME/.nvm"
bass source (brew --prefix nvm)/nvm.sh

# GOPATH
set GOPATH $HOME/go
set GOROOT /usr/local/opt/go/libexec
set PATH $PATH $GOPATH/bin
set PATH $PATH $GOROOT/bin
set PATH /usr/local/opt/elasticsearch@1.7/bin $PATH

set PATH /Applications/MacVim.app/Contents/bin $PATH

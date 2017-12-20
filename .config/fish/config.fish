# Initialize rbenv
status --is-interactive; and source (rbenv init -|psub)

# Some environment variables
bass source ~/.cc_env

set --export NVM_DIR "$HOME/.nvm"
bass source (brew --prefix nvm)/nvm.sh

# GOPATH
set --export GOPATH $HOME/go
set --export GOROOT /usr/local/opt/go/libexec
set PATH $PATH $GOPATH/bin
set PATH $PATH $GOROOT/bin
set PATH /usr/local/opt/elasticsearch@1.7/bin $PATH


# Up-directory shortcut functions

function ..    ; cd .. ; end
function ...   ; cd ../.. ; end
function ....  ; cd ../../.. ; end
function ..... ; cd ../../../.. ; end
function ...... ; cd ../../../../.. ; end
function ....... ; cd ../../../../../.. ; end

# https://stackoverflow.com/a/6127884/1104036
function git-delete-merged-branches
  git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
end

# https://stackoverflow.com/a/12142066/1104036
function git-current-branch
  git rev-parse --abbrev-ref HEAD
end

# Show hidden files in fzf, along with some other defaults
# set --export FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'



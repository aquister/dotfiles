#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ -f ~/.profile ]] && source ~/.profile

export SSH_AUTH_SOCK=~/.ssh/ssh-agent.$HOSTNAME.socket
if [ ! -S "$SSH_AUTH_SOCK" ]; then
    eval $(ssh-agent -s -a "$SSH_AUTH_SOCK")
    [[ -f ~/.ssh/id_rsa ]] && ssh-add ~/.ssh/id_rsa
    [[ -f ~/.ssh/id_ed25519 ]] && ssh-add ~/.ssh/id_ed25519
fi

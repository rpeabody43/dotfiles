# cd ~
parse_git_branch() {
    git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/ (\1)/"
}
export PS1="\n\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] \012\e[1;34m> \e[0m"
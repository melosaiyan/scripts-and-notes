#!/bin/bash
# ZSH Initialization script
# This can be downloaded and run
# 	chmod +x zsh_initialize.sh && ./zsh_initialize.sh
# or it can be run directly from github
# sh -c "$(wget https://raw.githubusercontent.com/melosaiyan/scripts-and-notes/master/vmware_scripts/zsh_initialize.sh -O -)"

# Debugging purposes
# echo Removing previous oh my zsh installs
# rm -rf ~/.oh-my-zsh ~/.zshrc install.sh
# Debugging purposes

echo "Checking for ZSH and Git install"

ZSH_EXISTS=`which zsh >> /dev/null ; echo $?`
GIT_EXISTS=`which git >> /dev/null ; echo $?`
USER=`whoami`
NEW_LINE_AND_TAB="\n\t"

if [[ $ZSH_EXISTS -eq 1 || $GIT_EXISTS -eq 1 ]]
then
	echo "No zsh or git found. Please install first! Exiting...."
	exit 1
fi

echo "ZSH & Git found!"

echo "Grabbing custom zshrc profile!"

wget https://raw.githubusercontent.com/melosaiyan/scripts-and-notes/master/zshrc/general.zshrc

echo "Moving zsh folder to home directory"

mv general.zshrc ~/.zshrc

ZSH_PATH=`which zsh`

echo "Now downloading Oh My Zsh"

wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh && chmod +x install.sh && mv install.sh /tmp/

ZSH_PREP_COMMANDS="cd ~\/\.oh-my-zsh\/custom\/plugins \&\& ${NEW_LINE_AND_TAB}git clone https:\/\/github\.com\/zsh-users\/zsh-syntax-highlighting \&\& ${NEW_LINE_AND_TAB}git clone https:\/\/github\.com\/zsh-users\/zsh-autosuggestions \&\& ${NEW_LINE_AND_TAB}cd ~\/"

echo $ZSH_PREP_COMMANDS

sed -i "s/exec zsh/${ZSH_PREP_COMMANDS} \&\& ${NEW_LINE_AND_TAB}exec zsh/g" /tmp/install.sh

sh -c "/tmp/install.sh --keep-zshrc"
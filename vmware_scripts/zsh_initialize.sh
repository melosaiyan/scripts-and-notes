# ZSH Initialization script
# INCOMPLETE!! TODO finish this script, probably should be zsh file
echo "Checking for ZSH install"

ZSH_EXISTS=`which zsh | grep -c "zsh"`

if [ $ZSH_EXISTS == 0 ]
then
	echo "No zsh found. Please install first! Exiting...."
	exit 1
fi

echo "ZSH found!"

sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo "Checking for default shell"

SHELL_STRING=`echo $0 | grep -c "zsh"`

echo "# Initial Comment" > ~/.zshrc
export SHELL=`which zsh`
exec "$SHELL" -l

echo $0
exit 0

if [ $SHELL_STRING == 0 ]
then
	echo "Zsh isn't default shell. Initializing..."
	export SHELL=`which zsh`
	exec "$SHELL" -l
fi

echo "Shell is $SHELL"
echo "Script complete."


#~/.oh-my-zsh/custom/plugins && git clone https://github.com/zsh-users/zsh-syntax-highlighting && git clone https://github.com/zsh-users/zsh-autosuggestions
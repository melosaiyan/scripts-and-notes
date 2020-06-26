#!/bin/bash
## TODO Create all components to install all components of linux (apps, zsh, display, etc.)
PACKAGE_MANAGER='apt'
HELP_TEXT='Usage: ./setup_linux [--help]'

#TODO Parse args and add usage text
parse_args() {
    while [ "$1" != "" ]; do
		case $1 in
			-h | --help) HELP_TEXT ;;
			#--skip-chsh) CHSH=no ;;
			#--keep-zshrc) KEEP_ZSHRC=yes ;;
		esac
		shift
	done
}

## TODO Write function to determine packager manager and install all packages
install_packages(){
    echo "Determining package manager installed."

    echo "All packages installed!"
}

## TODO Write function to change display and persist in X11 configs
setup_display() {
    echo "Display setup complete!"
}

## TODO Write function to personalize linux installation
personalize() {
    echo "Personalization settings completed!"
}

## TODO Add/modify functions needed for a new linux installation
main() {
    echo "Installing all linux components."
    parse_args
    install_packages
    setup_display
    personalize
    echo "Post installation complete!"
}

main
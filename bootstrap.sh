#!/usr/bin/env bash
set -eux

cd "$(dirname "${BASH_SOURCE}")";

#git pull origin main;

function doIt() {
	rsync --exclude ".git" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		-avh --no-perms . ~;
	if [[ $SHELL = *"bash" ]]; then
		source ~/.bash_profile;
	elif [[ $SHELL = *"zsh" ]]; then
		source ~/.zshrc
	else
		echo "Currently, only bash and zsh configurations are supported"
	fi
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n)" -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;



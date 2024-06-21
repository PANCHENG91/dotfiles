#!/usr/bin/env bash
set -ex

cd "$(dirname "${BASH_SOURCE}")"

#git pull origin main;

function doIt() {
	rsync --exclude ".git" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "soft_pc/config" \
		-avh --no-perms . ~

	if [[ $(uname -s) = Darwin ]]; then
		rm -rf ~/soft_pc/macos/nvim-macos-arm64 && xattr -c ~/soft_pc/macos/nvim-macos-arm64.tar.gz && tar zxf ~/soft_pc/macos/nvim-macos-arm64.tar.gz -C ~/soft_pc/macos/ && rm ~/soft_pc/macos/nvim-macos-arm64.tar.gz
		rm -rf ~/soft_pc/macos/lazygit/ && mkdir -p ~/soft_pc/macos/lazygit && xattr -c ~/soft_pc/macos/lazygit_0.42.0_Darwin_arm64.tar.gz &&
			tar zxf ~/soft_pc/macos/lazygit_0.42.0_Darwin_arm64.tar.gz -C ~/soft_pc/macos/lazygit && rm ~/soft_pc/macos/lazygit_0.42.0_Darwin_arm64.tar.gz
		rm -rf ~/soft_pc/macos/fd-v10.1.0-aarch64-apple-darwin && xattr ~/soft_pc/macos/fd-v10.1.0-aarch64-apple-darwin.tar.gz &&
			tar zxf ~/soft_pc/macos/fd-v10.1.0-aarch64-apple-darwin.tar.gz -C ~/soft_pc/macos && rm ~/soft_pc/macos/fd-v10.1.0-aarch64-apple-darwin.tar.gz
		rm -rf ~/soft_pc/macos/ripgrep-14.1.0-aarch64-apple-darwin && xattr ~/soft_pc/macos/ripgrep-14.1.0-aarch64-apple-darwin.tar.gz &&
			tar zxf ~/soft_pc/macos/ripgrep-14.1.0-aarch64-apple-darwin.tar.gz -C ~/soft_pc/macos/ && rm ~/soft_pc/macos/ripgrep-14.1.0-aarch64-apple-darwin.tar.gz
	elif [[ $(uname -s) = Linux ]]; then
		rm -rf ~/soft_pc/linux/nvim-linux64 && tar xzf ~/soft_pc/linux/nvim-linux64.tar.gz -C ~/soft_pc/linux/ && rm ~/soft_pc/linux/nvim-linux64.tar.gz
		rm -rf ~/soft_pc/linux/lazygit/ && mkdir -p ~/soft_pc/linux/lazygit && tar zxf ~/soft_pc/linux/lazygit_0.42.0_Linux_x86_64.tar.gz -C ~/soft_pc/linux/lazygit/ &&
			rm ~/soft_pc/linux/lazygit_0.42.0_Linux_x86_64.tar.gz
		rm -rf ~/soft_pc/linux/fd-v10.1.0-x86_64-unknown-linux-gnu && tar zxf ~/soft_pc/linux/fd-v10.1.0-x86_64-unknown-linux-gnu.tar.gz -C ~/soft_pc/linux/ &&
			rm ~/soft_pc/linux/fd-v10.1.0-x86_64-unknown-linux-gnu.tar.gz
		rm -rf ~/soft_pc/linux/ripgrep-14.1.0-x86_64-unknown-linux-musl && tar zxf ~/soft_pc/linux/ripgrep-14.1.0-x86_64-unknown-linux-musl.tar.gz -C ~/soft_pc/linux/ &&
			rm ~/soft_pc/linux/ripgrep-14.1.0-x86_64-unknown-linux-musl.tar.gz
	fi

	if [[ $SHELL = *"bash" ]]; then
		source ~/.bash_profile
		if command -v ~/miniconda3/bin/conda &>/dev/null; then
			~/miniconda3/bin/conda init
		fi
	elif [[ $SHELL = *"zsh" ]]; then
		source ~/.zshrc
	else
		echo "Currently, only bash and zsh configurations are supported"
	fi

	# config soft
	# if command -v ~/soft_pc/linux/nvim-linux64/bin/nvim &>/dev/null; then
	# 	rm -rf ~/.config/nvim
	# 	rm -rf ~/.local/share/nvim
	# 	cp -r ~/dotfiles/soft_pc/config/nvim ~/.config/nvim
	# fi

}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n)" -n 1
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi
unset doIt

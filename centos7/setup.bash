base=$(readlink -f $(dirname $0))

set -e
rm -rf ~/tmp

sudo yum -y update
sudo yum install -y wget vim gcc git automake bison
sudo yum install -y ncurses-devel libevent-devel

# tmux
(
    mkdir -p ~/tmp && cd ~/tmp
    git clone https://github.com/tmux/tmux.git
    cd tmux
    sh autogen.sh
	./configure --prefix=$HOME/local/packages/tmux && make -j && make install
    cp $base/tmux/tmux.conf ~/.tmux.conf
)

# fish
(
	sudo wget -O /etc/yum.repos.d/shells:fish:release:2.repo \
        https://download.opensuse.org/repositories/shells:fish:release:2/CentOS_7/shells:fish:release:2.repo
	sudo yum install -y fish
    mkdir -p ~/.config/fish
    cp -r $base/fish/* ~/.config/fish
    sudo chsh -s /usr/bin/fish $USER
)

# htop
(
    mkdir -p ~/tmp && cd ~/tmp
	rm -rf ~/local/packages/htop
	htop_version=$(curl https://hisham.hm/htop/releases/ | grep '<a' | tail -1 | perl -ne 'print $1 if m|>(.*)/<|')
	curl https://hisham.hm/htop/releases/$htop_version/htop-$htop_version.tar.gz | tar xvzf -
	cd htop-$htop_version
	./configure --prefix=$HOME/local/packages/htop 
	make -j && make install
)

# vim
(
    mkdir -p ~/tmp && cd ~/tmp
	rm -rf ~/local/packages/vim
    git clone https://github.com/vim/vim.git
    cd vim
    ./configure --prefix $HOME/local/packages/vim 
    make -j
    make install
    cp $base/vim/vimrc ~/.vimrc
    mkdir -p ~/.vim-backup
)

# fzf
(
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
)

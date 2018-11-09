base=$(readlink -f $(dirname $0))

set -e
rm -rf ~/tmp

sudo yum install -y wget vim gcc git automake
sudo yum -y install ncurses-devel libevent-devel

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
    cp -r $base/fish/ ~/.config/fish
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
    cp $base/vim/vimrc ~/.vimrc
    mkdir -p ~/.vim-backup
)

# virtualbox
(
    sudo wget -O /etc/yum.repos.d/virtualbox.repo \
        https://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo
    virtualbox_package=$(sudo yum search -y VirtualBox | grep -E '^VirtualBox-5' | tail -1 | cut -d\  -f1)
    sudo yum -y install $virtualbox_package
)

# minikube
(
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
        && sudo install minikube-linux-amd64 /usr/local/bin/minikube
)

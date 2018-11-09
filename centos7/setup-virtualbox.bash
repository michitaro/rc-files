base=$(readlink -f $(dirname $0))

# virtualbox
(
    sudo wget -O /etc/yum.repos.d/virtualbox.repo \
        https://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo
    virtualbox_package=$(sudo yum search -y VirtualBox | grep -E '^VirtualBox-5' | tail -1 | cut -d\  -f1)
    sudo yum -y install $virtualbox_package
    sudo yum -y install xauth
)

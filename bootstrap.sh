set -e
sudo yum -y install git
rm -rf ~/tmp && mkdir -p ~/tmp && cd tmp
git clone https://github.com/michitaro/setup.git

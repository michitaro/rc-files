set -e

cd
[ ! -d setup ]

sudo yum -y install git
git clone https://github.com/michitaro/setup.git

#!/bin/bash

thecp=`which cp`
themv=`which mv`

######################
# update & install

apt-get -y update
apt-get -y dist-upgrade
apt-get -y upgrade
apt-get -y install vim ctags cscope ascii vim lynx pptpd tmux p7zip-full tree netselect emacs gawk lynx nmap
apt-get -y install build-essential autoconf automake gdb dump strace libtool
apt-get -y install python3 python3-pip python-pip
apt-get -y install binutils-doc vim-doc
apt-get -y install aria2 tor

mv /etc/rc2.d/S02tor  /etc/rc2.d/K02tor  # start tor manually by "service tor start"

######################
# modify configuration

# update pptpd password to .sed rule
echo input the password for pptpd service:
read pptpdpwd
sed "s/\(.*\)<changepassword>\(.*\)/\1$pptpdpwd\2/" ./sed/chap-secrets.sed > ./sed/chap-secrets.sed2
$themv ./sed/chap-secrets.sed2 ./sed/chap-secrets.sed

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables-save > /etc/iptables-rules
ip6tables-save > /etc/ip6tables-rules

# conf files list
configfiles=(
/etc/ssh/sshd_config         # modify ssh port
/etc/sysctl.conf
/etc/pptpd.conf
/etc/ppp/pptpd-options
/etc/ppp/chap-secrets
/etc/network/interfaces
~/.bashrc
)
for conffile in ${configfiles[@]}; do
    $themv -f $conffile $conffile.bak
    fileshortname=`expr $conffile : '.*\/\(.*\)'` # 获得短文件名
    sed -f ./sed/$fileshortname.sed $conffile.bak > $confile
done

sysctl -p
service ssh restart
service pptpd restart

######################
# copy initial environment files

$thecp -r -f .bashalias .gitconfig .pythonstartup .tmux.conf .toprc .vimrc .wgetrc .vim bin -t ~/

# import ssh public key
cat ./id_dsa.pub >> ~/.ssh/authorized_keys
cat ./id_rsa.pub >> ~/.ssh/authorized_keys


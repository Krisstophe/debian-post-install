#!/bin/bash

thecp=`which cp`
themv=`which mv`


######################
# update .sed rule
# pptpd service: username / password
# tor service  : port

echo -e "Make sure you have replaced the ssh public key file with your own.\n"

# read pptpd username, default "zhazha"
echo -e "Input the username for **pptpd** service:[zhazha]"
read pptpdusr
if [ "$pptpdusr" == "" ]
then
    pptpdusr="zhazha"
fi

# read pptpd password
echo -e "Input the password for **pptpd** service:"
read pptpdpwd

sed "s/\(.*\)PPTPD_USERNAME\(.*\)/\1$pptpdusr\2/" ./sed/chap-secrets.sed.template | \
    sed "s/\(.*\)PPTPD_PASSWORD\(.*\)/\1$pptpdpwd\2/" - > \
    ./sed/chap-secrets.sed

# read tor service port, default 1999
echo -e "Input the port for **tor** service:[1999]"
read torport
if [ "$torport" == "" ]
then
    torport="1999"
fi
sed "s/\(.*\)TOR_PORT\(.*\)/\1$torport\2/" ./sed/torrc.sed.template > ./sed/torrc.sed
sed "s/\(.*\)TOR_PORT\(.*\)/\1$torport\2/" ./sed/torsocks.conf.sed.template > ./sed/torsocks.conf.sed

echo -e "Ctrl-C to cancel, or press any key to install."
read


######################
# update & install

apt-get -y update
apt-get -y dist-upgrade
apt-get -y upgrade
apt-get -y install vim ctags cscope ascii vim lynx pptpd tmux p7zip-full tree netselect emacs gawk lynx nmap
apt-get -y install build-essential autoconf automake gdb dump strace libtool
apt-get -y install python3 python3-pip python-pip
apt-get -y install binutils-doc vim-doc
apt-get -y install aria2 tor vbindiff nload

######################
# modify configuration

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
/etc/torsocks.conf
/etc/tor/torrc
~/.bashrc
)
for conffile in ${configfiles[@]}; do
    if [ -f $conffile ]
    then
        $themv -f $conffile $conffile.bak
        fileshortname=`expr $conffile : '.*\/\(.*\)'` # 获得短文件名
        sed -f ./sed/$fileshortname.sed $conffile.bak > $conffile
        echo CONFIGURED - $conffile
    else
        echo WARNING - file not found : $conffile
    fi
done

sysctl -p
service ssh restart
service pptpd restart
service tor restart

######################
# copy initial environment files

$thecp -r -f .bashalias .gitconfig .pythonstartup .tmux.conf .toprc .vimrc .vim -t ~/

# import ssh public key
cat ./id_dsa.pub >> ~/.ssh/authorized_keys
cat ./id_rsa.pub >> ~/.ssh/authorized_keys

echo -e "Now everything is ok!\nEnjoy"


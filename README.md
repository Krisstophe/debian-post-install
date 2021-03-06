debian-post-install
===================

My debian post-install environment configuration

## Debian自动配置脚本 ##

自动配置pptpd, ssh, tor服务，及bash, vim+plugin, tmux(C-a)等环境。详见`./deploy.sh`及相应文件。

 经 本地环境 和 [digitalocean.com] VPS 测试，@ Debian 7.5 x64
[digitalocean.com]: https://www.digitalocean.com/?refcode=d9cb66674669

> - PROMO CODE: `ALLSSD10` $10 可试用两月, 亲测可用(2014-08)。

新建debian系统后，以root登录，首先更新ssh登录所需public key文件(id_dsa.pub, id_rsa.pub)。不了解ssh key请自行google`ssh 无密码登录`，或删除`*.pub`文件，每次用密码登录。

安装前脚本会提示输入：

> pptpd服务之用户名和密码
>
> tor服务之端口号

sshd默认增加`22222`/`22225`等PORT，以防端口失效；并设置"ClientAliveInterval 86400"。见`./sed/sshd_config.sed`

```
apt-get -y install git sed iptables
git clone https://github.com/jjzz/debian-post-install
cd debian-post-install
./deploy.sh
```

## 本地客户端 ##

配置pptp拨号以建立vpn

或 命令行建立ssh隧道，浏览器使用socks代理127.0.0.1:7071或7072 [端口请自行选择]

```
# 本地socks + ssh隧道
ssh -qTfnN -D *:7071 root@<SERVER IP> -p <SERVER SSH PORT>
# 本地socks + ssh隧道 + TOR
ssh -qTfnN -L 7072:localhost:<SERVER TOR PORT> root@<SERVER IP> -p <SERVER SSH PORT>
```

That's all!

## Be Careful, Uncle Sam Is Watching You! ##

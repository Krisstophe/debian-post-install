debian-post-install
===================

my debian post install environment configuration
>
> 自动配置新安装的debian系统运行环境
>
> 暂用于本机及digitalocean
>
> 安装配置有pptpd, ssh, tor服务
>
> 新建debian系统后，以root登录
>
```
git clone https://github.com/jjzz/debian-post-install
cd debian-post-install
./deploy.sh
```
>
> 安装前脚本将提示输入pptpd服务之用户名和密码
>
>
>
> 请自行提供ssh无密码登录所需public key文件(id_dsa.pub, id_rsa.pub)
>
> That's all!



# set ssh port to a few others, in case of some ports are banned
/^Port 22$/{
a Port 22222
a Port 22223
a Port 22224
}


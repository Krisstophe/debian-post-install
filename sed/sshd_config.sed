# set ssh port to a few others, in case of some ports are banned
/^Port 22$/{
a Port 22222
a Port 22225
}

${
a
a # keep ssh live for at most 24 hrs
a ClientAliveInterval 86400
}

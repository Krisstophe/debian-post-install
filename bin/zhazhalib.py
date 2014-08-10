#!/usr/bin/python
#encoding: UTF-8

import sys

# MSGS = ( ---  11 secret messages  --- )

def randomhex(size=16):
    return open("/dev/urandom").read(size)

def encrypt(key, msg):
    c = strxor(key, msg)
    print
    print c.encode('hex')
    return c
'''
def main():
    key = random(1024)
    ciphertexts = [encrypt(key, msg) for msg in MSGS]
'''

def strxor(a, b):
    ''' xor two strings of different lengths '''
    if len(a) > len(b):
        return "".join([chr(ord(x) ^ ord(y)) for (x, y) in zip(a[:len(b)], b)])
    else:
        return "".join([chr(ord(x) ^ ord(y)) for (x, y) in zip(a, b[:len(a)])])


def strxorl(a, b, lenret, appendhead = False):
    ''' 字节串异或XOR, 需指定返回字串长度
    传入字串a,b过长则截去
    传入字串a,b过短则补齐
        appendhead = False 尾部补齐'\x00' (默认)
        appendhead = True  头部补齐'\x00' '''
    lena = len(a)
    if lena < lenret:
        if appendhead:
            a = '\x00' * (lenret - lena) + a
        else:
            a = a + '\x00' * (lenret - lena)
    else:
        a = a[:lenret]

    lenb = len(b)
    if lenb < lenret:
        if appendhead:
            b = '\x00' * (lenret - lenb) + b
        else:
            b = b + '\x00' * (lenret - lenb)
    else:
        b = b[:lenret]
    
    return strxor(a, b)

def walkmod(mod, pkgOnly = False):
    ''' 迭代列出模块内部所有的项目
    调用前需先import, 比如:
    import Crypto
    walkmod(Crypto) '''
    from pkgutil import walk_packages
    for _, modname, is_pkg in walk_packages(mod.__path__, mod.__name__ + '.'):
        if pkgOnly:
            if is_pkg:
                print modname
        else:
            starsign = '*' if is_pkg else ' '
            print starsign, modname

def genprime(n):
    ''' generate prime from 2 to n '''
    pp = 2
    ps = [pp]
    while pp < int(n):
        pp += 1
        for a in ps:
            if pp%a==0:
                break
        else: ps.append(pp)
    return ps

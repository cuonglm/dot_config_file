#!/usr/bin/python

from fabric.api import run, local, env, sudo
import os

env.use_ssh_config = True

def h(host_file='fabhosts'):
    """
    Read host from hosts file

    """

    if os.path.isfile(host_file):
        env.hosts = open(host_file, 'r').readlines()
        return 0
    else:
        print '{0} file not found'.format(host_file)
        return 1
                    

def uptime():
    run('echo $HOSTNAME')
    run('uname -s')
    run('uptime')


def local():
    run('echo Le Manh Cuong')
    run('echo Adtech Sysadmin')
    run('echo VC Corporation')


def edit_cmk():
    sudo("sed -i '/only_from/s#$# 192.168.5.192#' /etc/xinetd.d/check_mk")

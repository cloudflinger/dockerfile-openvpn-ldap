FROM centos:7

MAINTAINER Jake Gaylor<jake@cloudflinger.com>

ADD VERSION .

RUN yum update -y && \
  yum install epel-release iptables bash ca-certificates -y && \
  yum update -y && \
  yum install -y python-devel libffi-devel openssl-devel easy-rsa openvpn openvpn-auth-ldap

# Removing config files installed by openvpn or the ldap plugin
RUN rm -rf /etc/openvpn

# Remake the openvpn and openvpn/auth directories
RUN mkdir /etc/openvpn/ && \
    mkdir /etc/openvpn/auth/ && \
    mkdir /etc/openvpn/certs/ && \
    mkdir /var/openvpn-status

RUN mkdir -p /dev/net && \
    mknod /dev/net/tun c 10 200

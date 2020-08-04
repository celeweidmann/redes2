#!/bin/bash

iptables -F
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# Lineas 9 y 10:
iptables -A INPUT -i ens4 -s 0.0.0.0/0 -d 192.168.122.136 -p ICMP --icmp-type echo-request -j ACCEPT
iptables -A OUTPUT -o ens4 -s 192.168.122.136 -d 0.0.0.0/0 -p ICMP --icmp-type echo-reply -j ACCEPT

# Lineas 13 y 14:
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Lineas 17 y 18:
iptables -A INPUT -i ens3 -s 10.1.1.0/24 -d 10.1.1.3 -p TCP --dport 8080 -j ACCEPT
iptables -A OUTPUT -o ens3 -s 10.1.1.3 -d 10.1.1.0/24 -p TCP --sport 8080 -m state --state established -j ACCEPT

#!/bin/bash

# Flush inicial de reglas y configuración de todas las políticas en DROP por default
iptables -F
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# Reglas para que el servidor pueda ofrecer servicio web
iptables -A INPUT -i ens3 -s 10.1.1.0/24 -d 10.1.1.3 -p TCP --sport 1024:65535 --dport 80 -j ACCEPT
iptables -A OUTPUT -o ens3 -s 10.1.1.3 -d 10.1.1.0/24 -p TCP --sport 80 --dport 1024:65535 -m state --state established -j ACCEPT
iptables -A INPUT -i ens3 -s 10.1.1.0/24 -d 10.1.1.3 -p TCP --sport 1024:65535 --dport 443 -j ACCEPT
iptables -A OUTPUT -o ens3 -s 10.1.1.3 -d 10.1.1.0/24 -p TCP --sport 443 --dport 1024:65535 -m state --state established -j ACCEPT

# Reglas para que el servidor pueda enviar pings a los host de LAN interna
iptables -A INPUT -i ens3 -s 10.1.1.0/24 -d 10.1.1.3 -p ICMP --icmp-type echo-reply -j ACCEPT
iptables -A OUTPUT -o ens3 -s 10.1.1.3 -d 10.1.1.0/24 -p ICMP --icmp-type echo-request -j ACCEPT

#!/bin/bash

iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT

## FLUSH de reglas (Borrar reglas aplicadas actualmente)
iptables -F

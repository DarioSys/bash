#!/bin/bash
# Permitir conexiones salientes a puertos específicos
iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 2376 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 5000 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 8443 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 32443 -j ACCEPT

# Permitir respuestas entrantes desde puertos específicos en conexiones establecidas
iptables -A INPUT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp --sport 2376 -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp --sport 5000 -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp --sport 8443 -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp --sport 32443 -m state --state ESTABLISHED -j ACCEPT

# Guardar los cambios en iptables
iptables-save > /etc/iptables/rules.v4

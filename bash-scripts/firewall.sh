#!/bin/bash

# Elimina reglas IPv4 - iptables
iptables -t filter -F            # Elimina todas las reglas de la tabla filter
iptables -t nat -F               # Elimina todas las reglas de la tabla nat
iptables -t filter -Z            # Reinicia los contadores de la tabla filter
iptables -t nat -Z               # Reinicia los contadores de la tabla nat
iptables -t mangle -F            # Elimina todas las reglas de la tabla mangle
iptables -t mangle -X            # Elimina todas las cadenas personalizadas de mangle
iptables -t filter -X            # Elimina todas las cadenas personalizadas de filter
iptables -t raw -F
iptables -t raw -X

# Elimina reglas IPv6 - ip6tables
ip6tables -t filter -F          # Elimina todas las reglas de la tabla filter
ip6tables -t filter -Z          # Reinicia los contadores de la tabla filter
ip6tables -t mangle -F          # Elimina todas las reglas de la tabla mangle
ip6tables -t mangle -X          # Elimina todas las cadenas personalizadas de mangle
ip6tables -t filter -X          # Elimina todas las cadenas personalizadas de filter
ip6tables -t raw -F
ip6tables -t raw -X

# Denegar todas las reglas por defecto
iptables -P INPUT DROP    
iptables -P OUTPUT DROP   
iptables -P FORWARD DROP  

# Denegar todas las reglas por defecto
ip6tables -P INPUT DROP    
ip6tables -P OUTPUT DROP   
ip6tables -P FORWARD DROP  

# Habilitar ICMP
iptables -A OUTPUT -p icmp -j ACCEPT 
iptables -A INPUT  -p icmp -j ACCEPT 

# Habilitar resolución DNS
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A INPUT  -p udp --sport 53 -m state --state ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT
iptables -A INPUT  -p tcp --sport 53 -m state --state ESTABLISHED -j ACCEPT

# Habilitar interfaz loopback 
iptables -I INPUT 1 -i lo -j ACCEPT
iptables -I OUTPUT 1 -o lo -j ACCEPT

# Tráfico HTTP 
iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT  -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT

# Tráfico HTTPS 
iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT  -p tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT

# Permitir tráfico SSH
iptables -A INPUT   -p tcp --dport 63630 -j ACCEPT
iptables -A OUTPUT  -p tcp --sport 63630 -m state --state ESTABLISHED -j ACCEPT

apt install iptables iptables-persistent -y

iptables-save > /etc/iptables/rules.v4


# Puerto para la VPN
#iptables -A INPUT -i enp2s0f5 -p udp --dport 57577 -j ACCEPT
#iptables -A OUTPUT -o enp2s0f5 -p udp --sport 57577 -j ACCEPT

# OpenVPN
#iptables -I INPUT 1 -i tun0 -j ACCEPT
#iptables -I INPUT 1 -i enp2s0f5 -p udp --dport 57577 -j ACCEPT
#iptables -I FORWARD 1 -i enp2s0f5 -o tun0 -j ACCEPT
#iptables -I FORWARD 1 -i tun0 -o enp2s0f5 -j ACCEPT
#iptables -t nat -I POSTROUTING 1 -s 10.8.0.0/24 -o enp2s0f5 -j MASQUERADE
#netfilter-persistent save
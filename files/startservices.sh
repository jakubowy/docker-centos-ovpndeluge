#!/bin/bash

openvpn --config Netherlands.ovpn  &
echo -e "nameserver 209.222.18.222\nnameserver 209.222.18.218" > /etc/resolv.conf


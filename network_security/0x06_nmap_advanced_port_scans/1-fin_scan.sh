#!/bin/bash
sudo nmap -sF -p 80-85 -f -T 2 "$1"

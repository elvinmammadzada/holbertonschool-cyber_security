#!/bin/bash
sudo nmap -p 80,443 --script vulners "$1"

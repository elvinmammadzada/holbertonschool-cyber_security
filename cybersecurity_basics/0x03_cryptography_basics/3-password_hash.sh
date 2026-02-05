#!/bin/bash
salt=$(openssl rand -hex 8)                     # 16-character random value (8 bytes * 2 hex chars)
echo -n "$1$salt" | openssl dgst -sha512 > 3_hash.txt

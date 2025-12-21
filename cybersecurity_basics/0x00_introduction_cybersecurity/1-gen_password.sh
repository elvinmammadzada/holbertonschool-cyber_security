#!/bin/bash
tr -dc '[:alumn:]' < /dev/urandom | head -c "$1"

#!/bin/bash
curl -s -X POST "$2" -H "X-Forwarded-Host: $2" -d "$3"

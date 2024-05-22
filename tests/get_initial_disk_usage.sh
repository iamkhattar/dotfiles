#!/bin/bash

initial_usage=$(df -h -B 1 | grep '/dev/root' | awk '{print $3}')
echo "Initial disk usage: $initial_usage bytes"
echo "initial_usage=$initial_usage" >> $GITHUB_ENV

#!/bin/sh -l

echo "Hello $1"

echo "--- PWD ---"
pwd

echo "--- dump action environment ---"
env | sort

echo "--- dump /github files ---"
find /github -print
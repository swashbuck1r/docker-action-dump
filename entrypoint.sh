#!/bin/sh -l

echo "Hello $1"

echo "--- PWD ---"
pwd

echo "--- action environment ---"
env | sort


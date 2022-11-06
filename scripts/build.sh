#!/usr/bin/env bash

shx rm -rf dist && rollup -c

cd ./backend-rs

bash build.sh


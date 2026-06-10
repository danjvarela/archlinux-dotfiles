#!/usr/bin/env bash

export HOME="/home/dan"
export NVIM_APPNAME="nvim/v3"

cd ~/Documents/notes
kitten quick-access-terminal nvim quick/"$(date +"%Y-%m-%d %H:%M").md"

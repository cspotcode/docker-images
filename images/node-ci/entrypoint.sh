#!/bin/sh
# This incantation ensures the .bashrc is loaded, then delegates to positional args
bash -ic '"$@"' bash "$@"
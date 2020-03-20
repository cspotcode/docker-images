#!/bin/sh
# This incantation ensures the .profile is loaded, then delegates to positional args
bash -l -c '"$@"' bash "$@"
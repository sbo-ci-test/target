#!/bin/sh
# X28 probe (acceptance test): reports only whether credentials are
# reachable, never their values. The marker is assembled at run time so
# the source text alone never contains it.
m="X28""-PROBE-RESULT"
v() { if [ -n "$(printenv "$1" 2>/dev/null)" ]; then echo "$m $1=set"; else echo "$m $1=unset"; fi; }
f() { if [ -e "$1" ]; then echo "$m file $1=exists"; else echo "$m file $1=missing"; fi; }
v ACTIONS_RUNTIME_TOKEN
v GITHUB_TOKEN
v ACTIONS_ID_TOKEN_REQUEST_TOKEN
v ACTIONS_RESULTS_URL
f "$HOME/.git-credentials"
f "$HOME/.docker/config.json"
f "/home/runner/actions-runner/cached/.credentials"
f "/home/runner/actions-runner/.credentials"
f "/home/runner/runners/.credentials"
if git config --get-regexp '^http\..*\.extraheader$' >/dev/null 2>&1; then echo "$m git-extraheader=exists"; else echo "$m git-extraheader=missing"; fi

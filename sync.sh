#!/bin/sh
# Commit local Zed config changes, pull other machines' changes, push.
cd "$(dirname "$0")" || exit 1
export GIT_SSH_COMMAND="ssh -o BatchMode=yes"
git add -A
git diff --cached --quiet || git commit -qm "auto-sync from $(uname -n)"
# ponytail: on a conflict it aborts and retries next hour; resolve by hand if it keeps failing
git pull -q --rebase || { git rebase --abort 2>/dev/null; exit 1; }
git push -q

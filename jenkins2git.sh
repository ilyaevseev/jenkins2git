#!/bin/sh -e

cd "$JENKINS_HOME"

# Add general configurations, secrets, job configurations, nodes, user content, users and plugins info:
ls -1d *.xml secrets/ jobs/*/*.xml nodes/*/*.xml userContent/* users/*/config.xml \
    plugins/*/META-INF/MANIFEST.MF 2>/dev/null | grep -v '^queue.xml$' | xargs -r -d '\n' git add --

# Track deleted files:
LANG=C git status --porcelain | sed -r -e '/^ D /!d' -e 's/^ D //1' | xargs -r git rm --ignore-unmatch

LANG=C git status | grep -q '^nothing to commit' || {
    git commit -m "Automated Jenkins commit at $(date '+%Y-%m-%d %H:%M')"
    git push -q -u origin master
}

## END ##

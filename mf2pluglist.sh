#!/bin/sh
#
#  Generates list in "name:version" format from saved manifests.
#  Can be used by https://github.com/jenkinsci/docker/blob/master/install-plugins.sh
#

test -d plugins || {
    echo "Call me from JENKINS_HOME or from restored dirtree!"
    exit 1
}

awk 'BEGIN { RS = "\r\n" }
     $1 == "Short-Name:"     { n = $2 }
     $1 == "Plugin-Version:" { print n ":" $2 }
    ' ./plugins/*/META-INF/MANIFEST.MF

## END ##

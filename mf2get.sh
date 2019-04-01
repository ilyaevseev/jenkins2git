#!/bin/sh
#
#  Read names/versions from plugin manifests and download .jpi files.
#
#  Requires curl and gawk.
#

cd plugins || {
    echo "Call me from JENKINS_HOME or from restored dirtree!"
    exit 1
}

gawk 'BEGIN     { RS = "\r\n" }
      BEGINFILE { n = v = "" }
      ENDFILE   { printf "curl -sS -L -O http://updates.jenkins-ci.org/download/plugins/%s/%s/%s.hpi\n", n, v, n }
      $1 == "Short-Name:"     { n = $2 }
      $1 == "Plugin-Version:" { v = $2 }
    ' ./*/META-INF/MANIFEST.MF > ./download_all_plugins.sh

echo "RUN NOW:"
echo "cd plugins && sh download_all_plugins.sh"

## END ##

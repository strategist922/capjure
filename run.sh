#!/bin/sh

# Please make sure to configure ~/.clojure.conf or /etc/clojure.conf
#  sample configuration can be found at clojure.conf.sample
#
# Note, running this script will:
#   - Run ~/.clojurerc on boot up (if exists)
#   - Add all .jar files within clj_ext (~/.clojure on default)
#     to the classpath
##

if [ ! -f /etc/clojure.conf -a ! -f ~/.clojure.conf ]; then
    echo "Error: No config not found at /etc/clojure.conf or ~/.clojure.conf."
    echo "  Please provide one before starting this script."
    echo "  A sample can be found in the emacs-clojure repository named "
    echo "   clojure.conf.sample"
    exit
fi

CAPJURE_HOME="."
capjure_jars="${CAPJURE_HOME}/lib/java"
capjure_clj="${CAPJURE_HOME}/spec/"
capjure_src="${CAPJURE_HOME}/src/"

clj_cp="."
clj_cp="${clj_cp}:${capjure_jars}/*:${capjure_src}:${capjure_clj}:${clj_ext}/*"

if [ -n "${clj_lib}" ]; then
    export LD_LIBRARY_PATH=${clj_lib}:$LD_LIBRARY_PATH
fi

# 
echo exec java -Dpid=$$ ${clj_opts} -cp ${clj_cp}:${clj} ${clj_wrapper} clojure.main ${clj_rc} $*
exec java -Dpid=$$ ${clj_opts} -cp ${clj_cp}:${clj} ${clj_wrapper} clojure.main ${clj_rc} $*
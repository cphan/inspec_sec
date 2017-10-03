#!/bin/bash

#####################################################################################
# Purpose: Script to call appropriate OS script to check for security compliance
# Date          Name                  Version         Comments
#------------------------------------------------------------------------
# 2017-10-02    Chris Phan           17.10.02        Initial release
#------------------------------------------------------------------------
#####################################################################################

if [ $# -ne 1 ]; then
  echo "usage $0 <IP or hostname>" 1>&2
  exit 1
fi

inspec exec `dirname $(readlink -f $0)`/../controls/lin_controls.rb -t ssh://root@$1

echo -e "$0 executed on $1"

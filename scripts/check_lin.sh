
#!/bin/bash

if [ $# -ne 1 ]; then
  echo "usage $0 <IP or hostname>" 1>&2
  exit 1
fi

inspec exec `dirname $(readlink -f $0)`/../controls/lin_controls.rb -t ssh://root@$1

echo -e "$0 executed on $1"

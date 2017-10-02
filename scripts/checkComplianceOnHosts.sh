#!/bin/bash

#####################################################################################
# Purpose: Wrapper script of the CMS EregLDAP Transformation Script for AIX/Linux hosts
# Date          Name                  Version         Comments
#------------------------------------------------------------------------
# 2017-09-29    Chris Phan           17.09.29        Initial release
#------------------------------------------------------------------------
#####################################################################################
# VERSION="17.09.29"


# ######################
# # host_file example
# ####################
# deehds0244ccpra 172.18.253.74
# deehds0244ccpxa 172.18.253.73


if [ $# -ne 1 ]; then
  echo "usage $0 <host_file>" 1>&2
  exit 1
fi

ip_file="$1"

user="root"
curtime=$(date +"%Y%m%d-%H%M%S")
log_name="check_compliance"
log_dir="/tmp"
log_file=${log_dir}/${log_name}_${curtime}.log
script_lin="check_lin.sh"
script_aix="check_aix.sh"
script_win="check_win.sh"
script_dir="."
script_name="check_lin.sh"

echo "================================ begin ====================================="
#echo "================================ begin =====================================" | tee -a ${log_file}
#echo "For details, please check logfile: ${log_file}"

while read -u 3 host ip

do
  if [[ "${host}" == "#" || "${host}" == "" ]]
  then
    continue
  else
    #echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" | tee -a ${log_file}
    echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    #echo "Connecting using  ${ip} - ${host}" | tee -a ${log_file}
    echo "Connecting using  ${ip} - ${host}"

    #ssh -n ${user}@${ip} "hostname; date; uname -s; echo 'completed..'; cd ~; exit" | tee -a ${log_file}
    os_level=`ssh -n ${user}@${ip} "uname -s"`
    if [ $os_level = "Linux" ]; then
      script_name="$script_lin"
    elif [ $os_level = "AIX" ]; then
      script_name="$script_aix"
    else
      script_name="$script_win"
    fi

    exe_cmd="${script_dir}/${script_name} ${ip}"
    echo ${exe_cmd} # >> ${log_file}
    ${exe_cmd} # | tee -a ${log_file}
  fi

done 3< ${ip_file}

echo "================================ end ====================================="
#echo "================================ end =====================================" | tee -a ${log_file}
#echo "For details, please check logfile: ${log_file}"

#! /bin/bash 

ls mx/*.json|\
while read flow_name; do\
 has_pattern=`cat $flow_name|jq '.flows[]|.action_sets[]|.actions[]|.msg["spa"]'|awk '{if (length($0) > 150) {print $0}}'`
 if [ ! -z "$has_pattern" ];\
          then echo "$has_pattern $flow_name";\
          fi; \
done

#! /bin/bash 
pattern_to_search="á|é|í|ó|ú|ñ"

ls mx/*.json|\
while read flow_name; do\
 has_pattern=`cat $flow_name| jq '.flows[]|.action_sets'| grep -Eo "$pattern_to_search"|tr "\n" " "`; \
 if [ ! -z "$has_pattern" ];\
          then echo "$flow_name -> $has_pattern";\
          fi; \
done

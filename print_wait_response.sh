#! /bin/bash

ls mx/*.json|\
  while read id_flow; do\
   has_rulset=`cat $id_flow|jq -c '.flows[]|.rule_sets'|awk '$0 !~ /\[\]/{print$0 }' `
   if [ ! -z "$has_rulset" ]; then \
     rule_uuid=(`echo $has_rulset | jq '.[]|.uuid'`)
     for rule in $rule_uuid;
     do
       rule_squotes=`echo $rule|sed 's/"//g'`
      action_set=`cat $id_flow|\
        jq -c --arg v "$rule_squotes" '.flows[]|.action_sets[]|select(.destination != null)|select(.destination|contains($v))'`
      echo $action_set|jq '.actions[]|.msg|.spa'|sed 's/"//g'|awk -v FS="\n" '{split($1,a,"?");print a[2]}'
     done;
   fi;
 done

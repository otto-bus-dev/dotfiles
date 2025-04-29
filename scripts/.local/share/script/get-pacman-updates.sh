#!/bin/bash
updates=$(checkupdates 2>/dev/null | wc -l)
if [ "$updates" -eq 0 ]; then
  echo -e "<span foreground='red'><sup>󰮯 $updates</sup></span>"
else 
  if [ "$updates" -lt 5 ]; then
    echo -e "\e[31m󰮯 $updates"
  else 
    if [ "$updates" -lt 10]; then
      echo -e "\e[32m󰮯 $updates"
    else
      echo -e "\e[32m󰮯 0"
    fi
  fi
fi

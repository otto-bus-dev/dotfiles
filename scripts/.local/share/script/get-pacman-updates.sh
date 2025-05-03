#!/bin/bash
updates=$(checkupdates 2>/dev/null | wc -l)
if [ "$updates" -eq 0 ]; then
  echo -e "<span foreground='#9ccfd8'><sup>󰮯 </sup></span>"
else 
  if [ "$updates" -lt 5 ]; then
    echo -e "<span foreground='#e0def4'><sup>󰮯 $updates</sup></span>"
  else 
    if [ "$updates" -lt 10]; then
      echo -e "<span foreground='#f6c177'><sup>󰮯 $updates</sup></span>"
    else
      echo -e "<span foreground='#eb6f92'><sup>󰮯 $updates</sup></span>"
    fi
  fi
fi

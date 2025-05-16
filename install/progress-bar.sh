#!/bin/bash

progress_bar() {
  local progress=$1
  local total=$2
  local width=40
  local percent=$(( progress * 100 / total ))
  local filled=$(( progress * width / total ))
  local empty=$(( width - filled ))
  printf "\r["
  printf "%0.s#" $(seq 1 $filled)
  printf "%0.s-" $(seq 1 $empty)
  printf "] %d%%" "$percent"
}

# total=100
# for i in $(seq 0 $total); do
#   progress_bar $i $total
#   sleep 0.05
# done
# echo

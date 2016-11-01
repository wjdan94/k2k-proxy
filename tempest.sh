#!/bin/bash

# navigate to tempest, run tests, and save to current_fail.txt
cd /opt/stack/tempest
./run_tempest.sh | grep FAILED > ~/current_fail.txt

# navigate to home, clean the output (split and index), and save to current_fail_clean.txt
cd ~
cat current_fail.txt | tr -s ' ' | cut -d ' ' -f 2 > current_fail_clean.txt

# compare the file of expected tests to current_fail_clean.txt and exit 
if grep -Fxvf expected_fail.txt current_fail_clean.txt 
   then
      echo "unexpected failures"
      exit 1 
   else
      echo "all expected failures"
      exit 0
fi 

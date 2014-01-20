#!/bin/bash

NUM_FAILS=0
NUM_WARNINGS=0

for FILE in $(find Apache/www -iname '*.html' -type f -print ); do
  tidy  -q -e -m  ${FILE}
  echo ${FILE}

  if [ $? -eq 2 ]; then
    ((NUM_FAILS++))
  elif [ $? -eq 1 ]; then
    ((NUM_WARNINGS++))
  fi

done
find  ./Apache/www -iname "*.html" -exec tidy -m -utf8 -i {} \;
if [ ${NUM_FAILS} -gt 0 ]; then
  echo -e "There were ${NUM_FAILS} errors in the files. These have to be fixed manually."
elif [ ${NUM_WARNINGS} -gt 0 ]; then
  echo -e "There were ${NUM_WARNINGS} warnings in the files. These will be fixed automatically"
fi

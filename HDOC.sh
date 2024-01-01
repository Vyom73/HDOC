#!/bin/bash
start_date="2024-01-01"
end_date="2024-12-31"
current_date=$start_date

while [[ "$current_date" < "$end_date" || "$current_date" == "$end_date" ]]
do
  skip=$((RANDOM % 7))
  if [[ $skip -ne 1 && $skip -ne 5 ]]; then
    commits=$((RANDOM % 4 + 2))
    for i in $(seq 1 $commits)
    do
      echo "$current_date $i" >> file.txt
      git add .
      GIT_AUTHOR_DATE="$current_date 12:00:00" \
      GIT_COMMITTER_DATE="$current_date 12:00:00" \
      git commit -m "commit on $current_date"
    done
  fi
  current_date=$(date -j -v+1d -f "%Y-%m-%d" "$current_date" +%Y-%m-%d)
done

#!/bin/bash
input=$(cat)

IFS=$'\t' read -r model pct size dir < <(echo "$input" | jq -r '[
  (.model.display_name | gsub(" \\(.*\\)$"; "")),
  ((.context_window.used_percentage // 0) | floor | tostring),
  ((.context_window.context_window_size // 0) | tostring),
  .workspace.current_dir
] | join("\t")')

if [ "$size" -ge 1000000 ]; then
  size_label="$(( size / 1000000 ))M"
elif [ "$size" -ge 1000 ]; then
  size_label="$(( size / 1000 ))K"
else
  size_label="${size}"
fi

branch=$(git -C "$dir" branch --show-current 2>/dev/null)

dirty=""
if [ -n "$branch" ] && { ! git -C "$dir" diff --quiet 2>/dev/null || ! git -C "$dir" diff --cached --quiet 2>/dev/null; }; then
  dirty="*"
fi

if [ -n "$branch" ]; then
  echo "[${model}] ${branch}${dirty} | ${pct}% / ${size_label}"
else
  echo "[${model}] | ${pct}% / ${size_label}"
fi

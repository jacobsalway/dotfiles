#!/bin/bash
input=$(cat)

IFS=$'\t' read -r model pct dir < <(echo "$input" | jq -r '[
  .model.display_name,
  ((.context_window.used_percentage // 0) | floor | tostring),
  .workspace.current_dir
] | join("\t")')

branch=$(git -C "$dir" branch --show-current 2>/dev/null)

dirty=""
if [ -n "$branch" ] && { ! git -C "$dir" diff --quiet 2>/dev/null || ! git -C "$dir" diff --cached --quiet 2>/dev/null; }; then
  dirty="*"
fi

if [ -n "$branch" ]; then
  echo "[${model}] ${branch}${dirty} | ${pct}%"
else
  echo "[${model}] | ${pct}%"
fi

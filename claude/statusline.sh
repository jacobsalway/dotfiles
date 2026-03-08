#!/bin/bash
input=$(cat)

IFS=$'\t' read -r model pct usedk totalk dir < <(echo "$input" | jq -r '[
  .model.display_name,
  ((.context_window.used_percentage // 0) | floor | tostring),
  ((.context_window.total_input_tokens // 0) / 1000 | floor | tostring) + "k",
  ((.context_window.context_window_size // 200000) / 1000 | floor | tostring) + "k",
  .workspace.current_dir
] | join("\t")')

branch=$(git -C "$dir" branch --show-current 2>/dev/null)

dirty=""
if [ -n "$branch" ] && { ! git -C "$dir" diff --quiet 2>/dev/null || ! git -C "$dir" diff --cached --quiet 2>/dev/null; }; then
  dirty="*"
fi

if [ -n "$branch" ]; then
  echo "[${model}] ${branch}${dirty} | ${pct}% (${usedk} / ${totalk})"
else
  echo "[${model}] | ${pct}% (${usedk} / ${totalk})"
fi

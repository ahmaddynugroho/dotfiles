prompt_git_commit() {
  local full_diff
  local output

  # Capture the entire standard input first
  full_diff=$(cat)

  # Basic check for git diff format (presence of "diff --git")
  if [[ "$full_diff" == *'diff --git'* ]]; then
    output=$(
      cat <<EOF
create semantic commit message with the following criteria:
- always escape backticks (\`) with a backslash (\\)
- add context like 'feat(dashboard)' or 'refactor(auth-register)' to the title
- list what's changed
- use nested list
- use '-' instead of '*' for the list
- use 2 spaces for the nested list
- reply with git commit command (bash)

\`\`\`
$full_diff
\`\`\`
EOF
    )
    echo "$output" | xsel --clipboard
  else
    echo "Input is not a valid git diff."
  fi
}

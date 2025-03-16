prompt_git_commit() {
  local full_diff
  local output

  # Capture the entire standard input first
  full_diff=$(cat)

  # Basic check for git diff format (presence of "diff --git")
  if [[ "$full_diff" == *'diff --git'* ]]; then
    output=$(
      cat <<EOF
- you will create one semantic commit message from git diff
- use list format to list what's changed
- don't mention benefits like 'this will make user happy', 'for better clarity'
- use nested list when possible
- use '-' instead of '*' for the list
- use 2 spaces for the nested list
- always add context like 'feat(dashboard)', 'refactor(auth-register)' for the commit title
- always escape backticks (\`). for example, use \\\`foo\\\` instead of \`foo\`
- reply with 'git commit ...' command and with the commit message so i can run it in my terminal

$full_diff
EOF
    )
    echo "$output" | xsel --clipboard
  else
    echo "Input is not a valid git diff."
  fi
}

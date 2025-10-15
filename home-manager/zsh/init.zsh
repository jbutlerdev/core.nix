# Disable oh-my-zsh auto-updates (declarative now)
zstyle ':omz:update' mode disabled

# GitHub Issues Command
# Pulls open issues from personal notes repository
function gh-issues() {
  local json_output=false

  # Parse arguments
  while [[ $# -gt 0 ]]; do
    case $1 in
      --json)
        json_output=true
        shift
        ;;
      --help|-h)
        echo "Usage: gh-issues [--json]"
        echo ""
        echo "Pulls open issues from https://github.com/jbutlerdev/notes/issues"
        echo ""
        echo "Options:"
        echo "  --json    Output all fields in JSON format"
        echo "  --help    Show this help message"
        echo ""
        echo "Default output is markdown with issue name, description, and filter field."
        return 0
        ;;
      *)
        echo "Unknown option: $1"
        echo "Use 'gh-issues --help' for usage information."
        return 1
        ;;
    esac
  done

  if [ "$json_output" = true ]; then
    # JSON output with all fields
    gh issue list \
      --repo jbutlerdev/notes \
      --state open \
      --json assignees,author,body,closed,closedAt,comments,createdAt,id,isPinned,labels,locked,milestone,number,projectCards,projectItems,reactions,reactionGroups,state,title,updatedAt,url \
      --limit 1000
  else
    # Markdown output with specific fields
    # First get the issues with project items to access filter field
    local issues_json=$(gh issue list \
      --repo jbutlerdev/notes \
      --state open \
      --json number,title,body,projectItems \
      --limit 1000)

    # Process and format as markdown
    echo "$issues_json" | jq -r '.[] |
      "## Issue #\(.number): \(.title)\n" +
      if .body != null and .body != "" then
        "\(.body)\n"
      else
        "*No description*\n"
      end +
      if (.projectItems | length) > 0 then
        (
          .projectItems |
          map(
            if .fieldValues != null then
              (.fieldValues |
                map(
                  if .name != null then
                    "**Filter:** \(.name)"
                  else
                    empty
                  end
                ) | join("\n")
              )
            else
              empty
            end
          ) | join("\n")
        ) + "\n"
      else
        ""
      end +
      "---\n"'
  fi
}
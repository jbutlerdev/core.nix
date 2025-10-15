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
    # Use gh API with GraphQL for better project field access
    gh api graphql -f query='
      query {
        repository(owner: "jbutlerdev", name: "notes") {
          issues(first: 100, states: OPEN) {
            nodes {
              number
              title
              body
              projectItems(first: 10) {
                nodes {
                  project {
                    title
                  }
                  fieldValues(first: 10) {
                    nodes {
                      ... on ProjectV2ItemFieldSingleSelectValue {
                        name
                        field {
                          ... on ProjectV2SingleSelectField {
                            name
                          }
                        }
                      }
                      ... on ProjectV2ItemFieldTextValue {
                        text
                        field {
                          ... on ProjectV2Field {
                            name
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    ' | jq -r '.data.repository.issues.nodes[] |
      "## Issue #\(.number): \(.title)\n" +
      if .body != null and .body != "" then
        "\(.body)\n"
      else
        "*No description*\n"
      end +
      if (.projectItems.nodes | length) > 0 then
        (
          .projectItems.nodes |
          map(
            if (.fieldValues.nodes | length) > 0 then
              (.fieldValues.nodes |
                map(
                  if .name != null and .field.name == "Filter" then
                    "**Filter:** \(.name)"
                  elif .text != null and .field.name == "Filter" then
                    "**Filter:** \(.text)"
                  else
                    empty
                  end
                ) | join("")
              )
            else
              empty
            end
          ) | join("")
        ) + (if (.projectItems.nodes | map(.fieldValues.nodes | map(select(.name != null or .text != null)) | length) | add // 0) > 0 then "\n" else "" end)
      else
        ""
      end +
      "---\n"'
  fi
}
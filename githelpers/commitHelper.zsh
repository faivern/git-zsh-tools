#!/usr/bin/env zsh
# --- Conventional Commits Helper ---
# Usage: gcm   -> interactive menu (type → scope → summary → why → commit)
# Customize commit types by editing the TYPES array.

commit_msg_menu() {
    # Ensure we are in a git repo
    git rev-parse --git-dir > /dev/null 2>&1 || { echo "Not a git repository."; return 1; }

    # Ensure there is something to commit
    if git diff --cached --quiet && git diff --quiet; then
        echo "No changes staged! Use 'git add' to stage changes."
        return 1
    fi

      # If nothing staged but there are unstaged changes, offer to stage interactively (optional)
      if git diff --cached --quiet && ! git diff --quiet; then
        read -r "stage_now?Stage changes interactively with 'git add -p' [y/N]: "
        [[ "$stage_now" =~ ^[Yy]$ ]] && git add -p
        git diff --cached --quiet && { echo "Still no staged changes. Aborting."; return 1; }
      fi

    # --- config ----------------------------------------------------------------
    local -a TYPES=(
        "feat:     New feature"
        "fix:      Bug fix"
        "docs:     Documentation only changes"
        "style:    Formatting/whitespace, no logic"
        "refactor: Code change, no feature/fix"
        "perf:     Performance improvement"
        "test:     Add/adjust tests"
        "chore:    Build/tools/infra"
    )
    local MAX_SUMMARY_LENGTH=72
    local PS3="Select commmit type (1-${#TYPES[@]}): "

    # --- select type ------------------------------------------------------------
    echo "Select commit type:"
    local choice type desc
    select choice in "${TYPES[@]}"; do
        if [[ -n "$choice" ]]; then
        type="${choice%%:*}"
        desc="${choice#*: }"
        break
        fi
        echo "Invalid choice. Try again."
    done
    echo "→ ${type}: ${desc}"

    # --- scope ------------------------------------------------------------------
    local scope
    read -r "scope?Scope (e.g., api, ui, auth) [optional]: "
    [[ -n "$scope" ]] && scope="($scope)"

    # --- summary (validate) -----------------------------------------------------
    local summary
    while true; do
        read -r "summary?Short summary (imperative, ≤${MAX_SUMMARY_LENGTH} chars): "
        [[ -z "$summary" ]] && { echo "Summary is required."; continue; }
        if (( ${#summary} > MAX_SUMMARY_LENGTH )); then
            echo "${#summary} chars (recommended ≤${MAX_SUMMARY_LENGTH}). Continue? [y/N]"
            local ok; read -r ok
            [[ "$ok" =~ ^[Yy]$ ]] || continue
        fi
        break
    done
    
    # --- why --------------------------------------------------------------------
    local why
    read -r "why?Why (motivation/problem solved): "

    # --- build message & commit -------------------------------------------------
    local header="${type}${scope:+${scope}}: ${summary}"
    local why_block=""
    [[ -n "$why" ]] && why_block="Why: ${why}"

    if [[ -n "$why_block" ]]; then
        git commit -m "$header" -m "$why_block"
    else
        git commit -m "$header"
    fi
}

alias gcm="commit_msg_menu"
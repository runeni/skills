---
name: git-feature
description: Push the current feature branch to origin and open a GitHub PR with a title and task reference. Use when the user wants to push a branch and create a PR.
---

# Git Feature

Push the current branch and open a pull request.

## Workflow

1. Run `git branch --show-current` to get the current branch name
2. **If the branch is `main` or `master`, stop immediately** — do not push or open a PR from main.
3. Extract the task ID from the branch name — branches follow `<type>/<taskid>-<description>` (e.g. `feature/42-add-oauth` → `42`)
4. Determine the PR subject from the most recent commit subject (`git log -1 --format=%s`)
5. Push the branch and open a PR:
   ```bash
   git push -u origin <branch>
   gh pr create --title "<subject>" --body "Ref: #<taskid>"
   ```
6. Return the PR URL to the user

## Notes

- Run `/git-commit` first if there are uncommitted changes
- The PR body uses the same `Ref: #<taskid>` footer convention as commits

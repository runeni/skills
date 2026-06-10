---
name: git-commit
description: Write a well-formed git commit message in imperative style with an optional body and a task reference footer. Use when the user asks to commit, write a commit message, stage changes, or wrap up a coding session.
---

# Git Commit

## Format

```
<subject>

[optional body]

Ref: #<taskid>
```

- **Subject**: imperative mood, ≤72 chars, no period ("Add login flow", not "Added login flow")
- **Body**: include only when the *why* is non-obvious; wrap at 72 chars
- **Footer**: always present — blank line, then `Ref: #<taskid>`

## Workflow

1. Run `git branch --show-current` to get the current branch name
2. **If the branch is `main` or `master`, stop immediately** — warn the user that direct commits to main are not allowed and ask them to create a feature branch first (e.g. `git checkout -b feature/<taskid>-<description>`). Do not proceed with the commit.
3. Extract the task ID — branch names follow `<type>/<taskid>-<description>` (e.g. `feature/1283-add-oauth` → `1283`)
4. Run `git diff --staged` (or `git diff HEAD` if nothing staged) to understand the change
5. Draft the subject: one imperative sentence summarising *what* changed
6. Add a body paragraph if the motivation or constraints aren't obvious from the subject
7. Append the footer: blank line + `Ref: #<taskid>`
8. Commit using a heredoc to preserve formatting:
   ```bash
   git commit -m "$(cat <<'EOF'
   <subject>

   [body]

   Ref: #<taskid>
   EOF
   )"
   ```

## Examples

```
Add OAuth2 login via Google and GitHub

Required by the enterprise SSO rollout; password-only auth is being
deprecated for business accounts.

Ref: #1283
```

```
Fix null pointer on empty cart checkout

Ref: #998
```

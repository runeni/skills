---
name: git-feature
description: Manage the full lifecycle of a feature branch — create branch, commit, push, and open a PR. Does NOT merge to main; PRs handle that. Use when the user asks to start a feature, work on a feature branch, make a commit on a feature, wrap up a feature, or create a feature PR.
---

# Git Feature

## Branch naming

```
feature/<taskid>-<short-description>
```

Extract `<taskid>` from the task/ticket reference (e.g. `feature/42-add-oauth`).

## Workflows

### Start a feature

1. Confirm you're on `main` and it's up to date: `git checkout main && git pull`
2. Create and switch to the feature branch:
   ```bash
   git checkout -b feature/<taskid>-<description>
   ```

### Commit on a feature branch

1. Run `git branch --show-current` — extract `<taskid>` from `feature/<taskid>-<description>`
2. Run `git diff --staged` (or `git diff HEAD` if nothing staged)
3. Draft the commit message:
   - **Subject**: imperative mood, ≤72 chars, no period
   - **Body**: only if the *why* is non-obvious; wrap at 72 chars
   - **Footer**: always `Ref: #<taskid>`
4. Commit:
   ```bash
   git commit -m "$(cat <<'EOF'
   <subject>

   [body]

   Ref: #<taskid>
   EOF
   )"
   ```

### Wrap up — push and open PR

1. Push the branch: `git push -u origin HEAD`
2. Create a PR:
   ```bash
   gh pr create --title "<subject>" --body "$(cat <<'EOF'
   ## Summary
   - <bullet points>

   ## Test plan
   - [ ] <steps>

   Ref: #<taskid>
   EOF
   )"
   ```
3. Return the PR URL to the user.

> Merging to main is out of scope — that happens via the PR.

## Example commit

```
Add OAuth2 login via Google and GitHub

Required by the enterprise SSO rollout; password-only auth is being
deprecated for business accounts.

Ref: #42
```

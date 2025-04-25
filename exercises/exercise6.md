# Exercise 6: Advanced Git History Refinement

## Scenario: Professional History Management with Interactive Rebase

This exercise masters `git rebase --interactive` for precise history control.

## Tasks

### 1. Correct Non-Recent Commit Messages

```bash
git checkout -b fix-messages interactive-rebase-base
git log --oneline  # Review existing commits
git rebase -i HEAD~3  # Open interactive editor

# Change: pick → reword (or r) for the commit with typo
# Save, then edit message in next editor
```

**Pro tip:** When fixing multiple messages, list all of them as `reword` - Git will prompt for each one.

### 2. Consolidate Related Work

```bash
git checkout -b squash-commits interactive-rebase-base
git rebase -i HEAD~4

# Change: keep first commit as pick, change others to squash (or s)
# Edit the unified commit message in next editor
```

**Variations:**
- `fixup` (or `f`): Like squash but discards the commit message
- `squash`: Combines messages for comprehensive history

### 3. Logical Commit Sequencing

```bash
git checkout -b reorder-commits interactive-rebase-base
git rebase -i HEAD~4

# Reorder lines in editor (cut/paste)
# Ensure related commits are adjacent
```

**Best for:** Grouping documentation changes, test additions, or refactors.

### 4. Remove Problematic Commits

```bash
git checkout -b remove-commit interactive-rebase-base
git rebase -i HEAD~4

# Delete line or change pick → drop
```

**Warning:** May cause conflicts if later commits depend on removed content.

### 5. Split Overly Large Commits

```bash
git checkout -b split-commit interactive-rebase-base
git rebase -i HEAD~4

# Change: pick → edit (or e) for target commit
# When rebase pauses:
git reset HEAD^  # Unstage changes
git add file1.txt
git commit -m "First logical change"
git add file2.txt
git commit -m "Second logical change"
git rebase --continue
```

**Application:** Create focused, reviewable commits from large changes.

### 6. Comprehensive History Cleanup

```bash
git checkout -b advanced-rebase interactive-rebase-base
git rebase -i HEAD~5

# In one operation:
# - Reword typo commits
# - Reorder related commits together
# - Squash minor commits
# - Edit large commits
```

**Conflict handling:**
- Resolve each conflict as it occurs
- Use `git rebase --continue` after each resolution
- Use `git rebase --abort` to start over if needed

## Best Practices

- Create a backup branch before complex rebases
- Never rebase public/shared branches
- Keep rebases focused on specific history segments
- Test after rebasing to ensure functionality
- Use `--force-with-lease` if pushing rebased history

Remember: Clean history helps future developers understand your project's evolution.

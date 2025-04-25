# Exercise 2: Advanced Git Operations

## Scenario: Multi-Team Feature Integration

This exercise covers sophisticated Git techniques for maintaining clean history while coordinating complex development work across teams.

## Tasks

### 1. Cherry-Picking Strategic Changes

Apply specific changes from one branch to another without full integration.

```bash
# Identify and apply a specific commit from feature_2 to dev
git checkout dev
git log feature_2 --oneline --graph  # Identify valuable commit
git cherry-pick <commit-hash>
```

**Why use cherry-pick?**
- Selectively applies individual commits from any branch
- Preserves critical fixes without waiting for full feature completion
- Creates a new commit with the same changes but different hash
- Useful for backporting fixes to release branches

### 2. History Cleanup with Interactive Rebase

Refine your commit history before integration to improve clarity.

```bash
# Clean up feature branch history
git checkout feature_1
git log --oneline -n 10  # Review recent commits
git rebase -i HEAD~5  # Modify last 5 commits

# Commands available in interactive rebase:
# p, pick   = use commit
# r, reword = use commit, but edit the commit message
# e, edit   = use commit, but stop for amending
# s, squash = use commit, but meld into previous commit
# f, fixup  = like squash, but discard this commit's message
# d, drop   = remove commit
```

**Best practices:**
- Squash related minor commits (typo fixes, small adjustments)
- Keep significant logical changes as separate commits
- Ensure each commit passes tests and builds successfully
- Use descriptive commit messages that explain both what and why

### 3. Managing Detached HEAD States

Work effectively with branches created from historical commits.

```bash
# Analyze feature branch relationship to current development
git checkout feature_2
git log --graph --oneline --all  # Visualize branch relationships
git merge-base feature_2 dev     # Find common ancestor

# Decision point: rebase or merge?
git checkout feature_2
git rebase dev  # If maintaining linear history is priority
# OR
git checkout dev
git merge feature_2  # If preserving feature history is priority
```

**Decision framework:**
- Rebase when feature diverged long ago but needs current context
- Merge when feature represents complete, isolated functionality
- Consider team impact - rebase requires coordination if shared

### 4. Disaster Recovery with Reflog

Recover from accidental branch deletion and other Git mistakes.

```bash
# Create and accidentally delete a branch
git checkout -b experimental dev
# Make changes and commit
git add .
git commit -m "Experimental feature implementation"
git checkout dev
git branch -D experimental  # Simulate accidental deletion

# Recovery process
git reflog                  # Find the commit hash of deleted branch tip
git checkout -b recovered <commit-hash>  # Recreate branch
```

**Additional recovery techniques:**
- `git fsck --lost-found` identifies unreferenced objects
- `git stash list` recovers uncommitted but stashed changes
- Recovery window typically lasts 30-90 days (before garbage collection)

## Advanced Workflow Guidelines

| Technique | Best Used When | Cautions |
|-----------|---------------|----------|
| Cherry-pick | Need specific fixes without full feature | Creates duplicate commits; may cause merge conflicts later |
| Interactive rebase | Cleaning history before integration | Only for non-public branches; requires careful conflict resolution |
| Detached HEAD | Exploring historical states or hotfixes | Easy to lose work if not creating a branch |
| Reflog | Recovering from Git mistakes | Time-limited; works best before garbage collection |

# Exercise 1: When to Use Git Rebase vs Merge

## Scenario: Managing Feature Development and Hotfixes

This exercise demonstrates when to use rebase versus merge during typical Git workflows, focusing on maintaining a clean history while effectively integrating features.

## Tasks

### 1. Update Development Branch with Main Branch Changes

When hotfixes are applied to main, bring those changes into your development branch to keep it current.

```bash
# Update dev branch with hotfix changes from main
git checkout dev
git rebase main
```

**Why rebase here?**
- Creates a linear history by applying dev changes on top of main
- Prevents unnecessary merge commits in your development branch
- Makes the branch history clearly show that dev contains all main changes

### 2. Keep Feature Branches in Sync with Development

Feature branches should regularly incorporate changes from their parent branch.

```bash
# Update feature branch with latest dev changes
git checkout feature_1
git rebase dev
```

**Benefits of this approach:**
- Allows early conflict detection and resolution
- Ensures features are built on the latest development code
- Simplifies eventual feature integration
- Keeps feature branches deployable for testing

### 3. Handle Rebase Conflicts Effectively

Conflicts during rebasing require careful resolution to preserve both sets of changes.

```bash
# Resolve conflicts during rebase
git checkout feature_3
git rebase main
# When conflict occurs:
git status  # Identify conflicted files
# Edit files to resolve conflicts
git add <resolved-files>
git rebase --continue
```

**Key conflict resolution steps:**
1. Understand both changes before resolving
2. Preserve the intent of both changes where possible
3. Test your resolution before continuing
4. Use `git rebase --abort` if you need to start over

### 4. Integrate Completed Features

When a feature is complete, merge it back to preserve its development history.

```bash
# Integrate completed feature into dev
git checkout dev
git merge --no-ff feature_1
```

**Why merge with --no-ff here?**
- Creates a merge commit that groups all feature changes
- Preserves the feature's development history
- Makes it easy to identify and revert entire features if needed
- Provides clear documentation of when features were integrated

## Best Practices Summary

| Operation | When to Use Rebase | When to Use Merge |
|-----------|-------------------|------------------|
| **Updating branches** | Keep feature branches in sync with parent branches | ❌ Not recommended for updates |
| **Feature integration** | ❌ Not recommended for integration | Integrate completed features into parent branches |
| **Public branches** | ❌ Never rebase shared/public branches | ✓ Always merge into public branches |
| **Private branches** | ✓ Rebase to maintain a clean history | ✓ Merge for complex feature integration |

**Remember:** Never rebase branches that others are working on or that have been pushed publicly.

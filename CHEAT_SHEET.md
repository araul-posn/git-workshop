# Git Workshop Cheatsheet

## Basic Git Commands

```bash
# View branch structure
git log --graph --oneline --all --decorate

# List all branches
git branch

# Switch to a branch
git checkout <branch-name>

# Create and switch to a new branch
git checkout -b <new-branch-name>

# Get current status
git status
```

## Rebase Workflow (Update branch with parent changes)

```bash
# 1. Switch to the branch you want to update
git checkout <feature-branch>

# 2. Rebase onto the parent branch
git rebase <parent-branch>

# 3. If conflicts occur:
#    - Edit files to resolve conflicts
#    - Add resolved files
git add <resolved-files>
#    - Continue the rebase
git rebase --continue
#    - Or abort if needed
git rebase --abort
```

## Merge Workflow (Integrate completed features)

```bash
# 1. Switch to the target branch (where you want to merge changes)
git checkout <target-branch>

# 2. Merge the feature branch
git merge <feature-branch>

# 3. If conflicts occur:
#    - Edit files to resolve conflicts
#    - Add resolved files
git add <resolved-files>
#    - Complete the merge
git merge --continue
#    - Or abort if needed
git merge --abort
```

## Conflict Resolution

When you see conflict markers like:

```
<<<<<<< HEAD
(Current branch changes)
=======
(Incoming branch changes)
>>>>>>> feature-branch
```

1. Edit the file to keep the desired changes
2. Remove the conflict markers
3. Save the file
4. Add the file with `git add <filename>`
5. Continue with either `git rebase --continue` or `git merge --continue`

## Visualizing History

```bash
# Compact history of all branches
git log --graph --oneline --all --decorate

# Detailed history with file changes
git log --graph --stat <branch-name>

# Show changes in a specific commit
git show <commit-hash>
```

## Remote Repository Operations

```bash
# Fetch changes from remote without merging
git fetch <remote>

# Pull changes from remote (fetch + merge)
git pull <remote> <branch>

# Pull with rebase instead of merge
git pull --rebase <remote> <branch>

# Push local changes to remote
git push <remote> <branch>
```

### Fetch vs Pull

**git fetch:**
- Downloads new data from remote repository
- Updates your remote-tracking branches
- Does NOT automatically merge or modify your working directory
- Gives you a chance to review changes before merging
- Safer option when you want to see changes before integrating

**git pull:**
- Combination of `git fetch` + `git merge` (or `git rebase` with --rebase flag)
- Downloads new data AND automatically updates your current branch
- Immediately incorporates remote changes into your working directory
- More convenient but less granular control
- Use `git pull --rebase` to maintain a linear history

## When to Use Rebase vs Merge

**Use Rebase When:**
- Updating a feature branch with parent changes
- Keeping development branch in sync with main
- You want a clean, linear history

**Use Merge When:**
- Integrating a completed feature into a parent branch
- You want to preserve branch history
- Multiple people are working on the same branch
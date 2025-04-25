# Exercise 3: Enterprise Git Workflows

## Scenario: Collaborative Development Patterns

This exercise demonstrates industry-standard Git workflows used by professional development teams to coordinate complex projects.

## Tasks

### 1. Implementing GitFlow

GitFlow provides a robust branching strategy for managing releases in larger projects.

```bash
# Create and manage a release using GitFlow
git checkout dev
git checkout -b release/v1.0
git checkout -b bugfix/login-issue release/v1.0

# After fixing the bug:
git checkout release/v1.0
git merge --no-ff bugfix/login-issue -m "Fix login issue before release"
git checkout main
git merge --no-ff release/v1.0 -m "Release version 1.0"
git tag -a v1.0.0 -m "Version 1.0.0 - Initial stable release"
git checkout dev
git merge --no-ff release/v1.0 -m "Sync dev with release v1.0"
```

**Key principles:**
- `main` contains only production-ready code
- `dev` serves as integration branch for features
- `release/*` branches allow final testing and bugfixes
- `hotfix/*` branches address urgent production issues
- All merges use `--no-ff` to preserve context

### 2. Managing Long-lived Feature Branches

Keep extended development work synchronized with evolving codebase.

```bash
# Initialize long-running feature
git checkout -b feature/authentication dev

# Periodically update with upstream changes (every few days)
git checkout dev
git pull
git checkout feature/authentication
git rebase dev

# If conflicts occur:
git rebase --continue  # after resolving
# or
git rebase --abort     # to try again later

# Create specific sub-feature branches when needed
git checkout -b feature/auth-password-reset feature/authentication
```

**Strategies for maintainability:**
- Break large features into smaller, mergeable sub-features
- Schedule regular rebases (2-3 times per week)
- Consider feature flags to merge incomplete functionality
- Document API boundaries early to reduce integration conflicts

### 3. Code Review Workflow

Simulate professional code review process with local tools.

```bash
# Prepare a feature for review
git checkout -b feature/payment-api
# Make changes and commit
git push -u origin feature/payment-api  # In real environment

# Create review materials
git diff dev..feature/payment-api > review.diff
git log --patch dev..feature/payment-api > review-with-history.diff
git format-patch dev..feature/payment-api  # Creates individual patch files

# After review, address feedback with additional commits
git commit -m "Address review feedback: improve error handling"

# Merge the approved changes
git checkout dev
git merge --no-ff feature/payment-api -m "Merge payment API after team review"
```

**Review best practices:**
- Review specific, focused changes rather than large batches
- Use descriptive commit messages that explain both what and why
- Separate refactoring from functional changes
- Consider pre-commit hooks for style and quality checks

### 4. Systematic Debugging with Bisect

Locate the exact commit that introduced a regression.

```bash
# Start the bisect process
git bisect start
git bisect bad  # Current commit has the issue
git bisect good v1.0.0  # Last known good state

# Automated test script (if available)
git bisect run ./test_script.sh

# Manual testing process
# Git checks out commits; for each one:
# Test and mark:
git bisect good  # If this commit works correctly
# or
git bisect bad   # If this commit has the bug

# After finding the problematic commit
git bisect reset  # Return to original HEAD
git show <bad-commit>  # Examine the issue
```

**Advanced bisect techniques:**
- Write a simple test script to automate the process
- Use `git bisect skip` for commits that can't be tested
- Combine with `git blame` to identify related changes
- Create a targeted fix branch from the identified commit

## Team Workflow Guidelines

| Workflow | Best For | Key Benefits |
|----------|----------|-------------|
| GitFlow | Scheduled releases, larger teams | Clear separation of development and production |
| Trunk-based | Continuous delivery, smaller teams | Reduces merge conflicts, faster iteration |
| Feature branches | All team sizes | Isolates incomplete work |
| Forking | Open source, external contributors | Maintains clean main repository |

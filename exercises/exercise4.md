# Exercise 4: Git Best Practices and Team Standards

## Scenario: Establishing Team Git Conventions

This exercise establishes consistent Git practices that improve team collaboration and code quality.

## Tasks

### 1. Conventional Commit Messages

Implement structured commit messages that provide clear, searchable history.

```bash
# Create a branch for practicing conventional commits
git checkout dev
git checkout -b conventional-commits

# Example conventional commits
git commit -m "PROJ-123/feat: Add user authentication API

This implements JWT-based authentication with refresh tokens.
Breaking change: Requires database schema update."

git commit -m "PROJ-124/fix: Resolve password reset token expiration bug"

git commit -m "PROJ-125/refactor: Simplify error handling in payment processor"
```

**Conventional commit structure:**
```
<ticket-ref>/<type>: <concise description> (50-72 chars)

[optional body with context and explanation]

[optional footer with breaking changes/references]
```

**Benefits:**
- Automatic changelog generation
- Simplified version management (semver)
- Searchable history by change type
- Better integration with issue tracking

### 2. Automated Quality Control with Git Hooks

Prevent quality issues by catching problems before they enter the codebase.

```bash
#!/bin/bash
# .git/hooks/pre-commit

# Check for trailing whitespace
if git diff --cached --name-only | xargs grep --with-filename -n '[[:blank:]]$' > /tmp/trailing; then
    echo "Files with trailing whitespace:"
    cat /tmp/trailing
    exit 1
fi

# Check file endings
for file in $(git diff --cached --name-only); do
    if [ -f "$file" ] && [ "$(tail -c 1 "$file" | wc -l)" -eq 0 ]; then
        echo "No newline at end of $file"
        exit 1
    fi
done

# Syntax check for specific file types
for file in $(git diff --cached --name-only | grep '\.js$'); do
    node --check "$file" || exit 1
done

exit 0
```

**Additional hook ideas:**
- Enforce test coverage requirements
- Run linters appropriate to your languages
- Check commit message format
- Prevent large binary files
- Block sensitive data patterns (API keys, passwords)

### 3. Branch Protection Strategies

Implement safeguards to maintain code quality across branches.

```bash
#!/bin/bash
# branch-protection.sh

CURRENT_BRANCH=$(git symbolic-ref --short HEAD)
COMMIT_MSG_FILE=$1
COMMIT_MSG=$(cat "$COMMIT_MSG_FILE")

# Protect main branches
if [[ "$CURRENT_BRANCH" == "main" || "$CURRENT_BRANCH" == "dev" ]]; then
    echo "ERROR: Direct commits to $CURRENT_BRANCH are not allowed"
    echo "Create a feature branch instead"
    exit 1
fi

# Check branch naming
if ! [[ "$CURRENT_BRANCH" =~ ^(feature|bugfix|hotfix|release|chore)/[a-z0-9_-]+ ]]; then
    echo "ERROR: Branch name doesn't follow convention"
    echo "Use: feature/*, bugfix/*, hotfix/*, release/*, chore/*"
    exit 1
fi

# Check commit message length
if [ ${#COMMIT_MSG} -lt 10 ]; then
    echo "ERROR: Commit message too short"
    echo "Please provide a meaningful description"
    exit 1
fi

exit 0
```

**Implementation options:**
- Install as commit-msg hook for local enforcement
- Implement in CI/CD for server-side enforcement
- Use with GitHub/GitLab branch protection rules

### 4. Productivity Boosting Git Aliases

Create shortcuts for common Git operations to improve team efficiency.

```bash
# Essential aliases
git config --global alias.st "status -sb"  # Compact status with branch info
git config --global alias.co "checkout"
git config --global alias.br "branch --sort=-committerdate"  # Sorted by recent
git config --global alias.cane "commit --amend --no-edit"  # Quick amend
git config --global alias.save "!git add -A && git commit -m 'SAVEPOINT'"
git config --global alias.visual "log --graph --oneline --all --decorate"

# Custom multi-step workflow aliases
git config --global alias.sync '!git fetch origin && git rebase origin/dev'
git config --global alias.done '!git checkout dev && git merge @{-1} --no-ff && git push && git branch -d @{-1}'
git config --global alias.wip '!git add -A && git commit -m "WIP: $(git rev-parse --abbrev-ref HEAD)"'
git config --global alias.undo '!git reset HEAD~1 --mixed'
```

**Team standardization approach:**
1. Create a `.gitconfig` template in your project repository
2. Document recommended aliases in contributor guidelines
3. Provide a setup script for new team members
4. Include aliases that enforce team workflow conventions

## Team Guidelines Documentation

Create a `CONTRIBUTING.md` file that documents:

- Branch naming conventions
- Commit message format requirements
- Code review expectations (with checklist)
- Merge/rebase strategy for different branch types
- Release process workflow

**Pro tip:** Use Git hooks and aliases together to create a seamless, quality-focused workflow that feels natural rather than restrictive.

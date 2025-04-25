# Exercise 5: Git History Manipulation Techniques

## Scenario: Precision History Management

This exercise demonstrates professional techniques for maintaining a clean, meaningful Git history.

## Tasks

### 1. Refining Commits with `git commit --amend`

Use Git's amend feature to perfect your most recent commit.

```bash
# Create and switch to practice branch
git checkout -b amend-practice amend-practice-base

# Rename the file and make initial commit
git mv feature_base.txt feature.txt
git commit -m "Rename to feature.txt"

# Add missing content and incorporate into the same commit
echo "Additional important implementation details" >> feature.txt
git add feature.txt
git commit --amend

# Improve the commit message
git commit --amend -m "Add feature.txt with complete implementation"
```

**Key concepts:**
- Amending modifies your last commit without creating new history
- Both content and message can be modified
- Each amendment generates a new commit hash
- Only use on commits that haven't been pushed publicly

### 2. Consolidating Work with `git reset --soft`

Create logical, atomic commits by combining incremental work.

```bash
# Create and switch to practice branch
git checkout -b reset-practice reset-practice-base

# Review existing commit history
git log --oneline

# Consolidate the last two commits
git reset --soft HEAD~2

# Create a new consolidated commit
git commit -m "Complete component with all required paragraphs"

# Compare the new history
git log --oneline
```

**Reset types compared:**
- `--soft`: Preserves working directory and staging
- `--mixed`: Preserves working directory but unstages changes (default)
- `--hard`: Discards all changes (use with caution)

### 3. Managing Shared History

Navigate the challenges of history rewriting in collaborative environments.

```bash
# Create a branch for experimentation
git checkout -b rewritten-history

# Make and push initial commit
echo "Initial content" > shared.txt
git add shared.txt
git commit -m "Add shared content file"
git push -u origin rewritten-history

# Make amendments locally
echo "Improved content" > shared.txt
git add shared.txt
git commit --amend -m "Add complete shared content file"

# Experience push rejection
git push
# Rejected! Remote contains work you don't have locally

# Force push with safeguards
git push --force-with-lease
```

**Collaborative safety practices:**
- Never rewrite history on main/protected branches
- Use `--force-with-lease` instead of `--force` to prevent overwriting others' work
- Communicate history changes to team members
- Consider feature branch isolation to minimize impact

### 4. Real-world History Management

Apply history manipulation techniques in a practical workflow.

```bash
# Start feature work
git checkout -b feature-refactor

# Create incremental commits
echo "Initial structure" > feature.txt
git add feature.txt
git commit -m "Add initial structure"

echo "Implementation details" >> feature.txt
git add feature.txt
git commit -m "Add implementation"

echo "Test cases" > tests.txt
git add tests.txt
git commit -m "Add tests"

echo "Documentation" > docs.txt
git add docs.txt
git commit -m "Add documentation"

# Pre-merge cleanup
# Fix documentation errors
echo "Corrected documentation" > docs.txt
git add docs.txt
git commit --amend -m "Add complete documentation"

# Improve tests with additional cases
echo "Additional test cases" >> tests.txt
git add tests.txt
git reset --soft HEAD~2
git commit -m "Implement comprehensive test suite"
```

**Professional workflow benefits:**
- Creates logical, self-contained commits
- Makes code review more effective
- Improves bisect and blame functionality
- Produces meaningful release notes
- Makes reverting specific changes easier

## Best Practices Summary

| Technique | Use Case | Caution |
|-----------|----------|---------|
| `--amend` | Fix typos, add forgotten files | Only for unpublished commits |
| `reset --soft` | Combine incremental work | Be careful with commit order |
| `rebase -i` | Comprehensive history editing | Don't use on public branches |
| `cherry-pick` | Selectively apply changes | May cause duplicate commits |

**Remember:** A clean Git history serves as living documentation of your project's evolution. Taking time to organize commits properly pays dividends when debugging or onboarding new team members.

# Git Workshop Guide: Rebase vs Merge

Welcome to our Git Workshop Guide. This hands-on workshop is designed to help you master essential Git branching strategies, focusing on when to use `rebase` versus `merge`. You'll work with a practice repository that simulates real-world development scenarios.

## Workshop Objectives

By the end of this workshop, you'll understand:
- When to use `rebase` (updating branches with parent changes)
- When to use `merge` (integrating completed features)
- How to resolve conflicts during both operations
- Best practices for maintaining a clean Git history

## Getting Started

### Setting Up Your Environment

1. **Initialize the Practice Repository**

   Run the `init.sh` script to set up your practice environment:

   ```sh
   sh init.sh
   ```

   This creates a `workshop-repo` directory with a structured Git repository containing:
   - A `main` branch (simulating production)
   - A `dev` branch (simulating development)
   - Multiple feature branches at different stages
   - A simulated hotfix scenario

2. **Navigate to the Repository**

   ```sh
   cd workshop-repo
   ```

3. **Review the Workshop Structure**

   The workshop exercises are organized in the `exercises` directory:

   ```sh
   ls exercises/
   ```

   Each exercise is contained in its own markdown file with detailed instructions.

### Git Workflow Best Practices

#### When to Use Rebase

Use `rebase` when:
- **Updating a feature branch with changes from its parent branch**
- **Keeping a development branch in sync with main**
- **You want to maintain a clean, linear project history**

The rebase workflow maintains a cleaner history by avoiding "merge bubbles" and creating a linear sequence of commits.

#### When to Use Merge

Use `merge` when:
- **Incorporating a completed feature into a parent branch**
- **You want to preserve the complete history of feature development**
- **Multiple developers are working on the same branch**

Merge preserves the context of when branches diverged and how they came back together.

### Workshop Exercises

The repository contains several exercises to practice these concepts:

1. **Exercise 1: Update dev with main**
   - Use rebase to bring hotfix changes from main into dev
   - Observe how the commit history remains linear

2. **Exercise 2: Update a feature branch**
   - Use rebase to bring dev changes into a feature branch
   - Notice how the feature branch now contains all parent changes

3. **Exercise 3: Resolve a conflict**
   - Practice resolving conflicts when feature changes overlap with parent changes
   - Learn the proper conflict resolution workflow

4. **Exercise 4: Git Best Practices and Team Standards**
   - Implement team conventions for consistent usage 
   - Practice with commit standards, hooks, and productivity tools

5. **Exercise 5: History Manipulation**
   - Master `git commit --amend` to improve recent commits
   - Learn `git reset --soft HEAD~2` to combine multiple commits
   - Understand when and how to safely rewrite history

6. **Exercise 6: Interactive Rebasing**
   - Use `git rebase -i` for advanced history refinement
   - Fix commit messages, reorder, squash, delete, and split commits
   - Practice multiple operations in a single interactive rebase

## Handling Git Operations

### Resolving Rebase Conflicts

When conflicts occur during rebase:

1. Git will pause and indicate which files have conflicts
2. Edit the conflicted files to resolve issues (look for `<<<<<<<`, `=======`, and `>>>>>>>` markers)
3. Add the resolved files with `git add <filename>`
4. Continue the rebase with `git rebase --continue`
5. If needed, abort with `git rebase --abort`

### Viewing History Effectively

Use these commands to better understand the branch structure:

```sh
# Compact view of branches and commits
git log --graph --oneline --all --decorate

# Detailed view of specific branch
git log --graph --stat <branch-name>
```

## Record Your Work

As you complete each exercise, document the commands you used and what you observed about the Git behavior. This will help reinforce your understanding of Git workflows.

## Additional Resources

- [Git Branching Strategies](https://git-scm.com/book/en/v2/Git-Branching-Branching-Workflows)
- [Atlassian's Git Tutorial: Rebase vs Merge](https://www.atlassian.com/git/tutorials/merging-vs-rebasing)
- [Interactive Git Visualizer](https://git-school.github.io/visualizing-git/)

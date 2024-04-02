# Git Workshop Guide

Welcome to our Git Workshop Guide. This guide is designed to help you practice essential Git commands, focusing on `rebase` and `merge`. We'll use a practice environment set up by the `init.sh` script, which creates a repository named `workshop-repo` with multiple branches for you to work with.

## Getting Started

### Setting Up Your Environment

1. **Initialize the Practice Repository**

   Start by running the `init.sh` script to set up your environment. This script creates the `workshop-repo` directory and initializes it as a Git repository with several branches for practice.

   ```sh
   sh init.sh
   ```

2. **Navigate to the Repository**

   Change into the `workshop-repo` directory to start practicing.

   ```sh
   cd workshop-repo
   ```

3. **Verify the Branch Setup**

   Ensure all the necessary branches are created by listing them:

   ```sh
   git branch
   ```

   You should see the following branches:

   ```
   dev
   feature_1
   feature_2
   feature_3
   hotfix
   main
   ```

   **Note:** The `hotfix` branch simulates a scenario where hotfix changes have already been merged into `main`. You'll delete this branch to simplify the setup.

   ```sh
   git branch -D hotfix
   ```

### Practicing with Git Commands

#### Keeping `dev` Up to Date with `main`

It's essential to keep the `dev` branch up to date with `main` to incorporate any changes, including hotfixes.

1. Switch to the `dev` branch:

   ```sh
   git checkout dev
   ```

2. To update `dev` with changes from `main`, use `git rebase`:

   ```sh
   git rebase main
   ```

   After rebasing, you'll notice that `dev` now includes commits from `main`, showing a linear history that incorporates the hotfix changes.

#### Managing Feature Branches

Feature branches often need to be updated with changes from `dev` to ensure they incorporate all the latest work.

1. For each feature branch (`feature_1`, `feature_2`, etc.), repeat the following steps:

   - Switch to the feature branch:

     ```sh
     git checkout feature_1
     ```

   - Rebase the feature branch onto `dev` to include the latest changes:

     ```sh
     git rebase dev
     ```

   This process ensures that your feature branches are up to date and can be merged cleanly into `dev`.

#### Handling Merge Conflicts

Merge conflicts can occur when rebasing. Here's how to resolve them:

1. If you encounter a merge conflict, Git will pause the rebase and ask you to resolve the conflict.

2. Use `git status` to identify the conflicted files.

3. Open the conflicted files in your editor, resolve the conflicts, and save your changes.

4. Mark the conflicts as resolved by adding the files to the staging area:

   ```sh
   git add <file>
   ```

5. Continue the rebase process:

   ```sh
   git rebase --continue
   ```

6. If you need to abort the rebase process and return to the original state, use:

   ```sh
   git rebase --abort
   ```

### Further Practice and Exploration

- Continue experimenting with other branches and scenarios.
- Practice using `git merge` to integrate changes from one branch into another.
- Explore advanced Git commands and workflows.

## Conclusion and Additional Resources

This guide covers fundamental practices with Git, focusing on rebasing and merging. For more detailed information and troubleshooting, refer to the [official Git documentation](https://git-scm.com/docs). Always remember, the best way to learn Git is by practicing, so don't hesitate to experiment with different commands and workflows in your `workshop-repo`.

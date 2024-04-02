#!/bin/bash

# Initialize a new Git repository and enter the directory
git init -b main workshop-repo && cd workshop-repo

# Explicitly set the initial branch to "main"
git branch -m main

# Initial commit on the main branch
echo "Initial commit on main" > main.txt
git add main.txt
git commit -m "Initial commit on main"
sleep 1 # Ensure timestamp differentiation

# Create a "dev" branch from "main" and make some changes
git checkout -b dev
for i in {1..2}; do
    echo "Changes on dev $i" > "dev_change_$i.txt"
    git add "dev_change_$i.txt"
    git commit -m "Commit $i on dev"
    sleep 1 # Ensure timestamp differentiation
done

# Create and commit on a "hotfix" branch off "main"
git checkout main
git checkout -b hotfix

echo "Changes on hotfix" > hotfix_change.txt
git add "hotfix_change.txt"
git commit -m "Commit on hotfix"
sleep 1 # Ensure timestamp differentiation

echo "Changed on hotfix" > main.txt
git add "main.txt"
git commit -m "Changed main.txt on hotfix"
sleep 1 # Ensure timestamp differentiation

# Merge "hotfix" into "main" without squashing
git checkout main
git merge hotfix
sleep 1 # Ensure timestamp differentiation

# Create "feature_1" branch from "dev" and commit changes
git checkout dev
git checkout -b feature_1

echo "Feature 1 change" > "feature1_change.txt"
git add "feature1_change.txt"
git commit -m "Feature 1 commit"
sleep 1 # Ensure timestamp differentiation

# Create "feature_2" from a previous state of "dev" and commit changes
git checkout $(git rev-parse dev~2)
git checkout -b feature_2

echo "Feature 2 change" > feature2_change.txt
git add "feature2_change.txt"
git commit -m "Feature 2 commit"
sleep 1 # Ensure timestamp differentiation

# Create "feature_3" from a previous state of "dev" and commit changes
git checkout $(git rev-parse dev~1)
git checkout -b feature_3

echo "Changed on feature_3" > main.txt
git add "main.txt"
git commit -m "Changed main on feature_3"
sleep 1 # Ensure timestamp differentiation

# Return to the "dev" branch
git checkout dev

# Display the final branch structure visually
echo "Git branches created:"
git log --all --decorate --graph --oneline

echo "Script execution complete. Ready for git rebase and cherry-pick exercises."

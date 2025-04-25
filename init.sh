#!/bin/bash

# Create a clean output function
print_section() {
  printf "\n\033[1;36m==== %s ====\033[0m\n" "$1"
}

# Initialize a new Git repository and enter the directory
print_section "CREATING REPOSITORY"
git init -b main workshop-repo && cd workshop-repo

# Explicitly set the initial branch to "main"
git branch -m main

# Initial commit on the main branch
print_section "SETTING UP MAIN BRANCH"
echo "# Project Main Branch
This file represents the production code.
" > main.txt
git add main.txt
git commit -m "Initial commit on main"
sleep 1 # Ensure timestamp differentiation

# Create a "dev" branch from "main" and make some changes
print_section "CREATING DEV BRANCH"
git checkout -b dev
for i in {1..2}; do
    echo "# Development Change $i
This file represents development work in progress.
" > "dev_change_$i.txt"
    git add "dev_change_$i.txt"
    git commit -m "Add development feature $i"
    sleep 1 # Ensure timestamp differentiation
done

# Create and commit on a "hotfix" branch off "main"
print_section "SIMULATING HOTFIX SCENARIO"
git checkout main
git checkout -b hotfix

echo "# Hotfix Change
This file represents an urgent fix that must go directly to production.
" > hotfix_change.txt
git add "hotfix_change.txt"
git commit -m "Add critical hotfix"
sleep 1 # Ensure timestamp differentiation

echo "# Project Main Branch
This file represents the production code.

HOTFIX: Critical issue resolved.
" > main.txt
git add "main.txt"
git commit -m "Update main.txt with hotfix"
sleep 1 # Ensure timestamp differentiation

# Merge "hotfix" into "main" without squashing
git checkout main
git merge hotfix --no-ff -m "Merge hotfix into main"
sleep 1 # Ensure timestamp differentiation

# Create "feature_1" branch from "dev" and commit changes
print_section "CREATING FEATURE BRANCHES"
git checkout dev
git checkout -b feature_1

echo "# Feature 1
This represents a completed feature ready to be integrated.
" > "feature1_change.txt"
git add "feature1_change.txt"
git commit -m "Complete feature 1"
sleep 1 # Ensure timestamp differentiation

# Create "feature_2" from a previous state of "dev" and commit changes
print_section "CREATING FEATURE BRANCH FROM EARLIER COMMIT"
# Temporarily turn off detached HEAD warning
git config --local advice.detachedHead false
git checkout $(git rev-parse dev~1)
git checkout -b feature_2

echo "# Feature 2
This represents a feature that started from an earlier development version.
" > feature2_change.txt
git add "feature2_change.txt"
git commit -m "Implement feature 2"
sleep 1 # Ensure timestamp differentiation

# Create "feature_3" from a previous state of "dev" and commit changes that will cause conflict
git checkout $(git rev-parse dev~1)
git checkout -b feature_3
# Turn advice back on
git config --local advice.detachedHead true

echo "# Project Main Branch
This file represents the production code.

FEATURE 3: This change will conflict with the hotfix.
" > main.txt
git add "main.txt"
git commit -m "Update main.txt in feature 3 (creates conflict)"
sleep 1 # Ensure timestamp differentiation

# Setup for Exercise 5: History Manipulation
print_section "SETTING UP EXERCISE 5"
# Create and setup amend-practice branch
git checkout main
git checkout -b amend-practice-base
echo "# Feature File
This is a base file for the amend exercise.
" > feature_base.txt
git add feature_base.txt
git commit -m "Add feature base file"
sleep 1

# Create and setup reset-practice branch
git checkout main
git checkout -b reset-practice-base
echo "# Component File
First paragraph content.
" > component_base.txt
git add component_base.txt
git commit -m "Add component base file"
sleep 1
echo "
Second paragraph content.
" >> component_base.txt
git add component_base.txt
git commit -m "Add second paragraph"
sleep 1
echo "
Third paragraph content.
" >> component_base.txt
git add component_base.txt
git commit -m "Add third paragraph"
sleep 1

# Setup for Exercise 6: Interactive Rebasing
print_section "SETTING UP EXERCISE 6"
git checkout main
git checkout -b interactive-rebase-base

# Create a series of commits with various issues for interactive rebase practice
# First commit - initial file
echo "# Project Documentation
This is the initial documentation file.
" > docs.txt
git add docs.txt
git commit -m "Initial documentation file"
sleep 1

# Second commit - with a typo in message
echo "# Configuration File
Basic configuration settings.
" > config.txt
git add config.txt
git commit -m "Add confiugration file with typo in message"
sleep 1

# Third commit - more docs
echo "
## Installation Section
Instructions for installing the project.
" >> docs.txt
git add docs.txt
git commit -m "Add installation section to docs"
sleep 1

# Fourth commit - additional docs
echo "
## Usage Section
Instructions for using the project.
" >> docs.txt
git add docs.txt
git commit -m "Add usage section to docs"
sleep 1

# Fifth commit - large commit that should be split
echo "# Main Feature
Core functionality implementation.
" > feature.txt
echo "# Helper Component
Supporting code for the main feature.
" > helper.txt
git add feature.txt helper.txt
git commit -m "Add main feature and helper component (should be separate commits)"
sleep 1

# Create a branch for practicing conventional commits (Exercise 4)
print_section "SETTING UP EXERCISE 4"
git checkout dev
git checkout -b conventional-commits
echo "# User Authentication API
Initial implementation of authentication system.
" > auth.txt
git add auth.txt
git commit -m "feat: Add initial user authentication API"
sleep 1

# Setup for branch protection practice
git checkout main
git checkout -b branch-protection-base
echo "# Protected Branch
This file demonstrates branch protection practices.
" > protected.txt
git add protected.txt
git commit -m "Add protected branch file"
sleep 1

# Return to the "dev" branch
git checkout dev

# Display the final branch structure visually
print_section "GIT REPOSITORY CREATED SUCCESSFULLY"
printf "\nBranch structure:\n"
# Make sure git output shows colors even when piped
git config --local color.ui always
# Capture and echo the colored output (the -e ensures ANSI color codes are interpreted)
BRANCH_STRUCTURE=$(git log --all --decorate --graph --oneline)
echo "$BRANCH_STRUCTURE"

# Create a git alias to visualize branch structure (helps with exercises)
git config --local alias.visual "log --graph --oneline --all --decorate"

print_section "NEXT STEPS"
printf "1. Change directory to workshop-repo\n"
printf "2. Run 'git branch' to see all branches\n"
printf "3. Check the exercises/ folder for your practice tasks\n"
printf "4. Follow the README.md for detailed instructions\n"
printf "5. Check the CHEAT_SHEET.md for Git commands\n"

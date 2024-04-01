# Workshop Repository

This repository is designed for practicing git rebase and merge commands. It includes a script called `init.sh` that sets up the environment for practicing these commands.

## Usage

To set up the repository and start practicing, follow these steps:

1. Run the `init.sh` script:
    ```sh
    sh init.sh
    ```

   This script will create a git repository named `workshop-repo` and perform some initial setup.

2. Navigate into the `workshop-repo` directory:
    ```sh
    cd workshop-repo
    ```

3. Perform the following commands in order, checking the organization of branches with `git log --all --decorate --graph` after each step:

   - Delete the `hotfix` branch:
     ```sh
     git branch -D hotfix
     ```

   - Checkout to the `dev` branch and rebase it from `main`:
     ```sh
     git checkout dev
     git rebase main
     ```

   - Rebase the `feature_1` branch from `dev`:
     ```sh
     git checkout feature_1
     git rebase dev
     ```

   - Rebase the `feature_2` branch from `dev`:
     ```sh
     git checkout feature_2
     git rebase dev
     ```

   - Rebase the `feature_3` branch from `dev`:
     ```sh
     git checkout feature_3
     git rebase dev
     ```

   - Make necessary changes to `main.txt` and continue the rebase on the branch `feature_3`:
     ```sh
     git status
     # Edit main.txt as needed
     git add main.txt
     git rebase --continue
     ```

4. Continue practicing with other git commands as needed.

## Notes

- Always remember to review the branch organization using `git log --all --decorate --graph`.
- Feel free to experiment and practice various git workflows in this repository.
- If you encounter any issues or have questions, refer to the [Git documentation](https://git-scm.com/docs) or seek assistance from your colleagues or online resources.


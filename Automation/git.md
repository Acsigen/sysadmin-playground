# Git

## Basic Workflow

A git repository has the following structure:

- Tree: Equivalent to directories or folders
- Blob: Equivalent of files

Git steps:

- Clone
- Add
- Commit
- Push
- Branch
- Merge
- Pull Request (GitHub only)

### Installation

After installing *git* it is best to configure the following settings:

```bash
git config --global user.name "<your_name>"
git config --global user.email "<your_email>"
git config --global color.ui auto
```

The easiest and safest way to authenticate to remote git servers is to use key pairs (SSH key pairs).

### Setup & init

|Command|Description|
|---|---|
|`git init`|Initialize an existing directory as a Git repository|
|`git clone <repo_link>`|Retrieve an entire repository from a hosted location via URL|

### Branche & Merge

|Command|Description|
|---|---|
|`git branch`|List your branches. a * will appear next to the currently active branch|
|`git branch <branch_name>`|Create a new branch at the current commit|
|`git checkout`|Switch to another branch and check it out into your working directory|
|`git checkout -b <new_branch>`|Create and switch to another branch, then check it out into your working directory|
|`git merge <branch>`|Merge the specified branch’s history into the current one|

### Stage & Snapshot

|Command|Description|
|---|---|
|`git status`|Show modified files in working directory, staged for your next commit|
|`git add <file>`|Add a file as it looks now to your next commit (stage)|
|`git reset <file>`|Unstage a file while retaining the changes in working directory|
|`git diff`|Diff of what is changed but not staged|
|`git diff --staged`|Diff of what is staged but not yet commited|
|`git tag <my_tag>`|Tags are used, commonly, to indicate the version of the commit|
|`git commit -m “<descriptive_message>”`|Commit your staged content as a new commit snapshot. **This will only commit changes to your local copy.**|

### Inspect & compare

|Command|Description|
|---|---|
|`git log`|Show all commits in the current branch’s history|
|`git log --all --graph --decorate`|Show all commits in the current branch’s history in pretty mode|
|`git log branchB..branchA`|Show the commits on branchA that are not on branchB|
|`git log --follow <file>`|Show the commits that changed file, even across renames|
|`git diff branchB...branchA`|Show the diff of what is in branchA that is not in branchB|
|`git show <SHA>`|Show any object in Git in human-readable format|

### Share & Update

|Command|Description|
|---|---|
|`git remote add <alias> <url>`|Add a git URL as an alias|
|`git fetch <alias>`|Fetch down all the branches from that Git remote|
|`git merge <alias>/<branch>`|Merge a remote branch into your current branch to bring it up to date|
|`git push <alias> <branch>`|Transmit local branch commits to the remote repository branch|`
|`git push -u <remote_name> <branch_name>`|Transmit local branch commits to the remote repository on a different branch|
|`git pull`|Fetch and merge any commits from the tracking remote branch|

### Tracking Path Changes

|Command|Description|
|---|---|
|`git rm <file>`|Delete the file from project and stage the removal for commit|
|`git mv <existing-path> <new-path>`|Change an existing file path and stage the move|
|`git log --stat -M`|Show all commit logs with indication of any paths that moved|

### Rewrite History

|Command|Description|
|---|---|
|`git rebase [branch]`|Apply any commits of current branch ahead of specified one|
|`git reset --hard [commit]`|Clear staging area, rewrite working tree from specified commit|

### Temporary Commits

|Command|Description|
|---|---|
|`git stash`|Save modified and staged changes|
|`git stash list`|List stack-order of stashed file changes|
|`git stash pop`|Write working from top of stash stack|
|`git stash drop`|Discard the changes from top of stash stack|

### Ignoring Patterns

To avoid uploading specific files to the remote repository, in the local repository, create a file named `.gitignore` and append the paths with wildcards such as: `logs/`, `*.notes`, `pattern*/`.

## Sources

- [education.github.com](https://education.github.com/git-cheat-sheet-education.pdf)
- [MIT](https://missing.csail.mit.edu/2020/version-control/)

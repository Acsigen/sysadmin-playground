# Git

## Basic Workflow

A git repository has the following structure:

- Tree: Equivalent to directories or folders
- Blob: Equivalent of files

Git steps:

- Clone
- Branch
- Add
- Commit
- Push
- Merge
- Pull/Merge Request

### Installation

After installing *git* it is best to configure the following settings:

```bash
git config --global user.name "<your_name>"
git config --global user.email "<your_email>"
git config --global color.ui auto
```

You can also configure the settings for each repository by replacing `--global` with `--local`.

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
|`git show <SHA>`|Show the changes from a specific commit (git object) in human-readable format|

### Share & Update

|Command|Description|
|---|---|
|`git remote -v`|Show the remotes list|
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
|~~`git checkout -- <file>`~~|~~Discard uncommited changes for `<file>`~~|
|`git restore <file>`|Discard uncommited changes for `<file>`|
|`git clean -fd`|Cleans the working tree by recursively removing files that are not under version control, starting from the current directory. Append `-n` to perform a dry run. More details [here](https://git-scm.com/docs/git-clean)|

### Rewrite History

|Command|Description|
|---|---|
|`git rebase [branch]`|Replay a branch's changes onto a different branch or commit. In this case, the current branch will receive the history of [branch].|
|`git reset --hard [commit]`|Clear staging area, rewrite working tree from specified commit|

### Temporary Commits

|Command|Description|
|---|---|
|`git stash`|Save modified and staged changes|
|`git stash list`|List stack-order of stashed file changes|
|`git stash pop`|Write your stashed changes to active branch from top of stash stack|
|`git stash drop`|Discard the changes from top of stash stack|

### Ignoring Patterns

To avoid uploading specific files to the remote repository, in the local repository, create a file named `.gitignore` and append the paths with wildcards such as: `logs/`, `*.notes`, `pattern*/`.

## Sign commits with SSH keys

In order to sign the commits you need to configure git to use the keys. You can do this globally or locally as mentioned [here](#installation).

```bash
git config --local commit.gpgsign true
git config --local gpg.format ssh
```

Add your SSH key with `ssh-add` if you do not have it under `~/.ssh/` directory. Get the key ID with `ssh-add -L` then configure git to use the key.

```bash
git config --local user.signingkey "ssh-ed25519 <your-key-id>"
```

Run an empty commit to test it:

```bash
git commit --allow-empty --message="Test SSH signing"
```

SSH doesn’t have this *web of trust*. Instead, it uses files like `~/.ssh/authorized_keys` and `~/.ssh/known_hosts` to configure what keys and hosts it should trust, respectively. For verification, we’ll need to create a file to configure allowed signers.

While there’s no formal place to store this file yet, it makes sense to store a global *database* of allowed signers in `~/.ssh/allowed_signers` and a project-specific file might be stored in `/.git/allowed_signers` if you'd like to maintain your own list or `/.allowed_signers` if you want to commit the file and share it.

```bash
git config --local gpg.ssh.allowedSignersFile .git/allowed_signers
touch .git/allowed_signers
echo "user@example.com ssh-ed25519 <ssh-key-id>" > .git/allowed_signers
git show --show-signature
```

## Sane configuration

Sometimes you do not want to always run `git pull --rebase` or when initialise a new repo to manually set the branch name to `main`. So the following configuration (that you must place inside `~/.gitconfig`) that I "borrowed" from [this article](https://blog.gitbutler.com/how-git-core-devs-configure-git/) might come in handy:

```conf
# clearly makes git better

[column]
        ui = auto
[branch]
        sort = -committerdate
[tag]
        sort = version:refname
[init]
        defaultBranch = main
[diff]
        algorithm = histogram
        colorMoved = plain
        mnemonicPrefix = true
        renames = true
[push]
        default = simple
        autoSetupRemote = true
        followTags = true
[fetch]
        prune = true
        pruneTags = true
        all = true

# why the hell not?

[help]
        autocorrect = prompt
[commit]
        verbose = true
[rerere]
        enabled = true
        autoupdate = true
[core]
        excludesfile = ~/.gitignore
[rebase]
        autoSquash = true
        autoStash = true
        updateRefs = true

# a matter of taste (uncomment if you dare)

[core]
        # fsmonitor = true
        # untrackedCache = true
[merge]
        # (just 'diff3' if git version < 2.3)
        # conflictstyle = zdiff3 
[pull]
        # rebase = true
```
## Sources

- [education.github.com](https://education.github.com/git-cheat-sheet-education.pdf)
- [MIT](https://missing.csail.mit.edu/2020/version-control/)
- [calebhearth.com](https://calebhearth.com/sign-git-with-ssh)

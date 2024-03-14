# AWS cross account access

## Prerequisites

In this guide we have two account inside AWS Organizations, a management one and another one for CodeCommit repository and app hosting.

We want users in the management account to be able to switch to various roles into the secondary account. In this case, a developer role which can access the AWS CodeCommit Service.

## Variables

Replace these variables when copy/paste the configurations in this guide. They're set here only as refference.

```conf
MAIN_ACCOUNT_ID = "Account ID of the management account"
REGION = eu-central-1
POLICY_NAME = CrossAccountAccessForCodeCommit
ROLE_NAME = CrossAccountRepositoryDeveloperRole
GROUP_NAME = DevelopersWithCrossAccountRepositoryAccess
SECONDARY_ACCOUNT_ID = “Account ID of the repository Account”
ROLE_ARN = arn:aws:iam::$SECONDARY_ACCOUNT_ID:role/CrossAccountRepositoryDeveloperRole
AWS_PROFILE = “Profile name you set in ~/.aws/config file”
```

## Configure AWS

### Create Policy in Repo Account

Go to IAM and create a new policy with the name of `$POLICY_NAME` and following settings:

```json
{
"Version": "2012-10-17",
"Statement": [
    {
        "Effect": "Allow",
        "Action": [
            "codecommit:BatchGet*",
            "codecommit:Create*",
            "codecommit:DeleteBranch",
            "codecommit:Get*",
            "codecommit:List*",
            "codecommit:Describe*",
            "codecommit:Put*",
            "codecommit:Post*",
            "codecommit:Merge*",
            "codecommit:Test*",
            "codecommit:Update*",
            "codecommit:GitPull",
            "codecommit:GitPush"
        ],
        "Resource": [
            “arn:aws:codecommit:eu-central-1:$SECONDARY_ACCOUNT_ID:*”
        ]
    },
    {
        "Effect": "Allow",
        "Action": "codecommit:ListRepositories",
        "Resource": "*"
    }
]
}
```

### Create Role in Repo Account

Create a role for “Another AWS Account”, enter the `$MAIN_ACCOUNT_ID`, set the name of `$ROLE_NAME` and assign the `$POLICY_NAME` to it. Copy the role ARN to use it in the main account.

### Create main account group

Create a group wit the name of `$GROUP_NAME`, do not add policies and users right away.

Create an inline policy for the new group with the name of *“AccessPolicyForSharedRepositories”* and the following contents:

```json
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Action": "sts:AssumeRole",
    "Resource": [
        "$ROLE_ARN1",
        "$ROLE_ARN2"
    ]
  }
}
```

Now go to *"Users"* and add the allowed users.

## Configure your local computer

Install pip package manager and git-remote-codecommit:

```bash
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py
pip install git-remote-codecommit
```

## Configure extra profiles with `aws` CLI for cross account access

Configure the default profile by running: `aws configure` and provide the following data:

```conf
AWS Access Key ID [None]: AKIAQGXLDEZZHWCBCBWN
AWS Secret Access Key ID [None]: 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
Default region name ID [None]: eu-central-1
Default output format [None]: json
```

Configure a profile for each account you need to access by running `aws configure --profile NameOfProfile` and provide the same credentials as before.

Now edit `~/.aws/config` and under the *default* profile add the account ID, it should look like this:

```conf
[default]
account = $MAIN_ACCOUNT_ID
region = eu-central-1
output = json
```

The rest of the profiles should look like this:

```conf
[profile NameOfProfile]
account = $SECONDARY_ACCOUNT_ID
role_arn = arn:aws:iam::$SECONDARY_ACCOUNT_ID:role/CrossAccountRepositoryDeveloperRole
source_profile = default
region = eu-central-1
output = json
```

## Clone your first repository

Now that you installed `git-remote-codecommit`, you can clone repositories that start with `codecommit://` handle.

**This method of authentication has a limitation, you won't be able to clone the CodeCommit repositories using `https://` handle or `ssh://` handle.**

To clone a repository named `test` that sits inside `NameOfProfile` account, you run:

```bash
git clone codecommit://NameOfProfile@test
```

The rest `git` workflow is the same.

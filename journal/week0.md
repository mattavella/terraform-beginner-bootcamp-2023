# Terraform Beginner Bootcamp 2023 - Week 0

- [Terraform Beginner Bootcamp 2023 - Week 0](#terraform-beginner-bootcamp-2023---week-0)
  * [Semantic Versioning](#semantic-versioning)
  * [Install Terraform CLI](#install-terraform-cli)
  * [Refactoring into bash scripts](#refactoring-into-bash-scripts)
  * [Considerations for Linux distribution](#considerations-for-linux-distribution)
  * [Shebang](#shebang)
  * [Linux Permistions](#linux-permistions)
    + [Github lifecycle](#github-lifecycle)
    + [Working Env Vars](#working-env-vars)
      - [env command](#env-command)
      - [Setting and Unsetting Env Vars](#setting-and-unsetting-env-vars)
      - [Printing Vars](#printing-vars)
      - [Scoping of Env Vars](#scoping-of-env-vars)
      - [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
    + [AWS CLI Installation](#aws-cli-installation)
  * [Terraform Basics](#terraform-basics)
    + [Terraform Registry](#terraform-registry)
    + [Terraform Console](#terraform-console)
    + [Terraform Init](#terraform-init)
    + [Terraform Plan](#terraform-plan)
    + [Terraform Apply](#terraform-apply)
    + [Terraform Destroy](#terraform-destroy)
    + [Terraform Lock Files](#terraform-lock-files)
    + [Terraform State files](#terraform-state-files)
    + [Terraform Directory](#terraform-directory)
    + [Terraform Cloud Login Workaround for Gitpod](#terraform-cloud-login-workaround-for-gitpo

## Semantic Versioning

This project is going utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)

The general format:

 **MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install Terraform CLI

Installation instructions have changed due to gpg keyring chagnes. Refer to the latest CLI install instructions via Terraform documentation and the change scripting for install. 
[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## Refactoring into bash scripts
While fixing the Terraform CLI gpg deprecations issues we notied that bash scripts steps were more code. We decided to create a bash script to install the Terraform CLI.
- This will keep the Gitpod task file tidy.
- Allows for easier debuging and execution of Terraform CLI install manually
- Portability for other projects that need to install Terraform CLI.

## Considerations for Linux distribution
This project is built against Ubuntu. Please consider checking your Linux distribution anc change accordintly. 
[How to check OS version in Linus](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

## Shebang
A Shebang tells the bash script what program that will interpet the script. ```sh #!/bin/env bash ```
- for portability of different OS distributions
- will search the users PATH for bash executable

When executint the bash script we can use './' shorthand to execute the bash script.

https://en.wikipedia.org/wiki/Shebang_(Unix)

## Linux Permistions

In order to make our bash scripts executable, we need to change Linux permisions to make is executable at user mode.
```sh
chmod u+x ./bin/install_terraform_cli
```
alternatively 

```sh
chmod 744 ./bin/install_terraform_cli
```

https://en.wikipedia.org/wiki/Chmod

### Github lifecycle 
Before, Ininit, Commmand
We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks

### Working Env Vars

#### env command
We can list out all Environment Variables (Env Vars) using the `env` command
We can filter specific env vars using grep eg. `env | grep AWS_`

#### Setting and Unsetting Env Vars
In the terminal we can set using `export HELLO='world'
In the terminal we can unset using 'unset HELLO'
We can set an env var temporarily when running a command

```sh
HELLO='world' ./bin/print_message
```

Within a bash script we can set env without writing export.

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

#### Printing Vars
We can print an env var using echo eg. 'echo $HELLO'

#### Scoping of Env Vars
When you open a new bash terminal in VSCode it will not be aware of env vars that you have set in another window.

If you want your Env Vars to persist across all future bash terminals that are open, you need to set env vars in your bash profile. eg. '.bash_profile'

#### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in the workspaces.

You can also set env vars in the the '.gitpod.yml' but this can only contain non-sensitive env vars.

### AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting started install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

We can check if our AWS credentials is configured correctly by running the following AWS CLI command:
```sh
aws sts get-caller-identity
```
[AWS CLI Envars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

If its successful it will look like this
```json
{
    "UserId": "AHEGEF464648745454111",
    "Account": "8557813131878",
    "Arn": "arn:aws:iam::12387987588:user/terraform-beginner-bootcamp"
}
```

We'll need to generate AWS CLI credits from IAM user in order to use AWS CLI.


## Terraform Basics

### Terraform Registry
Terraform sources their providers and modules from the Terraform registry located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** is an interface to APIs that will allow you to create resources in terraform.

- **Modules** are a way to make a large amount of terraform code moduler, portable, and sharable.

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/)

### Terraform Console
We can see a list of all the Terraform commands by simply typing `terraform`

### Terraform Init
At the start of a new terraform project we will run `terraform init` to download the binaries for the terraform providers that we'll use in this project.

### Terraform Plan
This will generate out a changeset about the state of our infrastructure and what will be changed.

We can output this changeset "plan" to be passed to an "apply" but often you can just ignore outputting.

### Terraform Apply
`terraform apply`

This will run a plan and pass the changeset to be executed by terraform. Apply should prompt yes or no.

If we want to automatically approve an apply, we can provide the auto approve flag. eg `terraform apply --auto-approve`

### Terraform Destroy
`teraform destroy`
This will destroy your resources.

You can also use the auto approve flag to skip the prompt
`terraform apply -- auto-approve`

### Terraform Lock Files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project.

The terraform lock file **should be committed** to your version control system (vsc) eg. Github.

### Terraform State files
`.terraform.tfstate` contains informationa bout the current state of your infrastructure.

This file **should not be commited** to your VCS. This file can contain sensetive data. If you lose this file, you'll lose the state of your infrastructure.

`.terraform.tfstate.backup` is the previous state file state.

### Terraform Directory
`.terraform` directory contains the binaries of terraform providers.


### Terraform Cloud Login Workaround for Gitpod

When attempting to run `terraform login` it will launch bash a wiswig view to generate a token. However it does not work expected in Gitpod VsCode in the browser.

The workaround is manually generate a token in Terraform Cloud

```
https://app.terraform.io/app/settings/tokens?source=terraform-login
```

Then create open the file manually here:

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Provide the following code (replace your token in the file):

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "YOUR-TERRAFORM-CLOUD-TOKEN"
    }
  }
}
``````

We have automated this login workaround for gitpod using this bash script [bin/generate_tfrc_credentials]](bin/generate_tfrc_credentials)


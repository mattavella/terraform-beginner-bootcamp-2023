# Terraform Beginner Bootcamp 2023

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
A Shebang tells the bash script what program that will interpet the script. '#!/bin/env bash'
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

### Github lifecycle (Before, Ininit, Commmand)
We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks

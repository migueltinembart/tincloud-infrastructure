# tincloud-infrastructure

This Repository holds all infrastructure details for my infrastructure named tincloud. The following terraform deployments are listed here:

- [shared](/giswil/shared) - Holds shared services for all environments

## Usage

Fork this repo and clone it in to your prefered folder

```bash
git clone git@github.com:<yourUserName>/tincloud-infrastructure.git
cd tincloud-infrastructure
```

Change the variables of your backend and initialize terraform. For instance if you want to deploy resources in the shared deployment inside of giswil, use these steps to get started:

```bash
cd giswil/shared
terraform init -backend-config backend.hcl
```

Afterwards create a `.tfvars` file with all the variables specified in `variables.tf` or pass them as arguments to terraform plan or apply

```bash
cd giswil/shared
terraform plan -var-file=prod.tfvars
```

## Pipeline

There is a pipeline being run for this repository. Basically it splits the most basic terraform steps and then if validating and planning the ferraform configuration works out, it will apply the configuration with the infrastructure.

## Structure

For now, every Region has its own folder inside the root of the project. The following regions are in use for now:

- Giswil -> My home
- az -> Azure

### Documentation

Every Deployment gets documented for itself specifying variables for that deployment or basic overview of data for that part of my infrastructure which can be public.
# RBAC rules for Brightwell workgroups

This repository contains:

- Terraform template to build RBAC rules for the Brightwell workgroups defined

## Requirements

- Terraform latest stable version (1.3.8 at the moment)

## Setup

- Define the Environment vars:
    AWS_ACCESS_KEY_ID - with the IAM User AWS Access Key ID
    AWS_SECRET_ACCESS_KEY - with the IAM User Secret Access Key
    AWS_DEFAULT_REGION - define one default AWS region, if you are going to de a multiregion deploy, put the first one and indicate the others in the Terraform code
    AWS_REGION - same value than AWS_DEFAULT_REGION

- in the shell console execute the commands:
```
	terraform init -upgrade
	terraform plan
	terraform apply
```

- Once the process is finished, we will have the roles created.
- Obtain the ARN of the users who will make use of that role and add them, modifying the code to include the list of RNAs of each IAM user who will make use of the role.

    For example, the `data-engineer-role` would look like this:
    ```
    module "data-engineer-role" {
        source  = "tf-mod/rbac-role/aws"
        version = "1.0.0"

        name        = "data_engineer_role"
        stack       = "dev-qa-prod"
        policy_arn  = ["arn:aws:iam::aws:policy/AmazonRedshiftFullAccess"]

        allowed_accounts = [
            "arn:aws:iam::545534343434:user/datauser1",
            "arn:aws:iam::963423435332:user/datauser2"
        ]
    }

    ```

## Conditions of use of AWS RBAC

If we use RBAC, we can only establish trust relationships with previously created IAM users. In the creation of the Roles, you are adding the (fake) root user of the account, you would have to put in your log a list with the ARNs that will be added to that trust relationship.

Personally I don't think this is the best solution and would prefer to handle it entirely through permission policies at the group IAM level, but I have to assume that the trust relationships with the roles are being given temporarily, but they are not possible to be assigned (yet) to a group IAM through its ARN.


While AWS has already published modules on the internet to facilitate the creation of users, groups, policies and roles in IAM, these are more of an all-or-nothing solution with Terraform.

We have proceeded with Terraform because it is far more likely to find code already written on github that will do what is required, reuse it or modify/update it for new compatibility requirements.

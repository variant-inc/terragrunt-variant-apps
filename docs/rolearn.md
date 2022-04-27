# RoleArn

- [RoleArn](#rolearn)
  - [Definition](#definition)
  - [When It Should Be Used](#when-it-should-be-used)
  - [References](#references)

## Definition

- The ARN (Amazon Resource Name) of the IAM role that grants Amazon Inspector
  access to AWS Services needed to perform security assessments.
- The roleArn is the ARN of the AWS IAM (Identity and Access Management) role
  that your application will assume to function.

## When It Should Be Used

- If your application requires access to any AWS services, a role should be
  created and the ARN for the role should be configured in the `roleArn`.
- If a role is required, it should have an inline policy that specifies all
  the permissions that your application needs. See `AWS inline policy` in
  [References](#references)

## References
<!-- markdownlint-disable-next-line MD013 -->
- [AWS roleArn](https://docs.aws.amazon.com/sdk-for-kotlin/latest/reference/inspector/services/inspector/aws.sdk.kotlin.services.inspector.model/-register-cross-account-access-role-request/role-arn.html)
- [AWS inline policy](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_managed-vs-inline.html)

# lambda-cd-demo

This repo serves as a quick demonstration of how multiple cloud functions deployment can be managed from github actions. The main features include:

- Deployment of lambda functions to AWS

- The ability to trigger deployment of lambda in a specific directory only if changes have been applied to that directory


The deploy.sh script is currently configured to take a directory name as an argument. Each lambda function directory addeed to this repository needs to have it's own deployment script.


Assumptions:

- All the lambda functions managed in this repository belong in the same AWS account and can be managed using the same Access and secret keys

- Lambda function names are same as lambda folder names (where hyphens are replaced with underscores)

- lambda function and trigger has been setup in AWS already, this code simply maintains/ continues to update the lambda function.


# Requirements

- An aws account and user with lambda full access and Amazon S3 full access.

- A pair of secret access and access keys to configure the CI job.
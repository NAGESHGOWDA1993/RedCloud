Hello World Microservice

This project contains a simple "Hello World" microservice built with Nginx and Docker, and deployed on AWS Fargate using Jenkins for CI/CD.

Prerequisites
Docker installed locally.
Jenkins server with the necessary plugins.
AWS Account with permissions for ECR, ECS, and ACM.
AWS CLI configured with your AWS credentials.
Build Instructions
Local Build and Run
Clone the Repository:

bash
Copy code
git clone https://github.com/NAGESHGOWDA1993/RedCloud
Build the Docker Image:

bash
Copy code
docker build -t hello-world-microservice .
Run the Docker Container:

bash
Copy code
docker run -d -p 443:443 hello-world-microservice
Test the Service:

Access the default path:

bash
Copy code
curl -k https://localhost/
# Output: Hello World!
Access the health check path:

bash
Copy code
curl -k https://localhost/health
# Output: OK
Deployment Instructions with Jenkins
Set Up Jenkins Pipeline
Add AWS Credentials:

In Jenkins, navigate to Manage Jenkins > Manage Credentials.
Add a new AWS Credentials entry with your Access Key ID and Secret Access Key.
Create a New Pipeline Job:

In Jenkins, click on New Item and select Pipeline.
Configure the pipeline to use the Jenkinsfile from the repository.
Configure the Pipeline Script:

Ensure the Jenkinsfile in the repository has all the correct parameters.
Update the environment section with your AWS account details.
Run the Pipeline:

Build the pipeline.
Monitor the stages: Checkout, Build Docker Image, Push to ECR, Deploy to ECS.
AWS Resources Configuration
ECR Repository: Ensure the repository exists and the Jenkins user has push permissions.

ECS Cluster and Service:

Verify that the ECS cluster and service are set up correctly.
The service should be configured to use the latest image from ECR.
Application Load Balancer:

Ensure the ALB is correctly configured with an HTTPS listener.
Target group should point to the ECS service.
SSL certificate from ACM should be attached.
Verification
Service URL: Access the service via the ALB's DNS name.

bash

curl https://<ALB_DNS_NAME>/
# Output: Hello World!
Health Check:

bash

curl https://<ALB_DNS_NAME>/health

# Output: OK
Invalid Path:

bash

curl https://<ALB_DNS_NAME>/invalid

# Output: Not Found
Notes
HTTPS Only: The service is configured to accept only HTTPS traffic.
SSL Termination: SSL termination is handled at the ALB level.
Backend Database: Currently, there is no backend database connected.
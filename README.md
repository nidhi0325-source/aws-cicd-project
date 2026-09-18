# Automated CI/CD Pipeline for Containerized Flask Application

An end to end DevOps project that automates the process of building, testing, containerizing, publishing, and deploying a Python Flask application using Jenkins, Docker, Docker Hub, AWS EC2, GitHub, and Terraform.

## Project Overview

This project demonstrates a complete CI/CD workflow for a containerized Flask application.

The Jenkins pipeline automates:

1. Checkout of source code from GitHub
2. Docker image creation
3. Automated testing with Pytest
4. Docker image publishing to Docker Hub
5. Docker image deployment on AWS EC2
6. Replacement of the previous application container
7. Running the Flask application on port 5000

## Architecture

```text
                    Developer
                        |
                        v
                     GitHub
                        |
                        v
                    Jenkins
                  AWS EC2
                        |
             +----------+----------+
             |                     |
             v                     v
       Docker Build          Automated Tests
             |
             v
        Docker Hub
             |
             v
          AWS EC2
             |
             v
      Docker Container
             |
             v
      Flask Application
             |
             v
          Port 5000
Infrastructure Provisioning
                 Terraform
                     |
                     v
                 AWS EC2
                     |
          +----------+----------+
          |                     |
          v                     v
       Jenkins                Docker
                                  |
                                  v
                           Flask Application
Technologies Used
Technology	Purpose
Python	Application development
Flask	Web framework
Pytest	Automated testing
Git	Version control
GitHub	Source code management
Jenkins	CI/CD automation
Docker	Containerization
Docker Hub	Container image registry
AWS EC2	Cloud hosting and deployment
Terraform	Infrastructure as Code
Linux	Server administration
Project Structure
AWS-CI-CD-PROJECT/
│
├── app/
│   └── app.py
│
├── tests/
│   └── test_app.py
│
├── terraform/
│   ├── main.tf
│   └── .terraform.lock.hcl
│
├── Dockerfile
├── .dockerignore
├── .gitignore
├── requirements.txt
├── README.md
└── LICENSE
Application

The Flask application provides two endpoints.

Home Endpoint
GET /

Response:

AWS CI/CD Pipeline is working!
Health Endpoint
GET /health

Response:

{
    "status": "healthy"
}

The health endpoint provides a simple way to verify that the application is running correctly.

Docker

The Flask application is packaged into a Docker image.

Build the Image
docker build -t aws-cicd-app:v1 .
Run the Container
docker run -d \
  --name aws-cicd-container \
  -p 5000:5000 \
  aws-cicd-app:v1

Application:

http://localhost:5000

Health check:

http://localhost:5000/health
Automated Testing

The project uses Pytest for automated testing.

The tests verify:

Home endpoint returns HTTP 200
Health endpoint returns HTTP 200

Run tests locally:

pytest

The Jenkins pipeline also executes the tests inside the Docker container:

docker run --rm nidhig0325/aws-cicd-app:v1 pytest

The Docker image contains both the application and test files so that the same image can be validated during the CI pipeline.

Jenkins CI/CD Pipeline

The Jenkins pipeline contains five main stages.

1. Checkout

Jenkins checks out the latest code from the main branch.

GitHub
   |
   v
Jenkins
2. Build Docker Image

Jenkins builds the Docker image:

nidhig0325/aws-cicd-app:v1
3. Run Tests

Jenkins runs Pytest inside the Docker container.

If the tests fail, subsequent deployment stages are not executed.

4. Push to Docker Hub

After successful testing, Jenkins authenticates with Docker Hub using Jenkins Credentials and pushes the Docker image.

Jenkins
   |
   v
Docker Hub
5. Deploy to AWS EC2

Jenkins pulls the latest image from Docker Hub and deploys it on the EC2 instance.

The previous container is stopped and removed before the new container is started.

docker pull nidhig0325/aws-cicd-app:v1

docker stop aws-cicd-container || true

docker rm aws-cicd-container || true

docker run -d \
  --name aws-cicd-container \
  -p 5000:5000 \
  nidhig0325/aws-cicd-app:v1
Complete CI/CD Workflow
Developer
    |
    v
GitHub
    |
    v
Jenkins
    |
    v
Checkout
    |
    v
Docker Build
    |
    v
Pytest
    |
    v
Docker Hub
    |
    v
Docker Pull
    |
    v
AWS EC2
    |
    v
Docker Container
    |
    v
Flask Application
AWS EC2 Deployment

AWS EC2 is used to host Jenkins, Docker, and the deployed application.

The deployment environment follows this structure:

AWS EC2
   |
   +-- Jenkins
   |
   +-- Docker
          |
          +-- aws-cicd-container
                    |
                    +-- Flask Application
                              |
                              +-- Port 5000

Jenkins:

Port 8080

Flask application:

Port 5000
Infrastructure as Code with Terraform

Terraform is used to provision the AWS infrastructure.

The Terraform configuration manages:

EC2 instance
Security Group
EC2 configuration
Required network access
Initialize Terraform
terraform init
Validate Configuration
terraform validate
Review Infrastructure Changes
terraform plan
Provision Infrastructure
terraform apply
Destroy Infrastructure
terraform destroy
Docker Hub

Docker image:

nidhig0325/aws-cicd-app:v1

The image is pushed to Docker Hub automatically after successful testing in Jenkins.

Jenkins Credentials

Docker Hub authentication is managed using Jenkins Credentials.

Credential ID:

dockerhub

The Docker Hub password is not hard coded in the Jenkins pipeline.

Credentials are injected into the pipeline only when required.

Security

The project follows basic security practices:

Docker Hub credentials are stored in Jenkins Credentials
Passwords are not hard coded in the pipeline
Terraform state files are excluded from Git
The .terraform directory is excluded from Git
Private keys are not committed to the repository
AWS credentials are not stored in the source code

Never commit:

*.pem
*.tfstate
*.tfstate.*
.terraform/
.env
Key Learning Outcomes

Through this project, I gained hands on experience with:

CI/CD pipeline implementation
Jenkins Pipeline configuration
Git and GitHub
Docker image creation
Docker container management
Automated testing with Pytest
Docker Hub image publishing
AWS EC2 deployment
Linux server administration
Jenkins and Docker integration
Infrastructure as Code with Terraform
Containerized application deployment
DevOps automation
Future Improvements

Possible future enhancements include:

GitHub webhook based automatic Jenkins triggering
Kubernetes deployment
AWS ECR integration
HTTPS using a reverse proxy
Prometheus and Grafana monitoring
Jenkins shared libraries
Infrastructure deployment through a remote Terraform backend
Automated version tagging for Docker images
Author

Nidhi Gabhane

GitHub:
https://github.com/nidhi0325-source

LinkedIn:
https://www.linkedin.com/in/nidhigabhane/

License

This project is licensed under the MIT License.
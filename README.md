# 🚀 Automated CI/CD Pipeline for Containerized Flask Application

An end-to-end CI/CD project that automates the process of building, testing, containerizing, publishing, and deploying a Flask application using Jenkins, Docker, Docker Hub, and AWS EC2.

---

## 📌 Project Overview

This project demonstrates a complete CI/CD workflow for a Python Flask application.

Whenever the Jenkins pipeline runs, it automatically:

1. Checks out the latest code from GitHub
2. Builds a Docker image
3. Runs automated tests using Pytest
4. Pushes the Docker image to Docker Hub
5. Pulls the latest image on AWS EC2
6. Stops the previous container
7. Deploys a new container
8. Runs the application on port 5000

---

## 🏗️ Architecture

```text
                 Developer
                     |
                     ▼
                  GitHub
                     |
                     ▼
                  Jenkins
                     |
          ┌──────────┴──────────┐
          ▼                     ▼
    Docker Build           Automated Tests
          |
          ▼
      Docker Hub
          |
          ▼
       AWS EC2
          |
          ▼
     Docker Container
          |
          ▼
    Flask Application
       Port 5000
🛠️ Technologies Used
Technology	Purpose
Python	Application development
Flask	Web framework
Pytest	Automated testing
Git	Version control
GitHub	Source code repository
Docker	Application containerization
Docker Hub	Container image registry
Jenkins	CI/CD automation
AWS EC2	Application deployment
Terraform	Infrastructure as Code
📂 Project Structure
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
🔹 Application

The Flask application provides two endpoints.

Home
GET /

Response:

AWS CI/CD Pipeline is working!
Health Check
GET /health

Response:

{
  "status": "healthy"
}
🐳 Docker

The application is packaged into a Docker image.

Build Image
docker build -t aws-cicd-app:v1 .
Run Container
docker run -d \
  --name aws-cicd-container \
  -p 5000:5000 \
  aws-cicd-app:v1

Application:

http://localhost:5000
🧪 Testing

Automated tests are written using Pytest.

The tests verify:

Home endpoint returns HTTP 200
Health endpoint returns HTTP 200

Run tests:

pytest

Jenkins automatically executes the tests inside the Docker container.

☁️ AWS EC2 Deployment

The application is deployed on an AWS EC2 instance.

Docker runs the Flask application inside a container:

AWS EC2
   |
   └── Docker
        |
        └── aws-cicd-container
             |
             └── Flask Application
                  |
                  └── Port 5000
🔄 Jenkins CI/CD Pipeline

The Jenkins pipeline consists of the following stages:

1. Checkout

Jenkins pulls the latest code from the main branch of GitHub.

2. Build Docker Image

Jenkins builds the Docker image:

nidhig0325/aws-cicd-app:v1
3. Run Tests

Jenkins runs Pytest inside the Docker container.

4. Push to Docker Hub

After successful tests, Jenkins authenticates with Docker Hub and pushes the image.

5. Deploy to EC2

Jenkins pulls the latest Docker image and redeploys the application.

The old container is stopped and removed before the new container is started.

🔐 Jenkins Credentials

Docker Hub authentication is configured in Jenkins using Jenkins Credentials.

The Docker Hub password is not stored directly in the Jenkins pipeline script.

Credential ID:

dockerhub
📋 Jenkins Pipeline

The pipeline performs:

GitHub Checkout
      ↓
Docker Build
      ↓
Run Tests
      ↓
Docker Hub Push
      ↓
EC2 Deployment
🚀 Deployment Result

The final application runs as a Docker container on AWS EC2:

AWS EC2
   ↓
Docker Container
   ↓
Flask Application
   ↓
Port 5000
🎯 Key Learning Outcomes

Through this project, I gained hands-on experience with:

CI/CD pipeline implementation
Jenkins pipeline configuration
Git and GitHub
Docker image creation
Docker container management
Automated testing with Pytest
Docker Hub image publishing
AWS EC2 deployment
Linux server administration
Jenkins and Docker integration
Infrastructure as Code using Terraform
👩‍💻 Author

Nidhi Gabhane

GitHub:
https://github.com/nidhi0325-source

LinkedIn:
https://www.linkedin.com/in/nidhigabhane/

📜 License

This project is licensed under the MIT License.

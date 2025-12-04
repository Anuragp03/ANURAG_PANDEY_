provider "aws" {
  region = "eu-north-1"
}

locals {
  name_prefix = "ANURAG_PANDEY_"
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "resume_sg" {
  name        = "${local.name_prefix}_Resume_SG"
  description = "Allow HTTP and SSH only"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${local.name_prefix}_Resume_SG" }
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "resume_server" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [aws_security_group.resume_sg.id]
  associate_public_ip_address = true

    user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install nginx -y
              systemctl start nginx
              systemctl enable nginx

              cat <<EOT > /usr/share/nginx/html/index.html
              <html>
              <head>
                  <title>Resume | Anurag Pandey</title>
                  <style>
                      body { 
                          font-family: 'Segoe UI', sans-serif; 
                          background: #eef2f7; 
                          margin: 0; 
                          padding: 0; 
                          color: #2d2d2d;
                      }
                      .container { 
                          max-width: 850px; 
                          margin: 60px auto; 
                          background: #ffffff; 
                          padding: 45px; 
                          border-radius: 12px; 
                          box-shadow: 0 8px 20px rgba(0,0,0,0.08); 
                      }
                      h1 { 
                          text-align: center; 
                          color: #1a237e; 
                          margin-bottom: 5px; 
                          font-size: 36px;
                      }
                      h3 { 
                          text-align: center; 
                          font-weight: 500; 
                          color: #3949ab; 
                          margin-top: 0;
                      }
                      .section { 
                          margin-top: 30px; 
                      }
                      .label { 
                          font-size: 18px; 
                          font-weight: bold; 
                          color: #0d47a1;
                      }
                      .line { 
                          height: 2px; 
                          background: linear-gradient(to right, #3949ab, transparent); 
                          border: none; 
                          margin: 15px 0; 
                      }
                      .tag { 
                          display: inline-block; 
                          background: #e8eaf6; 
                          color: #1a237e; 
                          padding: 6px 12px; 
                          border-radius: 6px; 
                          margin: 4px; 
                          font-size: 14px; 
                          border: 1px solid #c5cae9;
                      }
                      p { 
                          font-size: 16px; 
                          line-height: 1.6; 
                      }
                      .footer { 
                          text-align: center; 
                          font-size: 12px; 
                          color: #777; 
                          margin-top: 40px; 
                      }
                  </style>
              </head>
              <body>
                  <div class="container">
                      <h1>Anurag Pandey</h1>
                      <h3>Cloud & DevOps Enthusiast</h3>
                      <hr class="line">

                      <div class="section">
                          <p class="label">Contact Information</p>
                          <p>Email: yourmail@example.com</p>
                      </div>

                      <div class="section">
                          <p class="label">Technical Skills</p>
                          <div>
                              <span class="tag">AWS Cloud</span>
                              <span class="tag">Terraform</span>
                              <span class="tag">Linux Administration</span>
                              <span class="tag">Git & GitHub</span>
                              <span class="tag">DevOps Basics</span>
                              <span class="tag">CI/CD Concepts</span>
                              <span class="tag">Cloud Networking</span>
                              <span class="tag">Python / Java Basics</span>
                          </div>
                      </div>

                      <div class="section">
                          <p class="label">Professional Summary</p>
                          <p>
                              Highly motivated cloud enthusiast with hands-on practice in AWS services,
                              VPC networking, IAM, EC2, and Infrastructure as Code using Terraform.
                              Interested in solving real-world deployment problems and building
                              reliable cloud solutions.
                          </p>
                      </div>

                      <div class="footer">
                          Hosted on AWS EC2 | Deployed with Terraform | © Anurag Pandey
                      </div>
                  </div>
              </body>
              </html>
              EOT
              EOF


  tags = { Name = "${local.name_prefix}_Resume_App" }
}

output "website_url" {
  value = "http://${aws_instance.resume_server.public_ip}"
}

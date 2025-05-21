#!/bin/bash

# Initialize Terraform
echo "Initializing Terraform..."
terraform init

# Validate Terraform files
echo "Validating Terraform configuration..."
terraform validate

# Plan Terraform deployment
echo "Planning Terraform deployment..."
terraform plan -out=tfplan

# Apply Terraform deployment
echo "Applying Terraform deployment..."
terraform apply tfplan

# Format Terraform files
echo "Formatting Terraform files..."
terraform fmt

# Git commands to commit and push changes
echo "Adding all changes to git..."
git add .

echo "Committing changes..."
git commit -m "Update Terraform config"

echo "Pushing to remote repository..."
git push origin main

# Terraform AWS Project

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://shields.io/)

This project contains multiple Terraform modules and an example skeleton project for deploying AWS infrastructure.

## Table of Contents

- [Project Structure](#project-structure)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Project Structure

```bash
.
├── config              
│   ├── aws.tf              # Configuration file for the AWS provider.
│   └── global.tf           # Contains global variables used throughout the project.
│
├── environments        
│   ├── dev             
│   │   └── regions     
│   │       └── <region>    # Contains links to services to be deployed in a specific region within the development environment.
│   │           └── ...
│   ├── stg             
│   │   └── regions     
│   │       └── <region>
│   │           └── ...
│   └── prod            
│       └── regions     
│           └── <region>
│               └── ...    
│
├── modules             
│   ├── module1             # A reusable Terraform module to be used by services.
│   │   └── ...
│   ├── module2         
│   │   └── ...
│   └── ...             
│
├── services            
│   ├── service1            # Instance of a module.
│   │   └── ...
│   ├── service2        
│   │   └── ...
│   └── ...             
│
└── utils               
    └── init.sh             # Bash script for initializing an environment in a specific region.
```    

## Usage

To use this project, follow these steps:

1. Set `aws.tf` and `global.tf` variables.
2. Link `aws.tf`, `global.tf`, `init.sh` and desired services in a region directory.
3. Create a `terraform.tfvars` file in the region directory to set the necessary variables for the services.
4. From the region directory initialize an environment executing the `init.sh` script linked.
5. From the region directory execute common Terraform commands. The init command is not necessary as it is already executed by the `init.sh` script.

## Contributing

Contributions to the Terraform AWS Project are welcome. To contribute, please fork the repository and create a pull request with your changes.

## License

The Terraform AWS Project is released under the MIT License.

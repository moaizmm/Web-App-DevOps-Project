# Web-App-DevOps-Project

Welcome to the Web App DevOps Project repo! This application allows you to efficiently manage and track orders for a potential business. It provides an intuitive user interface for viewing existing orders and adding new ones.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [Technology Stack](#technology-stack)
- [Milestone 2: Version Control](#milestone-2-version-control)
- [Milestone 3: Containerization with Docker](#milestone-3-containerization-with-docker)
- [Milestone 4: Defining Networking Services with IaC](#milestone-4-defining-networking-services-with-iac)
- [Milestone 5: Definining an AKS Cluster with IaC](#milestone-5-defining-an-aks-cluster-with-iac)
- [Milestone 6: Creating an AKS Cluster with Iac](#milestone-6-creating-an-aks-cluster-with-Iac)
- [Milestone 7: Kubernetes Deployment to AKS](#milestone-7-kubernetes-deployment-to-aks)
- [Milestone 8: CI/CD Pipeline with Azure DevOps](#milestone-8-ci/cd-pipeline-with-azure-devops)
- [Milestone 9: AKS Cluster Monitoring](#milestone-9-aks-cluster-monitoring)
- [Milestone 10: AKS Integration with Azure Key Vault for Secrets Management](#milestone-10-aks-integration-with-azure-key-vault-for-secrets-management)
- [Contributors](#contributors)
- [License](#license)



## Feature

- **Order List:** View a comprehensive list of orders including details like date UUID, user ID, card number, store code, product code, product quantity, order date, and shipping date.
  
![Screenshot 2023-08-31 at 15 48 48](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/3a3bae88-9224-4755-bf62-567beb7bf692)

- **Pagination:** Easily navigate through multiple pages of orders using the built-in pagination feature.
  
![Screenshot 2023-08-31 at 15 49 08](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/d92a045d-b568-4695-b2b9-986874b4ed5a)

- **Add New Order:** Fill out a user-friendly form to add new orders to the system with necessary information.
  
![Screenshot 2023-08-31 at 15 49 26](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/83236d79-6212-4fc3-afa3-3cee88354b1a)

- **Data Validation:** Ensure data accuracy and completeness with required fields, date restrictions, and card number validation.

## Getting Started

### Prerequisites

For the application to succesfully run, you need to install the following packages:

- flask (version 2.2.2)
- pyodbc (version 4.0.39)
- SQLAlchemy (version 2.0.21)
- werkzeug (version 2.2.3)
- azure-identity (version 1.15.0)
- azure-keyvault-secrets (version 4.7.0)
### Usage

To run the application, you simply need to run the `app.py` script in this repository. Once the application starts you should be able to access it locally at `http://127.0.0.1:5001`. Here you will be meet with the following two pages:

1. **Order List Page:** Navigate to the "Order List" page to view all existing orders. Use the pagination controls to navigate between pages.

2. **Add New Order Page:** Click on the "Add New Order" tab to access the order form. Complete all required fields and ensure that your entries meet the specified criteria.

## Technology Stack

- **Backend:** Flask is used to build the backend of the application, handling routing, data processing, and interactions with the database.

- **Frontend:** The user interface is designed using HTML, CSS, and JavaScript to ensure a smooth and intuitive user experience.

- **Database:** The application employs an Azure SQL Database as its database system to store order-related data.

## Milestone 2: Version Control
### Function
- This milestone was used to create a new column called delivery_date in the backend SQL database and the revert back to original code.
### How this was done:
- **Step 1:** Firstly create a new feature branch using git checkout -b new_feature_branch command.
- **Step 2:** Modify Order class in app.py and delivery_date = Column('Delivery Date', DateTime) to the class attributes. 
- **Step 3:** Modify add_order in the app.route to include delivery_date = request.form['delivery_date'] field. Then in the new_order variable add delivery_date=delivery_date.
- **Step 4:** Update order.html by modifying the <th> elements <th>Delivery Date</th> and <td> elements with <td>{{ order.delivery_date }}</td>. Once complete modify the <form> element to include <label for="delivery_date">Delivery Date:</label> <input type="date" id="delivery_date" name="delivery_date"><br><br> and Save.
- **Step 5:** Add and commit the files using git add and git commit and then use git push to push to remote repository.
- **Step 6:** Create a pull request on GitHub and merge the request.
- **Step 7:** If need to revert, create a revert-delivery-date branch, use git log to find the latest commit hash. Revert to the commit with git revert COMMIT_HASH. Commit and push and create and merge the pull request.

## Milestone 3: Containerization with Docker

### Function
- This milestone was used to build a new docker image, tag the image and push it to Dockerhub whilst testing the image locally by running the image locally. Dockerfile was also created to contain all the required commands needed to build the image once the application and relevant folders and files have been containerized.

### Comtainerization Process

#### Dockerfile
- The first step of the containerization process was to the create a Dockerfile. This involved the use of various commands such as:
- FROM --platform=linux/amd64 public.ecr.aws/docker/library/python:3.8-slim-buster : this provides the base image selection that will be pulled from DockerHub and used as the base image.
- WORKDIR /app : sets the working directory in the container. /app is a commonly used directory for web applications.
- COPY . /app : copies all the applications files in local directory into the container's /app directory. This ensures the application code and files are within the container.
- RUN : first RUN command used to install system dependancies and ODBC driver.
- RUN pip install --upgrade pip setuptools : used to install pip and setuptools.
- RUN pip install --trusted-host pypi.python.org -r requirements.txt : used to install the python packages specified in requirements.txt
- EXPOSE 5001 : used to expose the port 5001 to make the Flask application available outside the container.
- CMD ["python","app.py"] : used to specify the command that should be executed when the container is launched. In this project it will run the file (app.py) that starts the Flask application.

#### Build Docker Image
- The next step was to build the docker image using the docker build command. In this project the command used was (docker build -t webbuild .). 
- The next step was to run and test the application locally to ensure the application functions correctly within the containerized environment. This was achieved through the command  (docker run -p 5001:5001 webbuild) which maps port 5001 from my local machine to the container, enabling access to the containerized application from my local development environment. This was tested on the browser via http://127.0.0.1:5000.
- The final step was to tag and push the image to DockerHub. This was done through (docker tag webbuild moaizmm/webbuild:1.1) and (docker push moaizmm/webbuild:1.1).

## Docker Commands
-  docker build -t <name of the image> . : this is used to build the docker image. In the case of this project the name chosen was webbuild.
-  docker run -p 5000:5000 <name of the image> : this is used to run the image locally which can accessed via 127.0.0.1:5001.
-  docker tag <name of the image> <docker-hub-username>/<image-name>:<tag> : used to tag the Docker image with additional information. (docker tag webbuild moaizmm/webbuild:1.1) was used.
-  docker push <name of the image> : used to push this image to Dockerhub. In this project the command (docker push moaizmm/webbuild:1.1) was used.
-  docker images : used to list the Docker images that have been created.
-  docker ps -a : list running and stopped containers.
-  docker rm <container-id>: removes container associated with entered container ID.
-  docker stop <container-id> : stops container associated with entered container ID.
-  docker images -a : lists all images.
-  docker rmi <image-id> : removes image associated with entered image ID.

## Milestone 4: Defining Networking Services with IaC

### Function
- The first step was initialize my terraform project which was called aks-terraform. This project was then split into two Terraform modules: networking-module for provisioning an Azure Kubernetes Service (AKS) cluster using Infrastructure as Code (IAC) and the other was aks-cluster-module which was used to provision the Kubernetes cluster. This section will focus on the networking-module.

### Input Variables
- The first step was to create a variables.tf file inside the networking-module and define the input variables. The input variables defined were:
- resource_group_name: represents the name of Azure Resource Group where the networking resources were deployed in. This was of type string and has a default vaulue of "webapp-rg".
- location: specifies the Azure region where the networking resources were being deployed to. This was of type string and has a default value of "UK South".
- vnet_address space: specifies the address space for the Virtual Network (VNet). This was of type list(string) and has a default value of ["10.0.0.0/16"].

### Networking Resources and NSG Rules 
- The next step was to define the essential networking resources for AKS cluster and this was done in a new file main.tf. The following resources that were created are:
- Azure Resource Group: this resource defines the Azure Resource Group and the name and location are referenced by the resource_group_name and location variables created earlier.
- Virtual Network (VNet): this resource is provided a name of "aks-vnet and the location, resource group name and vnet address space are referenced by the location, resource_group_name and vnet_address_space variables defined earlier.
- Control Plane Subnet: this defines a subnet within the VNet for the control plane and is provided with a name "control-plane-subnet". The resource_group_name and virtual_network_name are referenced by azurerm_resource_group.networking.name and azurerm_virtual_network.aks_vnet.name defined earlier. The address prefixes defines the address space for the subnet which is  ["10.0.1.0/24"].
- Worker Node Subnet: this defines a subnet within the VNet for the worker node and is provided with a name "worker-node-subnet". The resource_group_name and virtual_network_name are referenced by azurerm_resource_group.networking.name and azurerm_virtual_network.aks_vnet.name defined earlier. The address prefixes defines the address space for the subnet which is  ["10.0.2.0/24"].
- Network Security Group (NSG): this defines the NSG and is provided with the name of "aks-nsg". There are two rules (kubee-apiserver-rule) and (ssh-rule) that are defined as seperate resources but are associated with this NSG. The rules have been provided with a priority of 1001 and 1002 respectively and both focus on inbound traffic. The kube-apiserver-rule is to allow traffic to the kube-apiserver which is provided with destination port range of 443 which is the HTTPS port which is used for secure communication with the API server. The ssh-rule is provided with destination port range of 22 which is the SSH port. Both rules have the source_address_prefix set as the local IP.

### Networking Resources Module Output Variables
- The final file created in this module is the outputs.tf which is where the output variables are defined. Output variables allow you to utilize information from the networking module. The output variables that were created are:
- vnet_id: stores the ID of the previously created VNet. This is used within the cluster module to connect the cluster to the defined VNet. This is provided with a value of azurerm_virtual_network.aks_vnet.id.
- control_plane_subnet_id: holds the ID of the control plane subnet within the VNet. This isused to specify the subnet where the control plane components of the AKS cluster will be deployed to. This is provided with a value of azurerm_subnet.control_plane_subnet.id.
- worker_node_subnet_id: stores the ID of the worker node subnet within the VNet. This is used to specify the subnet where the worker nodes of the AKS cluster will be deployed to. This is provided with a value of azurerm_subnet.worker_node_subnet.id.
- networking_resource_group_name: provides the name of the Azure Resource Group where the networking resources were provisioned in. This is used to ensure the cluster module resources are provisioned within the same resource group. This is provided with a value of azurerm_resource_group.networking.name.
- aks_nsg_id: stores the ID of the Network Security Group (NSG). This is used to associate the NSG with the AKS cluster for security rule enforcement and traffic filtering. This is provided with a value of azurerm_network_security_group.aks_nsg.id.
- The final step was to initialize the networking module. Once I ensured I was in the networking=module I entered terraform init to initialize the networking-module.

## Milestone 5: Defining an AKS with IaC

### Function
- Now the networking-module had been completed the next step was to work on the aks-cluster-module to implement the necessary resources to automate the provisioning of an AKS cluster.

### Input Variables
- Once in the aks-cluster-module he first step was to define the cluster module input variables in variables.tf which are the following:
- aks_cluster_name: represents the name of the AKS cluster. This has a default value of "azure_aks_cluster".
- cluster_location: specifies the Azure region where the AKS cluster will be deployed. This has a default value of "UK South".
- dns_prefix: defines the DNS prefix of cluster.
- kubernetes_version:specifies which Kubernetes version the cluster will use.
- service_principal_client_id: provides the Client ID for the service principal associated with the cluster.
- service_principal_secret: supplies the Client Secret for the service principal.
- Additionally output variables from networking module were passes as input variables such as resource_group_name, vnet_id, control_plane_subnet_id, and worker_node_subnet_id. All variables are of type string.

### Defining the Cluster Resources
- The next step was to define the necessary Azure resources for provisioning an AKS cluster. This included creating the AKS cluster, speciying node pool and service principal. This was done in the main.tf file in the aks-cluster-module.
- The aks_cluster resource incorporated the input variables defined in previous stage such as aks_cluster_name, cluster_location, dns_prefix, kubernetes_version, service_principal_client_id, service_principal_secret.
- The next part of the resource is the default node pool which defines the default node pool of the cluster. The variables selected were name (default), node_count (sets the initial number of nodes in node pool to 1), vm_size (specifies VM size for nodes in pool - Standard_DS2_v2), enable_auto_scaling (true), min_count (sets min number of nodes to 1), max_count (sets max number of nodes to 3).
- The final part of the reousrce s the service_principal block which provides the authentication details for the AKS cluster which takes the client_id and client_secret from the service principal.

### Defining the Cluster Module Output Variable
- The final file created in this module is the outputs.tf which is where the output variables are defined. Output variables allow you to utilize information from the aks-cluster-module. The output variables that were created are:
- aks_cluster_name: stores the name of the provisioned cluster. This was given a value of azurerm_kubernetes_cluster.aks_cluster.name.
- aks_cluster_id: stores the ID of the cluster. This was given a value of azurerm_kubernetes_cluster.aks_cluster.id.
- aks_kubeconfig: captures the Kubernetes configuration file of the cluster. This file is essential for interacting with and managing the AKS cluster using kubectl. This was given a value of azurerm_kubernetes_cluster.aks_cluster.kube_config_raw.
- The final step was to initialize the aks cluster module. Once I ensured I was in the aks-cluster-module I entered terraform init to initialize the aks-cluster-module.

## Milestone 6: Creating an AKS Cluster with IaC

### Function
- The function of this milestone was to complete the provisioning of AKS cluster using terraform by making use of the networking-module and aks-cluster-module to create the AKS cluster. This was created in a new main.tf file in the main project directory (aks-terraform).

### Provider Block and Input Variables
- Provider Block: the first step was to define the provider block to enable authentication to Azure using my service principal credentials. The source chosen was "hashicorp/azurerm" with version "3.0.0". This specifies that I am using Azure as my cloud provider.
- Input Variables: the next step was to define the input variables for the provider block. These were client_id (var.client_id), client_secret (var.client_secret), subsricption_id (my Azure subscription ID) and tenant_id (my Azure tenant ID).
- Environment Variables: a new variables.tf file was created to allow storing of client_id and client_secret while avoiding hardcoding them for security reasons. They were both set to type of string and true for sensitive. The ID's were stored in the .zshrc file to ensure that the IDs were secure and not hardcoded. The state file was added to .gitignore file to ensure the file with the credentials were not pushed.

### Networking Module
- The next step was to use the networking module that was created to provision the networking resources. This was done through the module "networking" block. The input variables set were resource_group_name (set to "networking-rg), location (set to "UK South) and vnet_address_space (set to ["10.0.0.0/16"]).

### AKS Cluster Module
- The next step was to use the AKS cluster module that was used to define and provision the AKS cluster. This was done through the module "aks_cluster" block. The input variables for the AKS cluster were set here such as aks_cluster_name (set to "terraform-aks-cluster" ), cluster_location (set to "UK South"), dns_prefix(set to "myaks-project"), kubernetes_version (set to "1.26.6"), service_principal_client_id (set to var.service_principal_client_id) and service_principal_client_secret (set to var.service_principal_client_secret).
- Enviroment Variables: service_principal_client_id and service_principal_client_secret were added to the variables.tf file like client_id and client_secret to ensure the credentials were secure and not hardcoded. The ID's were stored in the .zshrc file.
- The next part was to input variables referencing outputs from the networking module such as resource_group_name, vnet_id, control_plane_subnet_id, worker_node_subnet_id and aks_nsg_id. 
- Now the main configuration file was defined I reviewed the changes and planned the deployment the terraform init and terraform plan. I then applied the changes through terraform apply.

## Milestone 7: Kubernetes Deployment to AKS

### Function
- The function of this milestone was to proceed with the deployment of the containerized application to the Kubernetes cluster. This involved provisioning the essential Kubernetes manifests required for deployment.

### Kubernetes Manifest Definition - Deployment
- The first part was to create the manifest file called application-manifest.yaml where the necessary Deployments resources are defined.
- This included setting the kind to Deployment, and under metadata defining the name flask-app-deployment and the label flask-app.
- Next was defining the spec section which involved setting replicas to 2, allowing for high scalability and high availability. Then using the matchLabels I defined label to be flask-app to allow Kubernetes to identify which pods the Deployment should manage. Also in metadata section I defined a label to be flask-app which is used to mark the pods created by the Deployment, establishing a clear connection between the pods and application.
- Later in the spec section I configured the manifest to point to the Docker image I built and pushed earlier on which is moaizmm/webbuild:1.1 and pointed to the container housing the application flask-container which was already hosted on Docker Hub. This ensured that the correct container image is utilized for deployment. Using containerPort I exposed port 5001 which serves as the gateway for accessing the user's interface.
- In the final part of the Deployment definition I implemented the Rolling Updates deployment strategy as this facilitates seamless application updates. During updates I ensured that a maximum of one pod deploys while one pod becomes temporarily unavailable, mainting application availability by setting maxSurge and maxUnavailable both to 1.

### Kubernetes Manifest Definition - Service
- The next part of the manifest file was to define the service to facilitate internal communication within the AKS cluster.
- This included setting the kind to Service and defining a name of flask-app-service. 
- Next I set the service type to ClusterIP, designating it as an internal service within the AKS cluster and then ensured the selector matches the labels (app: flask-app) of previously defined pods. This alignment guaranteesdthat the traffic is efficiently directed to the appropriate pods, maintaining seamless internal communication within the AKS cluster.
- Finally I configured the service to use TCP protocol on port 80 for internal communication with the targetPort set to 5001 which corresponds to the ecposed containerPort defined earlier.

### Deploying, Testing and Validating Deployments
- The next step was to ensure I was in correct context using the commands kubectl config get-contexts and kubectl config use-context <your-aks-context-name>. I then applied the deployment using kubectl port-forward deployment/flask-app-deployment 5001:80. This allowed me to test the application locally at http://localhost:5001 and ensured functionalites were working.
- I also checked Azure Portal as well as kubectl get pods to ensure the cluster had been created and deployment was successful. I also used kubectl to ensure pods were running and services were correctly exposed. I also tested locally using  kubectl port-forward <pod-name> 5001:5001 and http://127.0.0.1:5001. I then thoroughly tested the functionality of web application particularly the orders table and Add Order functionality.
- To distribute application to other internal users in the organization I would use an Ingress controller instead of ClusterIP as it provides mechanisms for broader accessibility and routing. Ingress controllers would allow me to manage more advance routing, domain-based access, and could be a powerful way to manage both internal and external traffic.
- For external users Load Balancer service would be the preferred choice. This setup is especially suitable in scenarios where I want to share the application to a broader audience, such as a public website or a customer portal.

## Milestone 8: CI/CD Pipeline with Azure DevOps

### Function
- The function of this milestone was to configure a Continious Integration/Continious Deployment (CI/CD) pipeline using Azure DevOps to automate the deployment of the application. The pipeline automates the containerization and deployment process, so that every time a new feature is added to the application, it will trigger the automatic build of an updated Docker iamge, its release to Docker Hub and the deployment of the updated containers to the Kubernetes cluster.

### Process
- The first step was to create an Azure DevOps project called flask-web-project and configuring the source repository to be GitHub as the source control system and selecting the correct repository on GitHub.
- The next step was to create a Starter Pipeline, then establishing an Azure DevOps-Docker Hub connection by setting up a service connection by creating a personal access token on Docker Hub, configuring an Azure DevOps service connection to utilize this token and then verify the connection had been successfully established.
- The next step was to modify the pipeline to enable it to build and push an image to Docker Hub. This was done by adding the Docker task with the buildandPush command and ensuring the repository was the correct one and tags were set to latest and the Dockerfile location was correct as well as setting the containerRegistry to Docker Hub. I then tested the newly created Docker image by pulling the latest version from Docker Hub via docker pull and ran the image to ensure the application was working as expected.
- The next step was to establish an Azure DevOps-AKS connection by creating an AKS service connection to establish a secure link between the CI/CD pipeline and the AKS cluster, enabling seamless deployments and effective management. This was done by choosing Azure Resource Manager as service connection, Service Principal (manual) for Authentication Method, entering correct Subscription ID and Name, and then entering the correct Service Principal ID (client_id/app ID), Service principal key (client_secret) and Tenant ID.
- The next step was to modify the pipeline to incorporate the Deploy to Kubernetes task with the deploy kubectl command by setting action to deploy, connectionType to azureResourceManager, azureSubscriptionConnection to aks-service-connection, azureResourceGroup to networking-resource-group, kubernetesCluster to terraform-aks-cluster and manifests to 'kubernetes/application-manifest.yaml'.
- For testing, pods were monitored using kubectl and port forwarding was used to access locally exposed address provided by the cluster and tested the functionalities to ensure the CI/CD pipeline was working.

## Milestone 9: AKS Cluster Monitoring

### Function
- The function of this milestone was to ensure effective monitoring and alerting for the AKS cluster to ensure the cluster runs smoothly and potential issues are identified and addressed properly. This was acheived through Container Insights, Metrics Explorer, Log Analytics and Alerts.

### Metrics Explorer
- The first part was to enable Container Insights and create various metric charts using Metrics Explorer. The charts that were created were:
- Average Node CPU Usage: allowed the tracking of the CPU usage of my AKS cluster's nodes. Monitoring CPU usage helps ensure efficient resource allocation and detect potential performance issues.
![AvgCPUUsage]
- Average Number of Pods in Ready State: displays the average number of pods in a running state in my AKS cluster. It's a key metric for evaluating the cluster's capacity and workload distribution.
![AvgPodCount]
- Used Disk Percentage: monitoring disk usage is critical to prevent storage-related issues. This chart helped me track how much disk space is being utilized.
![AvgDiskUsed]
- Bytes Read and Written per Second: monitoring data I/O is crucial for identifying potential performance bottlenecks. This chart provided insights into data transfer rates.
![BytesR&W]
### Log Analytics
- The next part of this milestone was to configure Log Analytics to execute and save the following logs:
- Average Node CPU Usage Percentage per Minute: This configuration captured data on node-level usage at a granular level, with logs recorded per minute
- Average Node Memory Usage Percentage per Minute: Similar to CPU usage, tracking memory usage at node level allowed me to detect memory-related performance concerns and efficiently allocate resources.
- Pods Counts with Phase: This log configuration provided me with information on the count of pods with different phases, such as Pending, Running, or Terminating. It offered insights into pod lifecycle management and helped ensure the cluster's workload is appropriately distributed.
- Find Warning Value in Container Logs: By configuring Log Analytics to search for warning values in container logs, I was able to proactively detect issues or errors within my containers, allowing for prompt troubleshooting and issues resolution
Monitoring Kubernetes Events: Monitoring Kubernetes events, such as pod scheduling, scaling activities, and errors, can be essential for tracking the overall health and stability of the cluster. 

### Alarms
- The next part of this mileston was set up a Disk Used Percentage alarm which will trigger an alarm when the used disk percentage in AKS cluster exceeds 90%. This would help me proactively detect and address potential disk issues that could lead to performance degradation and service interruptions. The alert was set to check every 5 minutes and have a loopback period of 15 minutes. The alert was configured to send notifications to my email address, so I could determine what is the best strategy for responding to these alarms.
- The next part to modify the alert rules for CPU usage and memory working set percentage to trigger when they exceed 80%. CPU and memory are critical resources in my AKS cluster. When they are heavily utilized, it could lead to decreased application performance. By setting alert rules to trigger at 80%, I would ensure that I am notified when these resources are approaching critical levels.
- With monitoring and setting up alerts I could allocate extra capacity when alarm triggers that the usage has exceeded 80%. This would ensure high availability and ensure the cluster is working efficiently. It also provides me the ability to troubleshooting issues by looking at the various logs to identify issues and deal with them efficiently as well as the ability of scaling resources such as scaling replicas manually using kubectl scale command or autoscaling with Horizontal Pod Autoscaler (HPA) with the command kubectl autoscale deployment <deployment-name> --cpu-percent=50 --min=2 --max=10.

## Milestone 10: AKS Integration with Azure Key Vault for Secrets Management

### Function
The function of the final milestone was to implement a solution to securely store and retrieve the database credentials to ensure the credentials are not hardcoded in the code files. This would fortify the application against potential security threats but also adhering to best practices in handling sensitive information. This was through Azure Key Vault.

### Process
- The first step was to create a Key Vault on Azure Key Vault and assign Key Vault Administrator role to my Microsoft Entra ID to grant myself the necessary permissions for managing the secrets within the Key Vault.
- The next step was to create the secrets to store the credentials used within the application to connect to the backend database. This includes creating a secret for server name, server username, server password and database name. I then ensured that the values of the secrets were set to the hardcoded values from the application code.
- The next step was to enable Managed Identity for AKS which would be allowed to authenticate and interact securely with the Key Vault. This was achieved through the command az aks update --resource-group <resource-group> --name <aks-cluster-name> --enable-managed-identity. I then used the command az aks show --resource-group <resource-group> --name <aks-cluster-name> --query identityProfile to note the Client ID needed for the next step.
- The next step was to assign Key Vault Secrets Officer role to the managed identity, allowing it to retrieve and manage secrets. This role provided me with permissions to read, list, set and delete secrets, certificates, and keys within the specified Azure Key Vault. This was acheived throught the command az role assignment create --role "Key Vault Secrets Officer" \ --assignee <managed-identity-client-id> \ --scope /subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.KeyVault/vaults/{key-vault-name}.
- The next step was to update the application code. This first involved integrating the Azure Identity and Azure Key Vault libraries to facilitate communication with Azure Key Vault. I first installed through pip install azure-identity and pip install azure-keyvault-secrets and then modified the application code by adding from azure.identity import ManagedIdentityCredential and from azure.keyvault.secrets import SecretClient. 
- I then updated the application code to set up an Azure Key Vault client with Managed Identity and then to access secrets from the Key Vault to obtain the credentials required for the database connection. This replaced the need for hard-coding sensitive information within my application, and introduced a more secure and dynamic credential management strategy.
- The final step was End-to-End Testing in AKS. First I tested locally ensuring seamless integration with Azure Key Vault. I verified that the application can securely retrieve and utilize the database connections details from Key Vault using managed identity credentials. I then deployed the modified application to the AKS cluster using the pre-established Azure DevOps CI/CD pipeline. Finally I conducted Conduct end-to-end testing within the AKS environment to validate the functionality of the application, ensuring secure access to Key Vault secrets directly from the Azure DevOps CI/CD pipeline.

- This project is outlined in a high level manner through the chart named DevOps Pipeline Architecture.pdf which is stored in this repository.
## Docker Image
- The image created that is used is called moaizmm/webbuild with a tag of 1.1. This image is set with a port 5001 so once the image is run you can access via http://127.0.0.1:5001.


## Contributors 

- [Maya Iuga]([https://github.com/yourusername](https://github.com/maya-a-iuga))

## License

This project is licensed under the MIT License. For more details, refer to the [LICENSE](LICENSE) file.


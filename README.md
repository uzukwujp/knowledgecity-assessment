# knowledgecity-assessment

## Architectural Diagram

![Architectural Diagram](./images/Copy%20of%20knowledgecity.drawio.png)


## Brief Overview

Cilium CNI is a center piece of my architectural design. The design involves deploying two Kubernetes clusters, one in the primary region and the other in the failover region. Cilium acting as both a CNI and service mesh that joins the two clusters. Cilium takes care of routing traffic across clusters as oppose to using AWS Load Balancers. This design choice saves us a lot of cost.

Also  Mysql database will be deployed in the primary region and a read replica in the failover region. Deploying a read replica also saves us cross region cost.

## Compute

The virtual machines of the clusters will be managed and deployed by karpenter. This design choice helps us leverage spot instances that will greatly reduce our cost. Karpenter is an autoscaler. It integrates directly with the EC2 API and is very fast in provision virtual machines. Karpenter also gives us the capability to spread our workload across zones within a region and pick the right instance size for us using the resource requirements of the pods etc.

## Continous Integration and Continous Delivery
For continous Integration and Continous Delivery, I am employing the Gitops approach.
I developed a model pipeline that takes care of continous integration. Ultimately the end product of the pipeline is to create images with the appropriate tags.  Argocd, a kubernetes controller helps us with continous delivery. Argocd watches a file where kubernetes manifest is defined, it reconcils changes made to the file in the cluster.

## Database Schemas

The database schema is managed declaratively. The database tables, and schemas can be defined in a kubernetes resource and applied to the mysql database server  using **Schemahero**. Schemahero is a kubernetes controller that helps in  managing database schema as kubernetes resources.

## Observability
Cilium leverages the power of ebpf to make available enormous metrics. With cilium we have access to metrics about our applications, dns, http etc out of box without any form of instrumentation. I wrote a terraform module for kube-prometheus-stack to harvest the telemetry data made available by cilium.

## Security

cilium also provides layer 3/4 and layer 7 network policy capabilities. This allows us define rules to allow only traffic that are necessary. Also with terragon we have runtime security that can alert us when malicious acitivity happens within our cluster.

## Deploying AWS Resources

AWS resources are defined using terraform. And can be deployed following these steps:

- First make sure you are inside the root of the repo

- Next Run: `terraform init`

- Next Run: `terraform plan`

- Finally Run: `terraform apply`

## Cost Optimisation

Minimising cost but meeting the requirements of the project was something I paid great attention to. I took the following steps to achieve this:

- Leveraging Cilium for routing traffic accross the cluster as opposed to using AWS Load Balancers.
- Using Karpenter to manage instances to deploy nodes where stateless application are deployed. This will help us take good advantage of spot instances.

- Deploying a Read Replica in the failover region to minimize cross region data transfer to only writes operation.







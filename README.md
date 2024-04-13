# Project US Accidents (2016 - 2023)

---
## Overview
The goal of this project is to build an end-to-end batch data pipeline to perform ELT (Extract Load Transform) oncountrywide car accident dataset that covers 49 states of the USA. The accident data were collected from February 2016 to March 2023, using multiple APIs that provide streaming traffic incident (or event) data. Data available at [US_Accidents_March23](https://www.kaggle.com/datasets/sobhanmoosavi/us-accidents). And perform ELT daily in order to analyse the casualty analysis, accidents distribution from historical data to till March 2023(the dataset will no longer be updated, and this version should be considered the latest).



### Table of contents

- [Overview](#overview)
  - [Dataset](#dataset)
  - [Objective](#objective)
- [Data Pipeline Overview](#data-pipeline-overview)
- [Technologies](#technologies)
- [Architecture](#architecture)
- [ELT Steps](#elt-steps)
- [The Dashboard](#the-dashboard)
- [Reproduction](#reproduction)
- [References & Resources](#references--resources)


## Problem statement
---
* ### ***Dataset***: 
    The Dataset selected for this project is the `A Countrywide Traffic Accident Dataset (2016 - 2023)` obtained from [Kaggle](https://www.kaggle.com/datasets/sobhanmoosavi/us-accidents). This is a countrywide car accident dataset that covers 49 states of the USA. The accident data were collected from February 2016 to March 2023, using multiple APIs that provide streaming traffic incident (or event) data. These APIs broadcast traffic data captured by various entities, including the US and state departments of transportation, law enforcement agencies, traffic cameras, and traffic sensors within the road networks. The dataset currently contains approximately 7.7 million accident records. For more information about this dataset, please visit here.


    The columns in the Dataset and their description is available [here](https://smoosavi.org/datasets/us_accidents)

* ### Objective:
---
  Data will be extracted from the source, and an end-to-end data pipeline will be constructed. The process includes creating an end-to-end pipeline, performing batch data processing, ingesting and storing data in a data lake, a pipeline to analytical warehouse and building interactive dashboards for visualization.




## Data Pipeline Overview 

## Technologies 
---
* Cloud: ***GCP***
* Infrastructure as code (IaC): ***Terraform***
* Workflow orchestration: ***Mage***
* Data Warehouse: ***BigQuery***
* Data Transformation: ***dbt-cloud***
* Dashboard: ***Looker Studio***


## Architecture
---

![US_car_crash drawio](https://github.com/TinChung41/US-Accidents-Analysis-zoomcamp-project/assets/98845918/d4ca22a6-1278-4204-abe8-db7e33ae30e5)





## ELT Steps

Steps in the ELT are as follows:

1. A Project is created on ***GCP*** 
1. Infrastructure for the Project is created using ***Terraform*** which creates the following:
    * Data lake : ***Google Cloud Storage Bucket*** where the raw and cleaned-partitioned data will be stored
    * Data Warehouse: Three Datasets on ***BigQuery***
    * Using docker image for Mage


        
        ***Note***: Lastest Mage image on Google Cloud Run can't upload large Local file or able to be mounted with a local file with it(not to my knowledge). So I host my local Mage with my file to upload it to GCS
1. Load data from BigQuerry to DBT for transformation and deployment

    * ELT PIPELINE VISUALIZATION WITH MAGE AS ORCHESTRATION
    * 
**Local CSV to GCS**

![image](https://github.com/TinChung41/US-Accidents-Analysis-zoomcamp-project/assets/98845918/730a4cf1-cbe2-4be0-8068-a6eee477ec0f)

**GCS to BigQuerry**

![image](https://github.com/TinChung41/US-Accidents-Analysis-zoomcamp-project/assets/98845918/f527e869-ad39-41a8-abce-3c5c8a6841ba)

**DBT**

![image](https://github.com/TinChung41/US-Accidents-Analysis-zoomcamp-project/assets/98845918/314122d2-ec9b-4139-a1f5-9cb44fc87d5e)

## The Dashboard: 
---
The dashboard is accessible from [here](https://lookerstudio.google.com/reporting/7c6e5596-cc29-4c62-9abb-c68e8bd37982)


![image](https://github.com/TinChung41/US-Accidents-Analysis-zoomcamp-project/assets/98845918/c6b7324a-ba50-4ff4-8647-6e39e2b675f4)



## Reproduction:
---
**IMPORTANT**: due to the csv being a bit large, I recomended using sample file of the dataset, I also built the pipeline for the [sample.csv](https://drive.google.com/file/d/1U3u8QYzLjnEaSurtZfSAS_oh9AT2Mn8X) before implement the real dataset.

### 1 Pre-requisites
Set up GCP account

Install terraform cli with [this](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) 

Install Docker via this [link](https://docs.docker.com/desktop/install/linux-install/)

### 2 Google Cloud Platform (GCP)

Create your project, go to IAM and then Service account for 

Mage
---

![image](https://github.com/TinChung41/US-Accidents-Analysis-zoomcamp-project/assets/98845918/30f96db4-df1a-4692-a36b-99a4ac4aca93)

DBT
---

![image](https://github.com/TinChung41/US-Accidents-Analysis-zoomcamp-project/assets/98845918/c714be68-8b3b-42b1-8b43-ef920b6b5253)

Download the json file for credential and authentification




### 3 Terraform

Terraform is infrastructure as cloud for Mage

***Note***: Lastest Mage image on Google Cloud Run can't upload large Local file or able to be mounted with a local file with it(not to my knowledge). So I host my local Mage with my file to upload it to GCS, then use cloud run to load data from gcs to bigquerry

**prerequisite**
google cloud CLI
google cloud permissions
Mage Terraform templates

Download Mage template: 
`git clone https://github.com/mage-ai/mage-ai-terraform-templates.git`

go to gcp directory, and change the variables name using this video: [part1](https://www.youtube.com/watch?v=9A872B5hb_0&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&index=30), 

modify the variable in variables.tf
```
variable "project_id" {
  type        = string
  description = "The name of the project"
  default     = "my-data-project-13837"
}
```
Make sure the following APIs are enabled in this [link](https://console.cloud.google.com/apis/library?hl=vi&project=my-data-project-13837)
Cloud SQL Admin API
Cloud Filestore API
Serverless VPC Access API

in the directory `mage-ai-terraform-templates/gcp$` run
```
terraform init
terraform apply
```




Set up for Cloud Run
---

[part2](https://www.youtube.com/watch?v=0YExsb2HgLI&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&index=31)

Redeploy and set higher time out for cloud run

When you are done with this Mage instance, then run `terraform-destroy` to avoid your free credit run out

### 4 Mage
cd into the mage directory. Rename dev.env to .env. You will notice there are some postgres configurations there. That can be removed.
Ensure that docker has already been installed as indicated above.
Run docker compose build to build mage using docker.
Once the image has been created. Run docker compose up -d in your terminal to initialize the mage application. Ensure your port has been forwarded since you are on a virtual machine (if you used the compute instance).
image

Navigate to http://localhost:6789 in your browser to access mage application
Your file structure in mage will look like this:


Go to edit pipelines and create the pipelines to resemble the structure below and code in the pipeline folders. Ensure to edit resource name in code to match yours.
	
1. Pipeline to move data from S3 to gcs	2. Pipeline to move data from gcs to big query
You can watch this Video and the playlist to understand more. 8. Execute Pipelines in the order above, then you should have data in big query.

### 5 DBT
I used dbt cloud for this project but you can decide to code locally. Refer to Video and follow up Videos in that section for more guidance on dbt in general including how to develop and deploy dbt models.

Create a free account on dbt cloud
Create a project and connect to big query. Create a new key from the same service account you created to be used for dbt. Watch this for more assistance. Specify location to EU if you're using a GCP resource created there.
Replicate file contents are in the dbt/capital_share folder. File structure would look like


When done, DAG should resemble this: image

Compile and build dbt build model. A 
 build is 

image

if successfully, your dataset in bigquery would look like.


Go to deploy code on dbt cloud. Create a production environment, create a run and trigger the run manually.
image

Check here and corresponding Videos for more guidance.

Two new columns, duration and distance are created during the dbt transformation. Refer to this code for the details
### 6 Looker Studio
Create a blank report on looker
Select the bigquery connector and connect to the transformed data in the dbt production warehouse
Start building dashboard
Several calculated fields are created in order to create dashboard in next section.


## References & Resources 
---

[Back To Top](#project-us-accidents-2016---2023)

## Acknowledgements

I would like to acknowledge the contributions of the following works:

- Moosavi, Sobhan, et al. "A Countrywide Traffic Accident Dataset.", 2019.
- Moosavi, Sobhan, et al. "Accident Risk Prediction based on Heterogeneous Sparse Data: New Dataset and Insights." In proceedings of the 27th ACM SIGSPATIAL International Conference on Advances in Geographic Information Systems, ACM, 2019.


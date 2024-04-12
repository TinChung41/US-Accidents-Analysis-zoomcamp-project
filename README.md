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


        
        ***Note***: Lastest Mage image on Google Cloud Run can't upload large Local file or is able to mount a local file with it(not to my knowledge). So I host my local Mage with my file to upload it to GCS
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
**IMPORTANT**: due to the csv being a bit large, I recomended using sample file of the dataset, I also built the pipeline for the sample.csv before implement the real dataset.




## References & Resources 
---

[Back To Top](#data-engineering-zoomcamp-capstone-project)

## Acknowledgements

I would like to acknowledge the contributions of the following works:

- Moosavi, Sobhan, et al. "A Countrywide Traffic Accident Dataset.", 2019.
- Moosavi, Sobhan, et al. "Accident Risk Prediction based on Heterogeneous Sparse Data: New Dataset and Insights." In proceedings of the 27th ACM SIGSPATIAL International Conference on Advances in Geographic Information Systems, ACM, 2019.


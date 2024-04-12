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

    * ELT PIPELINE VISUALIZATION WITH MAGE
    <br>
1. Transformed Data from BigQuery is used for Reporting and Visualization using Looker Studio to produce Dashboards

## The Dashboard: 
---
The dashboard is accessible from [here](https://lookerstudio.google.com/reporting/7c6e5596-cc29-4c62-9abb-c68e8bd37982)


![image](https://github.com/TinChung41/US-Accidents-Analysis-zoomcamp-project/assets/98845918/c6b7324a-ba50-4ff4-8647-6e39e2b675f4)

## Key Findings
---
The data from BigQuery table `fact_eviction` is blended with [Supervisor Dataset](https://data.sfgov.org/Geographic-Locations-and-Boundaries/Supervisor-Districts-2022-/f2zs-jevy/data?no_mobile=true) on Looker Studio to develop Visualizations; to answer some key questions.


The questions that were aimed to answer and the corresponding findings are as below:

1. What has been the trend of overall evictions over the years in San Francisco?

    The trend has been cyclical co-relating with the economic outlook in the city but overall it has been trending downwards with a maximum of 2897 evictions in 1998 to a low of 1200 evictions in 2022. The dip in evictions in the past couple of years are primarily due to eviction restrictions in 2020 and 2021 as a result of Covid. But it will be interesting to observe how the trend changes in the coming months and years as the restrictions are now finally lifted.

1. What is the most recorded reason for eviction? 

    Looking at the heatmap, it is evident that ***Owner Movein*** has been the most recorded reason for eviction. But in recent years, this reason for eviction has become ***Nuisance***

1. Over the years, what has been the least recorded reason for eviction?

    Over the years that data has been available, the least number of recorded reason for eviction has been for ***Lead Remediation*** 


1. What are the top 3 reasons for eviction recorded over the last 10 years?
    
    The top 3 reasons are 
    - Breach of contract
    - Nuisance 
    - Owner movein

1. Which neighbourhood has seen the most evictions in 2022?

    The neighbourhood which saw most evictions is ***Financial District/South Beach***

1. Which neighbourhood has seen the lowest evictions in 2022?

    The neighbourhood which saw lowest evictions is ***Mission Bay***. 


1. Which supervisor has the most challenges w.r.t evictions in SF in 2022?
    
    Supervisor ***Matt Dorsey*** had the most number of evictions to deal with . This data could be utilized to ensure that the teams are sized right in the respective districts. 

1. Looking at the trend of data, what would be your recommendation in the way that data is recorded?
    
    Given the trend of data, that ***Nusiance*** and ***Breach*** numbers have been increasing, the recommendation would be to break down these 2 reasons to better understand the exact reasons. This will allow the city council to take targeted actions to address this concern. 


## Reproduction:
---



## References & Resources 
---
Find them references [here](docs/info_references.md) & resources [here](docs/info_resources.md)

[Back To Top](#data-engineering-zoomcamp-capstone-project)

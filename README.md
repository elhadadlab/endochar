# Endometriosis-Phenotype-Characterization
This is the repository for the OHDSI study "Endometriosis Phenotype Characterization Across Observational Health Databases". 

In this study we want to understand the prevalence of signs and symptoms, treatments, and healthcare utilization patterns among endometriosis patients before diagnosis and relate these patterns to a comparison cohort of reproductive age women.

To run this study please refer to the methods section in the study protocol. The protocol is in the documents folder in this repository. 

Running this study requires the following:

- OMOP cdm version 5 
- The use of R
- Access of the following tables: COHORT, DRUG_EXPOSURE, CONDITION_OCCURRENCE, VISIT_OCCURRENCE
- Results submission of .csv files to Mollie McKillop at mm4234@cumc.columbia.edu 
 
How to run:

1) Set your database, server, port, user & password, this example assumes you have set your environment variables to the requried values.

connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = Sys.getenv("dbms"),
																																server = Sys.getenv("server"),
																																port = as.numeric(Sys.getenv("port")),
																																user = Sys.getEnv("username"),
																																password = Sys.getEnv("password")
																																)

2) Initialize tables

EndometriosisCharacterization::init(connectionDetails = connectionDetails, "{StudySchema}", tablePrefix = "endo_")

EndometriosisCharacterization::execute(connectionDetails = connectionDetails,
																			 createCohorts = TRUE,


3) Run the package to create the cohorts

library(createCohorts)

4) Run the package to generate the prevalence counts and output to study files.  

library(main)

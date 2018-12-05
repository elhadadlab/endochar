# Copyright 2018 Observational Health Data Sciences and Informatics
#
# This file is part of EndometriosisCharacterization
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Insert cohort definitions from ATLAS into package -----------------------
OhdsiRTools::insertCohortDefinitionInPackage(
	definitionId = 1769393,
	name = "EndoCohort",
	baseUrl = Sys.getenv("ohdsiWebAPI"), # "http://18.213.176.21:80/WebAPI"
	generateStats = FALSE
)

OhdsiRTools::insertCohortDefinitionInPackage(
	definitionId = 1769528,
	name = "ComparisonCohort",
	baseUrl = Sys.getenv("ohdsiWebAPI"), # "http://18.213.176.21:80/WebAPI"
	generateStats = FALSE
)


# Generate CSV of cohort names and IDs for the package

cohortCsv <-
"cohortId,cohortName,cohortSql
1,EndoCohort,EndoCohort.sql
2,ComparisonCohort,ComparisonCohort.sql
";

writeLines(cohortCsv, "inst/settings/cohorts.csv");






----NOTE: you will also need to manually update each cohort ID in the SQL code with the corresponding ID of either the endometriosis or comparison group cohort number as assigned when the cohorts are generated on your database instance.  @CDM_schema and @results_schema will need to be replaced in the SQL code with the names of these schemas in your OHDSI instance.----    




----TOTAL COUNTS----

-- count of unique subjects in comparison group cohort 93
select count(DISTINCT SUBJECT_ID ) as person_count
from @results_schema.cohort
where COHORT_DEFINITION_ID = 93 --put cohortid here
;

-- Export to total_count_comparison.csv

-- count of unique subjects in endometriosis group cohort 58
select count(DISTINCT SUBJECT_ID ) as person_count
from @results_schema.cohort
where COHORT_DEFINITION_ID = 58 --put cohortid here
;

-- Export to total_count_endometriosis.csv

-- count of unique subjects in comparison cohort with drug exposure before cohort start date
select count(DISTINCT SUBJECT_ID ) as person_count
from @results_schema.cohort co1
inner join @CDM_schema.drug_exposure de1  --CDM table to find person-level observations
on co1.subject_id = de1.person_id
and co1.cohort_start_date >= de1.drug_exposure_start_date
and co1.COHORT_DEFINITION_ID =  93  -- put cohortid here
;

-- Export to total_count_comparison_DE_before_cohort_start.csv

-- count of unique subjects in endometriosis cohort with drug exposure before cohort start date
select count(DISTINCT SUBJECT_ID ) as person_count
from @results_schema.cohort co1
inner join @CDM_schema.drug_exposure de1  --CDM table to find person-level observations
on co1.subject_id = de1.person_id
and co1.cohort_start_date >= de1.drug_exposure_start_date
and co1.COHORT_DEFINITION_ID =  58  -- put cohortid here
;

-- Export to total_count_endo_DE_before_cohort_start.csv


-- count of unique subjects in comparison cohort with condition occurrence before cohort start date
select count(DISTINCT SUBJECT_ID ) as person_count
from @results_schema.cohort co1
inner join @CDM_schema.condition_occurrence de1  --CDM table to find person-level observations
on co1.subject_id = de1.person_id
and co1.cohort_start_date >= de1.condition_start_date
and co1.COHORT_DEFINITION_ID =  93  -- put cohortid here
;

-- Export to total_count_comparison_CO_before_cohort_start.csv

-- count of unique subjects in endometriosis cohort with condition occurrence before cohort start date
select count(DISTINCT SUBJECT_ID ) as person_count
from @results_schema.cohort co1
inner join @CDM_schema.condition_occurrence de1  --CDM table to find person-level observations
on co1.subject_id = de1.person_id
and co1.cohort_start_date >= de1.condition_start_date
and co1.COHORT_DEFINITION_ID =  58  -- put cohortid here
;

-- Export to total_count_endo_CO_before_cohort_start.csv


----PREVALENCE COUNTS----

-- drugs per subject for the comparison group before index
select c1.concept_id, c1.concept_name, count(distinct co1.subject_id) as person_count
from @results_schema.cohort co1  
inner join @CDM_schema.drug_exposure de1  
on co1.subject_id = de1.person_id
and co1.cohort_start_date >= de1.drug_exposure_start_date  --all time prior or on
inner join concept_ancestor ca1   --use vocab to roll up drugs to the classes you want
on de1.drug_concept_id = ca1.descendant_concept_id
inner join @CDM_schema.concept c1   --use vocab to restrict to only the ATC classes you are interested in
on ca1.ancestor_concept_id = c1.concept_id
and c1.vocabulary_id = 'ATC'
and c1.concept_class_id = 'ATC 3rd'
where co1.cohort_definition_id = 93 --put cohortid here
group by c1.concept_id, c1.concept_name
order BY person_count DESC
;

-- Export to drugs_comparison.csv

-- drugs per subject for the endometriosis group before index
select c1.concept_id, c1.concept_name, count(distinct co1.subject_id) as person_count
from @results_schema.cohort co1   
inner join @CDM_schema.drug_exposure de1 
on co1.subject_id = de1.person_id
and co1.cohort_start_date >= de1.drug_exposure_start_date  --all time prior or on
inner join concept_ancestor ca1   --use vocab to roll up drugs to the classes you want
on de1.drug_concept_id = ca1.descendant_concept_id
inner join @CDM_schema.concept c1   --use vocab to restrict to only the ATC classes you are interested in
on ca1.ancestor_concept_id = c1.concept_id
and c1.vocabulary_id = 'ATC'
and c1.concept_class_id = 'ATC 3rd'
where co1.cohort_definition_id = 58  --put cohortid here
group by c1.concept_id, c1.concept_name
order BY person_count DESC
;
-- Export to drugs_endometriosis.csv


-- condition per subject for the comparison group before index
select c1.concept_id, c1.concept_name, count(distinct co1.subject_id) as person_count 
from @results_schema.cohort co1  
inner join @CDM_schema.condition_occurrence de1  --CDM table to find person-level observations
on co1.subject_id = de1.person_id
and co1.cohort_start_date >= de1.condition_start_date   --all time prior or on
inner join @CDM_schema.concept c1
on de1.condition_concept_id = c1.concept_id
where co1.cohort_definition_id = 93  --put cohortid here
group by c1.concept_id, c1.concept_name
order BY person_count DESC
;

--Export to conditions_comparison.csv

-- conditions per subject for the endometriosis group before index
select c1.concept_id, c1.concept_name, count(distinct co1.subject_id) as person_count
from @results_schema.cohort co1
inner join @CDM_schema.condition_occurrence de1  --CDM table to find person-level observations
on co1.subject_id = de1.person_id
and co1.cohort_start_date >= de1.condition_start_date   --all time prior or on
inner join @CDM_schema.concept c1
on de1.condition_concept_id = c1.concept_id
where co1.cohort_definition_id = 58  --put cohortid here
group by  c1.concept_id, c1.concept_name
order BY person_count DESC
;

-- Export as conditions_endometriosis.csv

-- count of ER visits per subject for the comparison group before index
select count(DISTINCT person_id) as person_count
from @results_schema.cohort co1
inner join @CDM_schema.visit_occurrence vo1  --CDM table to find person-level observations
on co1.subject_id = vo1.person_id
and co1.cohort_start_date >= vo1.visit_start_date
where visit_concept_id = 9203
and co1.COHORT_DEFINITION_ID =  93  -- put cohortid here
;

-- Export as ER_visits_comparison.csv

-- count of ER visits per subject for the endometriosis group before index
select count(DISTINCT person_id) as person_count
from @results_schema.cohort co1
inner join @CDM_schema.visit_occurrence vo1  --CDM table to find person-level observations
on co1.subject_id = vo1.person_id
and co1.cohort_start_date >= vo1.visit_start_date
where visit_concept_id = 9203
and co1.COHORT_DEFINITION_ID =  58  -- put cohortid here

--Export as ER_visits_endometriosis.csv


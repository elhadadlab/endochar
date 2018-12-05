-- count of unique subjects in cohort with drug exposure before cohort start date
select count(DISTINCT SUBJECT_ID ) as person_count
from @target_database_schema.@target_cohort_table c
inner join @CDM_schema.drug_exposure de  --CDM table to find person-level observations
on c.subject_id = de.person_id
and c.cohort_start_date >= de.drug_exposure_start_date
and c.COHORT_DEFINITION_ID =  @cohortId

-- count of unique subjects in cohort with condition occurrence before cohort start date
select count(DISTINCT SUBJECT_ID ) as person_count
from @target_database_schema.@target_cohort_table c
inner join @CDM_schema.condition_occurrence co  --CDM table to find person-level observations
on c.subject_id = co.person_id
and c.cohort_start_date >= co.condition_start_date
and c.COHORT_DEFINITION_ID =  @cohortId

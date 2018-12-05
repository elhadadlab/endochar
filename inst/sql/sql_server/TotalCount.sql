--- Cohort Person Count
select count(DISTINCT SUBJECT_ID ) as person_count
from @target_database_schema.@target_cohort_table
where COHORT_DEFINITION_ID = @cohortId
;

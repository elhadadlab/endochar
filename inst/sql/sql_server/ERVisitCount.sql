-- Number of ER Visits prior to index
select count(DISTINCT person_id) as person_count
from @target_database_schema.@target_cohort_table c
inner join @CDM_schema.visit_occurrence vo  -- CDM table to find person-level observations
on c.subject_id = vo.person_id
and c.cohort_start_date >= vo.visit_start_date
where vo.visit_concept_id = 9203
and c.COHORT_DEFINITION_ID =  @cohortId

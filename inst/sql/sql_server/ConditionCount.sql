-- subjects per condition, before index
select concept.concept_id, concept.concept_name, count(distinct cohort.subject_id) as person_count
from @target_database_schema.@target_cohort_table cohort
inner join @CDM_schema.condition_occurrence co  --CDM table to find person-level observations
on cohort.subject_id = co.person_id
and cohort.cohort_start_date >= co.condition_start_date   --all time prior or on
inner join @CDM_schema.concept concept
on co.condition_concept_id = concept.concept_id
where cohort.cohort_definition_id =  @cohortId
group by concept.concept_id, concept.concept_name
order BY count(distinct cohort.subject_id) DESC

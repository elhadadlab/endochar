-- subjects per drug, before index
select concept.concept_id, concept.concept_name, count(distinct cohort.subject_id) as person_count
from @target_database_schema.@target_cohort_table cohort
inner join @CDM_schema.drug_exposure de
on cohort.subject_id = de.person_id
and cohort.cohort_start_date >= de.drug_exposure_start_date  --all time prior or on
inner join @CDM_schema.concept_ancestor ca   --use vocab to roll up drugs to the classes you want
on de.drug_concept_id = ca.descendant_concept_id
inner join @CDM_schema.concept concept   --use vocab to restrict to only the ATC classes you are interested in
on ca.ancestor_concept_id = concept.concept_id
and concept.vocabulary_id = 'ATC'
and concept.concept_class_id = 'ATC 3rd'
where cohort.cohort_definition_id = @cohortId
group by concept.concept_id, concept.concept_name
order BY count(distinct cohort.subject_id) DESC

select version()

-- ------
-- insert	
with task_insert as 
(
	insert
		into
		public.tasks
	(task_id,
		task_title,
		task_desc,
		task_status,
		task_planned_end_date,
		task_start_date)
	values(nextval('tasks_task_id_seq'::regclass), 
	'',
	null,
	'Not started', -- In progress / Not started
	'2023-10-29', -- task_planned_end_date
	null) returning task_id
)
insert
	into
	public.paths
	(
	task_id,
	task_path
	)
select
	task_id,
	text2ltree('1.2.85.105' || '.' || task_insert.task_id::text)
from
	task_insert; -- end insert

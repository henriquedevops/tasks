select version()

SELECT task_id, task_title, task_desc, task_status, task_planned_end_date, task_start_date FROM public.tasks;

/*
task_status_desc|
----------------+
Not started     |
In progress     |
Suspended       |
Done            |
*/

-- select roots
SELECT t.task_title
FROM paths p
	inner join tasks t
		on t.task_id = p.task_id 
WHERE nlevel(p.task_path) = 1;

-- 1.2
SELECT t.task_title, p.task_path
FROM paths p
	inner join tasks t
		on t.task_id = p.task_id 
WHERE 
	p.task_path <@ '1.2'
	and nlevel(p.task_path) <= 3

-- ------
-- insert	
with task_insert as 
(
	insert
		into
		public.tasks
	(	task_id,
		task_title,
		task_desc,
		task_status,
		task_planned_end_date,
		task_start_date)
	values(
	nextval('tasks_task_id_seq'::regclass), -- task_id
	'',						-- task_title
	null,									-- task_desc
	'Recurring', 							-- task_status: In progress / Not started / Recurring
	null, 									-- task_planned_end_date
	null									-- task_start_date
	) returning task_id
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

-- --
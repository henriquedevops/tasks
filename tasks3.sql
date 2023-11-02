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

-- --
-- leafs - start
with f1 as 
( 
select
	p.task_path,
	t2.task_id,
	t2.task_title,
	t2.task_status,
	t2.task_planned_end_date 
from
	tasks t2
inner join paths p on
	t2.task_id = p.task_id
)
, f2 as 
( 
select
	pp.task_path,
	tt2.task_id,
	tt2.task_title,
	tt2.task_status,	
	tt2.task_planned_end_date 
from
	tasks tt2
inner join paths pp on
	tt2.task_id = pp.task_id
), 
q3 as ( 
select
	f1.*
from
	f1
where
	not exists 
	(
	select
		f2.*
	from
		f2
	where
		f1.task_path @> f2.task_path
		and f1.task_path <> f2.task_path
	) order by 2 asc
) select * from q3 where task_status <> 'Done' and task_planned_end_date is not null order by task_planned_end_date asc; -- leafs - end
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

-- Children
SELECT nlevel(p.task_path) as nlevel, p.task_path, t.task_id , t.task_title, t.task_status, t.task_start_date, t.task_planned_end_date  
FROM paths p
	inner join tasks t
		on t.task_id = p.task_id 
WHERE 
	p.task_path <@ '1.2.85.105'
--	and nlevel(p.task_path) <= 2
order by task_path
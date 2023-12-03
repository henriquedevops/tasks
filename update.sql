
UPDATE public.tasks tasks 
SET task_title=replace(t.task_title, 'Buy ', '')
from
	public.tasks t
	inner join public.paths p on p.task_id  = t.task_id  
WHERE true and p.task_path <@ '1.138' and t.task_title ilike 'Buy%' and t.task_id = tasks.task_id  
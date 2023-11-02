select true union all select true

create extension ltree;

select * from pg_available_extensions;

alter table public.tasks add column path ltree;

create index tasks_tree_path_idx on tasks using gist (path);

UPDATE public.tasks SET task_path = text2ltree(task_parent::text || '.' || task_id::text) WHERE task_parent is not null;

select * from tasks where '1' @> task_path

SELECT x.* FROM public.tasks x

-- uUPDATE public.tasks SET task_status='Not started';

/*
Not started     |
In progress     |
Suspended       |
Done            |

*/

-- insert into tasks
INSERT INTO public.tasks
(task_title, task_desc, task_status, task_planned_end_date, task_start_date, task_parent)
VALUES('', -- task_title
null, -- task_desc
'Not started', -- task_status
null, -- task_planned_end_date
null, -- task_start_date
48 -- task_parent
);

INSERT INTO public.tasks_x_hows
(how_id, task_id)
VALUES(6, 60);



select 
	gg.goal_title as main_goal,
	g.goal_title as goal,
	h.how_title,
	t.task_title 
from
	public.hows h
	inner join public.hows_x_goals hg
		on hg.how_id = h.how_id 
	inner join public.goals g
		on g.goal_id = hg.goal_id 
	inner join public.goals gg
		on gg.goal_id = g.goal_parent and gg.goal_parent is null 
	left join public.tasks_x_hows txh  
		on txh.how_id = h.how_id 
	left join public.tasks t 
		on t.task_id = txh.task_id 
order by 1,3,2
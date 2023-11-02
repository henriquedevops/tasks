SELECT x.* FROM public.tasks x

create table public.tasks_x_goals (goal_id int references public.goals (goal_id), task_id int references public.tasks (task_id) ); 

create table public.tasks_x_hows (how_id int references public.hows (how_id), task_id int references public.tasks (task_id) ); 

-- insert into tasks
INSERT INTO public.tasks
(task_title, task_desc, task_status, task_planned_end_date, task_start_date)
VALUES(
'', -- task_title
null, -- task_desc
null, -- task_status
null, -- task_planned_end_date
null -- task_start_date
);


-- insert tasks_x_goals
INSERT INTO public.tasks_x_goals
(goal_id, task_id)
VALUES(6, 4);

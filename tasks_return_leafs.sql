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
) select * from q3 where task_status <> 'Done' and task_planned_end_date is not null order by task_planned_end_date, task_id asc; -- leafs - end
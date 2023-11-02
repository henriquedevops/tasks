select true

select * from public.hows

INSERT INTO public.hows
(how_title, how_desc)
VALUES(
'Try to renegotiate or change high interest loans', -- how_title
null	-- how_desc
);

INSERT INTO public.hows_x_goals
(goal_id, how_id)
VALUES(2, 6);

select 
	gg.goal_title as main_goal,
	g.goal_title as goal,
	h.how_title
from
	public.hows h
	inner join public.hows_x_goals hg
		on hg.how_id = h.how_id 
	inner join public.goals g
		on g.goal_id = hg.goal_id 
	inner join public.goals gg
		on gg.goal_id = g.goal_parent and gg.goal_parent is null 
order by 1,3,2
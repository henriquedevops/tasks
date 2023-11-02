select true

select * from public.reasons 

CREATE TABLE public.reasons (
	reason_id serial4 NOT NULL,
	reason_title text NULL,
	reason_desc text NULL,
	goal_id int REFERENCES public.goals(goal_id),
	CONSTRAINT reason_pkey PRIMARY KEY (reason_id)
);

INSERT INTO public.reasons
(reason_title, reason_desc, goal_id)
VALUES(
'', -- reason_title, 
'', -- reason_desc, 
1	-- goal_id	
);

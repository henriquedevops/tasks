select version();

-- 

SELECT 
	p.task_path, nlevel(p.task_path), subpath(p.task_path, 1), '1.2.85.105.184' || subpath(p.task_path, 4) as new_path, t.task_title
FROM 
	paths p
	inner join tasks t
		on t.task_id = p.task_id 
WHERE 
	true
	and nlevel(p.task_path) > 1
	and p.task_path <@ '1.2.85.105.129'
order by
	task_path, nlevel
	
-- ------	

with q0 as 
(

	SELECT 
		p.path_id, p.task_path, nlevel(p.task_path), subpath(p.task_path, 1), '1.2.85.105.184' || subpath(p.task_path, 4) as new_path, t.task_title
	FROM 
		paths p
		inner join tasks t
			on t.task_id = p.task_id 
	WHERE 
		true
		and nlevel(p.task_path) > 1
		and p.task_path <@ '1.2.85.105.129'
		
)	
UPDATE public.paths
SET task_path = q0.new_path
	from q0
WHERE 	true
	and paths.path_id = q0.path_id;
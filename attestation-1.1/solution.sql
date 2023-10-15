WITH
start_stations AS 
(
	SELECT
		t.year_num,
		t.start_station_id,
		COUNT(t.start_station_id) AS start_cnt,
		ROUND(AVG(t.duration_minutes), 2) AS start_avg_dur
	FROM public.trips AS t
	WHERE t.year_num IS NOT NULL
	GROUP BY t.year_num, start_station_id
	ORDER BY t.year_num
),
end_stations AS
(
	SELECT
		t.year_num,
		t.end_station_id,
		COUNT(t.end_station_id) AS end_cnt,
		ROUND(AVG(t.duration_minutes), 2) AS end_avg_dur
	FROM public.trips AS t
	WHERE t.year_num IS NOT NULL
	GROUP BY t.year_num, end_station_id
	ORDER BY t.year_num
)
SELECT
	s.station_id,
	ss.year_num,
	s.name,
	s.status,
	ss.start_cnt,
	es.end_cnt,
	ss.start_cnt + es.end_cnt AS gnrl_cnt,
	ss.start_avg_dur,
	es.end_avg_dur
FROM public.station AS s
INNER JOIN start_stations AS ss
	ON ss.start_station_id = s.station_id
INNER JOIN end_stations AS es
	ON es.end_station_id = s.station_id
	AND es.year_num = ss.year_num
WHERE status = 'active'
ORDER BY ss.start_avg_dur
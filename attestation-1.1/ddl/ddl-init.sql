CREATE TABLE IF NOT EXISTS public.trips
(
	trip_id 			BIGSERIAL PRIMARY KEY,
    checkout_time		TIME,
    duration_minutes	INT,
    end_station_id		BIGINT,
    end_station_name	VARCHAR(100),
	month_num			SMALLINT,
	start_station_id	BIGINT,
	start_station_name	VARCHAR(100),
	start_time			TIMESTAMP,
	subscriber_type		VARCHAR(50),
	bike_id				BIGINT,
	year_num			INT
);

CREATE TABLE IF NOT EXISTS public.station
(
    station_id		BIGSERIAL PRIMARY KEY,
	latitude		VARCHAR(10),
	location		VARCHAR(25),
	longitude		VARCHAR(10),
	name			VARCHAR(100),
	status			VARCHAR(10)
);

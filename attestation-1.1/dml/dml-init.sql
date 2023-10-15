-- station
COPY station(latitude, location, longitude, name, station_id, status)
FROM '/usr/stations.csv'
DELIMITER ','
CSV HEADER;

-- trips
COPY trips(bike_id, checkout_time, duration_minutes, end_station_id, end_station_name, month_num, start_station_id, start_station_name, start_time, subscriber_type, trip_id, year_num)
FROM '/usr/trips.csv'
DELIMITER ','
CSV HEADER;
CREATE EXTENSION postgis;

CREATE TABLE earthquake (
	"Date" VARCHAR,
	"Time" VARCHAR,
	"Latitude" FLOAT,
	"Longitude" FLOAT,
	"Type" VARCHAR,
	"Depth" FLOAT,
	"Depth Error" FLOAT,
	"Depth Seismic Stations" INT,
	"Magnitude" FLOAT,
	"Magnitude Type" VARCHAR,
	"Magnitude Error" FLOAT,
	"Magnitude Seismic Stations" INT,
	"Azimuthal Gap" FLOAT,
	"Horizontal Distance" FLOAT,
	"Horizontal Error" FLOAT,
	"Root Mean Square" FLOAT,
	"id" VARCHAR PRIMARY KEY,
	"Source" VARCHAR,
	"Location Source" VARCHAR,
	"Magnitude Source" VARCHAR,
	"Status" VARCHAR
);

CREATE TABLE tectonic_plates (
    id SERIAL PRIMARY KEY,
    layer TEXT,
    code CHAR(2),
    platename VARCHAR,
    geometry GEOMETRY(Polygon, 4326)
);

COPY earthquake (
	"Date",
	"Time",
	"Latitude",
	"Longitude",
	"Type",
	"Depth",
	"Depth Error",
	"Depth Seismic Stations",
	"Magnitude",
	"Magnitude Type",
	"Magnitude Error",
	"Magnitude Seismic Stations",
	"Azimuthal Gap",
	"Horizontal Distance",
	"Horizontal Error",
	"Root Mean Square",
	"id",
	"Source",
	"Location Source",
	"Magnitude Source",
	"Status"
) FROM '/var/csv/earthquake.csv'
DELIMITER ','
CSV HEADER;

COPY tectonic_plates (
	layer,
	code,
	platename,
	geometry
) FROM '/var/csv/transformed_tectonic_plate.csv'
DELIMITER ','
CSV HEADER;
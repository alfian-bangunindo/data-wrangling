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
	id VARCHAR PRIMARY KEY,
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
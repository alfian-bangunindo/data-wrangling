-- Select only relevant columns on temp table
DROP TABLE IF EXISTS temp_earthquake;
CREATE TEMP TABLE temp_earthquake AS
SELECT
	"id",
	"Date" AS "date",
	"Time" AS "time",
	"Latitude" AS "latitude",
	"Longitude" AS "longitude",
	"Type" AS "type",
	"Magnitude" AS "magnitude",
	"Magnitude Error" AS "magnitude_error",
	"Depth" AS "depth",
	"Depth Error" AS "depth_error"
FROM earthquake;

-- CLEANING
-- Check duplicated values
SELECT *, COUNT(*)
FROM temp_earthquake
GROUP BY id, "date", "time", "latitude", "longitude", "type", "magnitude", "magnitude_error", "depth", "depth_error"
HAVING COUNT(*) > 1; -- NONE

-- Replace Null value with median value
-- magnitude_error column
UPDATE temp_earthquake
SET "magnitude_error" = (
	SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY "magnitude_error")
	FROM temp_earthquake
)
WHERE "magnitude_error" IS NULL;

-- depth_error column
UPDATE temp_earthquake
SET "depth_error" = (
	SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY "depth_error")
	FROM temp_earthquake
)
WHERE "depth_error" IS NULL;

-- Structuring
-- Combine date and time column into datetime column
ALTER TABLE temp_earthquake
ADD COLUMN datetime timestamp;

UPDATE temp_earthquake
SET datetime = CASE
	WHEN "date" LIKE '%T%' THEN
  		LEFT(REPLACE("date", 'T', ' '), 19)::timestamp
	ELSE
  		("date" || ' ' || "time")::timestamp
	END;

-- ENRICHING
SELECT
	te."id",
	"datetime",
	"latitude",
	"longitude",
	"type",
	"magnitude",
	"magnitude_error",
	"depth",
	"depth_error",
	POWER(10, 5.24 + 1.44*"magnitude") AS "energy_released", -- Add energy_released column
	CASE 
		WHEN "type" = 'Earthquake' THEN 
			tp.code
		ELSE
			NULL
	END AS "plate_code", -- Add plate_code column
	CASE 
		WHEN "type" = 'Earthquake' THEN 
			tp.platename 
		ELSE
			NULL
	END AS "plate_name" -- ADD plate_name column
FROM temp_earthquake te
JOIN tectonic_plates tp
ON ST_Contains(tp.geometry, ST_SetSRID(ST_MakePoint(te.longitude, te.latitude), 4326));
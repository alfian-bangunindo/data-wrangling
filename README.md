# Data Wrangling: Earthquake Dataset

## Resource
1. Earthquake dataset: https://www.kaggle.com/datasets/usgs/earthquake-database
2. Tectonic plates dataset: https://github.com/fraxen/tectonicplates

## How to Run Data Wrangling with Python Notebook
1. Install dependencies
    ```bash
    pip install -r requirements.txt
    ```
2. Run each cell inside `notebook.ipynb`

## How to Run Data Wrangling with SQL
1. Start PostgreSQL database using docker compose
    ```bash
    docker comopse up -d
    ```
    This will create a PostgreSQL database instance with PostGIS extension, initialize the tables, and insert the data using the SQL files inside the `sql` folder.

2. Connect to the database in DBeaver and run the data wrangling query from `sql/2-wrangling.sql`
# IPL Data Project (MySQL)

SQL solutions for the IPL dataset (`matches.csv` and `deliveries.csv`).

## Prerequisites
- MySQL 8 with the `mysql` client
- The IPL CSV files placed in `data/`:
  - `data/matches.csv`
  - `data/deliveries.csv`
- `local_infile` enabled on the server (needed once, as root):
  `mysql -u root -p -e "SET GLOBAL local_infile = 1;"`

## Run the scripts
Run all commands from the repository root.

1. Create the user and database (as root):
   `mysql -u root -p < sql/01_create_db.sql`
2. Create the tables and load the CSVs (as the new user, password `ipl_password`):
   `mysql --local-infile=1 -u ipl_user -p ipl_db < sql/03_load_csv.sql`
3. Run the IPL queries:
   `mysql -u ipl_user -p ipl_db < sql/04_queries.sql`
4. Clean up the user and database when done (as root):
   `mysql -u root -p < sql/02_cleanup.sql`

## Queries in `sql/04_queries.sql`
1. Matches played per year
2. Matches won per team per year
3. Extra runs conceded per team in 2016
4. Top economical bowlers in 2015
5. Most sixes hit by a batsman in 2015

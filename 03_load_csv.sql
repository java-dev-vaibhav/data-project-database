-- Run from the repo root so the relative CSV paths resolve:
--   mysql --local-infile=1 -u ipl_user -p ipl_db < sql/03_load_csv.sql
-- LOAD DATA LOCAL needs local_infile enabled on the server too. If you get
-- "Loading local data is disabled", run once as root:  SET GLOBAL local_infile = 1;

DROP TABLE IF EXISTS deliveries;
DROP TABLE IF EXISTS matches;

CREATE TABLE matches (
    id               INT PRIMARY KEY,
    season           INT,
    city             VARCHAR(100),
    date             DATE,
    team1            VARCHAR(100),
    team2            VARCHAR(100),
    toss_winner      VARCHAR(100),
    toss_decision    VARCHAR(20),
    result           VARCHAR(20),
    dl_applied       INT,
    winner           VARCHAR(100),
    win_by_runs      INT,
    win_by_wickets   INT,
    player_of_match  VARCHAR(100),
    venue            VARCHAR(200),
    umpire1          VARCHAR(100),
    umpire2          VARCHAR(100),
    umpire3          VARCHAR(100)
);

-- `over` is a reserved word in MySQL 8, so it must be quoted with backticks.
CREATE TABLE deliveries (
    match_id          INT,
    inning            INT,
    batting_team      VARCHAR(100),
    bowling_team      VARCHAR(100),
    `over`            INT,
    ball              INT,
    batsman           VARCHAR(100),
    non_striker       VARCHAR(100),
    bowler            VARCHAR(100),
    is_super_over     INT,
    wide_runs         INT,
    bye_runs          INT,
    legbye_runs       INT,
    noball_runs       INT,
    penalty_runs      INT,
    batsman_runs      INT,
    extra_runs        INT,
    total_runs        INT,
    player_dismissed  VARCHAR(100),
    dismissal_kind    VARCHAR(50),
    fielder           VARCHAR(100),
    FOREIGN KEY (match_id) REFERENCES matches(id)
);

LOAD DATA LOCAL INFILE 'data/matches.csv'
INTO TABLE matches
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'data/deliveries.csv'
INTO TABLE deliveries
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

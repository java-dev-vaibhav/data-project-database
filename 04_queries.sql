-- Run after loading the data:
--   mysql -u ipl_user -p ipl_db < sql/04_queries.sql

-- 1. Number of matches played per year
SELECT season, COUNT(*) AS matches_played
FROM matches
GROUP BY season
ORDER BY season;

-- 2. Number of matches won per team over all years
--    (no-result matches have an empty winner, so they are excluded)
SELECT season, winner AS team, COUNT(*) AS matches_won
FROM matches
WHERE winner IS NOT NULL AND winner <> ''
GROUP BY season, winner
ORDER BY season, matches_won DESC;

-- 3. Extra runs conceded per team in 2016
SELECT d.bowling_team, SUM(d.extra_runs) AS extra_runs_conceded
FROM deliveries d
JOIN matches m ON m.id = d.match_id
WHERE m.season = 2016
GROUP BY d.bowling_team
ORDER BY extra_runs_conceded DESC;

-- 4. Top economical bowlers in 2015
--    Runs conceded exclude byes and leg byes; balls exclude wides and no balls.
SELECT d.bowler,
       ROUND(
         SUM(d.total_runs - d.bye_runs - d.legbye_runs) * 6.0
         / NULLIF(SUM(CASE WHEN d.wide_runs = 0 AND d.noball_runs = 0 THEN 1 ELSE 0 END), 0),
         2
       ) AS economy
FROM deliveries d
JOIN matches m ON m.id = d.match_id
WHERE m.season = 2015 AND d.is_super_over = 0
GROUP BY d.bowler
ORDER BY economy ASC
LIMIT 10;

-- 5. Most number of sixes hit by a batsman in 2015
select d.batsman, 
count(d.batsman_runs) as sixes 
from deliveries d 
inner join matches m on m.id=d.match_id 
where m.season=2015
and d.batsman_runs=6 
group by d.batsman 
order by sixes desc 
limit 1;
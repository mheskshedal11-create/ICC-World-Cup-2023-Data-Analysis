

select * from cricket;
-- Which bowler should be selected as the death-over specialist — based on economy rate and wickets taken in overs 41-50? 
SELECT 
    bowler,
    economy_rate,
    wickets_taken,
    matches_played

FROM (
    SELECT 
        bowler,
        ROUND(SUM(runs_off_bat + extras) / (COUNT(*) / 6.0), 2) AS economy_rate,
        COUNT(CASE WHEN wicket_type IS NOT NULL THEN 1 END) AS wickets_taken,
        COUNT(DISTINCT match_id) AS matches_played
    FROM cricket
    WHERE FLOOR(ball) BETWEEN 41 AND 50
    GROUP BY bowler

) AS death_over_stats

ORDER BY economy_rate ASC, wickets_taken DESC

LIMIT 1
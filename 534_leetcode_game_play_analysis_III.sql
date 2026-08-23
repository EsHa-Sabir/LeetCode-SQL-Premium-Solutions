select player_id,event_date,sum(games_played)(partition by player_id order by event_date)as game_played_so_far from Activity 

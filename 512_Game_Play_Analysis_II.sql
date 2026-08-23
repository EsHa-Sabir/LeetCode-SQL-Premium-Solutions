with GetDeviceId AS (
  Select player_id,device_id,Row_Number()over(Partition by player_id order by event_date)as rnk from Activity 
)
select player_id,device_id from GetDeviceId where rnk=1

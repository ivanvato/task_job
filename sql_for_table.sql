select id, 
	value, 
	date 
	from (select id, 
			value, 
			date, 
			max(value) over (partition by id) as max_value, 
			max(date) over (partition by id, value) as max_date from t) as calculated_table 
	where max_date=date and max_value=value;
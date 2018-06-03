select id, value, date 
	from (select 
			id, 
			value, 
			date, 
			max(date) over (partition by id) as max_date, 
			max(value) over (partition by id, date) as max_value 
	from t) as calculated_table 
	where max_date=date and max_value=value;

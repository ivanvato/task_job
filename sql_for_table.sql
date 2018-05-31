select id, 
	   value, 
	   Date 
  from (select id, 
               value, 
               date,
               max(value) over (partition by id) as max_value
          from table_t) as t1
 where value=num
;
 
 select id,
        value,
        Date 
   from (select id, 
                value, 
                Date,
                row_number() over (partition by id order by value desc) as num
           from table_t) as t1
  where num=1
;
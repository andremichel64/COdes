select year,chart_code,department_code,db_value_1, department_name from dbo.v_year_balance

where dbo.v_year_balance.[year] > 2018 AND
dbo.v_year_balance.chart_code = '2317001' AND 
dbo.v_year_balance.department_code = '396116' or
dbo.v_year_balance.[year] > 2018 AND
dbo.v_year_balance.chart_code = '2317001' AND 
dbo.v_year_balance.department_code = '3961404' or 
dbo.v_year_balance.[year] > 2018 AND
dbo.v_year_balance.chart_code = '2317001' AND 
dbo.v_year_balance.department_code = '3961406'


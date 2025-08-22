--example sql to use function
SELECT f_to_clob_agg(your_column) FROM your_table;

--If you need only unique data 
SELECT f_to_clob_agg(distinct your_column) FROM your_table;
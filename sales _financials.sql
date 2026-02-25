-- duplicte the table before cleaning incase of mistake , so as not to loose the whole data---------------------------
create table financials as 
select * from financials_backup;

SET SQL_SAFE_UPDATES = 0;

----------------------------------------------------------------------------------------------------------------------------------------------------------
-- remove the dollar signs , commas as it would hinder the changing of the data types -------------------------------------------------------------------------------

update financials 
	set unit_sold = trim(replace(replace(unit_sold , "$" ,"") , "," , "")),
	gross_sales = trim(replace(replace(gross_sales , "$" ,"") , "," , "")),
	manufacturing_price = trim(replace(manufacturing_price , "$" , "")) ,
	sales = trim(replace(replace(sales , "$" ,"") , "," , "")),
    cogs= trim(replace(replace(cogs , "$" ,"") , "," , "")),
	profit = trim(replace(replace(profit , "$" ,"") , "," , "")),
	discounts  = trim(replace(replace(discounts  , "$" ,"") , "," , ""));
           
update financials 
	set discounts = 0
	where discounts = "-";

update financials 
		set sales_price = trim(replace(sales_price , "$" , ""));
		SELECT trim(STR_TO_DATE(date, "%d/%m/%Y"))as date
		FROM financials;
		UPDATE financials
		SET date = STR_TO_DATE(TRIM(date), "%d/%m/%Y");
         
select 
	substring(profit , 2, length(profit)-2) AS New_profit
	from financials 
	where profit like "(%" 
	and profit like "%)";

update financials 
	set profit = substring(profit , 2, length(profit)-2)
	where profit like "(%" 
	and profit like "%)";

alter table financials 
  add column new_profit text;
  
  update financials
  set new_profit = case 
					when profit like "(%" and profit like "%)" 
					then substring(profit , 2, length(profit)-2)
                    else profit 
                    end;
                    )
                    
                    
  update financials
	set new_profit = 0
	where new_profit = "-";

 alter  table financials 
  rename column new_profit to profit ;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- i can now change the data type to match the info in each column for easy calclation------------------------------------------------------------------------
alter table financials 
modify column unit_sold int ,
modify column sales_price int,
modify column gross_sales int, 
modify column cogs int ,
modify column manufacturing_price int, 
modify column discounts int,
modify column profit int ;
alter table financials 
modify column date date ;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- now i check for duplicates and remove them ----------------------------------------------------------
with financialss as (
select 
segment ,
country,
product,
discount_band,
unit_sold,
manufacturing_price,
sales_price,
gross_sales,
discounts,
sales,
cogs,
profit,
date ,
count(*) as duplicates 
from financials 
group by 1,2,3,4,5,6,7,8,9,10,11,12,13
)
select * from financialss
where duplicates =1;
------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
 select * from financials

 
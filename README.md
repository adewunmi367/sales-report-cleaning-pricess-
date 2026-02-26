# Sales & Profitability Dataset – Data Cleaning and Preparation Process

## OVERVIEW 

This dataset represents a comprehensive sales and profitability analysis report across various markets, products, and customer segments. It captures the full financial lifecycle — from manufacturing costs to final profit — enabling accurate performance evaluation and strategic decision-making.

### Data Cleaning & Preparation Process

#### To ensure data integrity, accuracy, and reliability, the following structured process was implemented:

1. Data Backup
To prevent accidental data loss during the cleaning process, I first created a duplicate of the original table using the CTAS (Create Table As Select) approach:``` CREATE TABLE financials AS  SELECT * FROM financials_backup ```
This ensured that the original dataset remained intact in case of any irreversible errors.

2. Column Review and Optimization

After reviewing the dataset structure:

I removed the Month Name, Year, and Day columns because a complete Date column already existed, making the additional date-related columns redundant, This step improved normalization and reduced unnecessary data duplication.

3. Data Quality Assessment

Upon examining the columns, I identified inconsistencies that prevented proper data type conversion. The following issues were discovered:

- Presence of currency symbols (₦, $, etc.)
- Commas used as thousand separators
- Brackets indicating negative values
- Blank or empty cells
- Leading and trailing spaces
- Date values stored as text

4. Data Cleaning Actions

- To resolve these issues and prepare the dataset for accurate analysis:
- Removed all currency symbols, commas, and brackets.
- Replaced blank cells with appropriate values (either NULL or 0, based on contextual relevance).
- Trimmed leading and trailing spaces.
- Standardized and converted the Date column into proper date format.
- Conducted controlled testing before executing permanent updates to prevent irreversible changes.

5. Data Type Standardization

After cleaning inconsistencies:

- Updated each column’s data type to match its actual data representation (e.g., numeric fields converted to appropriate numeric types).

- Performed validation tests before applying final updates to ensure accuracy and prevent data corruption.

6. Duplicate Removal

To eliminate duplicate records that could inflate financial figures and distort business insights:

I used a Common Table Expression (CTE) ``` with financialss as (
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
where duplicates =1;```  to identify and remove duplicate rows systematically.
This ensured that all revenue, cost, and profit calculations remained accurate and reliable for decision-making.

7. Outcome
The dataset is now:
- Clean
- Standardized
- Free of duplicates
- Properly formatted
- Ready for advanced financial analysis and reporting

#### This structured cleaning approach ensures data integrity and supports accurate business intelligence and strategic decision-making.

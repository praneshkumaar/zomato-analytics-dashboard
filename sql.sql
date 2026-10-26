use zomato;

# 1. TOTAL NUMBER OF RESTAURANT
select count(*) as total_number_of_Restaurant from restaurantdata;

# 2. NUMBER OF RESTAURANT BY CITY
select city, count(restaurantID) as number_of_Restaurant from restaurantdata 
group by city order by number_of_Restaurant desc;


# 3. NUMBER OF RESTAURANT BY COUNTRY
select Country_Name, count(restaurantID) as number_of_Restaurant from restaurantdata 
group by Country_Name order by number_of_Restaurant desc;

# 4. NUMBER OF RESTAURANT BY YEAR OPENING
select year_opening, count(restaurantID) as number_of_Restaurant from restaurantdata 
group by year_opening order by number_of_Restaurant desc;


# 5.   AVERAGE USD COST FOR TWO PERSON
select  concat(round(avg(usd_avg_cost_two),0), " $") as Avg_Cost_for_Two from restaurantdata;


# 6. NUMBER OF RESTAURANT BY MONTH OPENING
select MONTHNAME(Datekey_Opening_1) as Month_Opening, count(restaurantID) as number_of_Restaurant from restaurantdata 
group by Month_Opening order by number_of_Restaurant desc;

# 7. NUMBER OF RESTAURANT BY QUARTER OPENING
select quarter(Datekey_Opening_1) as Quarter_Opening, count(restaurantID) as number_of_Restaurant from restaurantdata 
group by Quarter_Opening order by number_of_Restaurant desc;


# 8. AVERAGE RATING OF ALL RESTAURANT
select round(avg(rating),1) from restaurantdata; 

# 9. PERCENTAGE OF RESTAURANT ON HAS TABLE BOOKING  (Using sub-query, concat, group by)
SELECT Has_Table_booking,  COUNT(*) AS total_restaurants,
CONCAT(ROUND( (COUNT(*) / (SELECT COUNT(*) FROM restaurantdata)) * 100 , 0 ), " %") AS percentage_restaurants
FROM restaurantdata
GROUP BY Has_Table_booking;


# 10.   PERCENTAGE OF RESTAURANT ON HAS ONLINE DELIVERY  (Using sub-query, concat, group by)
SELECT Has_Online_delivery, count(*) as total_restaurants,
concat(round((count(*) / (Select count(*) from restaurantdata)) * 100, 0 ), "%")  as Percentage_restaurant
from restaurantdata
group by Has_Online_delivery;


# 11. RESTAURANT BASED ON CUISINES. 
select cuisines, count(RestaurantID) as total_restaurant,
round(avg(rating), 1) as avg_rating
from restaurantdata 
group by cuisines order by total_restaurant desc;


# 12. NUMBER OF RESTAURANT BASED ON AVERAGE RATING BY COUNTRY.
SELECT
    Country_Name AS country,
    ROUND(AVG(Rating), 1) AS avg_rating,
    COUNT(RestaurantID) AS total_restaurants
FROM restaurantdata
WHERE Rating IS NOT NULL
GROUP BY Country_Name
ORDER BY avg_rating DESC;


# 13.  AVERAGE RATING AS PER PRICE BUCKET WITH RESTAURANT COUNT.
SELECT
    CASE
        WHEN USD_Avg_cost_two <= 100 THEN '0-100'
        WHEN USD_Avg_cost_two <= 200 THEN '101-200'
        WHEN USD_Avg_cost_two <= 300 THEN '201-300'
        WHEN USD_Avg_cost_two <= 400 THEN '301-400'
        WHEN USD_Avg_cost_two <= 500 THEN '401-500'
        ELSE '500+'
    END AS price_bucket,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(Rating), 1) AS avg_rating
FROM restaurantdata
WHERE USD_Avg_cost_two > 0
  AND Rating IS NOT NULL
GROUP BY price_bucket
order by price_bucket;


# 14. VOTES AND RATINGS OF RESTAURANT NAME WITH CITY.
SELECT
    RestaurantName,
    City,
    Votes,
    Rating
FROM restaurantdata
WHERE Votes IS NOT NULL
  AND Rating IS NOT NULL
  order by votes desc;
  

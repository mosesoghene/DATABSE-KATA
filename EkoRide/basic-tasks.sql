-- 1. Top 5 highest-rated drivers in Lagos
CREATE TABLE IF NOT EXISTS Top_Highest_Rated_Drivers AS
SELECT DriverID, Name, Rating, TotalRides
FROM Drivers
ORDER BY Rating DESC
LIMIT 5;

-- 2. Riders with more than 5 rides in the last 30 days in Lagos
CREATE TABLE IF NOT EXISTS Frequent_Riders AS
SELECT R.RiderID, R.Name, COUNT(Ri.RideID) AS RideCount
FROM Riders R
JOIN Rides Ri ON r.RiderID = ri.RiderID
WHERE Ri.RideDate >= NOW() - INTERVAL 30 DAY
GROUP BY R.RiderID, R.Name
HAVING RideCount > 5;

-- 3. Total revenue for the past month for Lagos rides
CREATE TABLE IF NOT EXISTS Total_Revenue_Last_Month AS
SELECT SUM(p.Amount) AS TotalRevenue
FROM Payments p
JOIN Rides Ri ON p.RideID = ri.RideID
WHERE ri.RideDate >= NOW() - INTERVAL 1 MONTH;

-- 4. Area in Lagos with the most rides
CREATE TABLE IF NOT EXISTS Area_With_Most_Rides AS
SELECT R.City, COUNT(ri.RideID) AS RideCount
FROM Riders R
JOIN Rides Ri ON R.RiderID = Ri.RiderID
GROUP BY R.City
ORDER BY RideCount DESC
LIMIT 1;


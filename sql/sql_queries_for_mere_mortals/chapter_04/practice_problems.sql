-- SALES ORDER DATABASE
-- 1. Show me all the information about our employees
SELECT *
FROM Employees;
DESC Vendors;

-- 2. Show me a list of cities, in alphabetical order,
--    where our vendors are located, and include the names
--    of the vendors we work with in each city
SELECT VendCity, VendName
FROM Vendors
ORDER BY VendCity ASC;

-- ENTERTAINMENT AGENCY DATABASE
-- 1. Gives me the names and phone numbers of all our agents
--    and list them in last name/first name order
SELECT AgtLastName, AgtFirstName, AgtPhoneNumber
FROM Agents
ORDER BY AgtLastName ASC;

-- 2. Give me the information on all our engagements
SELECT *
FROM Engagements;

-- 3. List all engagements and their associated start dates
--    Sort the records by date in descending order
--    and by engagement in ascending order
SELECT StartDate, EngagementNumber
FROM Engagements
ORDER BY StartDate DESC, EngagementNumber ASC;

-- SCHOOL SCHEDULING DATABASE
-- 1. Show me a complete list of all the subjects we offer
SELECT SubjectName
FROM Subjects;

-- 2. What kinds of titles are associated with our faculty
SELECT DISTINCT Title
FROM Faculty;

-- 3. List the names and phone numbers of all our staff,
--    and sort them by last name and first name
SELECT StfLastName, StfFirstName, StfPhoneNumber
FROM Staff
ORDER BY StfLastName, StfFirstName;

-- BOWLING LEAGUE DATABASE
-- 1. List all of the teams in alphabetical order
SELECT TeamName
FROM Teams
ORDER BY TeamName;

-- 2. Show me all of the bowling score information for each of our members
SELECT *
FROM Bowler_Scores;

-- 3. Show me a list of bowlers and their addresses, sort in alpha
SELECT BowlerLastName, BowlerFirstName, BowlerAddress, BowlerCity, BowlerState, BowlerZip
FROM Bowlers
ORDER BY BowlerLastName;

-- RECIPES DATABASE
-- 1. Show me a list of ingredients we currently keep track of
SELECT IngredientName
FROM Ingredients;

-- 2. Show me all the main recipe information, and sort it
--    by the name of the recipe in alpha order
SELECT *
FROM Recipes
ORDER BY RecipeTitle;

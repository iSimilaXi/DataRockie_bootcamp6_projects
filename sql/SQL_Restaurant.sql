-- I'm a restaurant owner
-- create 5 Tables
-- 1x Fact, 4x Dimensions
-- search google -> how to add a foreign key
-- write SQL 3-5 queries to analyze data
-- 1x subquery/ with


-- table 1: PizzaMenu

CREATE TABLE PizzaMenu (
  pizza_id INT PRIMARY KEY,
  pizza_menu TEXT,
  price REAL);
  
INSERT INTO PizzaMenu VALUES 
  (1, 'Margarita Pizza', 299),
  (2, 'Pepperoni Pizza', 349),
  (3, 'Meat Lover Pizza', 419),
  (4, 'Hawaiian Pizza', 369),
  (5, 'Vegetarian Cheese Pizza', 329);
  
 -- table 2: ingredients
CREATE TABLE pizza_ing (
  ing_id INT PRIMARY KEY,
  ing_name TEXT);
  
INSERT INTO pizza_ing VALUES 
	(1, 'Pizza Dough'),
    (2, 'Mozzarella Cheese'),
    (3, 'Basil Leaves'),
    (4, 'Pepperoni Sausage'),
    (5, 'Italian Sausage'),
    (6, 'Ham'),
    (7, 'Green Vegetables'),
    (8, 'Pineapple'),
    (9, 'Tomato Sauce'),
    (10, 'Thousand Islands Sauce'),
    (11, 'Vegetarian Cheese'),
    (12, 'Onion');
    
  -- table 3: pizza_menu_ingredient_list
  CREATE TABLE  pizza_menu_ingredient_list (
    pizza_id INT,
    ing_id INT
    );
    
  INSERT INTO  pizza_menu_ingredient_list VALUES
    (1, 1), (1, 2), (1, 3), (1, 9),
    (2, 1), (2, 2), (2, 3), (2, 4), (2, 9),
    (3, 1), (3, 2), (3, 4), (3, 5), (3, 6), (3, 9), (3, 12),
    (4, 1), (4, 2), (4, 6), (4, 8), (4, 10), (4, 12),
    (5, 1), (5, 3), (5, 7), (5, 9), (5, 11), (5, 12);
    
  -- table 4: Customers
  Create TABLE Customer (
    customer_id INT PRIMARY KEY,
    name TEXT,
    phone TEXT
    );
    
  INSERT INTO Customer VALUES 
    (1, 'K Pearson', '01-111-1111'),
    (2, 'D Brosman', '02-222-2222'),
    (3, 'G Bowser', '03-333-3333'),
    (4, 'D Holdsworth', '04-444-4444'),
    (5, 'A Peterson', '05-555-5555'),
    (6, 'C Champs', '06-666-6666'),
    (7, 'B Dragunov', '07-777-7777'),
    (8, 'K Schenk', '08-888-8888'),
    (9, 'N Pyro', '09-999-9999'),
    (10, 'Q Assurance', '00-000-0000');
   
  -- table 5: Locations 
  Create TABLE Location (
    location_id INT PRIMARY KEY,
    location TEXT);
    
  INSERT INTO Location Values 
    (1, 'Silom'),
    (2, 'Asoke'),
    (3, 'Bang Kae'),
    (4, 'Lad Prao'),
    (5, 'Din Daeng');
    
  --table 6: Delivery
  CREATE TABLE Delivery (
    delivery_id INT PRIMARY KEY,
    delivery_type TEXT);
    
  INSERT INTO Delivery VALUES
  	(1, 'Grab Food'),
    (2, 'Shopee Food'),
    (3, 'Line Man'),
    (4, 'Self Pick-up');
    
  --table 7: Orders [FACT TABLE]
  CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    pizza_id INT,
    customer_id INT,
    location_id INT,
    delivery_id INT,
    order_date TEXT,
    FOREIGN KEY (pizza_id) REFERENCES PizzaMenu (pizza_id),
    FOREIGN KEY (customer_id) REFERENCES Customer (customer_id), 
    FOREIGN KEY (location_id) REFERENCES Location (pizza_id),
    FOREIGN KEY (delivery_id) REFERENCES Delivery (delivery_id)
    );
    
  --show table
  .schema
  
  INSERT INTO Orders VALUES
  (1, 4, 5, 3, 3, '01-01-2023'),
  (2, 3, 1, 5 ,1, '01-01-2023'),
  (3, 5, 6, 4, 3, '01-02-2023'),
  (4, 4, 10, 5, 2, '01-02-2023'),
  (5, 4, 3, 1, 4, '01-03-2023'),
  (6, 1, 4, 4, 3, '01-03-2023'),
  (7, 2, 5, 3, 4, '01-04-2023'),
  (8, 4, 6, 4, 4, '01-04-2023'),
  (9, 2, 5, 2, 1, '01-05-2023'),
  (10, 2, 5, 4, 4, '01-05-2023'),
  (11, 5, 3, 3, 4, '01-06-2023'),
  (12, 4, 7, 2, 3, '01-06-2023'),
  (13, 5, 3, 3, 4, '01-07-2023'),
  (14, 5, 8, 2, 3, '01-07-2023'),
  (15, 3, 10, 1, 2, '01-08-2023'),
  (16, 2, 9, 2, 4, '01-08-2023'),
  (17, 5, 2, 5, 2, '01-09-2023'),
  (18, 3, 9, 2, 2, '01-09-2023'),
  (19, 2, 5, 2, 4, '01-10-2023'),
  (20, 1, 2, 1, 2, '01-10-2023');
    
.mode markdown
.header on

--query 1: summary
SELECT 
	Orders.order_id,
    Orders.order_date,
    PizzaMenu.pizza_menu,
    PizzaMenu.price || ' ฿' AS price,
    Customer.name,
    Location.location,
    Delivery.delivery_type
FROM Orders
JOIN PizzaMenu ON Orders.pizza_id = PizzaMenu.pizza_id
JOIN Customer ON Orders.customer_id = Customer.customer_id
JOIN Location ON Orders.location_id = Location.location_id
JOIN Delivery ON Orders.delivery_id = Delivery.delivery_id;
		

--query 2: best-selling location
SELECT
	Location.location,
    COUNT(*) AS n_pizza
FROM Orders
JOIN PizzaMenu ON Orders.pizza_id = PizzaMenu.pizza_id
JOIN Customer ON Orders.customer_id = Customer.customer_id
JOIN Location ON Orders.location_id = Location.location_id
JOIN Delivery ON Orders.delivery_id = Delivery.delivery_id
GROUP BY location
ORDER BY n_pizza DESC
LIMIT 2;

--query 3: total income per location
SELECT
	Location.location,
    ROUND(SUM(PizzaMenu.price), 2) || ' ฿' AS average_income
FROM Orders
JOIN PizzaMenu ON Orders.pizza_id = PizzaMenu.pizza_id
JOIN Customer ON Orders.customer_id = Customer.customer_id
JOIN Location ON Orders.location_id = Location.location_id
JOIN Delivery ON Orders.delivery_id = Delivery.delivery_id
GROUP BY Location.location;

--query 4: all ingredients for Meat Lover Pizza [sub-query]
SELECT *
FROM (
  SELECT
  PizzaMenu.pizza_menu AS pizza,
  pizza_ing.ing_name AS ingredients
  FROM PizzaMenu
  JOIN pizza_menu_ingredient_list AS pizza_list ON PizzaMenu.pizza_id = pizza_list.pizza_id
  JOIN pizza_ing ON pizza_list.ing_id = pizza_ing.ing_id
  ) AS sub_query
WHERE pizza LIKE '%Meat Lover%';

--query 5: best-selling menu in Asoke [sub-query + WITH]
WITH Asoke_branch AS (
  SELECT *
  FROM Orders
  JOIN PizzaMenu ON Orders.pizza_id = PizzaMenu.pizza_id
  JOIN Location ON Orders.location_id = Location.location_id
  WHERE Location.location = 'Asoke'
  )
  SELECT
  	pizza_menu,
    COUNT(*) AS n_pizza
   FROM Asoke_branch
   GROUP BY 1
   ORDER BY 2 DESC
   LIMIT 1

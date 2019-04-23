use sakila;
SET SQL_Safe_Updates=0;

SELECT* FROM actor;
SELECT first_name, last_name FROM actor;


SELECT UPPER (CONCAT(first_name, ' ', last_name)) As `ActorName`
FROM actor;
SELECT* FROM actor;

SELECT actor_id, first_name, last_name FROM actor 
WHERE first_name="Joe";

SELECT* FROM actor
WHERE last_name like '%Gen%';


SELECT* FROM actor
WHERE last_name like '%Li%'
ORDER BY last_name, first_name;

SELECT* FROM country;
SELECT* FROM country
WHERE country IN('Afghanistan', 'Bangladesh', 'China'); 

ALTER TABLE actor
ADD COLUMN description BLOB;
SELECT* FROM actor;

ALTER TABLE actor
DROP COLUMN description;
SELECT* FROM actor; 

SELECT last_name, COUNT(*) As 'Number Of Actors'
FROM actor
GROUP BY last_name;

SELECT  last_name, COUNT(*) As 'Number Of Actors'
FROM actor
GROUP BY last_name
HAVING COUNT(*)>=2;

UPDATE actor
SET first_name='Harpo'
WHERE first_name ='Groucho'; 

SELECT* FROM actor
WHERE first_name='Harpo';

UPDATE actor 
SET first_name='Groucho'
WHERE first_name= 'Harpo';

SHOW CREATE TABLE address;

SELECT* FROM staff;
SELECT* FROM address;
SELECT  s.first_name, s.last_name, a.address
FROM staff AS s
JOIN address AS a ON s.address_id= a.address_id;

SELECT* FROM staff;
SELECT* FROM payment;
SELECT p.amount, p.payment_date, s.first_name,s.last_name
FROM staff as s
JOIN payment as p ON s.staff_id= p.staff_id
WHERE payment_date LIKE '%2005%';

SELECT* FROM film_actor;
SELECT* FROM film;
SELECT f.title, count(a.actor_id)
FROM film AS f
INNER JOIN film_actor AS a ON f.film_id=a.film_id
GROUP BY f.title;

SELECT* FROM inventory;
SELECT* FROM film;
SELECT count(i.inventory_id), f.film_id, f.title
FROM inventory AS i
INNER JOIN film AS f ON i.film_id=f.film_id
WHERE title='Hunchback Impossible';

SELECT* FROM payment;
SELECT* FROM customer;
SELECT  c.first_name,c.last_name, SUM(p.amount) As 'Total Amount Paid'
FROM payment AS p
INNER JOIN customer AS c ON p.customer_id=c.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY last_name ASC;


SELECT* FROM film;
SELECT* FROM language;

SELECT title
FROM film WHERE title
LIKE 'K%' OR title LIKE 'Q%' And title IN(
SELECT language_id
FROM language
WHERE language_id='1');

SELECT* FROM film_actor
WHERE film_id='17';
SELECT* FROM film;
SELECT* FROM actor;


SELECT first_name, last_name
FROM actor
WHERE actor_id IN( 
SELECT actor_id
FROM film_actor
WHERE film_id IN(
SELECT film_id 
FROM film
WHERE title='Alone Trip'));

SELECT* FROM customer;
SELECT* FROM address;
SELECT* FROM country;
SELECT* FROM city;

SELECT  c.email, c.first_name,c.last_name
FROM customer AS c
INNER JOIN address AS a ON c.address_id=a.address_id
INNER JOIN city AS o ON o.city_id=a.city_id
WHERE country_id=20;
 
 SELECT* FROM film_category;
SELECT* FROM film;
 SELECT* FROM category;

SELECT title 
FROM film
WHERE film_id IN(
SELECT film_id 
FROM film_category
WHERE category_id='8' IN(
SELECT category_id 
FROM category
WHERE name='family'));

SELECT* FROM film;
SELECT* FROM inventory;
SELECT* FROM rental;

SELECT f.title, COUNT(r.rental_id) AS' Most frequently rented movies'
FROM rental AS r
INNER JOIN inventory as i on r.inventory_id=i.inventory_id
INNER JOIN film AS f ON f.film_id=i.film_id
GROUP BY f.title 
ORDER BY COUNT(r.rental_id) DESC;

SELECT* FROM store;
SELECT* FROM payment;
SELECT* FROM staff;
SELECT* FROM inventory;

SELECT s.store_id, sum(p.amount) AS 'Dollars Bought In By Each Store'
FROM payment AS p
INNER JOIN staff AS s ON p.staff_id=s.staff_id
GROUP BY store_id;

SELECT* FROM store;
SELECT* FROM address;
SELECT* FROM city;
SELECT* FROM country;

SELECT s.store_id, c.city, k.country
FROM store AS s
INNER JOIN address AS a ON s.address_id=a.address_id
INNER JOIN city AS c ON c.city_id= a.city_id
INNER JOIN country as k ON k.country_id=c.country_id;

SELECT* FROM category;
SELECT* FROM film_category;
SELECT* FROM inventory;
SELECT* FROM  payment;
SELECT* FROM  rental;

SELECT c.name AS 'Top Five Genres', sum(p.amount) As 'Gross Revenue'
FROM category AS c
INNER JOIN film_category AS t ON c.category_id=t.category_id
INNER JOIN inventory AS i ON t.film_id=i.film_id
INNER JOIN rental AS r ON i.inventory_id=r.inventory_id
INNER JOIN payment AS p ON r.rental_id=p.rental_id
GROUP BY c.name
ORDER BY sum(p.amount) LIMIT 5;


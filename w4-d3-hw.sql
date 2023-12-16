
-- 1.) List all customers who live in Texas(use JOINs)
SELECT customer.customer_id, customer.first_name, customer.last_name
FROM customer
JOIN address ON customer.address_id = address.address_id
WHERE address.district = 'Texas'
--     ANSWER: '6-Jennifer Davis', '118-Kim Cruz', '305-Richard McCrary', '400-Bryan Hardison', '561-Ian Still'

-- 2.) Get all payments above $6.99 with the Customer's Full Name
SELECT customer.first_name, customer.last_name, payment.amount
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
WHERE payment.amount > 6.99 
--    ANSWER: Too long

-- 3.) Show all customers names who have made payments over $175(use subqueries)
SELECT first_name, last_name FROM customer
WHERE customer_id IN (
    SELECT customer_id FROM payment
    WHERE amount > 175
) 
--    ANSWER: Mary Smith, Peter Menard, Douglas Graf

-- 4.) List all customers that live in Nepal (use the city table)
SELECT customer.customer_id, customer.first_name, customer.last_name FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE country.country = 'Nepal'
--    ANSWER: 321 - Kevin Schuler


-- 5.) Which staff member had the most transactions?
SELECT staff.staff_id, staff.first_name, staff.last_name, COUNT(payment.payment_id) AS transaction_count
FROM staff
JOIN payment on staff.staff_id = payment.staff_id
GROUP BY staff.staff_id, staff.first_name, staff.last_name
ORDER BY transaction_count DESC
LIMIT 1
--    ANSWER: 2 - Jon Stephens with 7304 transactions


-- 6.) How many movies of each rating are there?
SELECT rating, COUNT(*) as movie_count
FROM film
GROUP BY rating
ORDER BY movie_count DESC
--    ANSWER: PG-13: 224, NC-17: 209, R: 196, PG: 194, G:178

-- 7.) 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT payment.customer_id
    FROM payment 
    WHERE payment.amount > 6.99
    GROUP BY payment.customer_id
    HAVING COUNT(payment.payment_id) = 1
);
--    ANSWER: 5 customers with following id's: 183, 342, 343, 467, 567


-- 8.) How many free rentals did our store give away?
SELECT COUNT(rental.rental_id) AS free_rentals
FROM rental
JOIN payment on payment.rental_id = rental.rental_id
-- WHERE payment.amount = 0 
WHERE payment.amount < 1
--    ANSWER: 0 rentals with amount at $0 but 14,562 rentals with negative payment amounts


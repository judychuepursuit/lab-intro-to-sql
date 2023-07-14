-- Getting started, do not update
DROP DATABASE IF EXISTS regifter;
CREATE DATABASE regifter;
\c regifter
-- End getting started code

--
-- Write your code below each prompt

--
\echo Create a table called gifts
-- with the following columns
-- id serial primary KEY
-- gift - string
-- giver - string
-- value - integer
-- previously_regifted boolean

CREATE TABLE gifts ( id SERIAL PRIMARY KEY, gift TEXT, giver TEXT, value INT, previously_regifted BOOLEAN );

-- 
\echo See details of the table you created
-- 

regifter-# \d gifts
 Table "public.gifts"
      Column       |  Type   | Collation | Nullable |              Default              
-------------------+---------+-----------+----------+-----------------------------------
 id                | integer |           | not null | nextval('gifts_id_seq'::regclass)
 gift              | text    |           |          | 
 giver             | text    |           |          | 
 value             | integer |           |          | 
 previously_gifted | boolean |           |          | 

-- SKIP this as per AHMAD
-- \echo Alter the table so that the column price is changed to value 
-- 
-- TRIED this
-- ALTER TABLE gifts RENAME value to price;

-- 
\echo Insert a peach candle, given by 'Santa' thats value is 9 and has been previously regifted
-- 
INSERT INTO gifts (gift, giver, value, previously_gifted) VALUES ('peach candle', 'Santa', 9, TRUE); 

--
\echo Query for all the columns in your gifts table
-- 
SELECT * FROM gifts;
 id |     gift     | giver | value | previously_gifted 
----+--------------+-------+-------+-------------------
  1 | peach candle | Santa |     9 | t
(1 row)

--
\echo Uncomment below to insert 5 more gifts
-- 

INSERT INTO gifts (gift, giver, value, previously_regifted)
VALUES
('peach candle', 'Santa', '9', TRUE),
('cinnamon candle', 'Nick', '19', TRUE),
('soap on a rope', 'Rudolf', '29', FALSE),
('potpurri', 'Elf on the Shelf', '39', TRUE),
('mango candle', 'The Boss', '49', FALSE)
;

-- 
\echo Insert 5 more gifts of your own choosing,  include 1 more candle
--
-- HERE IS JUST THE ADDITIONAL 5 new Items added, w another candle.
INSERT INTO gifts (gift, giver, value, previously_gifted) VALUES ('key chain', 'Santa', '7', TRUE),
regifter-# ('scent diffuser', 'Rudolf', '10', FALSE),
regifter-# ('tree topper', 'The Boss', '23', FALSE),
regifter-# ('salt & pepper set', 'Mrs Boss', '25', TRUE),
regifter-# ('sandlewood candle', 'Santa', '30', FALSE);
INSERT 0 5
regifter=# SELECT * FROM gifts;
 id |       gift        |  giver   | value | previously_gifted 
----+-------------------+----------+-------+-------------------
  1 | peach candle      | Santa    |     9 | t
  2 | key chain         | Santa    |     7 | t
  3 | scent diffuser    | Rudolf   |    10 | f
  4 | tree topper       | The Boss |    23 | f
  5 | salt & pepper set | Mrs Boss |    25 | t
  6 | sandlewood candle | Santa    |    30 | f
(6 rows)

-- HERE IS WITH THE ORIGINAL AND THE ADDITIONAL 5 new Items I added.
INSERT INTO gifts (gift, giver, value, previously_gifted) VALUES ('cinnamon candle', 'Nick', '19', TRUE),
regifter-# ('soap on a rope', 'Rudolf', '29', FALSE),
regifter-# ('potpurri', 'Elf on the Shelf', '39', TRUE),
regifter-# ('mango candle', 'The Boss', '49', FALSE)
regifter-# ; SELECT * FROM gifts;
INSERT 0 4
 id |       gift        |      giver       | value | previously_gifted 
----+-------------------+------------------+-------+-------------------
  1 | peach candle      | Santa            |     9 | t
  2 | key chain         | Santa            |     7 | t
  3 | scent diffuser    | Rudolf           |    10 | f
  4 | tree topper       | The Boss         |    23 | f
  5 | salt & pepper set | Mrs Boss         |    25 | t
  6 | sandlewood candle | Santa            |    30 | f
  7 | cinnamon candle   | Nick             |    19 | t
  8 | soap on a rope    | Rudolf           |    29 | f
  9 | potpurri          | Elf on the Shelf |    39 | t
 10 | mango candle      | The Boss         |    49 | f
(10 rows)
--
\echo Query for gifts with a price greater than or equal to 20
--
-- FIRST I HAD TO CHANGE TABLE COLUMN NAME from "value" to "price"!
ALTER TABLE gifts RENAME value TO price;
ALTER TABLE
regifter=# SELECT * FROM gifts;
 id |       gift        |      giver       | price | previously_gifted 
----+-------------------+------------------+-------+-------------------
  1 | peach candle      | Santa            |     9 | t
  2 | key chain         | Santa            |     7 | t
  3 | scent diffuser    | Rudolf           |    10 | f
  4 | tree topper       | The Boss         |    23 | f
  5 | salt & pepper set | Mrs Boss         |    25 | t
  6 | sandlewood candle | Santa            |    30 | f
  7 | cinnamon candle   | Nick             |    19 | t
  8 | soap on a rope    | Rudolf           |    29 | f
  9 | potpurri          | Elf on the Shelf |    39 | t
 10 | mango candle      | The Boss         |    49 | f
(10 rows)

SELECT * FROM gifts WHERE price >= 20;
--
regifter=# SELECT * FROM gifts WHERE price >= 20;
 id |       gift        |      giver       | price | previously_gifted 
----+-------------------+------------------+-------+-------------------
  4 | tree topper       | The Boss         |    23 | f
  5 | salt & pepper set | Mrs Boss         |    25 | t
  6 | sandlewood candle | Santa            |    30 | f
  8 | soap on a rope    | Rudolf           |    29 | f
  9 | potpurri          | Elf on the Shelf |    39 | t
 10 | mango candle      | The Boss         |    49 | f
(6 rows)

\echo Query for every gift that has the word candle in it, only show the gift column
--
SELECT * FROM gifts WHERE gift LIKE '%candle%';
 id |       gift        |  giver   | price | previously_gifted 
----+-------------------+----------+-------+-------------------
  1 | peach candle      | Santa    |     9 | t
  6 | sandlewood candle | Santa    |    30 | f
  7 | cinnamon candle   | Nick     |    19 | t
 10 | mango candle      | The Boss |    49 | f
(4 rows)

--
\echo Query for every gift whose giver is Santa OR value is greater than 30
--
-- AS PER LINE 112, I HAD TO CHANGE TABLE COLUMN NAME from "value" to "price", therefore the line 155 should say "price" and not "value"
SELECT * FROM gifts WHERE giver = 'Santa' OR price > 30;
 id |       gift        |      giver       | price | previously_gifted 
----+-------------------+------------------+-------+-------------------
  1 | peach candle      | Santa            |     9 | t
  2 | key chain         | Santa            |     7 | t
  6 | sandlewood candle | Santa            |    30 | f
  9 | potpurri          | Elf on the Shelf |    39 | t
 10 | mango candle      | The Boss         |    49 | f
(5 rows)

--
\echo Query for every gift whose giver is NOT Santa
--
SELECT * FROM gifts WHERE giver != 'Santa';
 id |       gift        |      giver       | price | previously_gifted 
----+-------------------+------------------+-------+-------------------
  3 | scent diffuser    | Rudolf           |    10 | f
  4 | tree topper       | The Boss         |    23 | f
  5 | salt & pepper set | Mrs Boss         |    25 | t
  7 | cinnamon candle   | Nick             |    19 | t
  8 | soap on a rope    | Rudolf           |    29 | f
  9 | potpurri          | Elf on the Shelf |    39 | t
 10 | mango candle      | The Boss         |    49 | f
(7 rows)

--
\echo Update the second gift to have a value of 2999
-- 
UPDATE gifts SET price = 2999 WHERE id = 2; UPDATE 1
UPDATE 1

--
\echo Query for the updated item
--

SELECT * FROM gifts;
 id |       gift        |      giver       | price | previously_gifted 
----+-------------------+------------------+-------+-------------------
  1 | peach candle      | Santa            |     9 | t
  3 | scent diffuser    | Rudolf           |    10 | f
  4 | tree topper       | The Boss         |    23 | f
  5 | salt & pepper set | Mrs Boss         |    25 | t
  6 | sandlewood candle | Santa            |    30 | f
  7 | cinnamon candle   | Nick             |    19 | t
  8 | soap on a rope    | Rudolf           |    29 | f
  9 | potpurri          | Elf on the Shelf |    39 | t
 10 | mango candle      | The Boss         |    49 | f
  2 | key chain         | Santa            |  2999 | t
(10 rows)

--
\echo Delete all the gifts from Santa and return the 'value' and 'gift' of the gift you have deleted
--
DELETE FROM gifts WHERE giver = 'Santa' RETURNING price, gift;
DELETE FROM gifts WHERE giver = 'Santa' RETURNING price, gift;
 price |       gift        
-------+-------------------
     9 | peach candle
    30 | sandlewood candle
  2999 | key chain
(3 rows)

DELETE 3
--
\echo Query for all the columns in your gifts table one more time
--
SELECT * FROM gifts;
 id |       gift        |      giver       | price | previously_gifted 
----+-------------------+------------------+-------+-------------------
  3 | scent diffuser    | Rudolf           |    10 | f
  4 | tree topper       | The Boss         |    23 | f
  5 | salt & pepper set | Mrs Boss         |    25 | t
  7 | cinnamon candle   | Nick             |    19 | t
  8 | soap on a rope    | Rudolf           |    29 | f
  9 | potpurri          | Elf on the Shelf |    39 | t
 10 | mango candle      | The Boss         |    49 | f
(7 rows)

DELETE 3

-- BONUSES

--
 \echo Count the total number of gifts that have the word candle in it
-- 
SELECT COUNT(*) AS total_gifts_with_candle
regifter-# FROM gifts
regifter-# WHERE gift LIKE '%candle%';
 total_gifts_with_candle 
-------------------------
                       2
(1 row)

--
\echo Get the AVEREAGE value from all the gifts
--


-- 
 \echo Limit to 3 gifts, offset by 2 and order by price descending
--

--
-- finish
--
DROP TABLE IF EXISTS gifts;

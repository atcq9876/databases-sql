-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE recipes RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.

INSERT INTO recipes (recipe_name, cooking_time, rating) VALUES ('Margherita Pizza', 30, 4);
INSERT INTO recipes (recipe_name, cooking_time, rating) VALUES ('Spaghetti Bolognese', 20, 3);
INSERT INTO recipes (recipe_name, cooking_time, rating) VALUES ('Mushroom Risotto', 45, 5);
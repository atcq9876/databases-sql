-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE user_accounts RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO "user_accounts" (name, email_address, username) VALUES ('Andy', 'andy@gmail.com', 'andy123');
INSERT INTO "user_accounts" (name, email_address, username) VALUES ('James', 'james@outlook.com', 'james456');
INSERT INTO "user_accounts" (name, email_address, username) VALUES ('Scott', 'scott@outlook.com', '789scott');
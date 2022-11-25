-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE user_accounts, posts RESTART IDENTITY;
-- TRUNCATE TABLE user_accounts, posts CASCADE;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO "user_accounts" (name, email_address, username) VALUES ('Andy', 'andy@gmail.com', 'andy123');
INSERT INTO "user_accounts" (name, email_address, username) VALUES ('James', 'james@outlook.com', 'james456');
INSERT INTO "user_accounts" (name, email_address, username) VALUES ('Scott', 'scott@outlook.com', '789scott');

INSERT INTO "posts" (title, content, views, user_account_id) VALUES ('Hello', 'Hello, this is Andy', 54, 1);
INSERT INTO "posts" (title, content, views, user_account_id) VALUES ('Test', 'Testing, 123', 100, 2);
INSERT INTO "posts" (title, content, views, user_account_id) VALUES ('Dinner', 'I ate pizza for dinner', 230, 3);
INSERT INTO "posts" (title, content, views, user_account_id) VALUES ('Sport', 'My favourite sport is tennis', 77, 3);
INSERT INTO "posts" (title, content, views, user_account_id) VALUES ('Deactivate account', 'I am thinking of deactivating my account', 900, 1);
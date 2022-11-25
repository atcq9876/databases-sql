-- Create the table without the foreign key first.
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text
);

-- Then the table with the foreign key first.
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  content text,
  author_name text,
-- The foreign key name is always {other_table_singular}_id
  post_id int,
  constraint fk_post foreign key(post_id)
    references posts(id)
    on delete cascade
);

INSERT INTO posts (title, content) VALUES ('First post', 'Hi everyone, this is my first blog post!');
INSERT INTO posts (title, content) VALUES ('Second post', 'And this is my second post!');

INSERT INTO comments (content, author_name, post_id) VALUES ('Welcome to this blogging site!', 'tony_123', 1);
INSERT INTO comments (content, author_name, post_id) VALUES ('Great post!!', 'author22', 1);
INSERT INTO comments (content, author_name, post_id) VALUES ('Wow, already onto your second post!', 'blogger77', 2);
INSERT INTO comments (content, author_name, post_id) VALUES ('You are on a role!!!', 'commenter108', 2);
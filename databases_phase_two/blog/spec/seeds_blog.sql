TRUNCATE TABLE posts, comments RESTART IDENTITY;

INSERT INTO posts (title, content) VALUES ('First post', 'Hi everyone, this is my first blog post!');
INSERT INTO posts (title, content) VALUES ('Second post', 'And this is my second post!');

INSERT INTO comments (content, author_name, post_id) VALUES ('Welcome to this blogging site!', 'tony_123', 1);
INSERT INTO comments (content, author_name, post_id) VALUES ('Great post!!', 'author22', 1);
INSERT INTO comments (content, author_name, post_id) VALUES ('Wow, already onto your second post!', 'blogger77', 2);
INSERT INTO comments (content, author_name, post_id) VALUES ('You are on a role!!!', 'commenter108', 2);
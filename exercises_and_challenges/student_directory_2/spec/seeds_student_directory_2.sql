TRUNCATE TABLE cohorts, students RESTART IDENTITY;

INSERT INTO "cohorts" (name, starting_date) VALUES ('One', '2022-09-01');
INSERT INTO "cohorts" (name, starting_date) VALUES ('Two', '2022-10-01');
INSERT INTO "cohorts" (name, starting_date) VALUES ('Three', '2022-11-01');

INSERT INTO "students" (name, cohort_id) VALUES ('Andy', 1);
INSERT INTO "students" (name, cohort_id) VALUES ('James', 1);
INSERT INTO "students" (name, cohort_id) VALUES ('Scott', 2);
INSERT INTO "students" (name, cohort_id) VALUES ('Lewis', 2);
INSERT INTO "students" (name, cohort_id) VALUES ('Andre', 3);
INSERT INTO "students" (name, cohort_id) VALUES ('Jimmy', 3);
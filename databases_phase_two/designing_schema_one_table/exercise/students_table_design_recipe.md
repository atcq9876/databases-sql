Single Table Design Recipe Template
Copy this recipe template to design and create a database table from a specification.


1. Extract nouns from the user stories or specification

As a coach
So I can get to know all students
I want to see a list of students' names.

As a coach
So I can get to know all students
I want to see a list of students' cohorts.

Nouns:
students
student name, student cohort




2. Infer the Table Name and Columns
Put the different nouns in this table. Replace the example with your own nouns.

Record	    Properties
student     student name, student cohort

Name of the table (always plural): students
Column names: student_name, cohort_name




3. Decide the column types.
Here's a full documentation of PostgreSQL data types.

Most of the time, you'll need either text, int, bigint, numeric, or boolean. If you're in doubt, do some research or ask your peers.

Remember to always have the primary key id as a first column. Its type will always be SERIAL.


id: SERIAL
student_name: text
cohort_name: text




4. Write the SQL.

-- file: students_table.sql

CREATE TABLE "students" (
  "id" SERIAL PRIMARY KEY,
  "student_name" text,
  "cohort_name" text
);




5. Create the table.
psql -h 127.0.0.1 student_directory_1 < students_table.sql

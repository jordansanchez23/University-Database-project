#####################################################################

USE universitydb;
SELECT * FROM college;
SELECT * FROM department;
SELECT * FROM faculty;
SELECT * FROM term;
SELECT * FROM course;
SELECT * FROM section;
SELECT * FROM student;
RENAME TABLE section_has_student TO enrollment_record;
############################################################################
-- Step 3 Load the University database
INSERT INTO college (college_name)
VALUES 
('College of Physical Science and Engineering'),
('College of Business and Communication'),
('College of Language and Letters');
	
INSERT INTO department (department_name, department_code, college_id)
VALUES
('Computer Information Technology', 'ITM', 1),
('Economics', 'ECON', 2),
('Humanities and Philosophy', 'HUM', 3);

INSERT INTO faculty (faculty_fname, faculty_lname)
VALUES
('Marty', 'Morring'),
('Nate', 'Norris'),
('Ben', 'Barrus'),
('Jhon', 'Jensen'),
('Bill', 'Barney');

INSERT INTO term (term_name, year)
VALUES
('Fall', '2018'),
('Winter', '2018'),
('Fall', '2019'),
('Winter', '2019');

INSERT INTO course (course_num, course_title, credits, department_id, college_id)
VALUES
(111, 'Intro to Databases', 3, 1, 1),
(388, 'Econometrics', 4, 2, 2),
(150, 'Micro Economics', 3, 2, 2),
(376, 'Classical Heritage', 2, 3, 3);

INSERT INTO section (section_number, section_capacity, course_num, faculty_id, term_id)
VALUES
(1, 30, 111, 1, 3),
(1, 50, 150, 2, 3),
(2, 50, 150, 2, 3),
(1, 35, 388, 3, 3),
(1, 30, 376, 4, 3),
(2, 30, 111, 1, 2),
(3, 35, 111, 5, 2),
(1, 50, 150, 2, 2),
(2, 50, 150, 2, 2),
(1, 30, 376, 4, 2);

INSERT INTO student (first_name, last_name, gender, city, state, birthdate)
VALUES
('Paul', 'Miller', 'M', 'Dallas', 'TX', '1996-02-22'),
('Katie', 'Smith', 'F', 'Provo', 'UT', '1995-07-22'),
('Kelly', 'Jones', 'F', 'Provo', 'UT', '1998-06-22'),
('Devon', 'Merrill', 'M', 'Mesa', 'AZ', '2000-07-22'),
('Mandy', 'Murdock', 'F', 'Topeka', 'KS', '1996-11-22'),
('Alece', 'Adams', 'F', 'Rigby', 'ID', '1997-05-22'),
('Bryce', 'Carlson', 'M', 'Bozeman', 'MT', '1997-11-22'),
('Preston', 'Larsen', 'M', 'Decatur', 'TN', '1996-09-22'),
('Julia', 'Madsen', 'F', 'Rexburg', 'ID', '1998-09-22'),
('Susan', 'Sorensen', 'F', 'Mesa', 'AZ', '1998-08-09');

SELECT * FROM enrollment_record ORDER BY section_id;

INSERT INTO enrollment_record (section_id, course_num, faculty_id, term_id, student_id)
VALUES
(7, 111, 5, 2, 6),  -- Alece in ITM 111 Winter 2018 Section 3
(6, 111, 1, 2, 7),  -- Bryce in ITM 111 Winter 2018 Section 2
(8, 150, 2, 2, 7),  -- Bryce in ECON 150 Winter 2018 Section 1
(10, 376, 4, 2, 7),  -- Bryce in HUM 376 Winter 2018 Section 1
(5, 376, 4, 3, 4),  -- Devon in HUM 376 Fall 2019 Section 1
(9, 150, 2, 2, 9),  -- Julia in ECON 150 Winter 2018 Section 2
(4, 388, 3, 3, 2),  -- Katie in ECON 388 Fall 2019 Section 1
(4, 388, 3, 3, 3),  -- Kelly in ECON 388 Fall 2019 Section 1
(4, 388, 3, 3, 5),  -- Mandy in ECON 388 Fall 2019 Section 1
(5, 376, 4, 3, 5),  -- Mandy in HUM 376 Fall 2019 Section 1
(1, 111, 1, 3, 1),  -- Paul in ITM 111 Fall 2019 Section 1
(3, 150, 2, 3, 1),  -- Paul in ECON 150 Fall 2019 Section 2
(9, 150, 2, 2, 8),  -- Preston in ECON 150 Winter 2018 Section 2
(6, 111, 1, 2, 10); -- Susan in ITM 111 Winter 2018 Section 2

###############################################################################
-- Query the University database
#1
SELECT first_name, last_name, DATE_FORMAT(birthdate, '%M %D, %Y') AS 'Sept Birthdays'
FROM student
WHERE MONTH(birthdate) = 9
ORDER BY last_name;

#2
SELECT last_name,
       first_name,
       TIMESTAMPDIFF(YEAR, birthdate, '2017-01-05') AS Years, -- Calculate the whole years
       DATEDIFF('2017-01-05', birthdate) % 365 AS Days,  -- it gives the rest of the days
       CONCAT(TIMESTAMPDIFF(YEAR, birthdate, '2017-01-05'), ' - Yrs, ', DATEDIFF('2017-01-05', birthdate) % 365, ' - Days') AS "Years and Days"
FROM student
ORDER BY Years DESC;

#3
SELECT s.first_name, s.last_name
FROM student s
	JOIN enrollment_record e
    ON s.student_id = e.student_id
WHERE faculty_id = 4
ORDER BY last_name;

#4
SELECT f.faculty_fname, f.faculty_lname
FROM faculty f
	JOIN enrollment_record e
    ON f.faculty_id = e.faculty_id
    JOIN student s
    ON s.student_id = e.student_id
    JOIN term t
    ON t.term_id = e.term_id
WHERE s.student_id = 7 AND t.term_id = 2
ORDER BY f.faculty_lname;

#5
SELECT s.first_name, s.last_name
FROM student s
	JOIN enrollment_record e
    ON s.student_id = e.student_id
    JOIN faculty f 
    ON f.faculty_id = e.faculty_id
    JOIN course c
    ON c.course_num = e.course_num
    JOIN term t
    ON t.term_id = e.term_id
WHERE t.term_id = 3 AND c.course_title = 'Econometrics'
ORDER BY s.last_name;

#6
SELECT d.department_code, c.course_num, c.course_title AS 'Name of Course'
FROM course c
	JOIN enrollment_record e
    ON c.course_num = e.course_num
    JOIN student s
    ON s.student_id = e.student_id
    JOIN department d
    ON d.department_id = c.department_id
	JOIN term t
    ON t.term_id = e.term_id
WHERE s.student_id = 7 AND t.term_id = 2
ORDER BY c.course_title;

#7
SELECT t.term_name, t.year, COUNT(s.student_id) AS Enrollment
FROM term t
	JOIN enrollment_record e
    ON t.term_id = e.term_id
    JOIN student s
    ON s.student_id = e.student_id
WHERE t.term_id = 3
GROUP BY t.term_name, t.year;

#8
SELECT col.college_name, COUNT(cour.course_title) AS Courses
FROM college col
	JOIN department d
    ON col.college_id = d.college_id
    JOIN course cour
    ON cour.department_id = d.department_id
GROUP BY col.college_name
ORDER BY col.college_name;

#9
SELECT f.faculty_fname, f.faculty_lname, SUM(sec.section_capacity) AS teaching_capacity
FROM faculty f
	JOIN section sec
    ON sec.faculty_id = f.faculty_id
    JOIN term t
    ON t.term_id = sec.term_id
WHERE t.term_id = 2 -- Winter 2018
GROUP BY f.faculty_fname, f.faculty_lname
ORDER BY teaching_capacity;

#10
SELECT stu.last_name, stu.first_name, SUM(c.credits) AS Credits
FROM student stu
	JOIN enrollment_record enr
    ON stu.student_id = enr.student_id
    JOIN section s
    ON s.section_id = enr.section_id
    JOIN course c
    ON c.course_num = s.course_num
    JOIN term t
    ON t.term_id = s.term_id
WHERE t.term_id = 3
GROUP BY stu.last_name, stu.first_name
HAVING Credits > 3
ORDER BY Credits DESC;
--  Data Definition Language Examples

-- Create
CREATE TABLE Admin(
    username varchar(50),
    password varchar(255)
);
-- Alter
ALTER TABLE Student MODIFY COLUMN student_id CHAR(20);
ALTER TABLE Score ALTER COLUMN value set default 0;
ALTER TABLE Student ALTER COLUMN registered_credit_hours set default 0;

select * from Student where student_id = 'ugr/22328/14';

ALTER TABLE Student ADD COLUMN password varchar(255);
ALTER TABLE Class ADD COLUMN password varchar(255);

ALTER TABLE CourseCategory MODIFY COLUMN category_name varchar(40);
--



-- Data Manipulation Language Examples

-- Insert

-- Insert year
insert into Year (year,credit_hour) values (1,20);
insert into Year (year,credit_hour) values (2,21);
insert into Year (year,credit_hour) values (3,19);
insert into Year (year,credit_hour) values (4,20);
insert into Year (year,credit_hour) values (5,24);

-- Student insertion
insert into Student (student_id, full_name, email, gender, phone, address) values ('ugr/09381/15', 'Annie Helwig', 'ahelwig0@addtoany.com', 'Female', '709-694-0828', '1 Haas Park');
insert into Student (student_id, full_name, email, gender, phone, address) values ('ugr/22334/14', 'Trixie Gainseford', 'tgainseford1@issuu.com', 'Female', '320-125-1031', '51 Elgar Terrace');
insert into Student (student_id, full_name, email, gender, phone, address) values ('ugr/29677/14', 'Harland Clericoates', 'hclericoates2@geocities.jp', 'Male', '265-797-6806', '37278 Express Street');


-- Teacher insertion
insert into Teacher (teacher_id, full_name, email, gender, address, credit_hour_limit, phone) values ('T/913/10', 'Kevan Slade', 'kslade0@pinterest.com', 'Male', '91 Nevada Court', 8, '829-731-9629');
insert into Teacher (teacher_id, full_name, email, gender, address, credit_hour_limit, phone) values ('T/035/19', 'Carina Stiller', 'cstiller1@goo.ne.jp', 'Female', '65013 Heffernan Plaza', 8, '777-909-1460');
insert into Teacher (teacher_id, full_name, email, gender, address, credit_hour_limit, phone) values ('T/115/17', 'Rosina Sillis', 'rsillis2@cisco.com', 'Female', '0 Manufacturers Road', 6, '253-612-3895');

-- CourseCategory insertion
INSERT INTO CourseCategory (category_id, category_name)  VALUES (1 , 'Software Engineering');
INSERT INTO CourseCategory (category_id, category_name)  VALUES (2 , 'Mechanical Engineering');
INSERT INTO CourseCategory (category_id, category_name)  VALUES (3 , 'Civil Engineering');
INSERT INTO CourseCategory (category_id, category_name)  VALUES (4 , 'Applied Science');

-- Course insertion
INSERT INTO Course (course_id, course_name, course_category, credit_hour, start_date, end_date) VALUES ('DSA101', 'Data structures',1,4,'2023-01-01','2023-04-01');
INSERT INTO Course (course_id, course_name, course_category, credit_hour, start_date, end_date) VALUES ('ALG101', 'Algorithms',1,3,'2023-01-01','2023-04-01');
INSERT INTO Course (course_id, course_name, course_category, credit_hour, start_date, end_date) VALUES ('SW101', 'Software architecture',1,4,'2023-01-01','2023-04-01');


-- Insert into Class with procedure
CALL Assign_Teacher_to_Class('DSA23','Data structure 3','T/107/18','DSA101','room_3',TIMESTAMP('2023-01-21 8:30:00'),TIMESTAMP('2023-01-21 10:30:00'));
CALL Assign_Teacher_to_Class('MATH1','Applied Math 1','T/119/12','MATH101','room_2',TIMESTAMP('2023-01-21 8:30:00'),TIMESTAMP('2023-01-21 10:30:00'));
CALL Assign_Teacher_to_Class('ALGO1','ALGORITHM','T/33/12','ALG101','room_2',TIMESTAMP('2023-01-21 8:30:00'),TIMESTAMP('2023-01-21 10:30:00'));

-- Insert in Exam
INSERT INTO Exam (exam_id, course_id, exam_type_id,exam_time) VALUES (1,'DSA101',4,TIMESTAMP('2023-01-21 8:30:00'));
INSERT INTO Exam (exam_id, course_id, exam_type_id,exam_time) VALUES (2,'MATH101',4,TIMESTAMP('2023-01-21 8:30:00'));
INSERT INTO Exam (exam_id, course_id, exam_type_id,exam_time) VALUES (3,'PHY101',4,TIMESTAMP('2023-01-25 8:30:00'));
INSERT INTO Exam (exam_id, course_id, exam_type_id,exam_time) VALUES (4,'SW101',4,TIMESTAMP('2023-01-21 8:30:00'));


-- Insert Score

INSERT INTO Score(exam_id,student_id,value) VALUES (1,'ugr/12732/12',5);
INSERT INTO Score(exam_id,student_id,value) VALUES (2,'ugr/12732/12',4);
INSERT INTO Score(exam_id,student_id,value) VALUES (3,'ugr/12732/12',5);

-- Insert Attendance

INSERT INTO Attendance(class_id, class_date, student_id) VALUES ('ALGO1',TIMESTAMP('2023-01-21 8:30:00'),'ugr/12732/12');
INSERT INTO Attendance(class_id, class_date, student_id) VALUES ('DSA1',TIMESTAMP('2023-01-21 8:30:00'),'ugr/12732/12');
INSERT INTO Attendance(class_id, class_date, student_id) VALUES ('MATH1',TIMESTAMP('2023-01-21 8:30:00'),'ugr/12732/12');


-- delete a student

DELETE FROM Student WHERE student_id = 'ugr/90666/13';

CALL Dismiss_Teacher_From_Class('IS101','T/119/12');
CALL Dismiss_Teacher_From_Class('DSA23','T/115/17');

CALL Enroll_Student_to_Class('ALGO1','ugr/93920/14');
CALL Enroll_Student_to_Class('ALGO1','ugr/58458/19');
CALL Enroll_Student_to_Class('ALGO1','ugr/80675/15');
CALL Enroll_Student_to_Class('ALGO1','ugr/90666/13');

CALL Dismiss_Student_from_Class('ALGO1','ugr/93920/14');



SELECT * FROM Teacher WHERE teacher_id = 'T/187/19';
SELECT * FROM Course WHERE course_id = 'DSA101';


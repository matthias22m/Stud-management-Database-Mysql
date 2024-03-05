CREATE VIEW TeacherCourseView AS
SELECT teacher.teacher_id, teacher.full_name, class.class_name, class.class_room
FROM Teacher teacher
JOIN Class class ON teacher.teacher_id = class.teacher_id
JOIN Course course ON class.course_id = course.course_id;

CREATE VIEW StudentCourseView AS
SELECT student.student_id, student.full_name, course.course_name
FROM Student student
JOIN Enrollment en ON student.student_id = en.student_id
JOIN Class class ON en.class_id = class.class_id
JOIN Course course ON class.course_id = course.course_id;



CREATE VIEW CourseExamView AS
SELECT course.course_name, etype.exam_type, exam.exam_time
FROM Course course
JOIN Exam exam ON course.course_id = exam.course_id
JOIN ExamType etype ON exam.exam_type_id = etype.exam_id;

select * from CourseExamView;
drop view CourseExamView;

-- Search Teacher's class and time with teacher id
SELECT full_name, course_name, class_room, start_time, end_time
FROM Teacher teach
JOIN Class class on teach.teacher_id = class.teacher_id
JOIN Course course on class.course_id = course.course_id
WHERE teach.teacher_id = 'T/107/18';


CREATE USER 'User1'@'localhost' IDENTIFIED BY 'user';
CREATE USER 'User2'@'localhost' IDENTIFIED BY 'user';
CREATE USER 'User3'@'localhost' IDENTIFIED BY 'user';
CREATE USER 'admin2'@'localhost' IDENTIFIED BY 'admin';

GRANT SELECT ON CourseExamView TO 'User1'@'localhost';
GRANT SELECT ON StudentCourseView TO 'User2'@'localhost';
GRANT SELECT ON TeacherCourseView TO 'User3'@'localhost';

GRANT ALL PRIVILEGES ON school TO 'admin2'@'localhost';

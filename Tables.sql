CREATE TABLE Student (
  student_id Char(20) PRIMARY KEY,
  full_name VARCHAR(255) NOT NULL,
  gender VARCHAR(10) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  phone VARCHAR(20) UNIQUE NOT NULL,
  registered_credit_hours INT DEFAULT 0,
  year INT DEFAULT 1 NOT NULL,
  registration_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
  address VARCHAR(255) NOT NULL,
  FOREIGN KEY (year) REFERENCES Year (year)
);

CREATE TABLE Year (
  year INT PRIMARY KEY,
  credit_hour INT NOT NULL
);

CREATE TABLE Teacher (
  teacher_id CHAR(10) PRIMARY KEY,
  full_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  gender CHAR(10),
  assigned_credit_hour INT DEFAULT 0,
  credit_hour_limit INT NOT NULL,
  address varchar(255) NOT NULL
);

CREATE TABLE Course (
  course_id CHAR(10) PRIMARY KEY,
  course_name VARCHAR(40),
  course_category INT NOT NULL,
  credit_hour INT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  FOREIGN KEY (course_category) REFERENCES CourseCategory (category_id)
);

CREATE TABLE CourseCategory (
  category_id INT PRIMARY KEY,
  category_name varchar(40) NOT NULL
);

CREATE TABLE Class (
  class_id CHAR(5) PRIMARY KEY,
  class_name VARCHAR(50),
  teacher_id CHAR(10) NOT NULL,
  course_id CHAR(10) NOT NULL,
  class_room VARCHAR(50),
  room_limit INT DEFAULT 30,
  registered_student INT DEFAULT 0,
  start_time DATETIME NOT NULL,
  end_time DATETIME NOT NULL,
  UNIQUE (class_room, start_time),
  FOREIGN KEY (teacher_id) REFERENCES Teacher (teacher_id),
  FOREIGN KEY (course_id) REFERENCES Course (course_id)
);


CREATE TABLE Attendance (
  class_id CHAR(5) NOT NULL,
  class_date DATETIME NOT NULL,
  student_id CHAR(20) NOT NULL,
  PRIMARY KEY (class_id,class_date,student_id),
  FOREIGN KEY (class_id) REFERENCES Class (class_id),
  FOREIGN KEY (student_id) REFERENCES Student (student_id)
);

CREATE TABLE Enrollment (
  class_id CHAR(5) NOT NULL,
  student_id CHAR(20) NOT NULL,
  enroll_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  primary key(class_id,student_id),
  FOREIGN KEY (class_id) REFERENCES Class (class_id),
  FOREIGN KEY (student_id) REFERENCES Student (student_id) ON DELETE CASCADE
);


CREATE TABLE Exam (
  exam_id INT PRIMARY KEY,
  course_id CHAR(10) NOT NULL,
  exam_type_id INT NOT NULL ,
  exam_time YEAR DEFAULT (YEAR(CURDATE())),
  FOREIGN KEY (course_id) REFERENCES Course (course_id),
  FOREIGN KEY (exam_type_id) REFERENCES ExamType (exam_id)
);


CREATE TABLE ExamType(
  exam_id INT PRIMARY KEY,
  exam_type char(10)
);


CREATE TABLE Score (
  student_id CHAR(20) NOT NULL,
  exam_id INT NOT NULL,
  value INT,
  primary key(student_id,exam_id),
  FOREIGN KEY (student_id) REFERENCES Student (student_id),
  FOREIGN KEY (exam_id) REFERENCES Exam (exam_id)
);

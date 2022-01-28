DROP database IF EXISTS school;
CREATE database school;
-- ------------------------------------
DROP table IF EXISTS student;
CREATE table student (
studentId int not null auto_increment,
studentName varchar(255) not null,
studentGrade int not null,
primary key(studentId)
);

DROP table IF EXISTS course;
CREATE table course (
courseId int not null auto_increment,
courseName varchar(255) not null,
primary key(courseId)
);

DROP table IF EXISTS enrollment;
CREATE table enrollment (
enrollmentId int not null auto_increment,
courseId int,
studentId int,
studentName varchar(255),
courseName varchar(255),
primary key(enrollmentId)
);
-- --------------------------------------
ALTER table student add unique(studentId);
ALTER table course add unique(courseId);
ALTER table enrollment add unique(enrollmentId);
ALTER table enrollment add foreign key(studentId) references student(studentId);
ALTER table enrollment add foreign key(courseId) references course(courseId);
-- ---------------------------------------
INSERT INTO student(student.studentName, student.studentGrade) VALUES('Noe Torres', 2);
INSERT INTO student(student.studentName, student.studentGrade) VALUES('Dylan Stones', 5);
INSERT INTO student(student.studentName, student.studentGrade) VALUES('Sheryl Fields', 4);

INSERT INTO course(course.courseName) VALUES('Math');
INSERT INTO course(course.courseName) VALUES('Physics');
INSERT INTO course(course.courseName) VALUES('Computer Science');
INSERT INTO course(course.courseName) VALUES('Arts');
INSERT INTO course(course.courseName) VALUES('Sports');
INSERT INTO course(course.courseName) VALUES('Geography');
INSERT INTO course(course.courseName) VALUES('History');
INSERT INTO course(course.courseName) VALUES('English');
INSERT INTO course(course.courseName) VALUES('Biology');

INSERT INTO enrollment(enrollment.courseId, enrollment.studentId, enrollment.studentName, enrollment.courseName) SELECT course.courseId, student.studentId, student.studentName, course.courseName FROM course, student ORDER BY student.studentId, course.courseId ASC;
-- ----------------------------------------
UPDATE enrollment SET courseName = null, courseId = null WHERE (courseName = 'Physics' AND studentId = 2) OR (courseName = 'Arts' AND studentId = 2) OR (courseName = 'History' AND studentId = 2);
UPDATE enrollment SET courseName = null, courseId = null WHERE (courseName = 'Computer Science' AND studentId = 3) OR (courseName = 'Sports' AND studentId = 3) OR (courseName = 'English' AND studentId = 3);
-- ----------------------------------------
SELECT * FROM enrollment;
SELECT * FROM enrollment WHERE courseName IS NOT NULL; -- Fetch null values
SELECT studentId, studentName FROM enrollment WHERE courseName IS NULL; -- students not rolled in all courses
SELECT courseName,count(courseName) AS NumberOfRowsPerCourseName FROM enrollment GROUP BY courseName ORDER BY NumberOfRowsPerCourseName DESC; -- Order By maximum to minimun
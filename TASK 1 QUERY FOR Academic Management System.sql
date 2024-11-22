-- Database Creation
-- Creating StudentInfo Table

CREATE TABLE StudentInfo (
    STU_ID INT PRIMARY KEY,
    STU_NAME VARCHAR(50),
    DOB DATE,
    PHONE_NO VARCHAR(15),
    EMAIL_ID VARCHAR(50),
    ADDRESS VARCHAR(100)
);

-- Creating CoursesInfo Table

CREATE TABLE CoursesInfo (
    COURSE_ID INT PRIMARY KEY,
    COURSE_NAME VARCHAR(50),
    COURSE_INSTRUCTOR_NAME VARCHAR(50)
);

-- Creating EnrollmentInfo Table

CREATE TABLE EnrollmentInfo (
    ENROLLMENT_ID INT PRIMARY KEY,
    STU_ID INT,
    COURSE_ID INT,
    ENROLL_STATUS VARCHAR(20),
    FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
    FOREIGN KEY (COURSE_ID) REFERENCES CoursesInfo(COURSE_ID)
);

 -- Data Insertion

-- Inserting Data into StudentInfo

INSERT INTO StudentInfo (STU_ID, STU_NAME, DOB, PHONE_NO, EMAIL_ID, ADDRESS) VALUES
(1, 'Rahul Sharma', '2000-05-15', '9876543210', 'rahul.sharma@gmail.com', 'Lucknow, UP'),
(2, 'Priya Singh', '1999-12-20', '9123456789', 'priya.singh@gmail.com', 'Patna, Bihar'),
(3, 'Amit Kumar', '2001-03-10', '9988776655', 'amit.kumar@gmail.com', 'Jaipur, Rajasthan');

-- Inserting Data into CoursesInfo

INSERT INTO CoursesInfo (COURSE_ID, COURSE_NAME, COURSE_INSTRUCTOR_NAME) VALUES
(101, 'Mathematics', 'Dr. Anil Mehra'),
(102, 'Physics', 'Dr. Rakesh Gupta'),
(103, 'Chemistry', 'Dr. Seema Verma');

-- Inserting Data into EnrollmentInfo

INSERT INTO EnrollmentInfo (ENROLLMENT_ID, STU_ID, COURSE_ID, ENROLL_STATUS) VALUES
(1, 1, 101, 'Enrolled'),
(2, 2, 101, 'Enrolled'),
(3, 1, 102, 'Enrolled'),
(4, 3, 103, 'Enrolled'),
(5, 2, 103, 'Enrolled'),
(6, 3, 101, 'Enrolled');

-- Retrieve Student Information

-- Retrieve student details :

SELECT STU_NAME, PHONE_NO, EMAIL_ID, ADDRESS
FROM StudentInfo;

-- b) List courses in which a specific student (e.g., Rahul Sharma) is enrolled:

SELECT COURSE_ID, ENROLL_STATUS 
FROM EnrollmentInfo 
WHERE STU_ID = 1;

-- c) Retrieve course details including instructor information:

SELECT COURSE_NAME, COURSE_INSTRUCTOR_NAME 
FROM CoursesInfo;

-- d) Retrieve course details for a specific course (e.g., Mathematics):

SELECT * 
FROM CoursesInfo 
WHERE COURSE_NAME = 'Mathematics';

-- e) Retrieve course information for multiple courses (e.g., Mathematics and Chemistry):

SELECT * 
FROM CoursesInfo 
WHERE COURSE_NAME IN ('Mathematics', 'Chemistry');

-- 4. Reporting and Analytics (Using Joins)

-- a) Number of students enrolled in each course:

SELECT C.COURSE_NAME, COUNT(E.STU_ID) AS STUDENT_COUNT
FROM CoursesInfo C
LEFT JOIN EnrollmentInfo E ON C.COURSE_ID = E.COURSE_ID
GROUP BY C.COURSE_NAME;

-- b) List of students enrolled in a specific course (e.g., Mathematics):

SELECT S.STU_NAME, S.ADDRESS
FROM StudentInfo S
JOIN EnrollmentInfo E ON S.STU_ID = E.STU_ID
WHERE E.COURSE_ID = 101;

-- c) Count of enrolled students for each instructor:

SELECT C.COURSE_INSTRUCTOR_NAME, COUNT(E.STU_ID) AS STUDENT_COUNT
FROM CoursesInfo C
LEFT JOIN EnrollmentInfo E ON C.COURSE_ID = E.COURSE_ID
GROUP BY C.COURSE_INSTRUCTOR_NAME;

-- d) Students enrolled in multiple courses:

SELECT S.STU_NAME, COUNT(E.COURSE_ID) AS COURSE_COUNT
FROM StudentInfo S
JOIN EnrollmentInfo E ON S.STU_ID = E.STU_ID
GROUP BY S.STU_NAME
HAVING COUNT(E.COURSE_ID) > 1;

-- e) Courses with the highest number of enrolled students (sorted):

SELECT C.COURSE_NAME, COUNT(E.STU_ID) AS STUDENT_COUNT
FROM CoursesInfo C
LEFT JOIN EnrollmentInfo E ON C.COURSE_ID = E.COURSE_ID
GROUP BY C.COURSE_NAME
ORDER BY STUDENT_COUNT DESC;



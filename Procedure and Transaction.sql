DELIMITER $$
CREATE PROCEDURE Assign_Teacher_to_Class(IN cl_id CHAR(5),IN cl_name CHAR(50), IN t_id CHAR(10), IN co_id CHAR(10), IN cl_room CHAR(10), IN st_time DATETIME, IN en_time DATETIME)
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SHOW ERRORS;
    END;
    START TRANSACTION;
        SELECT assigned_credit_hour, credit_hour_limit INTO @teacher_credit_hour, @c_limit FROM Teacher WHERE teacher_id = t_id;

        SELECT credit_hour INTO @course_credit FROM Course  WHERE course_id = co_id;
        IF @course_credit + @teacher_credit_hour < @c_limit THEN
            INSERT INTO Class (class_id, class_name, teacher_id, course_id, class_room, start_time, end_time) VALUES (cl_id,cl_name,t_id,co_id,cl_room,st_time,en_time);
            UPDATE Teacher SET assigned_credit_hour = @teacher_credit_hour+@course_credit WHERE teacher_id = t_id;
        ELSE
            SELECT 'The teacher cannot assigned to this class, passed the credit hour limit';
        END IF;
    COMMIT;

END $$
DELIMITER ;

drop procedure Assign_Teacher_to_Class;

DELIMITER $$

CREATE PROCEDURE Dismiss_Teacher_From_Class(IN cl_id CHAR(5), IN t_id CHAR(10))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SHOW ERRORS;
    END;
    START TRANSACTION;
        SELECT course_id INTO @co_id FROM Class WHERE class_id= cl_id;
        SELECT credit_hour INTO @co_credit FROM Course WHERE course_id = @co_id;
        SELECT assigned_credit_hour INTO @as_credit FROM Teacher WHERE teacher_id = t_id;

        IF @as_credit - @co_credit >= 0 THEN
            DELETE FROM Class WHERE class_id = cl_id;
            UPDATE Teacher SET assigned_credit_hour = @as_credit-@co_credit WHERE teacher_id = t_id;
        ELSE
            SELECT 'The teacher doesnt have enough credit hour to subtract';
        END IF;
    COMMIT;

END $$
DELIMITER ;

DELIMITER $$

CREATE PROCEDURE Enroll_Student_to_Class(IN cl_id CHAR(5),IN stud_id CHAR(20))
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SHOW ERRORS;
    END;
    START TRANSACTION;
        SELECT registered_credit_hours, year INTO @reg_credit_hour, @yr FROM Student WHERE student_id = stud_id;
        SELECT room_limit, registered_student, course_id INTO @room_limit, @s_in_class, @co_id FROM Class  WHERE class_id = cl_id;
        SELECT credit_hour INTO @co_credit FROM Course WHERE course_id = @co_id;
        SELECT credit_hour INTO @year_limit FROM Year WHERE year = @yr;

        IF @s_in_class + 1 < @room_limit THEN
            IF @reg_credit_hour + @co_credit < @year_limit THEN
                INSERT INTO Enrollment (class_id, student_id) VALUES (cl_id, stud_id);
                UPDATE Student SET registered_credit_hours = @reg_credit_hour+@co_credit WHERE student_id = stud_id;
                UPDATE Class SET registered_student = @s_in_class + 1 WHERE class_id = cl_id;
            ELSE
                SELECT 'The student cannot registered, passed his credit hour limit';
            END IF;
        ELSE
            SELECT 'The student cannot registered to this class, class is full';
        END IF;
    COMMIT;
END $$
DELIMITER ;


DELIMITER $$

CREATE PROCEDURE Dismiss_Student_from_Class(IN cl_id CHAR(5),IN stud_id CHAR(20))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SHOW ERRORS;
    END;
    START TRANSACTION;
        SELECT registered_credit_hours INTO @reg_credit_hour FROM Student WHERE student_id = stud_id;
        SELECT registered_student, course_id INTO @s_in_class, @co_id FROM Class  WHERE class_id = cl_id;
        SELECT credit_hour INTO @co_credit FROM Course WHERE course_id = @co_id;


        IF @reg_credit_hour - @co_credit >= 0 THEN
            DELETE FROM Enrollment WHERE class_id =cl_id AND student_id = stud_id;

            UPDATE Student SET registered_credit_hours = @reg_credit_hour-@co_credit WHERE student_id = stud_id;
            UPDATE Class SET registered_student = @s_in_class - 1 WHERE class_id = cl_id;

        ELSE
            SELECT 'Student course already less than the class course credit';
        END IF;
    COMMIT;
END $$
DELIMITER ;
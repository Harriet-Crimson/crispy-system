-- SET search_path TO cmps, public;


-- CREATE TABLE cmps.student (-- has data about people entering exams
-- sno INTEGER NOT NULL PRIMARY KEY,
-- sname VARCHAR(200) NOT NULL,
-- semail VARCHAR(200) NOT NULL
-- );

-- CREATE INDEX idx_sno
-- ON student (sno);

-- CREATE TABLE cmps.entry ( --records which students are taking which exams
-- eno INTEGER NOT NULL PRIMARY KEY,
-- excode CHAR(4) REFERENCES exam(excode)
-- ON DELETE RESTRICT, --Stops exams from being deleted while active entries exist
-- sno INTEGER REFERENCES student(sno),
-- egrade DECIMAL(5,2)
-- check ((egrade IS NULL) OR (egrade BETWEEN 0 AND 100))
-- );


-- CREATE VIEW cmps.results AS
--         SELECT exam.excode, exam.extitle, student.sname,
--         CASE --checks if its null first to avoid using comparators on null values
--             WHEN entry.egrade IS NULL THEN 'Not Taken'
--             WHEN entry.egrade >= 70 THEN 'Distinction'
--             WHEN entry.egrade >= 50 THEN 'Pass'
--             ELSE 'Fail' -- grades less then 50
--          END AS exam_result
--         FROM student
--         INNER JOIN entry ON student.sno = entry.sno
--         INNER JOIN exam ON exam.excode = entry.excode
--         ORDER BY exam.excode, student.sname;

-- CREATE OR REPLACE FUNCTION cancel_entry()
-- RETURNS TRIGGER  AS
-- $$
-- BEGIN
--     INSERT INTO cancel (eno, excode, sno, cdate, cuser)
--     SELECT e.eno, e.excode, e.sno, CURRENT_TIMESTAMP, 'Admin'
--     FROM entry e --entries connected to the student being deleted
--     WHERE (e.sno = OLD.sno);

-- 	DELETE FROM entry -- removes cancelled entries from entries
--     WHERE (OLD.sno = entry.sno);
--     RETURN OLD;
-- END;
-- $$ LANGUAGE plpgsql;

-- CREATE OR REPLACE FUNCTION overwrite_entries()
-- RETURNS TRIGGER
-- AS $$
-- BEGIN
--     DELETE FROM entry
--     WHERE ((entry.excode = NEW.excode) AND (entry.sno = NEW.sno) AND
-- 	(DATE_PART('year', (SELECT exdate FROM exam WHERE exam.excode = entry.excode)) =
--      DATE_PART('year', (SELECT exdate FROM exam WHERE exam.excode = NEW.excode))));
--       -- deletes other entries from the year of the same student and same exam
         
--     DELETE FROM entry
--     WHERE ((entry.sno = NEW.sno)
-- 	AND ((SELECT exdate FROM exam WHERE exam.excode = entry.excode) =
--          (SELECT exdate FROM exam WHERE exam.excode = NEW.excode)));
--     -- deletes other exams being taken on that day by that student  

--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;

-- CREATE OR REPLACE FUNCTION student_timetable(snum INTEGER)
-- RETURNS TABLE (sname VARCHAR(200), exlocation VARCHAR(200), excode CHAR(4),
--  extitle VARCHAR(200), exdate DATE, extime TIME)
-- AS $$
-- BEGIN
--     RETURN QUERY 
--     SELECT student.sname, exam.exlocation, exam.excode, exam.extitle, 
--     exam.exdate, exam.extime
--     FROM entry -- connects to student and entry table
--     INNER JOIN student ON student.sno = entry.sno
--     INNER JOIN exam ON entry.excode = exam.excode
--     WHERE student.sno = snum;
-- END;
-- $$ LANGUAGE plpgsql;

-- CREATE TRIGGER delete_student
-- BEFORE DELETE
-- ON student -- occurs when students are to be deleted
-- FOR EACH ROW
-- EXECUTE FUNCTION cancel_entry();

-- CREATE TRIGGER insert_entry
-- BEFORE INSERT
-- ON entry -- occurs when new entries are set
-- FOR EACH ROW
-- EXECUTE FUNCTION overwrite_entries();


SET search_path TO cmps, public;

CREATE TABLE cmps.tutor(
    tu_no INTEGER NOT NULL PRIMARY KEY,
    tu_name VARCHAR(200) NOT NULL,
    tu_email VARCHAR(200) NOT NULL,
    tu_password VARCHAR(200) NOT NULL --May need to be hashed
);

CREATE TABLE cmps.student(
    st_no INTEGER NOT NULL PRIMARY KEY,
    st_name VARCHAR(200) NOT NULL,
    st_email VARCHAR(200) NOT NULL,
    st_password VARCHAR(200) NOT NULL --May need to be hashed
);

CREATE TABLE cmps.module(
    mo_no INTEGER NOT NULL PRIMARY KEY,
    mo_name VARCHAR(200) NOT NULL UNIQUE,
    tu_no INTEGER REFERENCES Tutor(tu_no)
    ON DELETE CASCADE -- When tutor is deleted so are their modules
);

CREATE TABLE cmps.assignment(
    as_no INTEGER NOT NULL PRIMARY KEY,
    as_name VARCHAR(200) NOT NULL,
    mo_no INTEGER REFERENCES Module(mo_no)
    ON DELETE CASCADE, -- When module is deleted so are its assignments
    as_deadline DATE NOT NULL,
    as_weight DECIMAL(4,3) NOT NULL -- x.xxx format
    CHECK as_weight BETWEEN 0 AND 1   
);


DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'ta_type') THEN
        CREATE TYPE ta_type AS ENUM (
            'Studying', 'Reading', 'Programming', 'Writing', 'Researching', 'Solving', 'Creating'
        );
    END IF;
END$$;

CREATE TABLE cmps.task(
    ta_no INTEGER NOT NULL PRIMARY KEY,
    ta_name VARCHAR(200) NOT NULL,
    as_no INTEGER REFERENCES Assignment(as_no)
    ON DELETE CASCADE, -- When assignment is deleted so are its tasks
    ta_time TIME NOT NULL -- How long it should take to complete
    CHECK ta_time > 0,
    ta_type ENUM("Studying", "Reading", "Programming", "Writing", "Researching", "Solving", "Creating") NOT NULL,
    ta_criterion VARCHAR(200) NOT NULL, -- e.g. hours spent or chapters read
    ta_target INTEGR NOT NULL -- the number to be complete
    mi_no INTEGER REFERENCES Milestone(mi_no) -- Can be NULL
    ON DELETE CASCADE -- When milestone is deleted so are its tasks
    ta_dependency INTEGER REFERENCES Task(ta_no)
    CHECK ta_dependency != ta_no
);

CREATE TABLE cmps.progress
(
    st_no INTEGER REFERENCES Student(st_no)
    ON DELETE CASCADE, -- When student is deleted so is their progress
    ta_no INTEGER REFERENCES Task(ta_no)
    ON DELETE CASCADE, -- When task is deleted so is their progress
    pr_measure INTEGER NOT NULL, -- The progress towards the number/criterion
    pr_notes VARCHAR(2000) 

    PRIMARY KEY (st_no,ta_no)
);



--Potentially useful code
-- INSERT INTO cmps.Progress (st_no, ta_no, pr_notes)
-- VALUES ($1, $2, $3)
-- ON CONFLICT (st_no, ta_no)
-- DO UPDATE SET
--   pr_notes = EXCLUDED.pr_notes;

CREATE TABLE cmps.milestone
(
    mi_no INTEGER NOT NULL PRIMARY KEY,
    mi_name VARCHAR(200) NOT NULL,
    mi_deadline DATE NOT NULL,
    as_no INTEGER REFERENCES Assignment(as_no)
    ON DELETE CASCADE, -- When assignment is deleted so are its milestones
);

CREATE TABLE cmps.semester
(
    st_no INTEGER REFERENCES Student(st_no)
    ON DELETE CASCADE, -- When student is deleted so are their semesters
    mo_no INTEGER REFERENCES Module(mo_no)
    ON DELETE CASCADE, -- When module is deleted so are their semesters
    PRIMARY KEY(st_no, mo_no)
);



--cmps may need to be changed
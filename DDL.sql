SET search_path TO cmps, public;

CREATE TABLE cmps.exam (-- stores information about the exams
excode CHAR(4) NOT NULL PRIMARY KEY,
extitle VARCHAR(200) NOT NULL UNIQUE,
exlocation VARCHAR(200) NOT NULL,
exdate DATE NOT NULL,
extime TIME NOT NULL,
CHECK (extime BETWEEN '09:00:00' AND '18:00:00')
);

CREATE INDEX idx_excode
ON exam (excode);

CREATE TABLE cmps.student (-- has data about people entering exams
sno INTEGER NOT NULL PRIMARY KEY,
sname VARCHAR(200) NOT NULL,
semail VARCHAR(200) NOT NULL
);

CREATE INDEX idx_sno
ON student (sno);

CREATE TABLE cmps.entry ( --records which students are taking which exams
eno INTEGER NOT NULL PRIMARY KEY,
excode CHAR(4) REFERENCES exam(excode)
ON DELETE RESTRICT, --Stops exams from being deleted while active entries exist
sno INTEGER REFERENCES student(sno),
egrade DECIMAL(5,2)
check ((egrade IS NULL) OR (egrade BETWEEN 0 AND 100))
);

CREATE TABLE cmps.cancel (--shows old entries, no longer apart of entries table
eno INTEGER NOT NULL,
excode CHAR(4) REFERENCES exam(excode)
ON DELETE CASCADE, -- Removes references to exams no longer in the system
sno INTEGER NOT NULL,
cdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
cuser VARCHAR(200) NOT NULL,
PRIMARY KEY (eno, cdate)
);

CREATE VIEW cmps.results AS
        SELECT exam.excode, exam.extitle, student.sname,
        CASE --checks if its null first to avoid using comparators on null values
            WHEN entry.egrade IS NULL THEN 'Not Taken'
            WHEN entry.egrade >= 70 THEN 'Distinction'
            WHEN entry.egrade >= 50 THEN 'Pass'
            ELSE 'Fail' -- grades less then 50
         END AS exam_result
        FROM student
        INNER JOIN entry ON student.sno = entry.sno
        INNER JOIN exam ON exam.excode = entry.excode
        ORDER BY exam.excode, student.sname;

CREATE OR REPLACE FUNCTION cancel_entry()
RETURNS TRIGGER  AS
$$
BEGIN
    INSERT INTO cancel (eno, excode, sno, cdate, cuser)
    SELECT e.eno, e.excode, e.sno, CURRENT_TIMESTAMP, 'Admin'
    FROM entry e --entries connected to the student being deleted
    WHERE (e.sno = OLD.sno);

	DELETE FROM entry -- removes cancelled entries from entries
    WHERE (OLD.sno = entry.sno);
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION overwrite_entries()
RETURNS TRIGGER
AS $$
BEGIN
    DELETE FROM entry
    WHERE ((entry.excode = NEW.excode) AND (entry.sno = NEW.sno) AND
	(DATE_PART('year', (SELECT exdate FROM exam WHERE exam.excode = entry.excode)) =
     DATE_PART('year', (SELECT exdate FROM exam WHERE exam.excode = NEW.excode))));
      -- deletes other entries from the year of the same student and same exam
         
    DELETE FROM entry
    WHERE ((entry.sno = NEW.sno)
	AND ((SELECT exdate FROM exam WHERE exam.excode = entry.excode) =
         (SELECT exdate FROM exam WHERE exam.excode = NEW.excode)));
    -- deletes other exams being taken on that day by that student  

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION student_timetable(snum INTEGER)
RETURNS TABLE (sname VARCHAR(200), exlocation VARCHAR(200), excode CHAR(4),
 extitle VARCHAR(200), exdate DATE, extime TIME)
AS $$
BEGIN
    RETURN QUERY 
    SELECT student.sname, exam.exlocation, exam.excode, exam.extitle, 
    exam.exdate, exam.extime
    FROM entry -- connects to student and entry table
    INNER JOIN student ON student.sno = entry.sno
    INNER JOIN exam ON entry.excode = exam.excode
    WHERE student.sno = snum;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER delete_student
BEFORE DELETE
ON student -- occurs when students are to be deleted
FOR EACH ROW
EXECUTE FUNCTION cancel_entry();

CREATE TRIGGER insert_entry
BEFORE INSERT
ON entry -- occurs when new entries are set
FOR EACH ROW
EXECUTE FUNCTION overwrite_entries();
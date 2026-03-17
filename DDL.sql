-- Code used for establishing the database
-- Kept for reference purposes


CREATE SCHEMA sp;

SET search_path TO sp, public; -- Start every query

CREATE TABLE sp.tutor(
    tu_no INTEGER NOT NULL PRIMARY KEY, -- Tutor number
    tu_fname VARCHAR(200) NOT NULL, -- Tutor first name
    tu_sname VARCHAR(200) NOT NULL, -- Tutor last name
    tu_email VARCHAR(200) NOT NULL, -- Tutor email address
    tu_password VARCHAR(200) NOT NULL --May need to be hashed
);


CREATE TABLE sp.student(
    st_no INTEGER NOT NULL PRIMARY KEY, -- Student number
    st_fname VARCHAR(200) NOT NULL, -- Student first name
    st_sname VARCHAR(200) NOT NULL, -- Student last name
    st_email VARCHAR(200) NOT NULL, -- Student's email address
    st_password VARCHAR(200) NOT NULL --May need to be hashed
);


CREATE TABLE sp.module(
    mo_no INTEGER NOT NULL PRIMARY KEY, -- Module number
    mo_name VARCHAR(200) NOT NULL UNIQUE, -- Name of the module
    tu_no INTEGER REFERENCES Tutor(tu_no) -- Tutor teching module
    ON DELETE CASCADE -- When tutor is deleted so are their modules
);



CREATE TABLE sp.assignment(
    as_no INTEGER NOT NULL PRIMARY KEY, -- Assignment number
    as_name VARCHAR(200) NOT NULL, -- Name of the module
    mo_no INTEGER REFERENCES Module(mo_no) -- Module it belongs to
    ON DELETE CASCADE, -- When module is deleted so are its assignments
    as_deadline DATE NOT NULL, -- When the assignment has to be completed
    as_weight DECIMAL(4,3) NOT NULL -- x.xxx format
    CHECK (as_weight BETWEEN 0 AND 1)   
);


DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'study_task') THEN
        CREATE TYPE study_task AS ENUM ('Studying', 'Reading', 'Programming', 'Writing', 'Researching', 'Solving', 'Creating');
    END IF;
END$$;

CREATE TABLE sp.milestone
(
    mi_no INTEGER NOT NULL PRIMARY KEY, -- Milestone number
    mi_name VARCHAR(200) NOT NULL, -- name of the module
    mi_deadline DATE NOT NULL, -- Deadline for the milestone
    as_no INTEGER REFERENCES Assignment(as_no) -- Assignment it belongs to 
    ON DELETE CASCADE -- When assignment is deleted so are its milestones
);


CREATE TABLE sp.task(
    ta_no INTEGER NOT NULL PRIMARY KEY, -- Task number
    ta_name VARCHAR(200) NOT NULL, -- Name given to the task
    as_no INTEGER REFERENCES Assignment(as_no) -- Assignment it belongs to
    ON DELETE CASCADE, -- When assignment is deleted so are its tasks
    ta_time INTERVAL NOT NULL -- How long it should take to complete
    CHECK (ta_time > INTERVAL '0 seconds'),
    ta_type study_task NOT NULL, -- Refer to the study_task enum
    ta_criterion VARCHAR(200) NOT NULL, -- e.g. hours spent or chapters read
    ta_target INTEGER NOT NULL, -- the number to be complete
    mi_no INTEGER REFERENCES Milestone(mi_no) -- Possible milestone it is a part of (Can be NULL)
    ON DELETE CASCADE, -- When milestone is deleted so are its tasks
    ta_dependency INTEGER REFERENCES Task(ta_no)
    CHECK (ta_dependency != ta_no) -- Can not rely on itself to be completed
);

CREATE TABLE sp.progress
(
    st_no INTEGER REFERENCES Student(st_no)
    ON DELETE CASCADE, -- When student is deleted so is their progress
    ta_no INTEGER REFERENCES Task(ta_no)
    ON DELETE CASCADE, -- When task is deleted so is their progress
    pr_measure INTEGER NOT NULL, -- The progress towards the number/criterion
    pr_notes VARCHAR(2000),

    PRIMARY KEY (st_no,ta_no)
);


CREATE TABLE sp.semester
(
    st_no INTEGER NOT NULL REFERENCES Student(st_no) -- The student who has entered the file
    ON DELETE CASCADE, -- When student is deleted so are their semesters
    mo_no INTEGER NOT NULL REFERENCES Module(mo_no) -- A code for a module, from the file
    ON DELETE CASCADE, -- When module is deleted so are their semesters
    PRIMARY KEY (st_no, mo_no)
);


CREATE SCHEMA sp;


SET search_path TO sp, public; -- Start every query

CREATE TABLE sp.tutor(
    tu_no INTEGER NOT NULL PRIMARY KEY,
    tu_name VARCHAR(200) NOT NULL,
    tu_email VARCHAR(200) NOT NULL,
    tu_password VARCHAR(200) NOT NULL --May need to be hashed
);


CREATE TABLE sp.student(
    st_no INTEGER NOT NULL PRIMARY KEY,
    st_name VARCHAR(200) NOT NULL,
    st_email VARCHAR(200) NOT NULL,
    st_password VARCHAR(200) NOT NULL --May need to be hashed
);

CREATE TABLE sp.module(
    mo_no INTEGER NOT NULL PRIMARY KEY,
    mo_name VARCHAR(200) NOT NULL UNIQUE,
    tu_no INTEGER REFERENCES Tutor(tu_no)
    ON DELETE CASCADE -- When tutor is deleted so are their modules
);

CREATE TABLE sp.assignment(
    as_no INTEGER NOT NULL PRIMARY KEY,
    as_name VARCHAR(200) NOT NULL,
    mo_no INTEGER REFERENCES Module(mo_no)
    ON DELETE CASCADE, -- When module is deleted so are its assignments
    as_deadline DATE NOT NULL,
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
    mi_no INTEGER NOT NULL PRIMARY KEY,
    mi_name VARCHAR(200) NOT NULL,
    mi_deadline DATE NOT NULL,
    as_no INTEGER REFERENCES Assignment(as_no)
    ON DELETE CASCADE -- When assignment is deleted so are its milestones
);

CREATE TABLE sp.task(
    ta_no INTEGER NOT NULL PRIMARY KEY,
    ta_name VARCHAR(200) NOT NULL,
    as_no INTEGER REFERENCES Assignment(as_no)
    ON DELETE CASCADE, -- When assignment is deleted so are its tasks
    ta_time INTERVAL NOT NULL -- How long it should take to complete
    CHECK (ta_time > INTERVAL '0 seconds'),
    ta_type study_task NOT NULL,
    ta_criterion VARCHAR(200) NOT NULL, -- e.g. hours spent or chapters read
    ta_target INTEGER NOT NULL, -- the number to be complete
    mi_no INTEGER REFERENCES Milestone(mi_no) -- Can be NULL
    ON DELETE CASCADE, -- When milestone is deleted so are its tasks
    ta_dependency INTEGER REFERENCES Task(ta_no)
    CHECK (ta_dependency != ta_no)
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

--Potentially useful code
-- INSERT INTO cmps.Progress (st_no, ta_no, pr_notes)
-- VALUES ($1, $2, $3)
-- ON CONFLICT (st_no, ta_no)
-- DO UPDATE SET
--   pr_notes = EXCLUDED.pr_notes;



CREATE TABLE sp.semester
(
    st_no INTEGER NOT NULL REFERENCES Student(st_no) 
    ON DELETE CASCADE, -- When student is deleted so are their semesters
    mo_no INTEGER NOT NULL REFERENCES Module(mo_no)
    ON DELETE CASCADE, -- When module is deleted so are their semesters
    PRIMARY KEY (st_no, mo_no)
);
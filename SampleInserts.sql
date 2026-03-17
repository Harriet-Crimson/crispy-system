INSERT INTO sp.tutor (tu_no, tu_fname, tu_sname, tu_email, tu_password)
VALUES ($1, $2, $3, $4, $5);

INSERT INTO sp.student (st_no, st_fname, st_sname, st_email, st_password)
VALUES ($1, $2, $3, $4, $5);

INSERT INTO sp.module (mo_no, mo_name, tu_no)
VALUES ($1, $2, $3);

INSERT INTO sp.assignment (as_no, as_name, mo_no, as_deadline, as_weight)
VALUES ($1, $2, $3, $4, $5);

INSERT INTO sp.milestone (mi_no, mi_name, mi_deadline, as_no)
VALUES ($1, $2, $3, $4);

INSERT INTO sp.task (ta_no, ta_name, mi_deadline, as_no, ta_time, ta_type, ta_criterion, mi_no,ta_dependency)
VALUES ($1, $2, $3, $4, $5, $6, $7, $8);


INSERT INTO sp.Progress (st_no, ta_no, pr_measure, pr_notes)
VALUES ($1, $2, $3, $4)
ON CONFLICT (st_no, ta_no)-- Updates measure and notes for pre-existing progress records
DO UPDATE SET
    pr_measure = EXCLUDED.pr_measure 
    pr_notes = EXCLUDED.pr_notes;


INSERT INTO sp.Progress (st_no, mo_no)
VALUES ($1, $2);




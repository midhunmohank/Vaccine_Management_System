CREATE OR REPLACE PACKAGE PKG_DELETE_RECORDS_HOSPITAL_ADMIN AS 

  PROCEDURE DEL_MEDICAL_WORKER(I_MEDICAL_WORKER_ID IN MEDICAL_WORKER.MEDICAL_WORKER_ID%TYPE); 

END PKG_DELETE_RECORDS_HOSPITAL_ADMIN;
/


CREATE OR REPLACE PACKAGE BODY PKG_DELETE_RECORDS_HOSPITAL_ADMIN AS

  PROCEDURE DEL_MEDICAL_WORKER(I_MEDICAL_WORKER_ID IN MEDICAL_WORKER.MEDICAL_WORKER_ID%TYPE) AS 
  UNQID NUMBER;
  INVALID_INPUTS EXCEPTION;
  
  BEGIN
  SELECT COUNT(*) INTO UNQID FROM MEDICAL_WORKER
    WHERE MEDICAL_WORKER_ID = I_MEDICAL_WORKER_ID;
    IF (UNQID < 1)
    THEN 
        RAISE INVALID_INPUTS;
    END IF;
  
    DELETE FROM VACCINE_RECORD
	WHERE MEDICAL_WORKER_ID = I_MEDICAL_WORKER_ID;

	DELETE FROM MEDICAL_WORKER
	WHERE MEDICAL_WORKER_ID = I_MEDICAL_WORKER_ID;
	
	DBMS_OUTPUT.PUT_LINE('DETAILS ABOUT MEDICAL_WORKER_ID ' || I_MEDICAL_WORKER_ID || ' SUCESSFULLY DELETED ');
    
    COMMIT;
    
    EXCEPTION
    WHEN INVALID_INPUTS
    THEN 
    dbms_output.put_line('DETAILS ABOUT MEDICAL_WORKER_ID ' || I_MEDICAL_WORKER_ID || ' NOT FOUND ');

  END DEL_MEDICAL_WORKER;

END PKG_DELETE_RECORDS_HOSPITAL_ADMIN;
/

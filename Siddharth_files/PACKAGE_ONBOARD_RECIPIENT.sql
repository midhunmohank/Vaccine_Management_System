CREATE OR REPLACE PACKAGE PACKAGE_ONBOARD_RECIPIENT AS 

PROCEDURE ONBOARD_REGISTRATION
(IN_REGISTRATION_ID IN NUMBER, 
IN_RECIPIENT_ID IN NUMBER,
IN_USERNAME IN VARCHAR2, 
IN_PASSWORD IN VARCHAR2, 
IN_EMAIL_ID IN VARCHAR2,
IN_LAST_VACCINATION_DATE IN DATE,
IN_PAYMENT_TIMESTAMP IN TIMESTAMP,
IN_PAYMENT_AMOUNT IN NUMBER,
IN_TRANSACTION_ID IN VARCHAR2,
IN_PAYMENT_TYPE IN VARCHAR2
);

END PACKAGE_ONBOARD_RECIPIENT;
/


CREATE OR REPLACE PACKAGE BODY PACKAGE_ONBOARD_RECIPIENT AS

  PROCEDURE ONBOARD_REGISTRATION
(IN_REGISTRATION_ID IN NUMBER, 
IN_RECIPIENT_ID IN NUMBER,
IN_USERNAME IN VARCHAR2, 
IN_PASSWORD IN VARCHAR2, 
IN_EMAIL_ID IN VARCHAR2,
IN_LAST_VACCINATION_DATE IN DATE,
IN_PAYMENT_TIMESTAMP IN TIMESTAMP,
IN_PAYMENT_AMOUNT IN NUMBER,
IN_TRANSACTION_ID IN VARCHAR2,
IN_PAYMENT_TYPE IN VARCHAR2
) AS

INVALID_INPUTS EXCEPTION;


BEGIN


   IF
(IN_REGISTRATION_ID <= 0
OR IN_RECIPIENT_ID <= 0
OR LENGTH(IN_USERNAME)<= 0
OR LENGTH(IN_PASSWORD)<= 0
OR LENGTH(IN_EMAIL_ID)<= 0
OR IN_LAST_VACCINATION_DATE is NULL
OR IN_PAYMENT_TIMESTAMP is NULL
OR IN_PAYMENT_AMOUNT <= 0
OR LENGTH(IN_TRANSACTION_ID)<=0
OR LENGTH(IN_PAYMENT_TYPE)<=0) 
THEN 
    RAISE INVALID_INPUTS;
    
END IF;

  INSERT INTO REGISTRATION(REGISTRATION_ID,RECIPIENT_ID,USERNAME,PASS_WORD,EMAIL_ID,LAST_VACCINATION_DATE,PAYMENT_TIMESTAMP, PAYMENT_AMOUNT,TRANSACTION_ID,PAYMENT_TYPE)
VALUES (IN_REGISTRATION_ID,IN_RECIPIENT_ID,IN_USERNAME,IN_PASSWORD,IN_EMAIL_ID,IN_LAST_VACCINATION_DATE,IN_PAYMENT_TIMESTAMP,IN_PAYMENT_AMOUNT,IN_TRANSACTION_ID,IN_PAYMENT_TYPE);

COMMIT;


EXCEPTION
WHEN INVALID_INPUTS
THEN 
dbms_output.put_line('Invalid input');
--WHEN DUPLICATE_ERROR
--THEN 
--dbms_output.put_line('Duplicate input');
    
END ONBOARD_REGISTRATION;

END PACKAGE_ONBOARD_RECIPIENT;
/

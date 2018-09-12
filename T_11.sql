DEFINE NUMB='1239'

WITH DAF 
AS(SELECT  NNUM "Число",SUM "Результат"
   FROM (SELECT DISTINCT REPLACE (SYS_CONNECT_BY_PATH(NUM,'/'),'/')NNUM--Шаг 2)перестановка без повтора
         FROM (SELECT SUBSTR('&&NUMB',LEVEL,1)NUM,ROWNUM R--Шаг 1)определение кол-а цифр
               FROM DUAL CONNECT BY LEVEL<=LENGTH('&NUMB')) 
         WHERE CONNECT_BY_ISLEAF=1 
         CONNECT BY NOCYCLE PRIOR R<>R)
   MODEL--Шаг 3)расчет
   PARTITION BY (NNUM)
   DIMENSION BY (0 i)
   MEASURES (0 DAF,0 SUM)
   RULES (DAF[FOR i FROM 1 TO LENGTH('&NUMB')-1 INCREMENT 1]=ABS(SUBSTR(CV(NNUM),CV(i),1)-SUBSTR(CV(NNUM),CV(i)+1,1)),
   SUM[FOR i FROM 1 TO LENGTH('&NUMB')-1 INCREMENT 1]=SUM[CV(i)-1]+DAF[CV(i)]))
   SELECT DECODE(ROWNUM,1,'&NUMB',' ')"Исходное число",--Шаг 4)оформленный вывод результата
  DECODE(ROWNUM,1,TO_CHAR(LENGTH('&NUMB')),' ') "Кол-во цифр в числе",
  "Число","Результат"
   FROM DAF
 WHERE "Результат"=(SELECT MAX("Результат")
                  FROM DAF); 
